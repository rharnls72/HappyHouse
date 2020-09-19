<template>
    <div>
        삭제중...
    </div>
</template>

<script>
import http from '@/util/http-common.js';
export default {
    name:'Delete',
    created() {
    var no = this.$route.params.no;
    http.delete('/'+no).then(({ data }) => {
      let msg = '삭제 처리시 문제가 발생했습니다.';
      if (data === 'success') {
        msg = '삭제가 완료되었습니다.';
      }
      alert(msg);
      this.$router.push('/happyhouse/qna/list');
    });
  }
}
</script>

<style>

</style>