const tasks = {
    data: [
        { id: 1, text: "土方工程", start_date: "02-04-2018", duration: 6, progress: 1, open: false, locked: true, "render": "split", exceed: false, plan_start: "2018/04/10", plan_end: "04/15", plan_duration: "5", actual_start: "2018/04/11", actual_end: "04/15", actual_duration: "2" },
        { "id": 1991, "comment": "计划", "text": "", "start_date": "02-04-2018", "duration": 5, "parent": "1", "progress": 0, type: "plan" },
        { "id": 1992, "comment": "实际", "text": "已完工", "start_date": "02-04-2018", "duration": 6, "parent": "1", "progress": 1, type: "actual", exceed: false, "status": "finished" },

        { id: 2, text: "基础工程", start_date: "9-04-2018", duration: 16, progress: 0.4, open: true, exceed: true, priority: 1, exceed: false, plan_start: "2018/04/10", plan_end: "04/15", plan_duration: "5", actual_start: "2018/04/11", actual_end: "05/11", actual_duration: "2" },
        { id: 3, text: "垫层施工", start_date: "09-4-2018", duration: 2, progress: 0, parent: 2, "render": "split", exceed: false, plan_start: "2018/04/10", plan_end: "04/15", plan_duration: "5", actual_start: "2018/04/11", actual_end: "05/18", actual_duration: "2" },
        { "id": 3991, "comment": "计划", "text": "", "start_date": "09-4-2018", "duration": 2, "parent": "3", "progress": 0, type: "plan" },
        { "id": 3992, "comment": "实际", "text": "已延期5天", "start_date": "09-04-2018", "duration": 2, "parent": "3", "progress": 0, type: "actual", exceed: false, delayed: true, "status": "not_start" },

        { id: 4, text: "转胎膜砌筑抹灰", start_date: "10-04-2018", duration: 5, progress: 0.2, parent: 2, render: "split", exceed: false, plan_start: "2018/04/10", plan_end: "04/15", plan_duration: "5", actual_start: "2018/04/11", actual_end: "05/11", actual_duration: "2" },
        { "id": 4991, "comment": "计划", "text": "", "start_date": "10-04-2018", "duration": 5, "parent": "4", "progress": 0, type: "plan" },
        { "id": 4992, "comment": "实际", "text": "施工中", "start_date": "11-04-2018", "duration": 2, "parent": "4", "progress": 0.2, type: "actual", exceed: false, "status": "working" },
        { id: 5, text: "防水卷材施工", start_date: "12-04-2018", duration: 0, "render": "split", progress: 1, parent: 2, exceed: false, plan_start: "2018/04/10", plan_end: "04/15", plan_duration: "5", actual_start: "2018/04/11", actual_end: "05/11", actual_duration: "2" },
        { "id": 5991, "comment": "计划", "text": "", "start_date": "11-04-2018", "duration": 5, "parent": "5", "progress": 0, type: "plan" },
        { "id": 5992, "comment": "实际", "text": "已完工", "start_date": "12-04-2018", "duration": 7, "parent": "5", "progress": 1, type: "actual", exceed: false, "status": "finished" },
        { id: 6, text: "防水保护层", start_date: "15-04-2018", duration: 3, progress: 1, parent: 2, "render": "split", exceed: false, plan_start: "2018/04/10", plan_end: "04/15", plan_duration: "5", actual_start: "2018/04/11", actual_end: "05/11", actual_duration: "2" },
        { "id": 6991, "comment": "计划", "text": "", "start_date": "15-04-2018", "duration": 3, "parent": "6", "progress": 0, type: "plan" },
        { "id": 6992, "comment": "实际", "text": "已完工", "start_date": "15-04-2018", "duration": 2, "parent": "6", "progress": 1, type: "actual", exceed: false, "status": "finished" },
        { id: 7, text: "钢筋困扎", start_date: "15-04-2018", duration: 0, "render": "split", progress: 0, parent: 2, status: "pending", exceed: true, plan_start: "2018/04/10", plan_end: "04/15", plan_duration: "5", actual_start: "2018/04/11", actual_end: "2018/04/16", actual_duration: "2" },
        { "id": 7991, "comment": "计划", "text": "", "start_date": "15-04-2018", "duration": 2, "parent": "7", "progress": 0, type: "plan" },
        { "id": 7992, "comment": "实际", "text": "已停工8天", "start_date": "16-04-2018", "duration": 2, "parent": "7", "progress": 0.5, type: "actual", "status": "pending" },

        { id: 8, text: "模板支设-延期", start_date: "16-04-2018", duration: 0, "render": "split", progress: 0.5, parent: 2, exceed: true, plan_start: "2018/04/10", plan_end: "04/15", plan_duration: "5", actual_start: "2018/04/11", actual_end: "05/11", actual_duration: "2" },
        { "id": 8991, "comment": "计划", "text": "", "start_date": "16-04-2018", "duration": 5, "parent": "8", "progress": 0, type: "plan" },
        { "id": 8992, "comment": "实际", "text": "已逾期4天", "start_date": "18-04-2018", "duration": 7, "parent": "8", "progress": 0.5, type: "actual", exceed: true, "status": "working" },
        { id: 9, text: "混凝土浇筑", start_date: "18-04-2018", duration: 0, progress: 0.5, parent: 2, "render": "split", exceed: true, plan_start: "2018/04/10", plan_end: "04/15", plan_duration: "5", actual_start: "2018/04/11", actual_end: "05/11", actual_duration: "2" },
        { "id": 9991, "comment": "计划", "text": "", "start_date": "18-04-2018", "duration": 2, "parent": "9", "progress": 0, type: "plan", },
        { "id": 9992, "comment": "实际", "text": "延期3天逾期6天", "start_date": "21-04-2018", "duration": 5, "parent": "9", "progress": 0.5, type: "actual", exceed: true, "status": "working" },
        { id: 10, text: "地下室主体", start_date: "05-04-2018", duration: 10, progress: 0.3, open: true, exceed: false, plan_start: "2018/04/10", plan_end: "04/15", plan_duration: "5", actual_start: "2018/04/11", actual_end: "05/11", actual_duration: "200" },
        { id: 11, text: "墙柱钢筋绑扎", start_date: "5-04-2018", duration: 2, progress: 1, parent: 10, render: "split", exceed: false, plan_start: "2018/04/10", plan_end: "04/15", plan_duration: "5", actual_start: "2018/04/11", actual_end: "05/11", actual_duration: "2" },
        { "id": 11991, "comment": "计划", "text": "", "start_date": "5-04-2018", "duration": 2, "parent": "11", "progress": 0, type: "plan", },
        { "id": 11992, "comment": "实际", "text": "已完工", "start_date": "5-04-2018", "duration": 2, "parent": "11", "progress": 1, type: "actual", exceed: true, "status": "finised" },
        { id: 12, text: "排架搭设", start_date: "6-04-2018", duration: 2, progress: 0.3, parent: 10, render: "split", exceed: true, plan_start: "2018/04/10", plan_end: "04/15", plan_duration: "5", actual_start: "2018/04/11", actual_end: "05/11", actual_duration: "2" },
        { "id": 12991, "comment": "计划", "text": "", "start_date": "6-04-2018", "duration": 3, "parent": "12", "progress": 0, type: "plan", },
        { "id": 12992, "comment": "实际", "text": "施工中", "start_date": "6-04-2018", "duration": 2, "parent": "12", "progress": 0.3, type: "actual", exceed: false, "status": "working" },
        { id: 13, text: "顶板梁模板支设", start_date: "9-04-2018", duration: 4, progress: 0.6, parent: 10, render: "split", exceed: true, plan_start: "2018/04/10", plan_end: "04/15", plan_duration: "5", actual_start: "2018/04/11", actual_end: "05/11", actual_duration: "2" },
        { "id": 13991, "comment": "计划", "text": "", "start_date": "9-04-2018", "duration": 4, "parent": "13", "progress": 0, type: "plan", },
        { "id": 13992, "comment": "实际", "text": "施工中", "start_date": "8-04-2018", "duration": 3, "parent": "13", "progress": 0.6, type: "actual", exceed: false, "status": "working" },
        { id: 14, text: "顶板梁钢筋绑扎、墙柱模板加固", start_date: "10-04-2018", duration: 2, progress: 0.8, parent: 10, render: "split", exceed: true, plan_start: "2018/04/10", plan_end: "04/15", plan_duration: "5", actual_start: "2018/04/11", actual_end: "05/11", actual_duration: "2" },
        { "id": 14991, "comment": "计划", "text": "", "start_date": "10-04-2018", "duration": 4, "parent": "14", "progress": 0, type: "plan", },
        { "id": 14992, "comment": "实际", "text": "施工中", "start_date": "12-04-2018", "duration": 2, "parent": "14", "progress": 0.8, type: "actual", exceed: false, "status": "working" },
        { id: 15, text: "混凝土浇筑", start_date: "9-04-2018", duration: 5, progress: 0.7, parent: 10, render: "split", exceed: true, plan_start: "2018/04/10", plan_end: "04/15", plan_duration: "5", actual_start: "2018/04/11", actual_end: "05/11", actual_duration: "2" },
        { "id": 15991, "comment": "计划", "text": "", "start_date": "9-04-2018", "duration": 5, "parent": "15", "progress": 0, type: "plan", },
        { "id": 15992, "comment": "实际", "text": "施工中", "start_date": "10-04-2018", "duration": 5, "parent": "15", "progress": 0.7, type: "actual", exceed: true, "status": "working" },
        { id: 16, text: "主体结构", start_date: "11-04-2018", duration: 21, type: "plan", progress: 0, exceed: false, plan_start: "2018/04/10", plan_end: "04/15", plan_duration: "5", actual_start: "2018/04/11", actual_end: "05/11", actual_duration: "2" },
        { id: 17, text: "一层主体结构", start_date: "11-04-2018", duration: 2, progress: 0, parent: 16, exceed: true, plan_start: "2018/04/10", plan_end: "04/15", plan_duration: "5", actual_start: "2018/04/11", actual_end: "05/11", actual_duration: "2" },
        { id: 18, text: "墙柱钢筋绑扎", start_date: "11-04-2018", duration: 2, progress: 0, parent: 17 },
        { id: 19, text: "排架搭设", start_date: "11-04-2018", duration: 2, progress: 0, parent: 17 },
        { id: 20, text: "顶板梁模板支设", start_date: "11-04-2018", duration: 1, progress: 0, parent: 17 },
        { id: 21, text: "顶板梁钢筋绑扎、墙柱模板加固", start_date: "11-04-2018", duration: 2, progress: 0, parent: 17 },
        { id: 22, text: "一层混凝土浇筑", start_date: "11-04-2018", duration: 2, progress: 0, parent: 17 },
        { id: 23, text: "二层主体结构", start_date: "11-04-2018", duration: 2, progress: 0, parent: 16, },
        { id: 24, text: "墙柱钢筋绑扎", start_date: "11-04-2018", duration: 2, progress: 0, parent: 23 },
        { id: 25, text: "排架搭设", start_date: "11-04-2018", duration: 2, progress: 0, parent: 23 },
        { id: 26, text: "顶板梁模板支设", start_date: "11-04-2018", duration: 2, progress: 0, parent: 23 },
        { id: 27, text: "顶板梁钢筋绑扎、墙柱模板加固", start_date: "11-04-2018", duration: 2, progress: 0, parent: 23 },
        { id: 28, text: "二层混凝土浇筑", start_date: "11-04-2018", duration: 5, progress: 0, parent: 23, oldplan: { id: 1, start_date: "11-02-2018", duration: 2 } },
    ],
    links: [],
    start_date: "01-03-2018",
    end_date: "01-12-2019",
};

