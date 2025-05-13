/**
 * 将镜像站点链接重定向到源站点链接 by Awesome ChatGPT.
 *
 * 将当前页面中 class 为 source-page 的链接元素的 href 属性中链接重定向到
*  silverrainz.me 对应的链接，同时保留锚点。
 */

window.addEventListener("DOMContentLoaded", rewriteSourcePageURLs)

function rewriteSourcePageURLs() {
    // 获取当前页面的路径
    var currentPath = window.location.pathname;
    const currentHash = window.location.hash;

    // 移除 Homelab 部署的前缀，see also _conf/deploy.py
    const buildIndex = currentPath.indexOf("bullet/");
    if (buildIndex !== -1) {
        currentPath = currentPath.substring(buildIndex + "bullet/".length);
    }

    // 获取所有 class 为 source-page 的链接元素
    const links = document.querySelectorAll(".source-page");

    // 循环遍历所有链接元素
    for (let i = 0; i < links.length; i++) {
        console.log()
        const url = new URL(links[i].href);
        url.pathname += currentPath;
        links[i].href = url.toString() + currentHash;
    }
}
