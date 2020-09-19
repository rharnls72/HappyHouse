<template>
    <div>
        <table class="table" style="width:700px; min-height:200px;">
          <thead>
            <tr>
              <th scope="col" style="width: 50%;">{{item.qnaTitle}}</th>
              <th scope="col" style="width: 20%;">{{item.qnaUserid}}</th>
              <th scope="col" style="width: 30%;">{{getFormatDate(item.qnaDatetime)}}</th>
            </tr>
          </thead>
          <tbody>
          <tr>
            <td  scope="row" colspan="3">
              {{item.qnaContent}}
            </td>
          </tr>
          </tbody>
        </table>
        
        <form>
        <div>
        <router-link v-if="this.id == item.qnaUserid" :to="{name: 'update', params:{no: item.qnaNo}}"><button type="button" class="btn btn-primary">수정</button></router-link>
        <router-link :to="{name: 'list'}"><button type="button" class="btn btn-primary">목록</button></router-link>
        <router-link v-if="this.id == item.qnaUserid" :to="{name: 'delete', params:{no: item.qnaNo}}"><button type="button" class="btn btn-warning">삭제</button></router-link>
        </div>
        <br/>
        <div class="form-group" align="center" style="width:700px;display: table; vertical-align: middle;">
        <label for="reply" style="align:left;font-weight:bold;display: table-cell;" >답글:</label>
        <textarea :disabled="this.id == 'admin'? false:true" class="form-control" rows="2" id="reply" ref="reply" name="reply" placeholder="내용을 입력하세요" v-model="reply" style="background-color:#cce2eb;margin-left:10px;display:inline-block; width: 650px"></textarea>
        </div>
         <button v-if="this.id=='admin' && this.item.replyUserid ==null" type="button" class="btn btn-primary" @click="checkHandler" style="margin:5px;">등록</button>
         <button v-if="this.id=='admin' && this.item.replyUserid !=null" type="button" class="btn btn-primary" @click="checkHandler" style="margin:5px;">수정</button>
         <button v-if="this.id=='admin'" type="button" class="btn btn-warning" @click="deleteReply" style="margin:5px;">삭제</button>
        </form>
    </div>
</template>

<script>
  import http from '@/util/http-common.js';
  import moment from 'moment';

    export default {
        data() {
            return{
                item: {},
                reply:'',
                id:''
            }
        },
        created() {
            var no = this.$route.params.no;
            http
            .get('/'+no)
            .then(({data}) => {
              
                this.item = data.qna;
                this.reply = this.item.replyContent;
                this.id = data.userid;
                console.log(this.id == this.item.qnaUserid);
            })
        },
        methods: {
          getFormatDate(regtime) {
            return moment(new Date(regtime)).format('YYYY.MM.DD');
          },
          checkHandler() {
            let err = true;
            let msg = '';
            err && !this.reply && ((msg = '답글 입력해주세요'), (err = false), this.$refs.reply.focus());
            
            if (!err) alert(msg);
            else this.createHandler();
          },
          createHandler() {
            http
              .post('/reply', {
                qnaNo: this.item.qnaNo,
                replyDatetime: moment(new Date()).format('YYYY-MM-DD HH:mm:ss'),
                replyContent: this.reply,
              })
              .then(({ data }) => {
                let msg = '등록 처리시 문제가 발생했습니다.';
                if (data === 'success') {
                  msg = '등록이 완료되었습니다.';
                }
                alert(msg);
              });
          },
          updateReply(){
            http
            .put(`/reply`, {
              qnaNo: this.item.qnaNo,
              replyDatetime: moment(new Date()).format('YYYY-MM-DD HH:mm:ss'),
              replyContent: this.reply,
            })
            .then(({ data }) => {
              let msg = '수정 처리시 문제가 발생했습니다.';
              if (data === 'success') {
                msg = '수정이 완료되었습니다.';
              }
              alert(msg);
            });
          },
          deleteReply(){
            http.put('/reply/'+this.item.qnaNo).then(({ data }) => {
              let msg = '삭제 처리시 문제가 발생했습니다.';
              if (data === 'success') {
                msg = '삭제가 완료되었습니다.';
              }
              alert(msg);
              this.reply='';
            });
          }
        }
    }
</script>

<style lang="scss" scoped>

</style>