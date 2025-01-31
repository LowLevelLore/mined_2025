from langchain_google_genai import ChatGoogleGenerativeAI
from langchain.prompts import ChatPromptTemplate, PromptTemplate, SystemMessagePromptTemplate, HumanMessagePromptTemplate
from typing import List, Dict, Any
from typing_extensions import TypedDict
from langchain_core.output_parsers import StrOutputParser, JsonOutputParser
from langgraph.graph import StateGraph, START, END
from IPython.display import Image, display
from langchain_core.messages import AIMessage, HumanMessage, SystemMessage
from langchain_core.output_parsers import PydanticOutputParser
import os
from dotenv import load_dotenv
# from langchain.document_loaders import PyMuPDFLoader
from typing import List, Dict, Any, Optional
import fitz
from pydantic import BaseModel, Field
load_dotenv()
os.environ["LANGSMITH_PROJECT"] = f"Deployed MineD 2025"

llm = ChatGoogleGenerativeAI(
    model="gemini-1.5-flash",
    temperature=0,
    max_tokens=None,
    timeout=None,
    max_retries=2,
    # other params...
)

# Define Pydantic Model for PPT slides
class SlideContent(BaseModel):
    title: str = Field(..., description="Title of the particular slide")
    bullet_points: Optional[List[str]] = Field(None, description="Content in bullet points form for the slide")
    notes: Optional[str] = Field(None, description="Additional notes for the slide")
    images: Optional[List[str]] = Field(None, description="List of relevant image paths for the slide")

class PPTPresentation(BaseModel):
    title: str = Field(..., description="Title of the presentation")
    authors: List[str] = Field(..., description="List of authors of the presentation")
    institution: str = Field(..., description="Institution associated with the presentation")
    slides: List[SlideContent] = Field(..., description="List of slides, in the presentation,which are SlideContent schemas.")

class ResPaperExtractState(TypedDict):
    pdf_path: Optional[str] = None  # Path to the PDF file
    extracted_text: Optional[str] = None  # Full extracted text from the PDF
    extracted_images: Optional[Dict[str,str]] = None  # Paths to extracted images
    slides_content: Optional[List[Dict[str, str]]] = None  # Prepared content for PowerPoint slides
    metadata: str
    ppt_object: PPTPresentation

def load_pdf(state: ResPaperExtractState):
    pdf_path = state["pdf_path"]
    doc = fitz.open(pdf_path)  # Load the PDF only once
    
    extracted_text = []
    extracted_images = dict()
    output_folder = "extracted_images"
    os.makedirs(output_folder, exist_ok=True)

    # Iterate through each page
    img_cntr=1
    for page_number, page in enumerate(doc):
        # Extract text
        text = page.get_text("text")
        extracted_text.append(text)

        # Extract images
        for img_index, img in enumerate(page.get_images(full=True)):
            xref = img[0]
            base_image = doc.extract_image(xref)
            image_bytes = base_image["image"]
            image_ext = base_image["ext"]
            img_filename = f"{output_folder}/page_{page_number+1}_img_{img_index+1}.{image_ext}"
            
            with open(img_filename, "wb") as img_file:
                img_file.write(image_bytes)
            
            extracted_images[f"Fig{img_cntr}"] = img_filename
            img_cntr+=1

    # Combine text from all pages
    full_text = "\n".join(extracted_text)

    # Update state
    return {"extracted_text": full_text, "extracted_images": extracted_images}

def get_data(state):
    extracted_text = state["extracted_text"]
    
    # Format prompt with extracted text
    
    # Invoke LLM with structured output
    chain = chat_prompt | llm | parser

    # Parse structured output into Pydantic model
    ppt_object = chain.invoke({"extracted_text":extracted_text})
    
    return {"ppt_object": ppt_object}

system_message = SystemMessagePromptTemplate.from_template(
    """You are an expert in creating PowerPoint presentations. Generate a structured PowerPoint (PPT) presentation 
    that summarizes a research paper based on the provided extracted text. Follow these instructions:
    
    Remember that the objective of this PPT is for a third party to understand the key points of the research paper, and 
    give them a gist of the research paper.

    - Title Slide: Include the research paper title, authors, and institution.
    - Introduction Slide: Summarize the problem, objectives, and motivation.
    - Methods Slide: Briefly explain the methodology, datasets, and experimental setup.
    - Results Slide: Summarize key findings with bullet points. Mention any visuals (graphs, tables) found from the extracted text. You should definetly mention in the presentation any figures related to a performance metric or tables that are mentioned in the extracted text.
    - Graphics: Include any images of graphs or charts or other images, relevant to the results,or images depicting a performance metric,
      that are mentioned in the extracted text. You can find such images by looking for any captions that mention figures or tables. 
      It is necessary to name this slide as Graphics.
      Note that you should only mention the image number, like Fig1, Fig2, etc...
      Include only relevant image names.
    - Discussion Slide: Explain the significance of results and compare with prior work.
    - Conclusion Slide: Summarize key takeaways and potential future work.
    - References Slide: Include citations if available.

    Additional Guidelines:
    - Keep slides concise (use bullet points).
    - Maintain a professional and visually appealing slide design.
    - Give the text in markdown format.
    - Each slide should have rich information content, summarizing the information related to the particular slide heading, 
    and also include some content that is related to the slide heading but not directly mentioned in the extracted text.
    - Also keep in mind that the text for each slide should not be too lengthy, and should be concise and to the point.

    {format_instructions}
    """
)

# Human Message: Supplies extracted text from the research paper
human_message = HumanMessagePromptTemplate.from_template("Here is the extracted text:\n\n{extracted_text}")

parser = JsonOutputParser(pydantic_object=PPTPresentation)
# Combine into a structured chat prompt
chat_prompt = ChatPromptTemplate(
    messages=[system_message, human_message],
    partial_variables={"format_instructions": parser.get_format_instructions()}
)

builder = StateGraph(ResPaperExtractState)

builder.add_node("pdf-2-text", load_pdf)
builder.add_node("text-condensation", get_data)

builder.add_edge(START, "pdf-2-text")
builder.add_edge("pdf-2-text", "text-condensation")
builder.add_edge("text-condensation", END)

graph = builder.compile()
