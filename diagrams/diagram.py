from diagrams import Diagram
from diagrams.k8s.compute import Deployment, Pod, ReplicaSet
from diagrams.k8s.network import Service

graph_attr = {
    "fontsize": "30",
    "bgcolor": "transparent",
    "pad": "0.8",
    "fixedsize": "shape",
    "fontname": "Roboto",
    "width": "10.0",
    "dpi": "200"
}

with Diagram("Hazelcast on Kubernetes",
             show=False, outformat="png", graph_attr=graph_attr):
    Service() >> Pod() << ReplicaSet() << Deployment()
