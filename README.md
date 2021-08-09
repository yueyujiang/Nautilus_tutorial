# Nautilus
This is a tutorial of basic usages of Nautilus. We will begin by introducing how to create a docker image and then turn to some examples on running job in nautilus cluster
## Prepare
Before we get started,
1. Clone this repo to your PC.    
`git clone https://github.com/yueyujiang/Nautilus_tutorial/ && cd Nautilus_tutorial`
2. Login at [this](https://nautilus.optiputer.net/) page. After the first login, you would become a guest. An admin users can add your account to a namespace and then you would become a user.
3. Install Kubernetes https://kubernetes.io/docs/tasks/tools/
4. Click the **Get Config** link on top right corner of the page and save the config file.
5. At terminal `mkdir ~/.kube` and put the config file to the `~/.kube` directory.
6. To make sure we are ready, type `kubectl get nodes` to list the cluster nodes.

## Kubernetes
Kubernetes is a open-source platform for managing containerized workloads and services. A lot of Docker container images are available at the [Docker webiste](https://hub.docker.com/search?q=&type=image). Kubernetes is compatible with those images. Now let's also try to create our own one.  
### Create Docker image
**Building image**
1. Create an account at [https://hub.docker.com/](https://hub.docker.com/)
2. Install Docker from [https://docs.docker.com/get-docker/](https://docs.docker.com/get-docker/)
4. Run Docker in your PC  
5. Build Docker image use  
`docker build -t gitlab-registry.nrp-nautilus.io/yueyujiang/nautilus_tutorial/build_tree:test ./dockerfile`  
6. Use `docker images` to check your built images
7. A docker image is built! Now try to start a contrainer on your local PC.   
`docker run -it --rm -v $PWD:/build_tree gitlab-registry.nrp-nautilus.io/yueyujiang/nautilus_tutorial/build_tree:v1`
(type `exit` to exit the container)

**Exporting image**  
1. Sign up an account at [https://gitlab.nrp-nautilus.io](https://gitlab.nrp-nautilus.io)
2. Create a new blank project called **nautilus_tutorial**
3. Login to Gitlab registry, in the command line   
`docker login gitlab-registry.nrp-nautilus.io -u $USERNAEM`
4. Push the image to GitLab  
`docker push gitlab-registry.nrp-nautilus.io/yueyujiang/nautilus_tutorial/build_tree:v1`

Now the container is ready to use. Let's go to creating a pod in Nautilus.

### Pod
Pods are the smallest deployable units of computing that you can create and manage in Kubernetes.    
**CPU pod**
1. Create a pod only request CPU resources.  
`kubectl create -f yamlfile/cpu-pod.yaml`. 
2. List the pods in our namespace, we should be able to see the pod we just created.
`kubectl get pods`
4. When the STATUS of the pod become `RUNNING`, go into the pod.      
`kubectl exec -it cpu-pod -- /bin/bash`.   
4. Create a pod request GPU resources.   
`kubectl create -f yamlfile/gpu-pod.yaml`.   
When the pod gets ready got into the pod (`kubectl exec -it gpu-pod -- /bin/bash`), type `gpustat -i 1 -c -u -P` to check the availibility of the GPU.

Remember to **delete the pod** whenever you finish your job. `kubectl delete pod pod_name`

**Storage**
1. Basic: emptyDir (This is a local scratch volumn, it would be gone once the pod is deleted)
2. Persistent storage (More info: https://ucsd-prp.gitlab.io/userdocs/storage/ceph-posix/):    
  a. Let's create a persistent volume.      
  `kubectl create -f yamlfile/pvc1.yaml`.   
  b. One more.    
  `kubectl create -f yamlfile/pvc2.yaml`.   
  c. Open yamlfile/cpu-pod-storage.yaml, see how we mount the volumns to the pod.      
  d. Let's create a pod with the two volumns mounted.     
  `kubectl create -f yamlfile/cpu-pod-storage.yaml` 
  
Delete the PVC when you don't need it `kubectl delete pvc pvc_name`
  
  ### Job
  One drawback of Pod is that it has time limit. A pod would be destroyed after 6 hours. Therefore, if we want to run long time job, we would like to create a Job instead of a Pod.
  1. Create a job.    
  `kubectl create -f yamlfile/cpu-job.yaml`
  2. All stdout and stderr output from the script will be preserved and accessible by running     
  `kubectl logs pod_name`
  
That is it! Hopefully you would have some ideas on how to work with Kubernetes now. Kubernetes is a powerful and well-developed platform. This repo only cover limited materials on Nautilus or Kubenetes. And honestly I don't fully understand it myself. Here are some resources that might help if you want to know more about this tool,
1. Kubernetes: https://kubernetes.io/
2. Communication system for Nautilus, https://element.nrp-nautilus.io/. You can ask question regarding nautilus here and admin in the group are very helpful!
