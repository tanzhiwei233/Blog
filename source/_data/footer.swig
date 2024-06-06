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