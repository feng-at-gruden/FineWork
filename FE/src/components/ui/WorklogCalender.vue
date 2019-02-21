<template>
    <v-dialog v-model="dialog" fullscreen hide-overlay transition="dialog-bottom-transition">
        <v-card>
            <v-toolbar dark color="primary">
                <v-btn icon dark @click="dialog=false">
                    <v-icon>close</v-icon>
                </v-btn>
                <v-toolbar-title>工作日志</v-toolbar-title>
                <v-spacer></v-spacer>
                <v-toolbar-items>
                    <v-btn dark flat large @click="dialog=false" :loading="loading">关闭</v-btn>
                </v-toolbar-items>
            </v-toolbar>
            <full-calendar :events="fcEvents" class="calendar-container" locale="zh" :firstDay="1"></full-calendar>
        	<!--
            <ds-calendar-app v-cloak :calendar="calendar" :read-only="readOnly">
                <template slot="title">
                    工作日志
                </template>
                <template slot="menuRight">
                    <v-btn icon @click="dialog=false">
                        <v-icon>close</v-icon>
                    </v-btn>
                </template>
                <template slot="calendarAppCalendar">
                	<ds-calendar :calendar="calendar" :read-only="readOnly" class="calendar-container"></ds-calendar>
                </template>
            </ds-calendar-app>
        	-->

        </v-card>
    </v-dialog>
</template>
<script>
//https://github.com/ClickerMonkey/dayspan-vuetify
import BasePage from '../../assets/js/BasePage'
import { Calendar } from 'dayspan'
import fullCalendar from 'vue-fullcalendar'

var demoEvents = [
	{
      title : 'Sunny Out of Office',
      start : '2019-02-14',
      end : '2019-02-15'
    }
]
export default {
    extends: BasePage,
    name: 'WorklogCalender',
    props: ['open'],
    components:{fullCalendar,},
    data() {
        return {
            readOnly: true,
            calendar: Calendar.months(),
            fcEvents: demoEvents
        }
    },
    computed: {
        dialog: {
            get() { return this.$props.open },
            set(v) {
                this.$emit('close')
            }
        },
    },
    methods: {
        handleCancel() {
            //this.$refs.editAccountForm.reset()
            this.dialog = false
            this.loading = false
        },
        handleSave() {
            //Call API
            this.dialog = false
            this.loading = false
        },
    }
}

</script>
<style scoped>
#dayspan {
    font-family: Roboto, sans-serif;
    width: 100%;
    height: 100%;
}

.calendar-container {
    min-height: 520px;
    height: 100%;
    /*border-left: 1px solid #e0e0e0;
    border-top: 1px solid #e0e0e0;*/
}

.ds-month .ds-week-header-day {
    background: #ccc;
}




</style>
