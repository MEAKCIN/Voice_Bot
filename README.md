# Local Realtime Voice Bot

A low-latency, privacy-focused voice assistant that runs entirely locally. It combines state-of-the-art open-source models for Voice Activity Detection (VAD), Speech-to-Text (STT), Large Language Models (LLM), and Text-to-Speech (TTS).

## 🚀 Features

- **Real-time Interaction**: Seamless conversation loop with minimal latency.
- **100% Local**: No data leaves your machine. Powered by Ollama and local PyTorch models.
- **Multilingual Support**: Fully supports **English** and **Turkish**.
  - Automatic language detection during initialization.
  - Context-aware LLM responses (switches system prompts).
  - Native voice synthesis for the selected language.
- **High-Quality Audio**:
  - **Hearing**: OpenAI Whisper (Large V3) for accurate transcription.
  - **Speaking**: Coqui XTTS v2 for high-fidelity, expressive speech synthesis.
  - **VAD**: Silero VAD for precise endpointing.

## 🛠️ Architecture

The bot integrates four main components:
1. **VAD (Silero)**: Detects when you start and stop speaking.
2. **STT (Whisper)**: Transcribes your voice to text.
3. **LLM (Ollama/Qwen2.5)**: Generates intelligent responses.
4. **TTS (XTTS v2)**: Converts the AI's response back to speech.

## 📋 Requirements

* **OS**: Linux (Ubuntu Recommended)
* **GPU**: NVIDIA GPU with CUDA support (Recommended for acceptable latency).
* **Software**:
  * Python 3.10+
  * [Ollama](https://ollama.com/)
  * `ffmpeg` and `aplay` (ALSA utils)

## ⚡ Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/MEAKCIN/Voice_Bot.git
   cd Voice_Bot
   ```

2. **Install System Dependencies**
   ```bash
   sudo apt install ffmpeg alsa-utils
   ```

3. **Install Python Dependencies**
   It is recommended to use a virtual environment:
   ```bash
   python3 -m venv .venv
   source .venv/bin/activate
   pip install -r requirements.txt
   ```

4. **Setup Ollama**
   Ensure Ollama is installed. The startup script will attempt to pull the required model (`qwen2.5`) automatically.

## 🚦 Usage

Start the bot using the provided shell script. This script handles activating the environment and ensuring the backend services are running.

```bash
./scripts/run.sh
```

**How to interact:**
1. The bot will initialize and load all models (this may take a moment).
2. It will ask you to select a language by speaking.
   - Say **"English"** for English.
   - Say **"Türkçe"** for Turkish.
3. Once the language is set, simply speak into your microphone. The bot will listen, process, and respond audibly.
4. To stop the bot, use `Ctrl+C`.

## 📂 Project Structure

* `src/bot.py`: Main application loop and orchestration.
* `src/utils_*.py`: Wrapper classes for VAD, STT, LLM, and TTS.
* `src/xtts_server.py`: Dedicated server script for XTTS to isolate dependencies/processes.
* `scripts/run.sh`: Helper script to handle environment setup and startup.
* `models/`: Stores downloaded model weights (XTTS).

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.
