
```
cd win7
vagrant up
```


```bash
# 把box文件添加到虚拟机
vagrant box add centosMix https://mirrors.ustc.edu.cn/centos-cloud/centos/7/vagrant/x86_64/images/CentOS-7.box
# 初始化虚拟机box文件
vagrant init centosMix
# 启动虚拟机
vagrant up --provider=virtualbox --color
# 查看状态
vagrant status
```


```bash
agrant up
vagrant stauts
vagrant ssh <name>
vagrant ssh-config
vagrant suspend/resume/reload/hat <name>
vagrant destroy <name>
vagrant destroy -f       强制删除所有虚拟机
```
