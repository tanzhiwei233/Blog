---
title: hero installation and beautify
tags: hexo
---

## Install Hexo

```
$ npm install hexo-cli -g
$ brew install hexo
$ hexo init blog
$ cd blog
$ hexo server
$ hexo new "Hello Hexo"
$ hexo generate
```

## Install Next

```
git clone git@github.com:tanzhiwei233/hexo-theme-next.git themes/next
```

## 添加网站运行时间
来到\themes\next\layout\_partials找到footer.swig文件，添加如下代码

```
<span id="timeDate">载入天数...</span>
<span id="times">载入时分秒...</span>
<script>
    var now = new Date();
    function createtime() {
        var grt= new Date("7/18/2023 10:00:00"); //修改为你的网站开始运行的时间
        now.setTime(now.getTime()+250);
        days = (now - grt ) / 1000 / 60 / 60 / 24; dnum = Math.floor(days);
        hours = (now - grt ) / 1000 / 60 / 60 - (24 * dnum); hnum = Math.floor(hours);
        if(String(hnum).length ==1 ){hnum = "0" + hnum;} minutes = (now - grt ) / 1000 /60 - (24 * 60 * dnum) - (60 * hnum);
        mnum = Math.floor(minutes); if(String(mnum).length ==1 ){mnum = "0" + mnum;}
        seconds = (now - grt ) / 1000 - (24 * 60 * 60 * dnum) - (60 * 60 * hnum) - (60 * mnum);
        snum = Math.round(seconds); if(String(snum).length ==1 ){snum = "0" + snum;}
        document.getElementById("timeDate").innerHTML = "本站已安全运行 "+dnum+" 天 ";
        document.getElementById("times").innerHTML = hnum + " 小时 " + mnum + " 分 " + snum + " 秒.";
    }
setInterval("createtime()",250);
</script>
```

## 鼠标点击出现小红心
设置主题config，打开custom_file_path
source/_data/head.swig，这个source是站点下的source

下载保存 love.js 到 source/js/love.js
```
"use strict";!function(e,r,t){function a(){for(var e=0;e<i.length;e++)i[e].alpha<=0?(r.body.removeChild(i[e].el),i.splice(e,1)):(i[e].y--,i[e].scale+=.004,i[e].alpha-=.013,i[e].el.style.cssText="left:"+i[e].x+"px;top:"+i[e].y+"px;opacity:"+i[e].alpha+";transform:scale("+i[e].scale+","+i[e].scale+") rotate(45deg);background:"+i[e].color+";z-index:99999");requestAnimationFrame(a)}var o,i=[];e.requestAnimationFrame=e.requestAnimationFrame||e.webkitRequestAnimationFrame||e.mozRequestAnimationFrame||e.oRequestAnimationFrame||e.msRequestAnimationFrame||function(e){setTimeout(e,1e3/60)},function(t){var a=r.createElement("style");a.type="text/css";try{a.appendChild(r.createTextNode(t))}catch(e){a.styleSheet.cssText=t}r.getElementsByTagName("head")[0].appendChild(a)}(".heart{width: 10px;height: 10px;position: fixed;background: #f00;transform: rotate(45deg);-webkit-transform: rotate(45deg);-moz-transform: rotate(45deg);}.heart:after,.heart:before{content: '';width: inherit;height: inherit;background: inherit;border-radius: 50%;-webkit-border-radius: 50%;-moz-border-radius: 50%;position: fixed;}.heart:after{top: -5px;}.heart:before{left: -5px;}"),o="function"==typeof e.onclick&&e.onclick,e.onclick=function(e){var t,a;o&&o(),t=e,(a=r.createElement("div")).className="heart",i.push({el:a,x:t.clientX-5,y:t.clientY-5,scale:1,alpha:1,color:"rgb("+~~(255*Math.random())+","+~~(255*Math.random())+","+~~(255*Math.random())+")"}),r.body.appendChild(a)},a()}(window,document);
```
在 source/_data/head.swig 添加以下内容
```
<!-- 页面点击小红心 -->
<script type="text/javascript" src="/js/love.js"></script>
```

## 文章图片圆角

添加以下内容到 source/_data/styles.styl
```
// 图片圆角
.post-body img {
border-radius: 1em
}
```

## 搜索功能
安装 hexo-generator-searchdb，在站点的根目录下执行以下命令：
```
npm install hexo-generator-searchdb
```
编辑站点配置文件，新增以下内容到任意位置:
```
search:
path: search.xml
field: post
format: html
limit: 10000
```
打开config local_search

