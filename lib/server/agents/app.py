from fastapi import FastAPI, UploadFile, File, HTTPException
import shutil
import os
from langgraph.graph import StateGraph
from typing import Dict, Any
from pydantic import BaseModel

# Import your existing functions and graph setup
from agent import graph, ResPaperExtractState, PPTPresentation

app = FastAPI()
UPLOAD_DIR = "uploaded_pdfs"
os.makedirs(UPLOAD_DIR, exist_ok=True)

class PPTResponse(BaseModel):
    title: str
    authors: list[str]
    institution: str
    slides: list[dict[str, Any]]

@app.post("/generate-ppt", response_model=PPTResponse)
def generate_ppt(file: UploadFile = File(...)):
    """Endpoint to process a PDF file and generate structured PPT content."""
    pdf_path = os.path.join(UPLOAD_DIR, file.filename)
    
    try:
        with open(pdf_path, "wb") as buffer:
            shutil.copyfileobj(file.file, buffer)
        
        # Initialize state
        state: ResPaperExtractState = {"pdf_path": pdf_path}
        
        # Run the graph workflow
        result: Dict[str, Any] = graph.invoke(state)
        ppt_object: PPTPresentation = result.get("ppt_object")
        
        return ppt_object
    
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Processing error: {str(e)}")
    
    finally:
        os.remove(pdf_path)  # Cleanup uploaded file

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
