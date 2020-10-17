<template lang="pug">
v-card-text
  .font-weight-bold.ml-8.mb-2
    | Transações
  v-timeline(align-top, dense)
    v-timeline-item(v-for='transacao in transacoesListadas' :key='transacao.data' small primary)
      div
        .font-weight-normal
          strong {{ transacao.tipo }}
          |  @{{ transacao.dataFormatada }}
        div {{ transacao.mensagem }}
</template>

<script>
  import { mapGetters } from 'vuex'
  export default {
    name: 'AccountInfo',
    data: () => ({
      tamanhoExtrato: 5
    }),
    computed: {
      transacoesListadas () {
        return this.transacoes.slice(0, this.tamanhoExtrato)
      },
      ...mapGetters(['transacoes'])
    }
  }
</script>
