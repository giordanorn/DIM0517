<template lang="pug">
  v-container.d-flex.justify-space-around
    v-btn(height="80px").info Extrato
    v-btn(height="80px").success Depositar
    v-btn(height="80px").error Pagar
</template>

<script>
export default {
  name: 'Menu',
  
  data: () => ({
    //
  }),
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