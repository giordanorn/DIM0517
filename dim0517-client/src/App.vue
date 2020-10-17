<template lang="pug">
  v-app
    v-main
      v-container(style="padding-top:0")
        v-row(justify='space-around')
          UserInfo
          AccountInfo
          Menu
</template>

<script>
import UserInfo from './components/UserInfo'
import AccountInfo from './components/AccountInfo'
import Menu from './components/Menu'

export default {
  name: 'App',

  components: {
    UserInfo,
    AccountInfo,
    Menu
  },

  data: () => ({
    //
  })
}
</script>
