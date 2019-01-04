import auth from './Auth'
import config from './Config'

export default {
	data(){
		return{
			auth,
			config
		}
	},
    computed: {
		title() {
			return this.$route.meta.title
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
	}
}