var tlist = {
  1: ["立春", "2023-02-04"],
  2: ["元宵节", "2023-02-05"],
  3: ["雨水", "2023-02-19"],
  4: ["惊蛰", "2023-03-06"],
  5: ["妇女节", "2023-03-08"],
  6: ["春分", "2023-03-21"],
  7: ["清明节", "2023-04-05"],
  8: ["谷雨", "2023-04-20"],
  9: ["劳动节", "2023-05-01"],
  11: ["立夏", "2023-05-06"],
  12: ["小满", "2023-05-21"],
  13: ["儿童节", "2023-06-01"],
  14: ["老爸明天生日（农历）", "2023-06-03"],
  15: ["老爸生日（农历）", "2023-06-03"],
  16: ["芒种", "2023-06-06"],
  17: ["夏至", "2023-06-21"],
  18: ["端午节", "2023-06-22"],
  19: ["建党节", "2023-07-01"],
  20: ["小暑", "2023-07-07"],
  21: ["大暑", "2023-07-23"],
  22: ["建军节", "2023-08-01"],
  23: ["立秋", "2023-08-08"],
  24: ["七夕", "2023-08-22"],
  25: ["处暑", "2023-08-23"],
  26: ["白露", "2023-09-08"],
  27: ["中秋节", "2023-09-29"],
  28: ["国庆节", "2023-10-01"],
  29: ["寒露", "2023-10-08"],
  30: ["重阳节", "2023-10-23"],
  31: ["霜降", "2023-10-24"],
  32: ["立冬", "2023-11-08"],
  33: ["小雪", "2023-11-22"],
  34: ["大雪", "2023-12-07"],
  35: ["冬至", "2023-12-22"],
  36: ["元旦节", "2024-01-01"],
  37: ["老妈明天61岁生日（农历）", "2024-01-02"],
  38: ["老妈61岁生日（农历）", "2024-01-03"],
  39: ["小寒", "2024-01-06"],
  40: ["我明天36岁天生日（农历）", "2024-01-15"],
  41: ["我36岁生日（农历）", "2024-01-16"],
  42: ["大寒", "2024-01-20"],
  43: ["我明天36岁生日（公历）", "2024-01-23"],
  44: ["我36岁生日（公历）", "2024-01-24"],
  45: ["立春", "2024-02-04"],
  46: ["除夕", "2024-02-09"],
  47: ["春节", "2024-02-10"],
  48: ["雨水", "2024-02-19"],
  49: ["元宵节", "2024-02-24"],



};
let tnow = new Date();
let tnowf =
  tnow.getFullYear() + "-" + (tnow.getMonth() + 1) + "-" + tnow.getDate();

/* 计算2个日期相差的天数，不包含今天，如：2016-12-13到2016-12-15，相差2天
 * @param startDateString
 * @param endDateString
 * @returns
 */
function dateDiff(startDateString, endDateString) {
  var separator = "-"; //日期分隔符
  var startDates = startDateString.split(separator);
  var endDates = endDateString.split(separator);
  var startDate = new Date(startDates[0], startDates[1] - 1, startDates[2]);
  var endDate = new Date(endDates[0], endDates[1] - 1, endDates[2]);
  return parseInt(
    (endDate - startDate) / 1000 / 60 / 60 / 24
  ).toString();
}

//计算输入序号对应的时间与现在的天数间隔
function tnumcount(num) {
  let dnum = num;
  return dateDiff(tnowf, tlist[dnum][1]);
}

//获取最接近的日期
function now() {
  for (var i = 1; i <= Object.getOwnPropertyNames(tlist).length; i++) {
    if (Number(dateDiff(tnowf, tlist[i.toString()][1])) >= 0) {
      //console.log("最近的日期是:" + tlist[i.toString()][0]);
      //console.log("列表长度:" + Object.getOwnPropertyNames(tlist).length);
      //console.log("时间差距:" + Number(dateDiff(tnowf, tlist[i.toString()][1])));
      return i;
    }
  }
}

//如果是0天，发送emoji;
let nowlist = now();
function today(day) {
  let daythis = day;
  if (daythis == "0") {
    datenotice();
    return "🎉";
  } else {
    return daythis;
  }
}

//提醒日当天发送通知
function datenotice() {
  if ($persistentStore.read("timecardpushed") != tlist[nowlist][1] && tnow.getHours() >= 6) {
    $persistentStore.write(tlist[nowlist][1], "timecardpushed");
    $notification.post("假日祝福","", "今天是" + tlist[nowlist][1] + "日 " + tlist[nowlist][0] + "   🎉")
  } else if ($persistentStore.read("timecardpushed") == tlist[nowlist][1]) {
    //console.log("当日已通知");
  }
}
$done({
title:"节假提醒",
icon:"list.dash.header.rectangle",
'icon-color': "#5AC8FA",
content:tlist[nowlist][0]+"  :  "+today(tnumcount(nowlist))+"天\n"+tlist[Number(nowlist) + Number(1)][0] +"  :  "+ tnumcount(Number(nowlist) + Number(1))+ "天\n"+tlist[Number(nowlist) + Number(2)][0]+"  :  "+tnumcount(Number(nowlist) + Number(2))+"天"
})