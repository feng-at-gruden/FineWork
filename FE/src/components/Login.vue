<template>
	<v-app id="inspire">
		<v-content>
			<v-container fluid fill-height>
				<v-layout align-center justify-center>
					<v-flex xs12 sm8 md4>
						<v-card class="elevation-12">
							<v-toolbar dark color="primary">
								<v-toolbar-title>{{title}}</v-toolbar-title>
								<v-spacer></v-spacer>
								<v-tooltip bottom>
									<v-btn icon large target="_blank" slot="activator">
										<v-icon large>code</v-icon>
									</v-btn>
									<span>Help</span>
								</v-tooltip>
							</v-toolbar>
							<v-card-text>
								<v-form>
									<v-text-field prepend-icon="person" name="login" label="Login" type="text"></v-text-field>
									<v-text-field prepend-icon="lock" name="password" label="Password" id="password" type="password"></v-text-field>
								</v-form>
							</v-card-text>
							<v-card-actions>
								<v-spacer></v-spacer>
								<v-btn color="primary" @click="login">登录</v-btn>
							</v-card-actions>
						</v-card>
					</v-flex>
				</v-layout>
			</v-container>
		</v-content>
	</v-app>
</template>
<script>
import BasePage from '../assets/js/BasePage'

export default {
    extends : BasePage,
	name: 'Login',
	props: [],
	data() {
		return {
			
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
