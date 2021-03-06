FROM ubuntu:latest
MAINTAINER Brian Hopkins "brianhh1230@gmail.com"
RUN \
apt-get update -y && \
apt-get install -y python3-pip python3-dev build-essential git pandoc
COPY . /app
WORKDIR /app
RUN \
pip3 install pypandoc && \
ls -lah && \
pwd && \
pip3 install --no-cache-dir -r requirements.txt && \
git clone https://github.com/RasaHQ/rasa_core.git && \
cd rasa_core && \
pip3 install --no-cache-dir -r requirements.txt && \
python3 setup.py install
WORKDIR /app
RUN \
python3 -m spacy download en && \
python3 -m rasa_nlu.train -c nlu_model_config.json --fixed_model_name current && \
python3 -m rasa_core.train -s data/stories.md -d domain.yml -o models/dialogue
WORKDIR /app
RUN ["chmod", "+x", "entrypoint.sh"]
ENTRYPOINT ["./entrypoint.sh"]
