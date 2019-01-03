import auth from './Auth'
export default {
	data(){
		return{
			auth,
		}
	},
    computed: {
		title() {
			return this.$route.meta.title
		}
	},
	methods:{

	}
}