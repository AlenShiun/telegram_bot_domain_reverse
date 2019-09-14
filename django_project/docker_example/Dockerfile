FROM python:3.7.4
LABEL maintainer alen.tsai
ENV PYTHONUNBUFFERED 1
RUN mkdir /project
RUN mkdir /project/log
WORKDIR /project
COPY . /project
RUN pip install -r requirements.txt
RUN chmod a+x docker-entrypoint.sh

ENTRYPOINT ["./docker-entrypoint.sh"]

