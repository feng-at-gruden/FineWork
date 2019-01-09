<template>
	<v-app id="inspire">
		<v-content>
			<v-container fluid fill-height>
				<v-layout align-center justify-center>
					<v-flex xs12 sm8 md4>
						<v-card class="elevation-12">
							<v-toolbar :color="config.Theme">
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
									<v-text-field v-model="username" prepend-icon="person" name="login" label="Login" type="text" autofocus></v-text-field>
									<v-text-field v-model="password" prepend-icon="lock" name="password" label="Password" id="password" type="password" autofocus></v-text-field>
								</v-form>
							</v-card-text>
							<v-card-actions>
								<v-spacer></v-spacer>
								<v-btn :color="config.Theme" @click="handleLoginClick">登录</v-btn>
							</v-card-actions>
						</v-card>
						<v-alert :value="alert" type="error" icon="warning" transition="scale-transition">
							{{errorMsg}}
						</v-alert>
					</v-flex>
				</v-layout>
			</v-container>
		</v-content>
	</v-app>
</template>
<script>
import BasePage from '../assets/js/BasePage'

export default {
	extends: BasePage,
	name: 'Login',
	props: [],
	data() {
		return {
			username: '',
			password: '',
			alert: false,
			errorMsg: ''
		}
	},
	methods: {
		handleLoginClick() {
			this.alert = false
			this.auth.login(this.username, this.password, (msg) => {
				this.errorMsg = msg
				this.alert = true
			})
		}
	}
}

</script>
<style>
</style>
