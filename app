from flask import Flask, request, jsonify
from transformers import pipeline

app = Flask(__name__)
sentiment = pipeline("sentiment-analysis")

@app.route("/sentiment", methods=["POST"])
def analyze():
    data = request.get_json(force=True)
    text = data.get("text", "")
    if not text:
        return jsonify({"error": "No text provided"}), 400
    result = sentiment(text)[0]
    return jsonify(result)

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000)
