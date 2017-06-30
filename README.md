docker-ssh
==========


----------


    docker build -t centos7-ssh .

    docker run -d -p 32768:80 -p 32769:22 --name my-centos-ssh centos7-ssh
    docker inspect my-centos-ssh
    docker port my-centos-ssh 22

