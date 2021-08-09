# Nautilus
This is a tutorial of some basic usages of Nautilus. 
## Prepare
Before we get started,
1. Login at [this](https://nautilus.optiputer.net/) page. After the first login, you would become a guest. And admin users can add your account to a namespace to become the user.
2. Clone this repo to your PC
## Kubernetes
Kubernetes is a open-source platform for managing containerized workloads and services. A lot of Docker container images are available at the [Docker webiste](https://hub.docker.com/search?q=&type=image). Kubernetes is compatible with those images. Now let's also try to create our own one.  
### Create Docker image
**Building image**
1. Create an account [here](https://hub.docker.com/)
2. Install docker from [this page](https://docs.docker.com/get-docker/) (Note that if you use Mac with Apple silicon, you should install Rosetta 2 `softwareupdate --install-rosetta`)
4. Run Docker in your PC  
5. Build docker image use  
`docker build -t gitlab-registry.nrp-nautilus.io/$USERNAME/nautilus_tutorial/build_tree:latest .`  
6. Start a contrainer.   
`docker run -it --rm -v $PWD:/build_tree gitlab-registry.nrp-nautilus.io/yueyujiang/nautilus_tutorial/build_tree:v1`

**Exporting image**  
1. Sign up an account at [here](https://gitlab.nrp-nautilus.io)
2. Login to Gitlab registry, in the command line   
`docker login gitlab-registry.nrp-nautilus.io -u $USERNAEM`
4. Push the image to GitLab  
`docker push gitlab-registry.nrp-nautilus.io/yueyujiang/nautilus_tutorial:test1`

### Pod
Pods are the smallest deployable units of computing that you can create and manage in Kubernetes.
**CPU pod**
1. Create a pod only request CPU.  
`kubectl create -f cpu-pod.yaml`. 
2. Create a pod request GPU. 
`kubectl create -f gpu-pod.yaml`

**Storage**
