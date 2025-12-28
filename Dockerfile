# Use NVIDIA CUDA base image for GPU support
FROM nvidia/cuda:11.8.0-cudnn8-runtime-ubuntu22.04

# Set non-interactive installation
ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies
# python3-pyaudio and portaudio19-dev are for sounddevice
# alsa-utils is for aplay/arecord (used in bot.py)
RUN apt-get update && apt-get install -y \
    python3.10 \
    python3-pip \
    python3-venv \
    alsa-utils \
    portaudio19-dev \
    git \
    libsndfile1 \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy requirements first to leverage cache
COPY requirements.txt .

# Install Python dependencies
# Upgrade pip first
RUN python3.10 -m pip install --upgrade pip
RUN python3.10 -m pip install -r requirements.txt

# Copy application code
COPY . .

# Expose XTTS API port
EXPOSE 8002

# Environment variables
ENV PYTHONUNBUFFERED=1

# Command to run the bot
# Note: For audio input/output to work from a container, you typically need to pass devices
# e.g. docker run --device /dev/snd ...
CMD ["python3.10", "src/bot.py"]
