ARG PORT=443

FROM cypress/base:latest

RUN apt-get update && apt-get install -y python3 python3-pip
RUN echo $(python3 -m site --user-base)

COPY requirements.txt .
ENV PATH /root/.local/bin:$PATH

RUN pip install -r requirements.txt
COPY . .

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "$PORT"]
