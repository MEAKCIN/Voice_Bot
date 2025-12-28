#!/bin/bash
source .venv/bin/activate
echo "Starting Realtime Voice Bot..."

# Check for Ollama (Model Server)
if ! pgrep -x "ollama" > /dev/null; then
    echo "Ollama server not running. Starting it..."
    # Try to start ollama in background
    ollama serve &
    # Wait for it to initialize
    sleep 5
else
    echo "Ollama server is already running."
fi

# Check if model exists
REQUIRED_MODEL="qwen2.5:latest"
if ! ollama list | grep -q "$REQUIRED_MODEL"; then
    echo "Model $REQUIRED_MODEL not found. Pulling..."
    ollama pull "$REQUIRED_MODEL"
else
    echo "Model $REQUIRED_MODEL found."
fi

# Check for XTTS v2 model
XTTS_MODEL_DIR="models/xtts_v2"
if [ ! -d "$XTTS_MODEL_DIR" ] || [ -z "$(ls -A $XTTS_MODEL_DIR)" ]; then
    echo "XTTS model not found in $XTTS_MODEL_DIR. Running download script..."
    python scripts/download_models.py
else
    echo "XTTS model found in $XTTS_MODEL_DIR."
fi

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(pwd)/.venv/lib/python3.13/site-packages/nvidia/cudnn/lib:$(pwd)/.venv/lib/python3.13/site-packages/nvidia/cublas/lib
# Run from root so relative paths work (or cd src)
# bot.py expects CWD to be root generally for finding .venv_xtts if hardcoded?
# Let's check bot.py. It uses os.getcwd() + "/.venv_xtts..."
# So we must run from project root.

python src/bot.py
