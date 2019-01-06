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

    
    in: ['tada', 'bounceIn', 'shake', 'fadeInUp', 'flipInY', 'lightSpeedIn', 'rotateInDownlet', 'slidInUp', 'slidInDown','zoomIn','zoomInDown'],
    out: ['zoomOutUp', 'fadeOutDown', 'fadeOutDownBig', 'flipOutX', 'rotateOutUpRight', 'zoomOut', 'zoomOutRight', 'rollOut'],
    randomIn() {
        return 'animated  ' + this.in[this.randomNum(0, this.in.length-1)]
    },
    randomOut() {
        return 'animated ' + this.out[this.randomNum(0, this.out.length-1)]
    },
    
}
