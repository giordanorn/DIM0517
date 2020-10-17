<template lang="pug">
v-card-text
  .font-weight-bold.ml-8.mb-2
    | Hoje
  v-timeline(align-top, dense)
    v-timeline-item(v-for='message in messages' :key='message.time' :color='message.color' small)
      div
        .font-weight-normal
          strong {{ message.from }}
          |  @{{ message.time }}
        div {{ message.message }}
</template>

<script>
  export default {
    name: 'AccountInfo',

    data: () => ({
      messages: [
        {
          from: 'Pagamento',
          message: 'Pagamento de conta R$120,00',
          time: '10:42am',
          color: 'deep-purple lighten-1'
        },
        {
          from: 'Depósito',
          message: 'Transferência recebida R$500,00',
          time: '10:37am',
          color: 'green'
        },
        {
          from: 'Pagamento',
          message: 'Boleto R$50,00',
          time: '9:47am',
          color: 'deep-purple lighten-1'
        }
      ]
    })
  }
</script>
