node{
	stage('SCM Checkout')
 	{
       git branch: 'master', url: 'https://github.com/saiteja6030/JavaWebCalculator.git'
	}
	stage('Mvn Package')
	{
    	def mvnHome = tool name: 'maven-3', type: 'maven'
    	def mvnCMD = "${mvnHome}/bin/mvn"
    	sh "${mvnCMD} clean package"
   	}
	stage('Build Docker Image')
	{
    	sh 'docker build -t 8639628479/tomcatdocker:tomcatdevops .'
	}
	
	stage('Push Docker Image')
	{
    	withCredentials([string(credentialsId: 'docker-hub', variable: 'dockerHubPwd')]) 
    	{
        	sh "docker login -u 8639628479 -p ${dockerHubPwd}"
    	}
    	sh 'docker push 8639628479/tomcatdocker:tomcatdevops'
	}
	
	stage('Remove Previous Container')
	{
		try
		{
			def dockerRm = 'docker rm -f 8639628479/tomcatdocker'
			sshagent(['dev-server'])
			{
				sh "ssh -o StrictHostKeyChecking=no ec2-user@172.31.86.255 ${dockerRm}"
			}
		}
		catch(error)
		{
		//  do nothing if there is an exception
		}
	}	
	stage('Deploy to Dev Environment')
	{
   		def dockerRun = 'docker run -d --name tomcatcontainer -p 8080:8080 8639628479/tomcatdocker:tomcatdevops'
    	sshagent(['dev-server']) 
    	{
    		sh "ssh -o StrictHostKeyChecking=no ec2-user@172.31.86.255 ${dockerRun}"
   		}

 	}

}
