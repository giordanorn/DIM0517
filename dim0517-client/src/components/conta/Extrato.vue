<template lang="pug">
  v-timeline(align-top, dense)
    v-timeline-item(v-for='transacao in transacoesListadas' :key='transacao.data' small :color='transacao.cor')
      div
        .font-weight-normal
          strong {{ transacao.tipo }}
          |  @{{ transacao.dataFormatada }}
        div {{ transacao.mensagem }}
</template>

<script>
import { mapGetters } from 'vuex'
export default {
  name: 'Extrato',
  props: {
    tamanhoMaximo: {
      type: Number,
      default: 0
    }
  },
  computed: {
    transacoesListadas () {
      return this.tamanhoMaximo > 0
        ? this.contaSelecionada.extract.slice(0, this.tamanhoMaximo)
        : this.contaSelecionada.extract
    },
    ...mapGetters(['contaSelecionada'])
  }
}
</script>
