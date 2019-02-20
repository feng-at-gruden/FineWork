<template>
	<v-menu v-model="dialog" :close-on-content-click="false" max-width="300" nudge-bottom="50" offset-x nudge-left="155" attach="#hearder-search-btn">
		<v-card>
			<v-list>
				<v-list-tile avatar>
					<v-list-tile-avatar>
						<img src="https://cdn.vuetifyjs.com/images/john.jpg" alt="John">
                        </v-list-tile-avatar>
						<v-list-tile-content>
							<v-list-tile-title>John Leider</v-list-tile-title>
							<v-list-tile-sub-title>Founder of Vuetify.js</v-list-tile-sub-title>
						</v-list-tile-content>
						<v-list-tile-action>
							<v-btn class="red--text" icon @click="">
								<v-icon>favorite</v-icon>
							</v-btn>
						</v-list-tile-action>
				</v-list-tile>
			</v-list>
			<v-divider></v-divider>
			<v-list>
				<v-list-tile>
					<v-list-tile-action>
						<v-switch v-model="planGanttFilter.plan" color="purple"></v-switch>
					</v-list-tile-action>
					<v-list-tile-title>Enable messages</v-list-tile-title>
				</v-list-tile>
				<v-list-tile>
					<v-list-tile-action>
						<v-switch v-model="planGanttFilter.plan" color="purple"></v-switch>
					</v-list-tile-action>
					<v-list-tile-title>Enable hints</v-list-tile-title>
				</v-list-tile>
			</v-list>
			<v-card-actions>
				<v-spacer></v-spacer>
				<v-btn flat @click="dialog = false">取消</v-btn>
				<v-btn color="primary" flat @click="handleSaveClick">确定</v-btn>
			</v-card-actions>
		</v-card>
	</v-menu>
</template>
<script>
export default {
	name: 'TaskFilterDialog',
	props: ['open'],
	data() {
		return {
			planGanttFilter: [],
		}
	},
	computed: {
        dialog: {
            get() { return this.$props.open },
            set(v) {
                if (!v) {
                    this.$emit('close')
                }
            }
        }
    },
	methods: {
		handleSaveClick(){
			this.dialog = false
			this.$emit('save', this.planGanttFilter)
		}
	}
}

</script>
<style>
</style>
