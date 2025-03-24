/**
 * Surge & Loon 的运行模式，根据当前网络自动切换模式，此脚本思路来自于Quantumult X。
 * @author: Peng-YM
 * 更新地址: https://raw.githubusercontent.com/Peng-YM/QuanX/master/Tools/RunningMode/running-mode.js
 *
 *************** Surge配置 ***********************
 * 推荐使用模块：
 * https://raw.githubusercontent.com/Peng-YM/QuanX/master/Tools/RunningMode/running-mode.sgmodule
 * 手动配置：
 * [Script]
 * event network-changed script-path=https://raw.githubusercontent.com/Peng-YM/QuanX/master/Tools/RunningMode/running-mode.js
 *
 *************** Loon配置 ***********************
 * 推荐使用插件：
 * https://raw.githubusercontent.com/Peng-YM/QuanX/master/Tools/RunningMode/running-mode.plugin
 * 手动配置：
 * [Script]
 * network-changed script-path=https://raw.githubusercontent.com/Peng-YM/QuanX/master/Tools/RunningMode/running-mode.js
 *
 *************** 脚本配置 ***********************
 * 推荐使用BoxJS配置。
 * BoxJS订阅：https://raw.githubusercontent.com/Peng-YM/QuanX/master/Tasks/box.js.json
 * (不推荐！)手动配置项为config, 请看注释
 */

 let config = {
  silence: false, // 是否静默运行，默认false
  cellular: "RULE", // 蜂窝数据下的模式，RULE代表规则模式，PROXY代表全局代理，DIRECT代表全局直连
  wifi: "RULE", // wifi下默认的模式
  all_direct: ["SuiYue", "303", "WAYNE@NETGEAR_5G", "WiFi@1803@5G"], // 指定全局直连的wifi名字
  all_proxy: [], // 指定全局代理的wifi名字
};

// load user prefs from box
const boxConfig = $persistentStore.read("surge_running_mode");
if (boxConfig) {
  config = JSON.parse(boxConfig);
  config.silence = JSON.parse(config.silence);
  config.all_direct = JSON.parse(config.all_direct);
  config.all_proxy = JSON.parse(config.all_proxy);
}

const isLoon = typeof $loon !== "undefined";
const isSurge = typeof $httpClient !== "undefined" && !isLoon;
const MODE_NAMES = {
  RULE: "🚦规则模式",
  PROXY: "🚀全局代理模式",
  DIRECT: "🎯全局直连模式",
};

manager();
$done();

function manager() {
  let ssid;
  let mode;

  if (isSurge) {
    const v4_ip = $network.v4.primaryAddress;
    // no network connection
    if (!config.silence && !v4_ip) {
      notify("🤖 Surge 运行模式", "❌ 当前无网络", "");
      return;
    }
    ssid = $network.wifi.ssid;
    // 检查当前WiFi是否在all_direct列表中
    if (ssid && config.all_direct.includes(ssid)) {
      mode = "DIRECT";
    } else if (ssid && config.all_proxy.includes(ssid)) {
      mode = "PROXY";
    } else {
      mode = ssid ? config.wifi : config.cellular;
    }
    
    // 针对 macOS 环境的特殊处理
    if (mode === "DIRECT" && $environment && $environment.system === "macOS") {
      $surge.setOutboundMode("direct");
      // 确保模式切换成功
      setTimeout(() => {
        if ($surge.getOutboundMode() !== "direct") {
          $surge.setOutboundMode("direct");
        }
      }, 1000);
    } else {
      const target = {
        RULE: "rule",
        PROXY: "global-proxy",
        DIRECT: "direct",
      }[mode];
      $surge.setOutboundMode(target);
    }
  } else if (isLoon) {
    const conf = JSON.parse($config.getConfig());
    ssid = conf.ssid;
    // 检查当前WiFi是否在all_direct列表中
    if (ssid && config.all_direct.includes(ssid)) {
      mode = "DIRECT";
    } else if (ssid && config.all_proxy.includes(ssid)) {
      mode = "PROXY";
    } else {
      mode = ssid ? config.wifi : config.cellular;
    }
    const target = {
      DIRECT: 0,
      RULE: 1,
      PROXY: 2,
    }[mode];
    $config.setRunningModel(target);
  }
  
  if (!config.silence) {
    notify(
      `🤖 ${isSurge ? "Surge" : "Loon"} 运行模式`,
      `当前网络：${ssid ? ssid : "蜂窝数据"}`,
      `${isSurge ? "Surge" : "Loon"} 已切换至${MODE_NAMES[mode]}`
    );
  }
}

function lookupSSID(ssid) {
  // 由于在manager中已经处理了SSID匹配，这个函数可以简化
  return config.wifi;
}

function notify(title, subtitle, content) {
  const SUBTITLE_STORE_KEY = "running_mode_notified_subtitle";
  const lastNotifiedSubtitle = $persistentStore.read(SUBTITLE_STORE_KEY);

  if (!lastNotifiedSubtitle || lastNotifiedSubtitle !== subtitle) {
    $persistentStore.write(subtitle.toString(), SUBTITLE_STORE_KEY);
    $notification.post(title, subtitle, content);
  }
}
