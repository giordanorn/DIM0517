<template lang="pug">
  v-container.font-weight-bold
    v-app-bar
      v-card-title
        | Saldo atual R$ {{ contaSelecionada.account.balance }} 
    .d-flex.justify-center
      Extrato
</template>

<script>
  import Extrato from './Extrato'
  import { mapGetters } from 'vuex'
  export default {
    name: 'PreviewTransacoes',
    components: {
      Extrato
    },
    computed: {
      ...mapGetters(['contaSelecionada'])
    }
  }
</script>
