---
title: typora picture upload —— PicGo
---



下载：https://github.com/Molunerfinn/picgo/releases

issue：macOS系统安装完PicGo显示「文件已损坏」或者安装完打开没有反应

因为 PicGo 没有签名，所以会被 macOS 的安全检查所拦下。

1. 安装后打开遇到「文件已损坏」的情况，请按如下方式操作：

信任开发者，会要求输入密码:

```shell
sudo spctl --master-disable
```

然后放行 PicGo :

```shell
xattr -cr /Applications/PicGo.app
```

![image-20240603162116578](https://raw.githubusercontent.com/tanzhiwei233/picture/master/images/image-20240603162116578.png)