const projects = [
    { id: 1, name: '龙湖地产项目', description: '项目描述、项目描述、项目描述、项目描述、项目描述、项目描述、', image: '' },
    { id: 2, name: '碧桂园威海项目', description: '项目描述、项目描述、项目描述、项目描述、项目描述、项目描述、', image: '' },
    { id: 3, name: '万科市南项目', description: '项目描述、项目描述、项目描述、项目描述、项目描述、项目描述、', image: '' },
    { id: 4, name: '保利地产项目', description: '项目描述、项目描述、项目描述、项目描述、项目描述、项目描述、', image: '' },
    { id: 5, name: '万达中心城项目', description: '项目描述、项目描述、项目描述、项目描述、项目描述、项目描述、', image: '' },
]

const projectDetailedPlan = {
    start_date: "01-03-2018",
    end_date: "01-12-2019",
    links: [],
    data: [
        // {id:998, text:"项目开工", type:"milestone", start_date:"1-03-2018"},
        { id: 1, text: "基础工程", start_date: "02-04-2018", duration: 6, progress: 1, type: "project", open: true},
        { id: 2, text: "主体工程", start_date: "12-04-2018", duration: 20, progress: 0.8, type: "project", open: true},
        { id: 3, text: "屋面工程", start_date: "25-04-2018", duration: 36, progress: 0.2, type: "project", open: true},
        { id: 4, text: "装饰装修工程", start_date: "02-05-2018", duration: 47, progress: 0.2, type: "project", open: true},
        { id: 5, text: "收尾阶段", start_date: "02-05-2018", duration: 7, progress: 0, type: "project", open: true},
        // {id:999, text:"竣工", type:"milestone", start_date:"1-21-2019"},
    ]
}

const projectRawPlan = {
    start_date: "01-03-2018",
    end_date: "01-12-2019",
    links: [],
    data: [
        // {id:998, text:"项目开工", type:"milestone", start_date:"1-03-2018"},
        { id: 1, text: "基础工程", start_date: "02-04-2018", duration: 6, progress: 0, type: "project", open: true},
        { id: 2, text: "主体工程", start_date: "12-04-2018", duration: 20, progress: 0, type: "project", open: true},
        { id: 3, text: "屋面工程", start_date: "25-04-2018", duration: 36, progress: 0, type: "project", open: true},
        { id: 4, text: "装饰装修工程", start_date: "02-05-2018", duration: 47, progress: 0, type: "project", open: true},
        // {id:999, text:"竣工", type:"milestone", start_date:"1-21-2019"},
    ]
}

exports.tasks = tasks
exports.projects = projects
exports.projectDetailedPlan = projectDetailedPlan
exports.projectRawPlan = projectRawPlan
