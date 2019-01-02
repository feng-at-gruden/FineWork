const express = require('express')
//const cmd = require('node-cmd')

var app = express()

var bodyParser = require('body-parser')
app.use(bodyParser.json({limit: '1mb'}));
app.use(bodyParser.urlencoded({extended: true}));//解析字符

app.all('*',function(req,res,next){//跨域问题
    res.setHeader("Access-Control-Allow-Origin", "*");
    next();
});

app.use('/tmp', express.static('pub'))//虚拟目录

debugger;

app
	.get('/', (req, res) => {
		res.send('<h1>Welcom to Demo RESTful</h1>')
	})
	.get('/task', (req, res) => {
		res.json(tasks)
		console.log('GET Request')
	})
	.post('/task', (req, res) => {
		console.log('POST Request')
		tasks.data.push({
			id: tasks.data.length, 
			text: req.body.title, 
			start_date: "02-04-2018", 
			duration: 6, 
			progress: 0, 
			open: false, 
			locked:false
		})
     	res.json({"status":"success", "title": req.body.title})
	})
	.put('/task/:taskId', (req, res) => {
		console.log('PUT Request - ' + req.params.taskI)
		res.send({'status':'success', 'message':'Update - ' + req.body.title})
	})
	.delete('/task/:taskId', (req, res) => {
		console.log('DELETE Request')
		res.send({'status':'success', 'message':'Deleted - ' + req.params.taskId})
	})

app.listen(3000, ()=>console.log('api is running at :3000'))

/*
cmd.get(
        'C:\Program Files (x86)\Google\Chrome\Application\chrome.exe',
	    function(data){
	        console.log("data")
	    }
    );
*/

var tasks = {
		data: [
			{id: 1, text: "土方工程", start_date: "02-04-2018", duration: 6, progress: 1, open: false, locked:true},
			{id: 2, text: "基础工程", start_date: "9-04-2018", duration: 14+1, progress: 14/15, open: true,exceed: true, priority:1},
				{id: 3, text: "垫层施工", start_date: "09-4-2018", duration: 2,  progress: 1, parent: 2},
				{id: 4, text: "转胎膜砌筑抹灰", start_date: "10-04-2018", duration: 2, progress: 1, parent: 2},
				{id: 5, text: "防水卷材施工", start_date: "12-04-2018", duration: 4, progress: 1, parent: 2},
				{id: 6, text: "防水保护层", start_date: "15-04-2018", duration: 3, progress: 1, parent: 2},
				{id: 7, text: "钢筋困扎", start_date: "15-04-2018", duration: 1, progress: 1, parent: 2},
				{id: 8, text: "模板支设", start_date: "15-04-2018", duration: 5, progress: 1, parent: 2},
				{id: 9, text: "混凝土浇筑", start_date: "18-04-2018", duration: 5+1, progress: 5/6, parent: 2, exceed: true},
			{id: 10, text: "地下室主体", start_date: "05-04-2018", duration: 10, progress: 0.3, open: true},
				{id: 11, text: "墙柱钢筋绑扎", start_date: "5-04-2018", duration: 1, progress: 0, parent: 10},
				{id: 12, text: "排架搭设", start_date: "6-04-2018", duration: 2, progress: 0, parent: 10},
				{id: 13, text: "顶板梁模板支设", start_date: "9-04-2018", duration: 4, progress: 0, parent: 10},
				{id: 14, text: "顶板梁钢筋绑扎、墙柱模板加固", start_date: "10-04-2018", duration: 2, progress: 0, parent: 10},
				{id: 15, text: "混凝土浇筑", start_date: "10-04-2018", duration: 5, progress: 0.7, parent: 10},
			{id: 16, text: "主体结构", start_date: "11-04-2018", duration: 21, progress: 0,},
				{id: 17, text: "一层主体结构", start_date: "11-04-2018", duration: 2, progress: 0, parent: 16},
					{id: 18, text: "墙柱钢筋绑扎", start_date: "11-04-2018", duration: 2, progress: 0, parent: 17},
					{id: 19, text: "排架搭设", start_date: "11-04-2018", duration: 2, progress: 0, parent: 17},
					{id: 20, text: "顶板梁模板支设", start_date: "11-04-2018", duration:1, progress: 0, parent: 17},
					{id: 21, text: "顶板梁钢筋绑扎、墙柱模板加固", start_date: "11-04-2018", duration: 2, progress: 0, parent: 17},
					{id: 22, text: "一层混凝土浇筑", start_date: "11-04-2018", duration: 2, progress: 0, parent: 17},
				{id: 23, text: "二层主体结构", start_date: "11-04-2018", duration: 2, progress: 0, parent: 16,},
					{id: 24, text: "墙柱钢筋绑扎", start_date: "11-04-2018", duration: 2, progress: 0, parent: 23},
					{id: 25, text: "排架搭设", start_date: "11-04-2018", duration: 2, progress: 0, parent: 23},
					{id: 26, text: "顶板梁模板支设", start_date: "11-04-2018", duration: 2, progress: 0, parent: 23},
					{id: 27, text: "顶板梁钢筋绑扎、墙柱模板加固", start_date: "11-04-2018", duration: 2, progress: 0, parent: 23},
					{id: 28, text: "二层混凝土浇筑", start_date: "11-04-2018", duration: 2, progress: 0, parent: 23},
		],
		links: []
	};	