<template lang="pug">
  v-app
    v-main
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
import UserInfo from './components/UserInfo'
import PreviewTransacoes from './components/PreviewTransacoes'
import Menu from './components/Menu'

export default {
  name: 'App',

  components: {
    UserInfo,
    PreviewTransacoes,
    Menu
  },

  data: () => ({
    //
  })
}
</script>