## 文章阅读量、访问量计数
注册或登录 leancloud.app
新建或打开已有应用
获取 APPID 和 AppKey
数据存储 -> 结构化数据 -> 创建名为 Counter 的 class
修改主题配置文件 leancloud_visitors 部分
```
leancloud_visitors:
enable: true # 是否启用
app_id: # <your app id>
app_key:  # <your app key>
# Required for apps from CN region
server_url: # <your server url>
security: true
```
## 页脚添加总访问量
添加如下内容到 source/_data/footer.swig
```
<div>
    <!--添加总阅读次数-->
    <div>
        <span>本站总访问量</span>
        <span id="site_total_read_count">Loading...</span>
    </div>
    <script>
        async function sleep(ms = 1000) {
            return await new Promise(resolve => {
                const timer = setTimeout(() => {
                    clearTimeout(timer)
                    return resolve()
                }, ms)
            })
        }
        async function site_read_count() {
            const className = 'Counter',
                query = new AV.Query(className)
            return query.find()
                .then(_ => _.map(i => i.attributes.time))
                .then(_ => _.reduce((a, b) => a + b))
        }
        new Promise(resolve => {
            const timer = setInterval(() => {
                if (typeof AV !== "undefined") {
                    clearInterval(timer)
                    return resolve()
                }
            }, 250)
        })
            .then(() => site_read_count())
            .then(_ => {
                const s = ` ${_} 次`
                document.getElementById("site_total_read_count").innerHTML = s
            })
            .catch(e => console.error(e.message))
    </script>
</div>
```
## 评论功能
注册或登录 leancloud.app
新建或打开已有应用
获取 APPID 和 AppKey
数据存储 -> 结构化数据 -> 创建名为 Comment 的 class
修改主题配置文件 valine 部分
```
valine:
enable: true
appid:  # Your leancloud application appid
appkey:  # Your leancloud application appkey
notify: true # 邮件通知
verify: true # 验证码
placeholder: 写点什么... # Comment box placeholder
avatar: mm # Gravatar style
guest_info: nick,mail,link # Custom comment header
pageSize: 10 # Pagination size
language: zh-cn # Language, available values: en, zh-cn
visitor: true # Article reading statistic
comment_count: true # If false, comment count will only be displayed in post page, not in home page
recordIP: false # Whether to record the commenter IP
serverURLs: # When the custom domain name is enabled, fill it in here (it will be detected automatically by default, no need to fill in)
#post_meta_order: 0
```

```
comments:
  # Available values: tabs | buttons
  style: tabs
  # Choose a comment system to be displayed by default.
  # Available values: changyan | disqus | disqusjs | gitalk | livere | valine
  active: valine
  # Setting `true` means remembering the comment system selected by the visitor.
  storage: true
  # Lazyload all comment systems.
  lazyload: false
```

## 文章字数计数、阅读时间估计、站点总字数统计、总时间统计
```
npm install hexo-symbols-count-time
```
修改主题配置文件的 symbols_count_time 部分
```
symbols_count_time:
separated_meta: true
item_text_post: true # 文章字数统计
item_text_total: true # 站点总字数统计
# 平均单词长度（单词的计数）。默认值:4。CN≈2 EN≈5 俄文≈6
awl: 2
# 每分钟的单词。默认值:275。缓慢≈200 正常≈275 快≈350
wpm: 275
```

## 在菜单栏添加留言板

## 添加2d看板娘
git clone拷贝到主题的source目录下
```
git clone git@github.com:stevenjoezhang/live2d-widget.git
```
在主题目录的layout文件夹中找到head文件(_layout.swig)并在其中添加代码script
```
<head>
  {{ partial('_partials/head/head.swig', {}, {cache: theme.cache.enable}) }}
  {% include '_partials/head/head-unique.swig' %}
  {{- next_inject('head') }}
  <title>{% block title %}{% endblock %}</title>
  {{ partial('_third-party/analytics/index.swig', {}, {cache: theme.cache.enable}) }}
  {{ partial('_scripts/noscript.swig', {}, {cache: theme.cache.enable}) }}
  <script src="/live2d-widget/autoload.js"></script>
</head>
```
修改看板娘代码的autoload.js
```
const live2d_path = "/live2d-widget/";
cdnPath: "https://gcore.jsdelivr.net/npm/yzs-live2d_src@1.1.0/",
```

## 添加网易云音乐

在网页版网易云音乐，分享歌单，点击动态里的歌单，生成外链
```
<iframe frameborder="no" border="0" marginwidth="0" marginheight="0" width=330 height=395 src="//music.163.com/outchain/player?type=0&id=8693395876&auto=1&height=430"></iframe>
```
将外链加在next/layout/_macro/sidebar.swig