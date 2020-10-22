<template lang="pug">
  v-app
    v-main
      Contas
      Conta(v-if="contaSelecionada")
</template>

<script>
import Contas from './components/Contas'
import Conta from './components/conta/Conta'
import { mapGetters } from 'vuex'

export default {
  name: 'App',
  components: {
    Contas,
    Conta
  },
  data() {
    return {
      //
    }
  },
  computed: {
    ...mapGetters(['contaSelecionada'])
  }
}
</script>
