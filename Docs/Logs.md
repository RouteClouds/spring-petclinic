 aws eks update-kubeconfig --name petclinic-cluster --region us-east-1
Added new context arn:aws:eks:us-east-1:867344452513:cluster/petclinic-cluster to /home/geek/.kube/config
geek@ubuntu-24:~$ kubectl get namespaces
NAME              STATUS   AGE
default           Active   141m
kube-node-lease   Active   141m
kube-public       Active   141m
kube-system       Active   141m
geek@ubuntu-24:~$ kubectl get pods
NAME                         READY   STATUS             RESTARTS   AGE
petclinic-78b6dfbdf9-bdkxm   0/1     ImagePullBackOff   0          22m
geek@ubuntu-24:~$ kubectl describe pod petclinic-78b6dfbdf9-bdkxm
Name:             petclinic-78b6dfbdf9-bdkxm
Namespace:        default
Priority:         0
Service Account:  default
Node:             ip-10-0-102-213.ec2.internal/10.0.102.213
Start Time:       Wed, 03 Sep 2025 13:44:14 +0530
Labels:           app=petclinic
                  pod-template-hash=78b6dfbdf9
Annotations:      <none>
Status:           Pending
IP:               10.0.102.71
IPs:
  IP:           10.0.102.71
Controlled By:  ReplicaSet/petclinic-78b6dfbdf9
Containers:
  petclinic:
    Container ID:   
    Image:          867344452513.dkr.ecr.us-east-1.amazonaws.com/petclinic:latest
    Image ID:       
    Port:           8080/TCP
    Host Port:      0/TCP
    State:          Waiting
      Reason:       ImagePullBackOff
    Ready:          False
    Restart Count:  0
    Liveness:       http-get http://:8080/actuator/health/liveness delay=10s timeout=1s period=5s #success=1 #failure=3
    Readiness:      http-get http://:8080/actuator/health/readiness delay=10s timeout=1s period=5s #success=1 #failure=3
    Environment:
      SPRING_PROFILES_ACTIVE:      postgres
      SPRING_DATASOURCE_URL:       jdbc:postgresql://petclinic-db.c6t4q0g6i4n5.us-east-1.rds.amazonaws.com:5432/petclinic
      SPRING_DATASOURCE_USERNAME:  <set to the key 'POSTGRES_USER' in secret 'petclinic-db'>      Optional: false
      SPRING_DATASOURCE_PASSWORD:  <set to the key 'POSTGRES_PASSWORD' in secret 'petclinic-db'>  Optional: false
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-xbb5j (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             False 
  ContainersReady   False 
  PodScheduled      True 
Volumes:
  kube-api-access-xbb5j:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type     Reason     Age                   From               Message
  ----     ------     ----                  ----               -------
  Normal   Scheduled  22m                   default-scheduler  Successfully assigned default/petclinic-78b6dfbdf9-bdkxm to ip-10-0-102-213.ec2.internal
  Normal   Pulling    21m (x4 over 22m)     kubelet            Pulling image "867344452513.dkr.ecr.us-east-1.amazonaws.com/petclinic:latest"
  Warning  Failed     21m (x4 over 22m)     kubelet            Failed to pull image "867344452513.dkr.ecr.us-east-1.amazonaws.com/petclinic:latest": rpc error: code = NotFound desc = failed to pull and unpack image "867344452513.dkr.ecr.us-east-1.amazonaws.com/petclinic:latest": failed to resolve reference "867344452513.dkr.ecr.us-east-1.amazonaws.com/petclinic:latest": 867344452513.dkr.ecr.us-east-1.amazonaws.com/petclinic:latest: not found
  Warning  Failed     21m (x4 over 22m)     kubelet            Error: ErrImagePull
  Warning  Failed     20m (x6 over 22m)     kubelet            Error: ImagePullBackOff
  Normal   BackOff    2m30s (x87 over 22m)  kubelet            Back-off pulling image "867344452513.dkr.ecr.us-east-1.amazonaws.com/petclinic:latest"
geek@ubuntu-24:~$ 