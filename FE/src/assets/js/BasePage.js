import auth from './Auth'
import config from './Config'
import util from './Util'

export default {
	data(){
		return{
			auth,
			config,
			util,
			mainContainerCSS:'main-container'
		}
	},
    computed: {
		title() {
			return this.$route.meta.title
		},
		fullWidth() {
			return this.$route.meta.fullWidth
		},
		loading(){
			return this.$store.state.loading
		},
		needFooter(){
			return this.util.IsPC() && !this.$route.meta.fullWidth
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