<template lang="pug">
  v-container.d-flex.justify-space-around
    v-btn(height="80px").info
      | Extrato
    v-btn(height="80px" @click="dialogSacar = !dialogSacar").error
      | Sacar
    v-dialog(v-model="dialogSacar" width="250")
      v-card
        v-container
          v-card-text
            | Insira o valor para efetuar o saque
            v-text-field(
              :rules="rules"
              v-model="valorSacar"
              color="primary"
              append-icon="mdi-send"
              placeholder="0"
              outline
              flat
              autofocus
              @keyup.enter="sacar"
            )
    v-btn(height="80px" @click="dialogDepositar = !dialogDepositar").success
      | Depositar
    v-dialog(v-model="dialogDepositar" width="250")
      v-card
        v-container
          v-card-text
            | Insira o valor para efetuar o depósito
            v-text-field(
              :rules="rules"
              v-model="valorDepositar"
              color="primary"
              append-icon="mdi-send"
              placeholder="0"
              outline
              flat
              autofocus
              @keyup.enter="depositar"
            )

</template>

<script>
export default {
  name: 'Menu',
  data: () => ({
    dialogDepositar: false,
    valorDepositar: '',
    dialogSacar: false,
    valorSacar: '',
    rules: [
      value => /^\d+$/.test(value) || 'Deve ser um número positivo.'
    ]
  }),
  methods: {
    sacar () {
      const valor = parseInt(this.valorSacar)
      this.$store.dispatch('descontarSaldo', valor)
      this.valorSacar = ''
      this.dialogSacar = false
    },
    depositar () {
      const valor = parseInt(this.valorDepositar)
      this.$store.dispatch('incrementarSaldo', valor)
      this.valorDepositar = ''
      this.dialogDepositar = false
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