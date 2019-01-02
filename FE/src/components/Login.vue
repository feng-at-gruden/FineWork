<template>
	<div>
		This is Login Page
		<v-btn color="error" @click="login">Login</v-btn>
	</div>
</template>
<script>
export default {
	name: 'Login',
	props: [],
	data() {
		return {
			msg: 'Welcome to Your Vue.js App'
		}
	},
	methods: {
		login() {
			this.$store.commit('userLogin', {
				userName: 'Feng Guo',
				token: '123123'
			})
			this.$router.push('/')
		}
	}
}

</script>
<style>
</style>
