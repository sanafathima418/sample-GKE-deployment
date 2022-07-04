FROM python:3

ADD sample_app.py /

RUN pip install flask

CMD [ "python", "./sample_app.py" ]