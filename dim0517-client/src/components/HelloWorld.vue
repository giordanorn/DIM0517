<template lang="pug">
  v-container(style="padding-top:0")
    v-row(justify='space-around')
      v-card(tile, width="100%")
        .primary(style="height:200px")
          v-card-title.justify-center.align-center.flex-column(style="height:100%")
            v-avatar(size='56')
              img(alt='user' src='https://cdn.pixabay.com/photo/2020/06/24/19/12/cabbage-5337431_1280.jpg')
            div.mt-1.black--text.font-weight-bold
              | João da Silva
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
    name: 'HelloWorld',

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
