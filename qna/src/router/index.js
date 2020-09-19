import Vue from "vue";
import VueRouter from "vue-router";
import Create from '../components/Create.vue';
import Delete from '../components/Delete.vue';
import List from '../components/List.vue';
import Read from '../components/Read.vue';
import Update from '../components/Update.vue';
Vue.use(VueRouter);

const routes = [
  {
    path: '/happyhouse/qna.do',
    name: 'main',
    redirect: { name: 'list' }
  },
  {
    path: '/happyhouse/qna/list',
    name: 'list',
    component: List,
  },
  {
    path: '/happyhouse/qna/create',
    name: 'create',
    component: Create,
  },
  {
    path: '/happyhouse/qna/read/:no',
    name: 'read',
    component: Read,
  },
  {
    path: '/happyhouse/qna/update/:no',
    name: 'update',
    component: Update,
  },
  {
    path: '/happyhouse/qna/delete/:no',
    name: 'delete',
    component: Delete,
  }
];

const router = new VueRouter({
  mode: "history",
  base: process.env.BASE_URL,
  routes
});

export default router;
