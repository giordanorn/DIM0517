<template lang="pug">
v-card.text-center
  v-card-title
    | Contas
  v-container
    v-btn(
      v-for="(conta, i) in contas"
      @click="selecionarConta(i+1)")
      | {{conta.first_name}} {{conta.last_name}}
</template>

<script>
// import axios from 'axios'
import { mapGetters } from 'vuex'
export default {
  name: "Contas",
  data() {
    return {
      //
    }
  },
  mounted() {
    // axios.get('dim0517-api.herokuapp.com/accounts/1balance)
  },
  methods: {
    selecionarConta (id) {
      this.$store.dispatch('selecionarConta', id)
    }
  },
  computed: {
    ...mapGetters(['contas'])
  }
}
</script>

<style>

</style>