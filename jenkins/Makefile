apply:
	read -p "Initial Jenkins Admin Password: " JENKINS_PASSWORD; \
	sed 's/$$JENKINS_VOLUME_ID/'`cd ../aws; terraform output jenkins-volume | sed 's/\//\\\\\//g' `'/g' env.yaml | \
	sed 's/$$JENKINS_GRADLE_VOLUME_ID/'`cd ../aws; terraform output jenkins-gradle-volume | sed 's/\//\\\\\//g' `'/g' | \
	sed 's/$$JENKINS_PASSWORD/'`printf $$JENKINS_PASSWORD | base64`'/g' | \
	kubectl apply -f -

	sed 's/$$SONAR_POSTGRES_URL/'`cd ../aws; terraform output sonar-postgres-address  | sed 's/\//\\\\\//g' `'/g' pod.yaml | \
	sed 's/$$SONAR_POSTGRES_PASSWORD/'`cd ../aws; terraform output sonar-postgres-password`'/g' | \
	kubectl apply -f -

	kubectl apply -f load-balancer.yaml
	while [ `kubectl get service jenkins-lb -o json | jq .status.loadBalancer.ingress[0].hostname | sed s/\"//g` == "null" ]; do sleep 1; done;
	echo Jenkins is now running at http://`kubectl get service jenkins-lb -o json | jq .status.loadBalancer.ingress[0].hostname | sed s/\"//g`:8080
	echo SonarQube is now running at http://`kubectl get service jenkins-lb -o json | jq .status.loadBalancer.ingress[0].hostname | sed s/\"//g`:9000/sonar/
	echo DNS might take a few minutes to begin working.
