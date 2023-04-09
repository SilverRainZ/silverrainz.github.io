// By Awesome ChatGPT.

window.addEventListener("DOMContentLoaded", rewriteSourcePageURLs)

function rewriteSourcePageURLs() {
    // 获取当前页面的路径
    var currentPath = window.location.pathname;
    const currentHash = window.location.hash;

    // 如果当前路径中包含 _build/html，说明这是在本地构建的
    const buildIndex = currentPath.indexOf("_build/html/");
    if (buildIndex !== -1) {
        currentPath = currentPath.substring(buildIndex + "_build/html/".length);
    }

    // 获取所有 class 为 source-page 的链接元素
    const links = document.querySelectorAll(".source-page");

    // 循环遍历所有链接元素
    for (let i = 0; i < links.length; i++) {
        const url = new URL(links[i].href);
        url.pathname = currentPath;
        links[i].href = url.toString() + currentHash;
    }
}
