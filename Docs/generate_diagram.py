
from diagrams import Diagram, Cluster
from diagrams.onprem.client import User
from diagrams.onprem.vcs import Github, Git
from diagrams.onprem.ci import GithubActions
from diagrams.onprem.container import Docker

from diagrams.aws.devtools import Codebuild
from diagrams.aws.compute import ECR
from diagrams.aws.database import RDS

from diagrams.k8s.compute import Deployment, Pod
from diagrams.k8s.network import Service
from diagrams.k8s.infra import Node


with Diagram("CI/CD Pipeline for Spring PetClinic", show=False, filename="/home/ubuntu/Projects/spring-petclinic/Docs/cicd_architecture", direction="LR"):

    developer = User("Developer")

    with Cluster("Version Control (GitHub)"):
        vcs = Github("GitHub Repo")

    with Cluster("CI Server (GitHub Actions)"):
        ci_pipeline = GithubActions("CI Pipeline")
        with Cluster("Pipeline Steps"):
            build_test = Codebuild("Build & Test")
            build_image = Docker("Build Image")
            push_image = ECR("Push to ECR")
            deploy_k8s = Node("Deploy to K8s")

    with Cluster("Artifact Repository"):
        registry = ECR("Container Registry")

    with Cluster("Kubernetes Cluster (EKS)"):
        k8s_service = Service("Service")
        k8s_deployment = Deployment("Deployment")
        k8s_pods = [Pod("Pod 1"), Pod("Pod 2")]
        db = RDS("PostgreSQL DB")

    developer >> Git("Git Push") >> vcs
    vcs >> ci_pipeline
    ci_pipeline >> build_test >> build_image >> push_image >> registry
    push_image >> deploy_k8s
    deploy_k8s >> k8s_service >> k8s_deployment >> k8s_pods
    k8s_pods >> db
