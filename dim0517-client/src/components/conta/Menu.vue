<template lang="pug">
  v-container.d-flex.justify-space-between
    v-btn.info(height="80px" @click="dialogTransferencia = !dialogTransferencia")
      | Transferência
      v-dialog(v-model="dialogTransferencia" width="300")
        v-card
          v-container
            v-form(ref="formTransferencia" v-on:submit.prevent="validarTransferencia")
              v-card-title
                | Transferência
              v-text-field(
                :rules="[rules.isNumeroPositivo]"
                v-model="agenciaTransferencia"
                color="primary"
                label="Agência"
                autofocus
                required)
              v-text-field(
                :rules="[rules.isNumeroPositivo]"
                v-model="contaTransferencia"
                color="primary"
                label="Conta"
                required)
              v-text-field(
                :rules="[rules.isNumeroPositivo, rules.isSaldoSuficiente]"
                v-model="valorTransferencia"
                color="primary"
                label="Valor"
                required)
              v-btn(color="secondary" text @click="cancelarTransferencia")
                | Cancelar
              v-btn(color="primary" text @click="validarTransferencia")
                | Confirmar
    v-btn.error(
      height="80px"
      @click="dialogSacar = !dialogSacar")
      | Saque
      v-dialog(v-model="dialogSacar" width="300")
        v-card
          v-container
            v-form(ref="formSaque" v-on:submit.prevent="validarSaque")
              v-card-title
                | Saque
              v-text-field(
                :rules="[rules.isNumeroPositivo, rules.isSaldoSuficiente]"
                v-model="valorSacar"
                color="primary"
                label="Valor"
                autofocus
                required)
              v-btn(color="secondary" text @click="cancelarSaque")
                | Cancelar
              v-btn(color="primary" text @click="validarSaque")
                | Confirmar
    v-btn(height="80px" @click="dialogDepositar = !dialogDepositar").success
      | Crédito
      v-dialog(v-model="dialogDepositar" width="300")
        v-card
          v-container
            v-form(ref="formDeposito" v-on:submit.prevent="validarDeposito")
              v-card-title
                | Crédito
              v-text-field(
                :rules="[rules.isNumeroPositivo]"
                v-model="valorDepositar"
                color="primary"
                label="Valor"
                autofocus
                required)
              v-btn(
                color="secondary"
                text
                @click="cancelarDeposito")
                | Cancelar
              v-btn(
                color="primary"
                text
                @click="validarDeposito")
                | Confirmar
</template>

<script>
import Extrato from './Extrato'
import { mapGetters } from 'vuex'
export default {
  name: 'Menu',
  components: {
    Extrato
  },
  data() {
    return {
      dialogTransferencia: false,
      dialogDepositar: false,
      valorDepositar: '',
      dialogSacar: false,
      valorSacar: '',
      valorTransferencia: '',
      contaTransferencia: '',
      agenciaTransferencia: '',
      rules: {
        isNumeroPositivo: (value) => /^\d+$/.test(value) || 'Deve ser um número positivo.',
        isSaldoSuficiente: (value) => value <= this.contaSelecionada.account.balance || 'Saldo insuficiente.'
      },
    }
  },
  methods: {
    sacar () {
      const valor = parseInt(this.valorSacar)
      this.$store.dispatch('realizarSaque', {
        id: this.contaSelecionada.account.id,
        valor
      })
      this.cancelarSaque()
    },
    depositar () {
      const valor = parseInt(this.valorDepositar)
      this.$store.dispatch('realizarDeposito', {
        id: this.contaSelecionada.account.id,
        valor
      })
      this.cancelarDeposito()
    },
    transferir () {
      const valor = parseInt(this.valorTransferencia)
      const conta = this.contaTransferencia
      const agencia = this.agenciaTransferencia
      this.$store.dispatch('realizarTransferencia', {
        id: this.contaSelecionada.account.id,
        destino: {
          agencia,
          conta
        },
        valor
      })
      this.cancelarTransferencia()
    },
    validarDeposito () {
      if (this.$refs.formDeposito.validate()) {
        this.depositar()
      }
    },
    cancelarDeposito () {
      this.dialogDepositar = false
      this.$refs.formDeposito.reset()
    },
    validarSaque () {
      if (this.$refs.formSaque.validate()) {
        this.sacar()
      }
    },
    cancelarSaque () {
      this.dialogSacar = false
      this.$refs.formSaque.reset()
    },
    validarTransferencia () {
      if (this.$refs.formTransferencia.validate()) {
        this.transferir()
      }
    },
    cancelarTransferencia () {
      this.dialogTransferencia = false
      this.$refs.formTransferencia.reset()
    },
  },
  computed: {
    ...mapGetters(['contaSelecionada'])
  }
}
</script>

<style lang="scss" scoped>
.v-btn {
  flex-grow: 1;
  margin: 0 10px;
  flex-basis: 0;

  &:first-child {
    margin-left: 0;
  }

  &:last-child {
    margin-right: 0;
  }
}
</style>