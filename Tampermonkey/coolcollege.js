// ==UserScript==
// @name         酷学院弹框去除
// @namespace    http://tampermonkey.net/
// @version      0.2
// @description  酷学院学习网站，视频播放弹框去除
// @author       涂涂
// @match        https://pro.coolcollege.cn/*
// @icon         data:image/gif;base64,R0lGODlhAQABAAAAACH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==
// @require      https://cdn.bootcdn.net/ajax/libs/jquery/3.6.3/jquery.js
// @license      MIT
// ==/UserScript==

(function() {
    $(()=>{
        let a = setInterval(()=>{
            if($('.ant-modal-content .ant-modal-footer').length){
                $('.ant-modal-content .ant-modal-footer').each(function(index,element){
                    $(element).find('button').click();
                    console.log($('video').length);
                    var video = $('video')[0];
                    video.muted = true;
                    video.play();
                });
            }
        },1000);
    })
})();