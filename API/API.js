const express = require('express')
const mockData = require('./MockData')
//const cmd = require('node-cmd')

var app = express()

var bodyParser = require('body-parser')
app.use(bodyParser.json({ limit: '1mb' }));
app.use(bodyParser.urlencoded({ extended: true })); //解析字符

app.all('*', function(req, res, next) { //跨域问题
	res.setHeader("Access-Control-Allow-Origin", "*");
	next();
});

app.use('/tmp', express.static('pub')) //虚拟目录

app
	.get('/', (req, res) => {
		res.send('<h1>Welcom to Demo RESTful</h1>')
	})
	.post('/token', (req, res) => {
		var username = req.body.username;
		var password = req.body.password;
		console.log(username,password);
		if(username=='admin' && password=="123456"){
			res.json({ "success": true, Token:'AAAAAAAAAAA' })
		}
		else{
			res.status(401).send({ Message: 'Invalid username and passowrd' });			
		}
	})
	.get('/project/list', (req, res) => {
		res.json(mockData.projects)
		console.log('GET /project/list')
	})
	.get('/project/rawplan/:id', (req, res) => {
		res.json(mockData.projectRawPlan)
		console.log('GET /project/rawplan')
	})
	.get('/project/detailedplan/:id', (req, res) => {
		res.json(mockData.projectDetailedPlan)
		console.log('GET /project/detailedplan')
	})
	.get('/phase/plan', (req, res) => {
		res.json(mockData.tasks)
		console.log('GET /phase/plan')
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
			locked: false
		})
		res.json({ "status": "success", "title": req.body.title })
	})
	.put('/task/:taskId', (req, res) => {
		console.log('PUT Request - ' + req.params.taskI)
		res.send({ 'status': 'success', 'message': 'Update - ' + req.body.title })
	})
	.delete('/task/:taskId', (req, res) => {
		console.log('DELETE Request')
		res.send({ 'status': 'success', 'message': 'Deleted - ' + req.params.taskId })
	})

app.listen(3000, () => console.log('api is running at :3000'))

/*
cmd.get(
        'C:\Program Files (x86)\Google\Chrome\Application\chrome.exe',
	    function(data){
	        console.log("data")
	    }
    );
*/
