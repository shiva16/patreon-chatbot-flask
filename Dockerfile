FROM ubuntu:latest
MAINTAINER Brian Hopkins "brianhh1230@gmail.com"
RUN apt-get update -y
RUN apt-get install -y python3-pip python3-dev build-essential
COPY . /app
WORKDIR /app/web
RUN pip3 install -r requirements.txt
RUN git clone https://github.com/Geeked-Out-Solutions/patreon-rasa-model.git
RUN cd patreon-rasa-model
RUN ls -lah
ENTRYPOINT ["python3"]
RUN ["python3 -m spacy download en"]
CMD ["app.py"]
