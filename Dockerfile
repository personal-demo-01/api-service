FROM python:3.8-slim-buster
WORKDIR /python-docker

COPY requirements.txt ./
RUN pip3 install -r requirements.txt

COPY sqlite-create.py ./
RUN python3 sqlite-create.py

COPY . .
ENV APP_SETTINGS=config.DevelopmentConfig
EXPOSE 5000
CMD [ "python3", "-m" , "flask", "run", "--host=0.0.0.0"]