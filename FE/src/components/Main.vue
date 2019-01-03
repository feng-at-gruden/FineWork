<template>
	<v-app dark>
		<Header />
		<Drawer />
		<v-content>
			<v-container fluid fill-height>
				<v-layout justify-center align-center>
					<v-flex shrink>
						<v-fade-transition mode="out-in">
							<router-view class="main-container" />
						</v-fade-transition>
					</v-flex>
				</v-layout>
			</v-container>
		</v-content>
		<Footer />
	</v-app>
</template>
<script>
// Components
import Header from '@/components/share/Header'
import Drawer from '@/components/share/Drawer'
import Footer from '@/components/share/Footer'
import BasePage from '../assets/js/BasePage'

export default {
    extends : BasePage,
	name: 'Main',
	props: [],
	components: {
		Header,
		Drawer,
		Footer,
	},
	data() {
		return {
			msg: 'Welcome to Your Vue.js App'
		}
	},
	methods: {

	}
}

</script>
<style>
</style>
