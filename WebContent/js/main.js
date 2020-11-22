function getTime(){
	 var date = new Date();
     var seperator1 = "-";
     var year = date.getFullYear();
     var month = date.getMonth() + 1;
     var strDate = date.getDate();
     if (month >= 1 && month <= 9) {
         month = "0" + month;
     }
     if (strDate >= 0 && strDate <= 9) {
         strDate = "0" + strDate;
     }
     var currentdate = year + seperator1 + month + seperator1 + strDate;
     document.getElementsByName("time")[0].value=currentdate;
}
function on_off() {
	var oUl = document.getElementById('nav');
	var aLi = oUl.getElementsByTagName('li');
	var aH = oUl.getElementsByTagName('h2');
	var aUl = oUl.getElementsByTagName('ul');
	var aLi = null;
	var arrLi = [];

	// 用于存放id=friend的ul标签里面的li标签
	for(var i = 0; i < aUl.length; i++) {
		aLi = aUl[i].getElementsByTagName('li');
		for(var j = 0; j < aLi.length; j++) {
			arrLi.push(aLi[j]);  //将获取到的节点存入数组里面
		}
	}

	for(var i = 0; i < aH.length; i++) {
		//设置index属性的值
		aH[i].index = i;
		//每一个h2标签被点击
	    aH[i].onclick = function() {
	    	
           //没有class就给他类名hover，反之清空类名
			if(this.className == '') {
				this.className = 'hover';
				aUl[this.index].className = 'hover';
			} else {
				this.className = '';
				aUl[this.index].className = '';

				var aLi = aUl[this.index].getElementsByTagName('li');
				for(var i = 0; i < aLi.length; i++) {
					aLi[i].className = '';
					aLi[i].onOff = true;//设置标量值
				}

			}

		};
	}

	for(var i = 0; i < arrLi.length; i++) {

		arrLi[i].onOff = true;
        //标量值为true则代表鼠标在上面，添加对应样式
		arrLi[i].onmouseover = function() {
			if(this.onOff) {
				this.className = 'active';
			}
		};
		//设置鼠标移出移除样式
		arrLi[i].onmouseout = function() {
			if(this.onOff) {
				this.className = '';
			} else {
				this.className = 'hover';
			}
		};

		arrLi[i].onclick = function() {

			for(var i = 0; i < arrLi.length; i++) {
				if(this != arrLi[i]) {
					arrLi[i].className = '';
					arrLi[i].onOff = true;
				}
			}

			if(this.onOff) {
				this.className = 'hover';
				this.onOff = false;
			} else {
				this.className = '';
				this.onOff = true;
			}
		};
	}

}

   window.onload = function (){on_off(),getTime()};
