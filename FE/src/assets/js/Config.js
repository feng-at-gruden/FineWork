import colors from 'vuetify/es5/util/colors'

//const ENV = 'UAT'
const ENV = 'PROD'

if(ENV=='UAT'){
    var APP_NAME = "Fine.Work"
    var CLIENT_NAME = "Feng Guo 691427@QQ.COM"
    var API_URL = "http://114.115.178.72/FineWork/API"
    //var API_URL = "http://localhost:9909/API"
    //var API_URL = "http://103.254.77.30:8001/API"
    //var API_URL = "http://127.0.0.1:3000"
}else{
    var APP_NAME = "中阳集团项目进度跟踪系统"
    var CLIENT_NAME = "中阳集团"
    var API_URL = "/FineWork/API"
}

const WALL_PAPER_URL = "https://cn.bing.com/HPImageArchive.aspx?format=js&idx=#INDEX#&n=1&nc=1361089515117&FORM=HYLH1"
const Themes = [
    { primary: colors.lightBlue , secondary: colors.grey.darken1, accent: colors.shades.black, error: colors.red.accent3 },
    { primary: colors.orange.darken2, secondary: colors.grey.darken1, accent: colors.shades.black, error: colors.red.accent3, },
    { primary: colors.teal.darken1, secondary: colors.grey.darken1, accent: colors.shades.black, error: colors.red.accent3 },
    { primary: colors.cyan, secondary: colors.grey.darken1, accent: colors.shades.black, error: colors.red.accent3 },
    { primary: colors.green.darken3, secondary: colors.grey.darken1, accent: colors.shades.black, error: colors.red.accent3 },
    { primary: colors.deepPurple , secondary: colors.grey.darken1, accent: colors.shades.black, error: colors.red.accent3 },
    { primary: colors.brown.darken3, secondary: colors.grey.darken1, accent: colors.shades.black, error: colors.red.accent3 },
    { primary: colors.indigo.darken3, secondary: colors.grey.darken1, accent: colors.shades.black, error: colors.red.accent3 },
    { primary: colors.blueGrey, secondary: colors.grey.darken1, accent: colors.shades.black, error: colors.red.accent3 },
    { primary: colors.blue.darken1, secondary: colors.grey.darken1, accent: colors.shades.black, error: colors.red.accent3 },
    { primary: colors.grey, secondary: colors.grey.darken1, accent: colors.shades.black, error: colors.red.accent3 },
    { primary: colors.shades.black, secondary: colors.grey.darken1, accent: colors.shades.black, error: colors.red.accent3 },
    { primary: colors.amber.darken1, secondary: colors.grey.darken1, accent: colors.shades.black, error: colors.red.accent3 },
    { primary: colors.pink.accent2, secondary: colors.grey.darken1, accent: colors.shades.black, error: colors.red.accent3, info: colors.pink.accent4 },
    { primary: colors.red, secondary: colors.grey.darken1, accent: colors.shades.black, error: colors.red.accent3 },
    { primary: colors.lightGreen.accent4, secondary: colors.grey.darken1, accent: colors.shades.black, error: colors.red.accent3 },
    { primary: colors.purple.accent2, secondary: colors.grey.darken1, accent: colors.shades.black, error: colors.red.accent3 },
    { primary: colors.lime, secondary: colors.grey.darken1, accent: colors.shades.black, error: colors.red.accent3 },
]

const Theme = Themes[0]

//项目状态
const ProjectStatus = [
    { value: '筹备中', text: '筹备中' },
    { value: '在建中', text: '在建中' },
    { value: '已停工', text: '已停工' },
    { value: '已竣工', text: '已竣工' },
    { value: '已验收', text: '已验收' },
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
const TaskStatus = ['未开工', '施工中', '已停工', '已完工', ]
const TaskProgress = ['正常', '已延期', '已逾期']


//用户权限
const UserPermissions = [
    { value: 'project-management', text: '项目管理' },
    { value: 'plan-management', text: '计划管理' },
    { value: 'progress-management', text: '进度管理' },
    { value: 'system-management', text: '系统管理' },
]

export default {
    APP_NAME,
    CLIENT_NAME,
    API_URL,
    WALL_PAPER_URL,
    Themes,
    Theme,
    ProjectStatus,
    TaskStatus,
    ProjcetType,
    ProjectPhase,
    UserPermissions
}
