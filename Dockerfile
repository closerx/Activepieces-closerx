# ----------------------------------------------------
# Base Image
# ----------------------------------------------------
FROM python:3.10-slim

# ----------------------------------------------------
# Install system dependencies
# ----------------------------------------------------
RUN apt-get update && apt-get install -y \
    libsndfile1 \
    ffmpeg \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# ----------------------------------------------------
# Install PaddlePaddle (CPU)
# ----------------------------------------------------
RUN pip install --no-cache-dir paddlepaddle -i https://mirror.baidu.com/pypi/simple

# ----------------------------------------------------
# Install PaddleSpeech
# ----------------------------------------------------
RUN pip install --no-cache-dir paddlespeech paddlespeech[server]

# ----------------------------------------------------
# Copy server configs
# ----------------------------------------------------
WORKDIR /app
COPY conf /app/conf

# ----------------------------------------------------
# Expose port for Railway
# ----------------------------------------------------
EXPOSE 8190

# ----------------------------------------------------
# Start the realtime server
# ----------------------------------------------------
CMD ["paddlespeech_server", "start", "--config_file", "conf/application.yaml"]
