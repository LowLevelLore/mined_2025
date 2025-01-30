from flask import Flask, request, send_file, after_this_request
from gtts import gTTS
import os
import io
import time

app = Flask(__name__)

"""gTTS languages options:
    hi -> Hindi
    en -> English
    fr -> French
    
    Returns:
        _type_: audio file
"""


@app.route("/generate-audio", methods=["POST"])
def generate_audio():
    if request.method == "POST":
        if request.is_json:
            req = request.get_json()
            text = req.get("text")
            language = req.get("language")
            if language not in ["hi", "en"]:
                raise ValueError("Unsupported Language!!")
            filename = f"audio/{time.strftime('%Y%m%d-%H%M%S')}.mp3"

            out = gTTS(text=text, lang=language, slow=False)
            out.save(filename)

            return_data = io.BytesIO()
            with open(filename, "rb") as fo:
                return_data.write(fo.read())
            return_data.seek(0)
            os.remove(filename)

            return send_file(
                return_data,
                mimetype="audio/mpeg",
            )


if __name__ == "__main__":
    port = int(os.environ.get("PORT", 5000))
    app.run(host="0.0.0.0", port=port)
