<template>
    <div style="width:1000px;">
      <div class="text-right">
        <button class="btn btn-primary" @click="movePage">등록</button>
      </div>
      <div v-if="items.length">
        <table class="table" style="width: 100%">
        
          <thead>
          <tr>
            <th scope="col" style="width: 10%;">번호</th>
            <th scope="col" style="width: 50%;">제목</th>
            <th scope="col" style="width: 15%;">작성자</th>
            <th scope="col" style="width: 25%;">날짜</th>
          </tr>
          </thead>
          <tbody>
          <tr v-for="(qna, index) in items" :key="index + '_items'">
            <td>{{qna.qnaNo}}</td>
            <td><router-link :to="{name: 'read', params:{no:qna.qnaNo}}">{{qna.qnaTitle}}</router-link></td>
            <td>{{qna.qnaUserid}}</td>
            <td>{{getFormatDate(qna.qnaDatetime)}}</td>
          </tr>
          </tbody>
        </table>
      </div>
      <div v-else class="text-center">
        게시글이 없습니다.
      </div>
      
    </div>
</template>

<script>
  import http from '@/util/http-common.js';
  import moment from 'moment';
    export default {
        name : 'List',
        data() {
            return {
                items:{}
            }
        },
        created() {
            http
            .get('/list')
            .then(({data}) => {
                this.items = data;
            })
        },
        methods: {
            getFormatDate(regtime) {
              return moment(new Date(regtime)).format('YYYY.MM.DD');
            },
            movePage() {
              this.$router.push('/happyhouse/qna/create');
            },
        }
    }
</script>

<style lang="scss" scoped>

</style>