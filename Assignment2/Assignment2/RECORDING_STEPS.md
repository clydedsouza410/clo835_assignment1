The recording must demonstrate the items below. The Kubernetes cluster creation can be omitted, but the cluster must be shown running on the EC2 instance. Use terminal + browser capture.
1.	1) Show local K8s cluster running on Amazon EC2 (single node; components healthy)
•	On EC2: kubectl get nodes -o wide
•	On EC2: kubectl get pods -A
•	State verbally: single node kind cluster on EC2; core components (etcd, apiserver, scheduler, controller-manager, coredns, kube-proxy) are running.
2.	2) Deploy MySQL and web applications as Pods in their respective namespaces
•	On EC2: kubectl get ns
•	Apply Pod manifests for mysql and employees namespaces (show the YAML files in repo briefly).
•	Show Pods Running: kubectl get pods -n mysql -o wide; kubectl get pods -n employees -o wide
•	Connect to web Pod using port-forward: kubectl -n employees port-forward pod/<pod-name> 8080:8080
•	In a second terminal tab: curl http://127.0.0.1:8080/ (show valid response)
•	Show logs reflect request: kubectl -n employees logs pod/<pod-name> --tail=50
3.	3) Deploy ReplicaSets with 3 replicas for both apps using labels app:employees and app:mysql
•	Apply RS manifests (web + mysql).
•	Show RS objects: kubectl get rs -A
•	Show pods scaled to 3: kubectl get pods -n employees; kubectl get pods -n mysql
•	Explain governance/adoption: labels must match selector; show 'Controlled By' for a pod using kubectl describe.
4.	4) Create Deployments for MySQL and web applications
•	Apply Deployment manifests (web + mysql).
•	Show Deployments and ReplicaSets: kubectl get deploy -A; kubectl get rs -A
•	Explain that Deployment uses matchLabels selectors from step 3; and that Deployment creates its own RS.
5.	5) Expose web application as NodePort 30000; demonstrate curl + browser access
•	Apply Services manifests (MySQL ClusterIP, web NodePort 30000).
•	Show services: kubectl get svc -A (ensure web shows 8080:30000)
•	On EC2: curl http://127.0.0.1:30000/ (valid response)
•	On laptop browser: http://<EC2_PUBLIC_IP>:30000/ (show the page)
6.	6) Roll out updated web application image version via Deployment manifest
•	Build/push a new web image tag (e.g., v2 or v2b) to ECR (briefly show ECR tags or CLI output).
•	Update Deployment image to the new tag: kubectl -n employees set image deploy/employees-deploy employees=<ECR_URI>:<NEW_TAG>
•	Show rollout: kubectl -n employees rollout status deploy/employees-deploy
•	Show new pods/RS: kubectl -n employees get rs; kubectl -n employees get pods
•	Demonstrate new version in browser (e.g., 'Employee Database - v2' + green background).
7.	7) Close-out proof
•	Restate answers included in report: API server IP, port reasoning, RS adoption, RS vs Deployment, service type rationale.
•	Confirm recording length <= 15 minutes.
