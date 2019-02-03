<template>
    <v-layout row wrap>
        <v-flex lg12 md12>
            <v-card class="task-filter-box">
                <v-form lazy-validation ref="searchUserForm">
                    <v-layout wrap row>
                        <v-flex xs12 md8 pa-3 class="keyword" style="margin-top: -10px;">
                            <v-text-field v-model="keyword" label="用户名" append-icon="search"></v-text-field>
                        </v-flex>
                        <v-flex xs12 md4 pa-3 class="keyword button-box">
                            <v-btn @click="handleResetClick">清空</v-btn>
                            <v-btn color="primary" @click="handleSearchClick">查找</v-btn>
                        </v-flex>
                    </v-layout>
                </v-form>
            </v-card>
        </v-flex>
        <v-flex xs12 style="padding-top:25px;">
        	<v-data-table :headers="headers" :items="filteredUsers" class="elevation-1">
                <template slot="items" slot-scope="props">
                    <td class="text-no-wrap" @click="openWorkDialog(props.item)">{{ props.item.text }} <span class="task-exceed-small" v-if="props.item.exceed">已逾期</span></td>
                    <td class="text-xs-center text-no-wrap task-date">{{ props.item.start_date.split('T')[0] }} 至 {{ props.item.end_date.split('T')[0] }}</td>
                    <td class="text-xs-center">{{ props.item.duration }}天</td>
                </template>
            </v-data-table>
        </v-flex>
    </v-layout>
</template>
<script>
import BasePage from '../../assets/js/BasePage'

export default {
    extends: BasePage,
    name: 'Users',
    data() {
        return {
        	filteredUsers,
        	headers: [{
                    text: '用户名',
                    align: 'left',
                    sortable: false,
                    value: 'text'
                },
                { text: '部门', value: 'start_date', align: 'center' },
                { text: '登录日期', value: 'duration', align: 'center' },
                { text: '操作', value: 'actual_start', align: 'center' },
            ],
            dateToStr: gantt.date.date_to_str("%Y-%m-%d"),
        }
    },
    methods: {

    }

}

</script>
<style>
</style>
