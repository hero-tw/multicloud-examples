apply:
	sed 's/$$JENKINS_VOLUME_ID/'`cd ../aws; terraform output jenkins-volume`'/g' jenkins-env.yaml | kubectl apply -f -
