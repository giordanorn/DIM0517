<template lang="pug">
  v-card(tile, width="100%")
    .primary(style="height:200px")
      v-card-title.justify-center.align-center.flex-column(style="height:100%")
        v-card.text-center(elevation="4")
          v-avatar.secondary(size='56')
            v-icon(dark) mdi-account-circle
          v-card-title.mt-1.justify-center
            | {{ contaSelecionada.first_name }} {{ contaSelecionada.last_name }}
          v-card-subtitle
            | Agência {{ contaSelecionada.account.bank_number }}
            br
            | Conta {{ contaSelecionada.account.account_number }}
</template>

<script>
import { mapGetters } from 'vuex'
export default {
  name: 'UserInfo',
  data: () => ({
    //
  }),
  computed: {
    ...mapGetters(['contaSelecionada'])
  }
}
</script>
