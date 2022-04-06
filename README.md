**Question 1**

**Reasons for NGINX reverse proxy**

NGINX reverse proxy are mostly used by the origin application servers. 
The NGINX web servers are deployed in front of the application servers to receive users' request, 
passes it to the application server and return the response from the application server back to the users'.
They are used for enhancing application server security as they handle the request from the user most times 
through the internet and pass it to the application server deployed in the private subnet.

The NGINX web server to handle requests from the internet is set up in a public subnets.

Edit the NGNIX default.conf configuration file to handle and send requests to the application server located in
/etc/nginx/conf.d/default.conf.

Define the proxy_pass to point to the application server with Private IP address of 172.17.0.2
listening on port 5000.

server {
 listen 80;
 location / {
 proxy_pass http://172.17.0.2:5000;
 proxy_http_version 1.1;
 proxy_set_header Upgrade $http_upgrade;
 proxy_set_header Connection 'upgrade';
 proxy_set_header Host $host;
 proxy_cache_bypass $http_upgrade;
 }
}

**Question 2**
Assuming we have an EC2 t3a.small instance running that is managed with Terraform, the local 
configuration file is edited and the instance type is changed to t3a.large ,
if the terraform apply command is run, what would happen?

The t3a.small instance will be destroyed when **terraform apply** command is run and the new instance of t3a.large
will be created.

**Question 3**
Imagine you have a DB backup dump/file which is compressed to tar.gz format and its size is 2TB. 
We always need to share this file between different EC2 instances, can you provide steps?


The DB backup dump file can be shared among different EC2 instances using the AWS elastic files system. 
The elastic files system in mounted on the EC2 instances for access to the DB dump file.

Go to AWS EFS (Elastic File system), Click on the create button to create new file storage.

Click on the file system ID and click on the attach button to get the file system connection 
string using the EFS mount helper.

SSH to the EC2 instances and run the command sudo yum install -y amazon-efs-utils.

Make a directory efs on the EC2 instance, this is the directory that connects to the file system.

Run the command from the EFS mount helper **sudo mount -t efs -o tls <NFS name>/ efs** 
Run the command **df -h** to show mounted drives on the machine and confirm if the NFS drive has been mounted.

**Question 4**

You have ssh access to an Ubuntu or Debian Linux server, the disk is full and you need to clean it up, 
what would you do and which specific commands should you run?

Check the sizes of the mounted drive on the server by running the command **df -h**

An option is to remove unwanted dependencies from the debian package manager apt, 
using the command **sudo apt-get autoremove**.

Files with sizes greater than a defined size can be deleted manually from the server
using the command **sudo find / -type f -size +80M -exec ls -lh {} \;** ( The command finds file greater than
80Mb on the server).

Run the rm -rf <directory name> rm <filename> to remove unwanted files from the server.
