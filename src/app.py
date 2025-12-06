from flask import Flask, request, jsonify
from datetime import datetime
import os

app = Flask(__name__)

@app.route("/", methods=["GET"])
def root():
    # Current timestamp in ISO 8601 format (UTC)
    timestamp = datetime.utcnow().isoformat() + "Z"

    # Extract client IP
    if request.headers.get("X-Forwarded-For"):
        ip = request.headers.get("X-Forwarded-For").split(",")[0].strip()
    else:
        ip = request.remote_addr

    return jsonify({
        "timestamp": timestamp,
        "ip": ip
    })

if __name__ == "__main__":
    port = int(os.environ.get("PORT", 8080))
    app.run(host="0.0.0.0", port=port)
