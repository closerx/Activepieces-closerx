FROM ubuntu:22.04

# ------------------------------
# System dependencies
# ------------------------------
RUN apt-get update && apt-get install -y \
    python3 python3-pip python3-dev \
    ffmpeg libsndfile1 build-essential \
    wget curl git \
    && rm -rf /var/lib/apt/lists/*

# ------------------------------
# Install PaddlePaddle CPU
# (استخدم PyPI الرسمي وليس الميرور الصيني)
# ------------------------------
RUN pip3 install --no-cache-dir paddlepaddle==2.6.1

# ------------------------------
# Install PaddleSpeech
# ------------------------------
RUN pip3 install --no-cache-dir paddlespeech paddlespeech[server]

# ------------------------------
# Copy config
# ------------------------------
WORKDIR /app
COPY conf /app/conf

# ------------------------------
# Expose port
# ------------------------------
EXPOSE 8190

# ------------------------------
# Start server
# ------------------------------
CMD ["paddlespeech_server", "start", "--config_file", "conf/application.yaml"]# Start the realtime server
# ----------------------------------------------------
CMD ["paddlespeech_server", "start", "--config_file", "conf/application.yaml"]
