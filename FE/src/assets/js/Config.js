import colors from 'vuetify/es5/util/colors'

//const API_URL = "http://127.0.0.1:3000"
const API_URL = "http://192.168.123.1:3000"
//const API_URL = "http://192.168.31.33:3000"


const Themes = [
	{ primary: colors.purple, secondary: colors.grey.darken1, accent: colors.shades.black, error: colors.red.accent3 },
	{ primary: colors.amber, secondary: colors.grey.darken1, accent: colors.shades.black, error: colors.red.accent3 },
	{ primary: colors.orange.accent4, secondary: colors.grey.darken1, accent: colors.shades.black, error: colors.red.accent3 },
	{ primary: colors.pink.accent2, secondary: colors.grey.darken1, accent: colors.shades.black, error: colors.red.accent3 },
]

const Theme = Themes[1]
//"amber" "orange accent-4"//"pink accent-2"//"amber" orange

const ProjectStatus = [
	{ value: 1, label: '筹备中' },
	{ value: 2, label: '在建中' },
	{ value: 3, label: '已竣工' },
	{ value: 4, label: '已验收' },
	{ value: 5, label: '已停工' },
]

const TaskStatus = []

export default {
	API_URL,
	Theme,
	ProjectStatus,
	TaskStatus
}
