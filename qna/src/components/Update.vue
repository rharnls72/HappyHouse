<template>
  <div>
    <form id="writeform" method="post" action="">
      <div class="form-group" align="center" style="width:700px">
      <label for="writer" style="align:left;font-weight:bold;">작성자</label>
      <input readonly="readonly" type="text" class="form-control" id="qnaUserid" ref="qnaUserid" placeholder="작성자" v-model="qnaUserid" style="margin-left:10px;display:inline-block; width: 650px">
    </div>
      <input type="hidden" name="act" id="act" value="write">
         <div class="form-group" align="center" style="width:700px">
            <label for="qnaTitle" style="align:left;position: relative;font-weight:bold; float:left; left: 6px;">제목:</label>
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
import http from '@/util/http-common.js'
export default {
    name:'Update',
data: function () {
    return {
      qnaNo: '',
      qnaTitle: '',
      qnaUserid: '',
      qnaDatetime: '',
      qnaContent: '',
    };
  },
  methods: {
    checkHandler() {
      let err = true;
      let msg = '';
      !this.qnaUserid && ((msg = '작성자를 입력해주세요'), (err = false), this.$refs.qnaUserid.focus());
      err && !this.qnaTitle && ((msg = '제목 입력해주세요'), (err = false), this.$refs.qnaTitle.focus());
      err &&
        !this.qnaContent &&
        ((msg = '내용 입력해주세요'), (err = false), this.$refs.qnaContent.focus());

      if (!err) alert(msg);
      else this.updateHandler();
    },
    updateHandler() {
      http
        .put(`${this.qnaNo}`, {
          qnaNo: this.qnaNo,
          qnaDatetime: this.qnaDatetime,
          qnaUserid: this.qnaUserid,
          qnaTitle: this.qnaTitle,
          qnaContent: this.qnaContent,
        })
        .then(({ data }) => {
          let msg = '수정 처리시 문제가 발생했습니다.';
          if (data === 'success') {
            msg = '수정이 완료되었습니다.';
          }
          alert(msg);
          this.$router.push('/happyhouse/qna/list');
        });
    },
  },
  created() {
    var no = this.$route.params.no;
    http.get('/'+no).then(({ data }) => {
      this.qnaNo = data.qna.qnaNo;
      this.qnaDatetime = data.qna.qnaDatetime;
      this.qnaUserid = data.qna.qnaUserid;
      this.qnaTitle = data.qna.qnaTitle;
      this.qnaContent = data.qna.qnaContent;
    });
  }
}
</script>

<style>

</style>