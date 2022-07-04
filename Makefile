DOCKERUSER=sanafathima418

build:
		docker build -t sample-docker-app . --platform linux/amd64

push: 
		docker tag sample-docker-app $(DOCKERUSER)/sample-docker-app:v1
		docker push $(DOCKERUSER)/sample-docker-app:v1
