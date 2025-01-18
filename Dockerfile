# Use the Cypress base image
FROM cypress/browsers:latest

# Install Python and pip
USER root
RUN apt-get update && apt-get install -y python3 python3-pip python3-venv

# Create and activate a virtual environment
ENV VIRTUAL_ENV=/opt/venv
RUN python3 -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# Copy the requirements and install dependencies inside the virtual environment
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application code
COPY . .

# Set the default command
CMD ["uvicorn", "selenium_webapp:app", "--host", "0.0.0.0", "--port", "${PORT}"]
