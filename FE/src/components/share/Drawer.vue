<template>
	<v-navigation-drawer v-model="drawer" :mini-variant="mini" @input="handleInput" clipped fixed app>
		<v-list class="pa-1">
			<v-list-tile v-if="mini" @click.stop="mini = !mini">
				<v-list-tile-action>
					<v-icon>chevron_right</v-icon>
				</v-list-tile-action>
			</v-list-tile>
			<v-list-tile avatar tag="div">
				<v-list-tile-avatar>
					<img src="https://randomuser.me/api/portraits/men/85.jpg">
          			</v-list-tile-avatar>
					<v-list-tile-content>
						<v-list-tile-title>{{userName}}</v-list-tile-title>
					</v-list-tile-content>
					<v-list-tile-action>
						<v-btn icon @click.stop="mini = !mini">
							<v-icon>chevron_left</v-icon>
						</v-btn>
					</v-list-tile-action>
			</v-list-tile>
		</v-list>
		<v-list class="pt-0" dense>
			<v-divider light></v-divider>
			<div v-for="(item,index) in navItems">
				<v-list-tile v-if="!item.subNav" @click="goto(item)">
					<v-list-tile-action>
						<v-icon>{{item.icon}}</v-icon>
					</v-list-tile-action>
					<v-list-tile-title>{{item.title}}</v-list-tile-title>
				</v-list-tile>
				<v-list-group no-action :prepend-icon="item.icon" v-if="item.subNav">
					<v-list-tile slot="activator">
						<v-list-tile-title>{{item.title}}</v-list-tile-title>
					</v-list-tile>
					<v-list-tile v-for="(subItem, i) in item.subNav" :key="i" @click="goto(subItem)" width="200px">
						<v-list-tile-title v-text="subItem.title"></v-list-tile-title>
						<v-list-tile-action>
							<v-icon v-text="subItem.icon"></v-icon>
						</v-list-tile-action>
					</v-list-tile>
				</v-list-group>
			</div>
		</v-list>
	</v-navigation-drawer>
</template>
<script>
import auth from '../../assets/js/Auth'
export default {
	name: 'Drawer',
	props: [],
	data() {
		return {
			mini: false,
			navItems: [
				/*{ title: '登录', link: '/login', icon: 'supervisor_account' },*/
				{ title: '主页', link: '/', icon: 'home' },
				{
					title: '工程管理',
					link: '',
					icon: 'location_city',
					subNav: [
						{ title: '工程一览', link: '/project/list', icon: 'view_list' },
						{ title: '新建工程', link: '/project/create', icon: 'playlist_add' },
						{ title: '工程详细', link: '/project/12', icon: 'view_module' },
					]
				},
				{
					title: '计划管理',
					link: '',
					icon: 'assessment',
					subNav: [
						{ title: '工程计划', link: '/project/plan', icon: 'view_module' },
						{ title: '阶段计划', link: '/plan/phase', icon: 'view_headline' },
					]
				},
				{
					title: '工作汇报',
					link: '',
					icon: 'assessment',
					subNav: [
						{ title: '日工作汇报', link: '/work/daily', icon: 'view_module' },
					]
				},
				{ title: 'About', link: 'about', icon: 'question_answer' },
				{ title: '退出', link: 'logout', icon: 'directions_run' }
			],
			right: null
		}
	},
	computed: {
		userName() {
			return this.$store.state.identity.realname
		},
		drawer: {
			get() {
				return this.$store.state.drawer
			},
			set(value) {
				//this.$store.commit('openDrawer')
			}
		}
	},
	methods: {
		goto(item) {
			if (item.link == 'logout') {
				auth.logout()
			} else {
				this.$router.push(item.link)
			}
		},
		handleInput(v) {
			this.$store.commit('openDrawer', v)
		}
	}
}

</script>
<style>
</style>
