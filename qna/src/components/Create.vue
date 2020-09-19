<template>
  <div>
    <form id="writeform" method="post" action="">
      <input type="hidden" name="act" id="act" value="write">
         <div class="form-group" align="center" style="width:700px">
            <label for="qnaTitle" style="align:left;font-weight:bold;">제목:</label>
            <input type="text" class="form-control" id="qnaTitle" ref="qnaTitle" name="qnaTitle" placeholder="제목을 입력하세요" v-model="qnaTitle" style="margin-left:10px;display:inline-block; width: 650px">
         </div>
         <div class="form-group" align="center" style="width:700px">
            <label for="qnaContent" style="align:left;position: relative;font-weight:bold; float:left; left: 6px;">내용:</label>
            <textarea class="form-control" rows="15" id="qnaContent" ref="qnaContent" name="qnaContent" placeholder="내용을 입력하세요" v-model="qnaContent" style="margin-left:10px;display:inline-block; width: 650px"></textarea>
         </div>
         <button type="button" class="btn btn-primary" @click="checkHandler" style="margin:5px;">등록</button>
         <button type="reset" class="btn btn-warning" style="margin:5px;">초기화</button>
      </form>
  </div>
</template>

<script>
import http from '@/util/http-common.js';
export default {
    name:'Create',
data: function () {
    return {
      qnaTitle: '',
      qnaDatetime: '',
      qnaContent: '',
    };
  },
  methods: {
    checkHandler() {
      let err = true;
      let msg = '';
      err && !this.qnaTitle && ((msg = '제목 입력해주세요'), (err = false), this.$refs.qnaTitle.focus());
      err &&
        !this.qnaContent &&
        ((msg = '내용 입력해주세요'), (err = false), this.$refs.qnaContent.focus());

      if (!err) alert(msg);
      else this.createHandler();
    },
    createHandler() {
      http
        .post('', {
          qnaUserid: this.qnaUserid,
          qnaTitle: this.qnaTitle,
          qnaContent: this.qnaContent,
        })
        .then(({ data }) => {
          let msg = '등록 처리시 문제가 발생했습니다.';
          if (data === 'success') {
            msg = '등록이 완료되었습니다.';
          }
          alert(msg);
          this.moveList();
        });
    },
    moveList() {
      this.$router.push('./list');
    },
  }
}
</script>

<style>

</style>