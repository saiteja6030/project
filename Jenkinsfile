node{
	stage('kube executions')
 	{
 		def scmcheckout = 'git clone -b kubernatives https://github.com/saiteja6030/project.git'
		def killfolder = 'sudo rm -rf JavaWebCalculator'
 		def K8start = 'kubectl apply -f JavaWebCalculator/app.yml'
 		sshagent(['private'])
			{
				sh "ssh -o StrictHostKeyChecking=no ec2-user@172.31.69.141 ${scmcheckout}"			
				sh "ssh -o StrictHostKeyChecking=no ec2-user@172.31.69.141 ${K8start}"
				sh "ssh -o StrictHostKeyChecking=no ec2-user@172.31.69.141 ${killfolder}"
			}
	}
	
		
}
