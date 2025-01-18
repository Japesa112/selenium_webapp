# Set a default port if not passed as an argument
ARG PORT=443

# Use the Cypress base image
FROM cypress/browsers:latest

# Ensure apt-get commands work correctly and install required tools
USER root
RUN apt-get update && \
    apt-get install -y python3 python3-pip

# Set the PATH to include the user base binary directory
ENV PATH=$HOME/.local/bin:$PATH

# Copy the requirements file
COPY requirements.txt .

# Install Python dependencies
RUN pip3 install --no-cache-dir -r requirements.txt

# Copy the application code
COPY . .

# Expose the specified port
EXPOSE $PORT

# Start the application using uvicorn
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "${PORT}"]
