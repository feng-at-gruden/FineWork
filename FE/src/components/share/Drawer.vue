<template>
	<v-navigation-drawer v-model="drawer" @input="handleInput" class="my-drawer grey lighten-4" clipped fixed app>
		<v-list dense class="grey lighten-4">
			<template v-for="(item, i) in items">
				<v-layout row v-if="item.heading" align-center :key="i">
					<v-flex xs6>
						<v-subheader v-if="item.heading">
							{{ item.heading }}
						</v-subheader>
					</v-flex>
					<v-flex xs6 class="text-xs-right">
						<!--<v-btn small flat>edit</v-btn>-->
					</v-flex>
				</v-layout>
				<v-divider dark v-else-if="item.divider" class="my-3" :key="i"></v-divider>
				<v-list-tile :key="i" v-else @click="goto(item)">
					<v-list-tile-action>
						<v-icon>{{ item.icon }}</v-icon>
					</v-list-tile-action>
					<v-list-tile-content>
						<v-list-tile-title class="text-darken-3">
							{{ item.title }}
						</v-list-tile-title>
					</v-list-tile-content>
				</v-list-tile>
			</template>
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
			items: [
				/*{ title: '登录', link: '/login', icon: 'supervisor_account' },*/
				{ title: '主页', link: '/', icon: 'home' },
				{ divider: true },
				{ heading: '工程管理' },
				{ title: '新建工程', link: '/Project/Create', icon: 'library_add' },
				{ title: '工程一览', link: '/Project/List', icon: 'location_city' },
				{ divider: true },
				{ heading: '计划管理' },
				{ title: '工程计划', link: '/Project/Plan', icon: 'subject' },
				{ title: '阶段计划', link: '/Plan/Phase', icon: 'playlist_add_check' },
				{ divider: true },
				{ heading: '工作汇报' },
				{ title: '施工日志', link: '/work/daily', icon: 'assignment' },
				{ divider: true },
				{ heading: '系统管理' },
				{ title: '账号管理', link: '/Setting/Account', icon: 'supervisor_account' },
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
				this.auth.logout()
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
.navigation-drawer__border {
	display: none;
}
.my-drawer{
	padding-top: 15px;	
}
</style>
