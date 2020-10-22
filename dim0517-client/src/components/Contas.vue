<template lang="pug">
div.text-center
  v-card-title.justify-center
    | Contas
  v-container.d-flex.justify-space-around
    v-card(v-for="(conta, i) in contas")
      v-container
        v-card-title.justify-center
          | {{conta.first_name}} {{conta.last_name}}
        v-card-text
          | Agência: {{conta.account.bank_number}}
          br
          | Conta: {{conta.account.account_number}}
        v-btn(@click="selecionarConta(i+1)")
          | Selecionar
</template>

<script>
// import axios from 'axios'
import { mapGetters } from 'vuex'
export default {
  name: "Contas",
  methods: {
    selecionarConta (id) {
      this.$store.dispatch('selecionarConta', { id })
    }
  },
  computed: {
    ...mapGetters(['contas'])
  }
}
</script>

<style>

</style>