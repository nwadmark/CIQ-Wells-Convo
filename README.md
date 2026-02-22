# CIQ Wells Convo

##  CIQ AI Assistant – WF Network Ops Prototype

An AI-powered conversational assistant prototype built for Cisco CX/CIQ, 
demonstrating intelligent self-service for enterprise network operations teams.

## What It Does

- Persona-based AI assistant supporting multiple roles: Network Ops, Executive, TAC
- Natural language Q&A for network infrastructure queries
- Voice input support via Web Speech API (speak your question, it auto-sends)
- Smart responses to queries like "What are the top risks?", "How do I file a TAC case?", "Show me PSIRTs"
- TAC Integration: file support tickets via voice or text
- Graceful degradation if browser doesn't support voice

## How to Run Locally

1. Clone the repo
2. Run `python3 -m http.server 8000`
3. Open `http://localhost:8000/wells_fargo_network_ops.html`

## Live Demo

[View on GitHub Pages](https://nwadmark.github.io/CIQ-Wells-Convo/wells_fargo_network_ops.html)

## Built With

- Vanilla HTML/CSS/JavaScript
- Web Speech API for voice input
- Claude Code (AI-assisted development)
