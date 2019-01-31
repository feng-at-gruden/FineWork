<template>
	<v-layout row wrap>
		<v-form lazy-validation ref="searchTaskForm">
			<v-flex lg12 md12>
				<v-card class="task-filter-box">
					<v-layout wrap row>
						<v-flex xs12 md6 pa-3>
							<v-autocomplete v-model="searchFilter.project" :items="allProjects" @input="handleProjecctChange" item-text="Name" item-value="Id" color="black lighten-4" class="header-search" label="选择项目" hint="选择项目" hide-no-data>
								<template slot="item" slot-scope="data">
									<template v-if="typeof data.item !== 'object'">
										<v-list-tile-content v-text="data.item"></v-list-tile-content>
									</template>
									<template v-else>
										<v-list-tile-content class="search-result-project-name">
											<v-list-tile-title v-html="data.item.Name"></v-list-tile-title>
										</v-list-tile-content>
									</template>
								</template>
							</v-autocomplete>
						</v-flex>
						<v-flex xs12 md6 pa-3>
							<v-text-field v-model="searchFilter.phase" :counter="25" label="选择阶段" append-icon="business"></v-text-field>
						</v-flex>
						<v-flex xs12 md8 pa-3 class="keyword">
							<v-text-field v-model="searchFilter.keyword" label="任务关键字" append-icon="search"></v-text-field>
						</v-flex>
						<v-flex xs12 md4 pa-3 class="keyword button-box">
							<v-btn @click="handleResetClick">清空</v-btn>
							<v-btn color="primary" @click="handleSearchClick">查找</v-btn>
						</v-flex>
					</v-layout>
				</v-card>
			</v-flex>
			<v-flex xs12 style="padding-top:40px;">
				<v-tabs v-model="taskStatus" color="grey lighten-3" slider-color="primary">
					<v-tab :key="-1" ripple>
						全部
					</v-tab>
					<v-tab v-for="n in config.TaskStatus.length" :key="n" ripple>
						{{config.TaskStatus[n-1]}}
					</v-tab>
				</v-tabs>
				<v-data-table :headers="headers" :items="desserts" class="elevation-1">
					<template slot="items" slot-scope="props">
						<td>{{ props.item.name }}</td>
						<td class="text-xs-right">{{ props.item.calories }}</td>
						<td class="text-xs-right">{{ props.item.fat }}</td>
						<td class="text-xs-right">{{ props.item.carbs }}</td>
						<td class="text-xs-right">{{ props.item.protein }}</td>
						<td class="text-xs-right">{{ props.item.iron }}</td>
					</template>
				</v-data-table>
			</v-flex>
		</v-form>
	</v-layout>
</template>
<script>
import BasePage from '../../assets/js/BasePage'
export default {
	extends: BasePage,
	name: 'ProgressPlan',
	props: [],
	data() {
		return {
			searchFilter: {},
			taskStatus: 0,
			headers: [{
					text: '施工任务',
					align: 'left',
					sortable: false,
					value: 'name'
				},
				{ text: '开工日期', value: 'calories' },
				{ text: 'Fat (g)', value: 'fat' },
				{ text: 'Carbs (g)', value: 'carbs' },
				{ text: '状态', value: 'protein' },
				{ text: '进度', value: 'iron' }
			],
			desserts: [{
					name: 'Frozen Yogurt',
					calories: 159,
					fat: 6.0,
					carbs: 24,
					protein: 4.0,
					iron: '1%'
				},
				{
					name: 'Ice cream sandwich',
					calories: 237,
					fat: 9.0,
					carbs: 37,
					protein: 4.3,
					iron: '1%'
				},
				{
					name: 'Eclair',
					calories: 262,
					fat: 16.0,
					carbs: 23,
					protein: 6.0,
					iron: '7%'
				},
				{
					name: 'Cupcake',
					calories: 305,
					fat: 3.7,
					carbs: 67,
					protein: 4.3,
					iron: '8%'
				},
				{
					name: 'Gingerbread',
					calories: 356,
					fat: 16.0,
					carbs: 49,
					protein: 3.9,
					iron: '16%'
				},
				{
					name: 'Jelly bean',
					calories: 375,
					fat: 0.0,
					carbs: 94,
					protein: 0.0,
					iron: '0%'
				},
				{
					name: 'Lollipop',
					calories: 392,
					fat: 0.2,
					carbs: 98,
					protein: 0,
					iron: '2%'
				},
				{
					name: 'Honeycomb',
					calories: 408,
					fat: 3.2,
					carbs: 87,
					protein: 6.5,
					iron: '45%'
				},
				{
					name: 'Donut',
					calories: 452,
					fat: 25.0,
					carbs: 51,
					protein: 4.9,
					iron: '22%'
				},
				{
					name: 'KitKat',
					calories: 518,
					fat: 26.0,
					carbs: 65,
					protein: 7,
					iron: '6%'
				}
			]
		}
	},
	computed: {
		allProjects() {
			var result = []
			var all = this.$store.state.allProjects
			if (all.length) {
				for (var i = 0; i < this.config.ProjectStatus.length; i++) {
					var s = this.config.ProjectStatus[i]
					if (all.filter(t => t.Status == s.value).length) {
						result.push({ header: s.text })
						result = result.concat(all.filter(t => t.Status == s.value))
						result.push({ divider: true })
					}
				}
				if (result.length)
					result.pop()
			} else {
				// Call Ajax
				this.$http.get(this.config.API_URL + '/Project/List').then(function(res) {
					this.$store.commit('updateAllProjects', JSON.parse(res.bodyText))
				})
			}
			return result
		},
	},
	methods: {
		handleProjecctChange(){
			//TODO Load project phase
			if(this.searchFilter.project)
			{
				console.log(this.searchFilter.project)
			}
		},
		handleResetClick(){
			this.$refs.searchTaskForm.reset()
		},
		handleSearchClick(){

		}
	},
	watch:{
		searchFilter:{
			deep:true,
			handler(){
				console.log(this.searchFilter)
			}
		}
	}
}

</script>
<style scoped>
.search-result-project-name {
	padding-left: 12px;
}

.task-filter-box .v-text-field {
	padding-top: 0px !important;
	padding-bottom: 0px !important;
}

.keyword {
	padding-top: 0px !important;
}

.button-box {
	text-align: right;
}

</style>
