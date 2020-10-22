<template lang="pug">
v-container(style="padding-top:0")
  v-row(justify='space-around')
    UserInfo
    v-card(tile, width="100%")
      v-container
        v-row
          Menu
          PreviewTransacoes
</template>

<script>
import UserInfo from './UserInfo'
import PreviewTransacoes from './PreviewTransacoes'
import Menu from './Menu'

export default {
  name: 'Conta',
  components: {
    UserInfo,
    PreviewTransacoes,
    Menu
  },
  data() {
    return {
      //
    }
  }
}
</script>
