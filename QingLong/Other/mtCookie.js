
let cookies = [

    'ck1',

    'ck2'
  
  ];
  
// 判断环境变量里面是否有ck
if (process.env.mtTk) {
    if (process.env.mtTk.indexOf('&') > -1) {
        console.log(`您的cookie选择的是用&隔开\n`)
        cookies = process.env.mtTk.split('&');
    } else if (process.env.mtTk.indexOf('\n') > -1) {
        console.log(`您的cookie选择的是用换行隔开\n`)
        cookies = process.env.mtTk.split('\n');
    } else {
        cookies = [process.env.mtTk];
    }
}

module.exports = cookies;