import auth from './Auth'
import config from './Config'
import util from './Util'

export default {
	data() {
		return {
			auth,
			config,
			util,
			mainContainerCSS: 'main-container',
			subTitle:''
		}
	},
	computed: {
		appName(){
			return this.config.APP_NAME
		},
		copyright(){
			return '©' + (new Date()).getFullYear() + ' ' +  this.config.CLIENT_NAME	
		},
		title: {
			get(){return this.$route.meta.title},
		},
		fullWidth() {
			return this.$route.meta.fullWidth
		},
		showOptionMenu() {
			return this.$route.meta.showOptionMenu
		},
		loading: {
			get() { return this.$store.state.loading },
			set(v) { this.$store.commit('loading', v) }
		},
		needFooter() {
			return this.util.IsPC() && !this.$route.meta.fullWidth
		},
		drawer: {
			get() { this.$store.state.drawer },
			set(v) { this.$store.commit('openDrawer', v) }
		},
		selectedProject:{
        	get(){return this.$store.state.selectedProject},
        	set(v){
	    		this.$store.commit('updateSelectedPorject', v)
	    		this.eventBus.$emit('selectedProjectChanged',v)
	    		console.log('selectedProjectChanged',v)
        	}
        }
	},
	watch: {
		subTitle(v, ov) {
			document.title = config.APP_NAME + " - " + v + this.title
			this.eventBus.$emit('subTitleChanged',v)
		}
	},
	methods: {},
	created() {
		if (this.$route.meta.requiresAuth) {			
			if (!this.auth.checkIsLogin(this.$store.state)) {
				this.$router.replace('/login' + '?returnUrl=' + this.$route.path)
				return
			}
		}
	},	
	beforeDestroy (){
		this.eventBus.$emit('subTitleChanged','')
	}
}
