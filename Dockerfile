# Use NVIDIA CUDA 12.4 runtime base (matches torch 2.5.1+cu124)
FROM nvidia/cuda:12.4.1-runtime-ubuntu22.04

# Set non-interactive installation
ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies
# We add deadsnakes PPA to get Python 3.11 on Ubuntu 22.04
RUN apt-get update && apt-get install -y \
    software-properties-common \
    && add-apt-repository ppa:deadsnakes/ppa \
    && apt-get update && apt-get install -y \
    python3.11 \
    python3.11-venv \
    python3.11-dev \
    python3-pip \
    alsa-utils \
    portaudio19-dev \
    git \
    libsndfile1 \
    liblzma-dev \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Install pip for Python 3.11
RUN curl -sS https://bootstrap.pypa.io/get-pip.py | python3.11

# Set working directory
WORKDIR /app

# Copy requirements first to leverage cache
COPY requirements.txt .

# Install Python dependencies
RUN python3.11 -m pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY . .

# Expose XTTS API port
EXPOSE 8002

# Environment variables
ENV PYTHONUNBUFFERED=1

# Command to run the bot
CMD ["python3.11", "src/bot.py"]
