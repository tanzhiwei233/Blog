---
title: hero + github
tags: hexo
---

## 新建一个仓库

名字为用户名+.github.io

```
tanzhiwei233.github.io
```

## 上传 hexo 程序到 GitHub

```shell
npm install hexo-deployer-git --save
```

然后修改_config.yml 文件末尾的 Deployment 部分：

```shell
deploy:
  type: git
  repo: git@github.com:xxxx/xxxx.git
  branch: master
```

Hero d 将页面推到github上，打开GitHub 仓库的page设置

![image-20240606165606388](https://raw.githubusercontent.com/tanzhiwei233/picture/master/images/image-20240606165606388.png)