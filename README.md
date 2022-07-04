# Creating the python app and Docker Image	
	
- Create python program( flask app for simplicity)
- In the same directory create a file named "Dockerfile"
- Add commands to the dockerfile wrt. Base image and python script you want to deploy (base image can be obtained by googling)
- Build the docker image using - docker build -t "name of image" .
- Check docker images in system using "docker images"
- To run the application on docker - docker run -it "name of docker image" : THIS IS A CONTAINER
- -d in place of -it runs the app in the background and can be checked using  - "docker ps"
- To kill container running on docker - docker kill "container id" - container id can be obtained from docker ps

# Moving the app to Kubernetes (GKE cluster)

- Check connection between docker container, host and browser: Give port number on docker run - docker run -d -p 8500:8500 sample-docker-app
- Create a GKE cluster to run the app on the web on instead of local host: Goto Google Cloud Console - > Kubernetes - >Create Cluster and then specify the specs in node, security etc and then click 'Connect'.
- Connect local machine to created cluster: Copy cluster credentials from cloud shell terminal by opening - cat ~/.kube/config.
- Download Google Cloud SDK onto local system
- Copy contents of opened file into local file named '~/.kube/config' and change name of cmd-path to the place where google sdk is downloaded on local system(navigate to bin/gcloud)
- To check if terminal is connected test using. - kubectl get pods(No resources at the moment)
- Create a deployment file called Deployment.yaml(or anything): Copy contents from internet
- To ensure Kubernetes can access the created docker image push the image to registry: Create docker image using Makefile under build section -  docker build -t "image name" .  --platform linux/amd64
- "make build" creates the docker image
- Push the docker image to registry: Include code under push section - First login using cmd "docker login" and then include code in the push section of make file with 
	"docker tag sample-docker-app $(DOCKERUSER)/sample-docker-app:v1
	 docker push $(DOCKERUSER)/sample-docker-app:v1"
	"make push" pushes the image to registry
- Change the name of image on deployment file to the username/imagename (as given on the make file)
- Deploy app on Kubernetes: kubectl create -f Deployment.yaml 
- Check running pods using kubectl get pods
- View the running application(Flask app): Create a service - using a file - "service.yaml" where target port is same as container port and name and app are same as that on deployment file
- To create the service - kubectl create -f service.yaml and view services - kubectl get svc
- To change internal port to external: Patch the service file by including a section "type: LoadBalancer" after the ports section - kubectl apply-f service.yaml(for rewrite)
- Keep checking get svc until external IPis assigned
- Once IP is assigned checked against the external_ip/port to see the flask app running

	
	
	
	
	
	
