apply:
	sed 's/$$JENKINS_VOLUME_ID/'`cd ../aws; terraform output jenkins-volume`'/g' env.yaml | kubectl apply -f -
	kubectl apply -f pod.yaml
	kubectl apply -f load-balancer.yaml
	while [ `kubectl get service jenkins-lb -o json | jq .status.loadBalancer.ingress[0].hostname | sed s/\"//g` == "null" ]; do sleep 1; done;
	echo Jenkins is now running at http://`kubectl get service jenkins-lb -o json | jq .status.loadBalancer.ingress[0].hostname | sed s/\"//g`:8080
	echo DNS might take a few minutes to begin working.
