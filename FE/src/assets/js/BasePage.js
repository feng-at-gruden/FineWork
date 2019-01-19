import auth from './Auth'
import config from './Config'
import util from './Util'

export default {
	data(){
		return{
			auth,
			config,
			util,
			mainContainerCSS:'main-container',			
		}
	},
    computed: {
		title() {
			return this.$route.meta.title
		},
		fullWidth() {
			return this.$route.meta.fullWidth
		},
		showOptionMenu(){
			return this.$route.meta.showOptionMenu
		},
		loading: {
			get() { return this.$store.state.loading },
			set(v) { this.$store.commit('loading', v) }
		},
		needFooter(){
			return this.util.IsPC() && !this.$route.meta.fullWidth
		},
		drawer:{
			get(){this.$store.state.drawer},
			set(v){this.$store.commit('openDrawer', v)}
		}
	},
	methods:{
	},	
	created(){		
	    if (this.$route.meta.requiresAuth) {
	        if (!this.auth.checkIsLogin(this.$store.state)) {
	            this.$router.replace('/login' + '?returnUrl=' + this.$route.path)
	            return
	        }
	    }
	},	
}