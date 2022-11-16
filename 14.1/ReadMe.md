
```bash
iva@c9v:~/Documents/14 $ kubectl get pods
No resources found in default namespace.
iva@c9v:~/Documents/14 $ kubectl get ns
NAME              STATUS   AGE
default           Active   49d
kube-node-lease   Active   49d
kube-public       Active   49d
kube-system       Active   49d
iva@c9v:~/Documents/14 $ kubectl get pods
No resources found in default namespace.
iva@c9v:~/Documents/14 $ kubectl get secret
No resources found in default namespace.
iva@c9v:~/Documents/14 $ kubectl get secrets
No resources found in default namespace.
```

```bash
iva@c9v:~/Documents/14 $ mkdir certs
iva@c9v:~/Documents/14 $ cd certs/
iva@c9v:~/Documents/14/certs $ openssl genrsa -out cert.key 4096
iva@c9v:~/Documents/14/certs $ openssl req -x509 -new -key cert.key -days 3650 -out cert.crt -subj '/C=RU/ST=Moscow/L=Moscow/CN=server.local'
iva@c9v:~/Documents/14/certs $ cd ..
iva@c9v:~/Documents/14 $ kubectl create secret tls domain-cert --cert=certs/cert.crt --key=certs/cert.key
secret/domain-cert created
iva@c9v:~/Documents/14 $ kubectl get secrets
NAME          TYPE                DATA   AGE
domain-cert   kubernetes.io/tls   2      39s
iva@c9v:~/Documents/14 $ kubectl get secret
NAME          TYPE                DATA   AGE
domain-cert   kubernetes.io/tls   2      48s
```

```bash
iva@c9v:~/Documents/14 $ kubectl get secret domain-cert
NAME          TYPE                DATA   AGE
domain-cert   kubernetes.io/tls   2      83s
iva@c9v:~/Documents/14 $ kubectl describe secret domain-cert
Name:         domain-cert
Namespace:    default
Labels:       <none>
Annotations:  <none>

Type:  kubernetes.io/tls

Data
====
tls.crt:  1944 bytes
tls.key:  3272 bytes

```

```bash
iva@c9v:~/Documents/14 $ kubectl get secret domain-cert -o yaml
apiVersion: v1
data:
  tls.crt: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUZiVENDQTFXZ0F3SUJBZ0lVWnRa<cut>
  tls.key: LS0tLS1CRUdJTiBQUklWQVRFIEtFWS0tLS0tCk1JSUpRZ0lCQURBTkJna3Foa2lHOXcw<cut>
kind: Secret
metadata:
  creationTimestamp: "2022-11-16T17:53:44Z"
  name: domain-cert
  namespace: default
  resourceVersion: "16429"
  uid: e5b588f7-f1d0-4348-87e0-ab4aed8978e2
type: kubernetes.io/tls

```

```bash
iva@c9v:~/Documents/14 $ kubectl get secret domain-cert -o json
{
    "apiVersion": "v1",
    "data": {
        "tls.crt": "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUZiVENDQTFXZ0F3SUJBZ0lVWnRa<cut>",
        "tls.key": "LS0tLS1CRUdJTiBQUklWQVRFIEtFWS0tLS0tCk1JSUpRZ0lCQURBTkJna3Foa2lHOXcw<cut>"
    },
    "kind": "Secret",
    "metadata": {
        "creationTimestamp": "2022-11-16T17:53:44Z",
        "name": "domain-cert",
        "namespace": "default",
        "resourceVersion": "16429",
        "uid": "e5b588f7-f1d0-4348-87e0-ab4aed8978e2"
    },
    "type": "kubernetes.io/tls"
}

```

```bash
iva@c9v:~/Documents/14 $ kubectl delete secret domain-cert
secret "domain-cert" deleted
iva@c9v:~/Documents/14 $ kubectl get secrets
No resources found in default namespace.
```

```bash
iva@c9v:~/Documents/14 $ kubectl apply -f domain-cert.yml
secret/domain-cert created
iva@c9v:~/Documents/14 $ kubectl get secrets
NAME          TYPE                DATA   AGE
domain-cert   kubernetes.io/tls   2      7s
```

Секреты доступны в зависимости от используемого namespace

```bash
iva@c9v:~/Documents/14 $ kubectl get ns
NAME              STATUS   AGE
default           Active   49d
kube-node-lease   Active   49d
kube-public       Active   49d
kube-system       Active   49d
stage             Active   25s
iva@c9v:~/Documents/14 $ kubectl config set-context --current --namespace=default
Context "kubernetes-admin@cluster.local" modified.
iva@c9v:~/Documents/14 $ kubectl get ns
NAME              STATUS   AGE
default           Active   49d
kube-node-lease   Active   49d
kube-public       Active   49d
kube-system       Active   49d
stage             Active   43s
iva@c9v:~/Documents/14 $ kubectl get secret
NAME          TYPE                DATA   AGE
domain-cert   kubernetes.io/tls   2      3m40s
```

[докер образ для тренировок nettols](https://hub.docker.com/r/jrecord/nettools)

```bash
iva@c9v:~/Documents/14/kub/stage $ kubectl apply -f 30-nettols.yaml
deployment.apps/mynettools unchanged
iva@c9v:~/Documents/14/kub/stage $ kubectl get secret
NAME              TYPE                DATA   AGE
domain-cert       kubernetes.io/tls   2      110m
testsecret-env    Opaque              2      65m
testsecret-yaml   Opaque              1      65m
iva@c9v:~/Documents/14/kub/stage $ kubectl get deploy
NAME         READY   UP-TO-DATE   AVAILABLE   AGE
myapp        0/1     1            0           61m
mynettools   1/1     1            1           53m
iva@c9v:~/Documents/14/kub/stage $ kubectl get pod
NAME                         READY   STATUS              RESTARTS   AGE
myapp-6d5d74f76c-zcls8       0/1     ContainerCreating   0          61m
mynettools-d58b87558-zsf5j   1/1     Running             0          5m24s
iva@c9v:~/Documents/14/kub/stage $ kubectl exec -it mynettools-d58b87558-zsf5j -- bash
[root@mynettools-d58b87558-zsf5j /]# echo $SECRET_USERNAME 
admin
[root@mynettools-d58b87558-zsf5j /]# echo $SECRET_PASSWORD 
some_password
[root@mynettools-d58b87558-zsf5j /]# cat /app/config.yaml  
apiUrl: "https://secret.site.tt/api/v1"
username: <admin>
password: <some_password>
[root@mynettools-d58b87558-zsf5j /]# cat etc/sec/         
..2022_11_16_20_17_51.703413158/ tls.crt                          
..data/                          tls.key                          
[root@mynettools-d58b87558-zsf5j /]# cat etc/sec/tls.crt 
-----BEGIN CERTIFICATE-----
MIIFbTCCA1WgAwIBAgIUZtZT/6kqh7whUzEnxn5O7dcq950wDQYJKoZIhvcNAQEL
BQAwRjELMAkGA1UEBhMCUlUxDzANBgNVBAgMBk1vc2NvdzEPMA0GA1UEBwwGTW9z
Y293MRUwEwYDVQQDDAxzZXJ2ZXIubG9jYWwwHhcNMjIxMTE2MTc1MzI5WhcNMzIx
<cut></cut>
5w==
-----END CERTIFICATE-----
[root@mynettools-d58b87558-zsf5j /]# 
