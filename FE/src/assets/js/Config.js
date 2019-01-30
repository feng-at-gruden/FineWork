import colors from 'vuetify/es5/util/colors'

//const API_URL = "http://127.0.0.1:3000"
//const API_URL = "http://192.168.31.33:3000"
const API_URL = "http://103.254.77.30:8001/API"
//const API_URL = "http://localhost:9909/API"
//const API_URL = "/API"

//const APP_NAME = "中阳集团项目进度跟踪系统"
//const CLIENT_NAME = "中阳集团"
const APP_NAME = "Fine.Work"
const CLIENT_NAME = "Feng Guo"

const WALL_PAPER_URL = "https://cn.bing.com/HPImageArchive.aspx?format=js&idx=#INDEX#&n=1&nc=1361089515117&FORM=HYLH1"

const Themes = [
	{ primary: colors.purple, secondary: colors.grey.darken1, accent: colors.shades.black, error: colors.red.accent3 },
	{ primary: colors.amber, secondary: colors.grey.darken1, accent: colors.shades.black, error: colors.red.accent3 },
	{ primary: colors.orange.accent4, secondary: colors.grey.darken1, accent: colors.shades.black, error: colors.red.accent3,  },
	{ primary: colors.pink.accent2, secondary: colors.grey.darken1, accent: colors.shades.black, error: colors.red.accent3, info: colors.pink.accent4 },
]

const Theme = Themes[1]
//"amber" "orange accent-4"//"pink accent-2"//"amber" orange

//项目状态
const ProjectStatus = [
	{ value: '筹备中', text: '筹备中' },
	{ value: '在建中', text: '在建中' },
	{ value: '已竣工', text: '已竣工' },
	{ value: '已验收', text: '已验收' },
	{ value: '已停工', text: '已停工' },
]

//施工阶段
const ProjectPhase = [
	'基础工程',
	'主体工程',
	'屋面工程',
	'装饰装修工程',
]

//项目性质类型
const ProjcetType = ['新建', '扩建', '改建', '拆建', '恢复', '其他']


//任务状态
const TaskStatus = ['未开工', '施工中', '已完工', '已停工',]
const TaskProgress = ['正常','已延期','已逾期']


export default {
	APP_NAME,
	CLIENT_NAME,
	API_URL,
	WALL_PAPER_URL,
	Theme,
	ProjectStatus,
	TaskStatus,
	ProjcetType,
	ProjectPhase
}
