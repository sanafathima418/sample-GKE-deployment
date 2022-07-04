	1. Create python program( flask app for simplicity)
	2. In the same directory create a file named "Dockerfile"
	3. Add commands to the dockerfile wrt. Base image and python script you want to deploy (base image can be obtained by googling)
	4. Build the docker image using - docker build -t "name of image" .
	5. Check docker images in system using "docker images"
	6. To run the application on docker - docker run -it "name of docker image" : THIS IS A CONTAINER
	7. -d in place of -it runs the app in the background and can be checked using  - "docker ps"
	8. To kill container running on docker - docker kill "container id" - container id can be obtained from docker ps

Moving the app to Kubernetes (GKE cluster)

	1. Check connection between docker container, host and browser: Give port number on docker run - docker run -d -p 8500:8500 sample-docker-app
	2. Create a GKE cluster to run the app on the web on instead of local host: Goto Google Cloud Console - > Kubernetes - >Create Cluster and then specify the specs in node, security etc and then click 'Connect'.
	3. Connect local machine to created cluster: Copy cluster credentials from cloud shell terminal by opening - cat ~/.kube/config.
	4. Download Google Cloud SDK onto local system
	5. Copy contents of opened file into local file named '~/.kube/config' and change name of cmd-path to the place where google sdk is downloaded on local system(navigate to bin/gcloud)
	6. To check if terminal is connected test using. - kubectl get pods(No resources at the moment)
	7. Create a deployment file called Deployment.yaml(or anything): Copy contents from internet
	8. To ensure Kubernetes can access the created docker image push the image to registry: Create docker image using Makefile under build section -  docker build -t "image name" .  --platform linux/amd64
	9. "make build" creates the docker image
	10. Push the docker image to registry: Include code under push section - First login using cmd "docker login" and then include code in the push section of make file with 
	"docker tag sample-docker-app $(DOCKERUSER)/sample-docker-app:v1
	 docker push $(DOCKERUSER)/sample-docker-app:v1"
	"make push" pushes the image to registry
	11. Change the name of image on deployment file to the username/imagename (as given on the make file)
	12. Deploy app on Kubernetes: kubectl create -f Deployment.yaml 
	13. Check running pods using kubectl get pods
	14. View the running application(Flask app): Create a service - using a file - "service.yaml" where target port is same as container port and name and app are same as that on deployment file
	15. To create the service - kubectl create -f service.yaml and view services - kubectl get svc
	16. To change internal port to external: Patch the service file by including a section "type: LoadBalancer" after the ports section - kubectl apply-f service.yaml(for rewrite)
	17. Keep checking get svc until external IPis assigned
	18. Once IP is assigned checked against the external_ip/port to see the flask app running

	
	
	
	
	
	
