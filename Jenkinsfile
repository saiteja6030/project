node{
	stage('SCM Checkout')
 	{
       git branch: 'master', url: 'https://github.com/saiteja6030/project.git'
	}
	stage('Mvn Package')
	{
    	def mvnHome = tool name: 'maven-3', type: 'maven'
    	def mvnCMD = "${mvnHome}/bin/mvn"
    	sh "${mvnCMD} clean package"
   	}
	stage('Build Docker Image')
	{
	sh 'sudo service docker start'
    	sh 'docker build -t 8639628479/tomcatdocker:tomcatdevops .'
	}
	
	stage('Push Docker Image')
	{
    	withCredentials([string(credentialsId: 'dockerpwd', variable: 'dockerHubPwd')]) 
    	{
        	sh "docker login -u 8639628479 -p ${dockerHubPwd}"
    	}
    	sh 'docker push 8639628479/tomcatdocker:tomcatdevops'
	}
	
	
	stage('Remove Previous container')
	{
		try
		{
			def dockerstart = ' sudo service docker start'
			def dockerRm = 'docker rm -f tomcatcontainer'
			sshagent(['private'])
			{
				sh "ssh -o StrictHostKeyChecking=no ec2-user@172.31.69.141 ${dockerstart}"
				sh "ssh -o StrictHostKeyChecking=no ec2-user@172.31.69.141 ${dockerRm}"
			}
		}
		catch(error)
		{
		//  do nothing if there is an exception
		}
	}
	
	stage('Remove Previous Image')
	{
		
		try
		{
			def dockerRm = 'docker rmi -f 8639628479/tomcatdocker:tomcatdevops'
			sshagent(['private'])
			{
				sh "ssh -o StrictHostKeyChecking=no ec2-user@172.31.69.141 ${dockerRm}"
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
    	sshagent(['private']) 
    	{
    		sh "ssh -o StrictHostKeyChecking=no ec2-user@172.31.69.141 ${dockerRun}"
   		}

 	}

}
