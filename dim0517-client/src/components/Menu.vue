<template lang="pug">
  v-container.d-flex.justify-space-around
    v-btn(height="80px").info
      | Extrato
    v-btn(height="80px" @click="descontarSaldo").error
      | Pagar
    v-btn(height="80px" @click="incrementarSaldo").success
      | Depositar
</template>

<script>
export default {
  name: 'Menu',
  data: () => ({
    //
  }),
  methods: {
    descontarSaldo () {
      this.$store.dispatch('descontarSaldo', 50)
    },
    incrementarSaldo () {
      this.$store.dispatch('incrementarSaldo', 50)
    }
  }
}
</script>

<style lang="scss" scoped>
.v-btn {
  flex-grow: 1;
  margin: 0 10px;

  &:first-child {
    margin-left: 0;
  }

  &:last-child {
    margin-right: 0;
  }
}
</style>