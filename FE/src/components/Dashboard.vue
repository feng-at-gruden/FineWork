<template>
	<v-layout>
		<v-container>
			<v-layout justify-center>
				<v-btn color="pink" dark @click.stop="drawer = !drawer">
					Toggle {{userName}}
				</v-btn>
			</v-layout>
		</v-container>
		<v-navigation-drawer v-model="drawer" :mini-variant="mini" dark temporary absolute value="true">
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
						<v-list-tile v-for="(subItem, i) in item.subNav" :key="i" @click="goto(subItem)" width="200px	">
							<v-list-tile-title v-text="subItem.title"></v-list-tile-title>
							<v-list-tile-action>
								<v-icon v-text="subItem.icon"></v-icon>
							</v-list-tile-action>
						</v-list-tile>
					</v-list-group>
				</div>
			</v-list>
		</v-navigation-drawer>
	</v-layout>
</template>
<script>
export default {
	name: 'Dashboard',
	props: [],
	data() {
		return {
			msg: 'Welcome to Your Vue.js App',
			mini: false,
			drawer: null,
			navItems: [
				{ title: '登录', link: 'login', icon: 'supervisor_account' },
				{ title: '主页', link: '/', icon: 'home' },

				{
					title: '项目',
					link: '',
					icon: 'location_city',
					subNav: [
						{ title: '项目一览', link: '/Project/List', icon: 'view_list' },
						{ title: '新建项目', link: '/Project/Create', icon: 'playlist_add' },
						{ title: '项目计划=', link: '/Project/Plan', icon: 'view_module' },
					]
				},

				{
					title: '计划管理',
					link: '',
					icon: 'assessment',
					subNav: [
						{ title: '项目计划', link: '/Plan/Create', icon: 'view_module' },
						{ title: '阶段计划', link: '/Plan/', icon: 'view_headline' },
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
			return this.$store.state.identity.userName
		}
	},
	methods: {
		goto(item) {
			if (item.link == 'logout') {
				this.$store.commit('userLogout')
				this.$router.push('login')
			} else {
				this.$router.push(item.link)
			}
		}
	}
}

</script>
<style>
</style>
