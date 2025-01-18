ARG PORT=443

FROM python:3.11-slim

# Install required system libraries
RUN apt-get update && apt-get install -y \
    python3-venv \
    libpq-dev \
    build-essential \
    && apt-get clean

# Create and activate a virtual environment
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Upgrade pip and install dependencies
COPY requirements.txt .
RUN pip install --upgrade pip && pip install -r requirements.txt

# Copy application code
COPY . .

CMD uvicorn main:app --host 0.0.0.0 --port $PORT

