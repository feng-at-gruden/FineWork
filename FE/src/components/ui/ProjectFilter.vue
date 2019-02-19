<template>
	<v-layout row wrap>
		<v-flex d-flex lg1 md2 sm2 xs12>
			<v-layout justify-start align-center>
				<v-label>项目状态:</v-label>
			</v-layout>
		</v-flex>
		<v-flex d-flex lg6 md6 sm8 xs12>
			<v-layout justify-start>
				<v-checkbox v-for="item in config.ProjectStatus" v-model="filter" :label="item.text" :value="item.value" :key="item.value" @change="filterChange" class="text-truncate"></v-checkbox>
			</v-layout>
		</v-flex>
		<!--
		<v-flex lg2 md4 sm12 xs12 offset-lg3>
			<v-layout justify-end align-center class="project-layout-container">
				<v-btn-toggle v-model="displayLayout" mandatory>
					<v-btn flat>
						<v-icon>view_module</v-icon>
					</v-btn>
					<v-btn flat>
						<v-icon>view_list</v-icon>
					</v-btn>
					<v-btn flat>
						<v-icon>vertical_split</v-icon>
					</v-btn>
				</v-btn-toggle>
			</v-layout>
		</v-flex>
		-->
	</v-layout>
</template>
<script>
import config from '../../assets/js/Config'
export default {
	name: 'VUE',
	props: ['layout'],
	data() {
		return {
			config,
			filter: ['在建中']
		}
	},
	computed:{
		displayLayout:{
			get(){return this.$props.layout},
			set(v){this.$emit('layoutChange', v)}
		}
	},
	methods: {
		filterChange() {
			this.$emit('filterChange', this.filter)
		}
	}
}

</script>
<style>
.project-layout-container{
    padding-right: 10px;
}
</style>
