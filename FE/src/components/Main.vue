<template>
	<div>
		<v-app >
			<Drawer />
			<Header @onOptionMenuClick="handleHeaderOptionMenuClick" :subHeader="subHeader"/>			
			<v-content class="v-content-container">
				<v-container fill-height :class="[fullWidth?'main-container-full':'main-container', '']">
					<v-layout justify-center fill-height row wrap align-center>
						<v-flex fill-height xs12>
							<v-fade-transition mode="out-in">
								<router-view />
							</v-fade-transition>
						</v-flex>
					</v-layout>
				</v-container>
			</v-content>
			<Footer v-if="needFooter" />		
			
		</v-app>
		<div :class="loaderCss" v-if="loading"></div>
		<!--<div class="loading" v-show="loading"></div>-->		
	</div>
</template>
<script>
// Components
import Header from '@/components/share/Header'
import Drawer from '@/components/share/Drawer'
import Footer from '@/components/share/Footer'
import BasePage from '../assets/js/BasePage'

export default {
	extends: BasePage,
	name: 'Main',
	props: [],
	components: {
		Header,
		Drawer,
		Footer,
	},
	data() {
		return {
			subHeader:'',
		}
	},
	computed:{
		loaderCss(){
			var path = this.$route.name
			if(path=='ProjectPlan' || path=='PhasePlan')
				return 'gantt-loader'
			else
				return 'loader'

		}
	},
	methods: {
		handleHeaderOptionMenuClick(menuItem){
			this.$store.commit('optionMenuClick', menuItem)
		}
	},
	mounted() {
        this.eventBus.$on('subTitleChanged', v=> this.subHeader = v)
    },
    beforeDestroy() {
    	this.eventBus.$off('subTitleChanged')
    }
}

</script>
<style>
</style>
