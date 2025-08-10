FROM python:3.13

RUN mkdir /job
WORKDIR /job
ADD requirements.txt /job/
RUN pip install -r requirements.txt

ADD receive_message_queue_job.py /job/main.py
CMD ["python", "/job/main.py"]