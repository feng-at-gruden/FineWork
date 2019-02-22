export
default {

    IsPC() {
        var userAgentInfo = navigator.userAgent;
        var Agents = ["Android", "iPhone",
            "SymbianOS", "Windows Phone",
            "iPad", "iPod"
        ];
        var flag = true;
        for (var v = 0; v < Agents.length; v++) {
            if (userAgentInfo.indexOf(Agents[v]) > 0) {
                flag = false;
                break;
            }
        }
        return flag;
    },

    randomNum(minNum, maxNum) {
        switch (arguments.length) {
            case 1:
                return parseInt(Math.random() * minNum + 1, 10);
                break;
            case 2:
                return parseInt(Math.random() * (maxNum - minNum + 1) + minNum, 10);
                break;
            default:
                return 0;
                break;
        }
    },

    toDecimal(x) {
        var f = parseFloat(x);
        if (isNaN(f)) {
            return;
        }
        f = Math.round(x * 100) / 100;
        return f;
    },

    accMul(arg1, arg2) {
        var m = 0,
            s1 = arg1.toString(),
            s2 = arg2.toString();
        try { m += s1.split(".")[1].length } catch (e) {}
        try { m += s2.split(".")[1].length } catch (e) {}
        return Number(s1.replace(".", "")) * Number(s2.replace(".", "")) / Math.pow(10, m)
    },

    objCopy(obj) {
        var newobj = {};
        for (var attr in obj) {
            newobj[attr] = obj[attr];
        }
        return newobj;
    },

    stringInArray(str, array) {
        for (var i = 0; i < array.length; i++) {
            if (array[i] == str)
                return true
        }
        return false
    },

    /**************************************时间格式化处理************************************/
    dateFormat(fmt, date) {
        var o = {
            "M+": date.getMonth() + 1, //月份   
            "d+": date.getDate(), //日   
            "h+": date.getHours(), //小时   
            "m+": date.getMinutes(), //分   
            "s+": date.getSeconds(), //秒   
            "q+": Math.floor((date.getMonth() + 3) / 3), //季度   
            "S": date.getMilliseconds() //毫秒   
        };
        if (/(y+)/.test(fmt))
            fmt = fmt.replace(RegExp.$1, (date.getFullYear() + "").substr(4 - RegExp.$1.length));
        for (var k in o)
            if (new RegExp("(" + k + ")").test(fmt))
                fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
        return fmt;
    },

    stringToDate: function(dateStr, separator) {
        if (!separator) {
            separator = "-";
        }
        var dateArr = dateStr.split(separator);
        var year = parseInt(dateArr[0]);
        var month;
        //处理月份为04这样的情况                         
        if (dateArr[1].indexOf("0") == 0) {
            month = parseInt(dateArr[1].substring(1));
        } else {
            month = parseInt(dateArr[1]);
        }
        var day = parseInt(dateArr[2]);
        var date = new Date(year, month - 1, day);
        return date;
    },

    dateDifference(sDate1, sDate2) { //sDate1和sDate2是2006-12-18格式  
        var dateSpan,
            tempDate,
            iDays;
        sDate1 = Date.parse(sDate1);
        sDate2 = Date.parse(sDate2);
        dateSpan = sDate2 - sDate1;
        dateSpan = Math.abs(dateSpan);
        iDays = Math.floor(dateSpan / (24 * 3600 * 1000));
        return iDays
    },

    in: ['tada', 'bounceIn', 'shake', 'fadeInUp', 'flipInY', 'lightSpeedIn', 'rotateInDownlet', 'slidInUp', 'slidInDown', 'zoomIn', 'zoomInDown'],
    out: ['zoomOutUp', 'fadeOutDown', 'fadeOutDownBig', 'flipOutX', 'rotateOutUpRight', 'zoomOut', 'zoomOutRight', 'rollOut'],
    randomIn() {
        return 'animated  ' + this.in[this.randomNum(0, this.in.length - 1)]
    },
    randomOut() {
        return 'animated ' + this.out[this.randomNum(0, this.out.length - 1)]
    },

}
