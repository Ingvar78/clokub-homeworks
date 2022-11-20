
```bash
va@c9v:~/Documents/14/clokub-homeworks  (HW-14.2)$ kubectl apply -f 14.2/vault-pod.yml
pod/14.2-netology-vault created
iva@c9v:~/Documents/14/clokub-homeworks  (HW-14.2)$ kubectl get pod
iva@c9v:~/Documents/14/clokub-homeworks  (HW-14.2)$ kubectl get pod 14.2-netology-vault -o json | jq -c '.status.podIPs'
[{"ip":"10.233.75.12"}]
iva@c9v:~/Documents/14/clokub-homeworks  (HW-14.2)$ kubectl run -i --tty fedora --image=fedora --restart=Never -- sh
If you don't see a command prompt, try pressing enter.
sh-5.1# dnf -y install pip
Fedora 37 - x86_64                                                                                   5.5 MB/s |  64 MB     00:11    
Fedora 37 openh264 (From Cisco) - x86_64                                                             1.9 kB/s | 2.5 kB     00:01    
Fedora Modular 37 - x86_64                                                                           3.0 MB/s | 3.0 MB     00:00    
Fedora 37 - x86_64 - Updates                                                                         2.8 MB/s |  14 MB     00:05    
Fedora Modular 37 - x86_64 - Updates                                                                 3.3 MB/s | 3.7 MB     00:01    
Dependencies resolved.
=====================================================================================================================================
 Package                               Architecture              Version                             Repository                 Size
=====================================================================================================================================
Installing:
 python3-pip                           noarch                    22.2.2-2.fc37                       fedora                    3.1 M
Installing weak dependencies:
 libxcrypt-compat                      x86_64                    4.4.28-3.fc37                       fedora                     89 k
 python3-setuptools                    noarch                    62.6.0-2.fc37                       fedora                    1.6 M

Transaction Summary
=====================================================================================================================================
Install  3 Packages

Total download size: 4.8 M
Installed size: 23 M
Downloading Packages:
(1/3): python3-setuptools-62.6.0-2.fc37.noarch.rpm                                                   5.8 MB/s | 1.6 MB     00:00    
(2/3): libxcrypt-compat-4.4.28-3.fc37.x86_64.rpm                                                     302 kB/s |  89 kB     00:00    
(3/3): python3-pip-22.2.2-2.fc37.noarch.rpm                                                          3.7 MB/s | 3.1 MB     00:00    
-------------------------------------------------------------------------------------------------------------------------------------
Total                                                                                                3.4 MB/s | 4.8 MB     00:01     
Running transaction check
Transaction check succeeded.
Running transaction test
Transaction test succeeded.
Running transaction
  Preparing        :                                                                                                             1/1 
  Installing       : python3-setuptools-62.6.0-2.fc37.noarch                                                                     1/3 
  Installing       : libxcrypt-compat-4.4.28-3.fc37.x86_64                                                                       2/3 
  Installing       : python3-pip-22.2.2-2.fc37.noarch                                                                            3/3 
  Running scriptlet: python3-pip-22.2.2-2.fc37.noarch                                                                            3/3 
  Verifying        : libxcrypt-compat-4.4.28-3.fc37.x86_64                                                                       1/3 
  Verifying        : python3-pip-22.2.2-2.fc37.noarch                                                                            2/3 
  Verifying        : python3-setuptools-62.6.0-2.fc37.noarch                                                                     3/3 

Installed:
  libxcrypt-compat-4.4.28-3.fc37.x86_64        python3-pip-22.2.2-2.fc37.noarch        python3-setuptools-62.6.0-2.fc37.noarch       

Complete!
sh-5.1# pip install hvac
Collecting hvac
  Downloading hvac-1.0.2-py3-none-any.whl (143 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 143.5/143.5 kB 2.8 MB/s eta 0:00:00
Collecting pyhcl<0.5.0,>=0.4.4
  Downloading pyhcl-0.4.4.tar.gz (61 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 61.1/61.1 kB 12.5 MB/s eta 0:00:00
  Installing build dependencies ... done
  Getting requirements to build wheel ... done
  Preparing metadata (pyproject.toml) ... done
Collecting requests<3.0.0,>=2.27.1
  Downloading requests-2.28.1-py3-none-any.whl (62 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 62.8/62.8 kB 15.6 MB/s eta 0:00:00
Collecting charset-normalizer<3,>=2
  Downloading charset_normalizer-2.1.1-py3-none-any.whl (39 kB)
Collecting idna<4,>=2.5
  Downloading idna-3.4-py3-none-any.whl (61 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 61.5/61.5 kB 12.4 MB/s eta 0:00:00
Collecting urllib3<1.27,>=1.21.1
  Downloading urllib3-1.26.12-py2.py3-none-any.whl (140 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 140.4/140.4 kB 11.0 MB/s eta 0:00:00
Collecting certifi>=2017.4.17
  Downloading certifi-2022.9.24-py3-none-any.whl (161 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 161.1/161.1 kB 10.7 MB/s eta 0:00:00
Building wheels for collected packages: pyhcl
  Building wheel for pyhcl (pyproject.toml) ... done
  Created wheel for pyhcl: filename=pyhcl-0.4.4-py3-none-any.whl size=50127 sha256=976f95296833ac126587fdcf3e5469e5a25e829d3565cfb0baeab2a4c1869611
  Stored in directory: /root/.cache/pip/wheels/e4/f4/3a/691e55b36281820a2e2676ffd693a7f7a068fab60d89353d74
Successfully built pyhcl
Installing collected packages: pyhcl, urllib3, idna, charset-normalizer, certifi, requests, hvac
Successfully installed certifi-2022.9.24 charset-normalizer-2.1.1 hvac-1.0.2 idna-3.4 pyhcl-0.4.4 requests-2.28.1 urllib3-1.26.12
WARNING: Running pip as the 'root' user can result in broken permissions and conflicting behaviour with the system package manager. It is recommended to use a virtual environment instead: https://pip.pypa.io/warnings/venv
sh-5.1# 
```

```bash
sh-5.1# python3
Python 3.11.0 (main, Oct 24 2022, 00:00:00) [GCC 12.2.1 20220819 (Red Hat 12.2.1-2)] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> import hvac
>>> client = hvac.Client(
...     url='http://10.233.75.12:8200',
...     token='aiphohTaa0eeHei'
... )
>>> client.is_authenticated()
True
>>> # Пишем секрет
>>> client.secrets.kv.v2.create_or_update_secret(
...     path='hvac',
...     secret=dict(netology='Big secret!!!'),
... )
{'request_id': 'd033fb33-6c94-7327-af2d-72154ec83270', 'lease_id': '', 'renewable': False, 'lease_duration': 0, 'data': {'created_time': '2022-11-20T21:30:38.094014072Z', 'custom_metadata': None, 'deletion_time': '', 'destroyed': False, 'version': 1}, 'wrap_info': None, 'warnings': None, 'auth': None}
>>> # Читаем секрет
>>> 
>>> client.secrets.kv.v2.read_secret_version(
...     path='hvac',
... )
{'request_id': '79db0209-a609-78a6-87c8-eb2ed7e474d5', 'lease_id': '', 'renewable': False, 'lease_duration': 0, 'data': {'data': {'netology': 'Big secret!!!'}, 'metadata': {'created_time': '2022-11-20T21:30:38.094014072Z', 'custom_metadata': None, 'deletion_time': '', 'destroyed': False, 'version': 1}}, 'wrap_info': None, 'warnings': None, 'auth': None}
>>> 

```