FROM ubuntu:latest
RUN apt-get update -y
RUN apt-get install -y python-pip python-dev build-essential wget
RUN mkdir -p /multichain
WORKDIR /multichain
ADD multichain.sh /multichain/multichain.sh
RUN /multichain/multichain.sh
COPY ./app /app
WORKDIR /app
RUN pip install -r /app/requirements.txt
ENTRYPOINT ["python"]
CMD ["app.py"]

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
