import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    saldo: 500,
    extrato: []
  },
  getters: {
    saldo (state) {
      return state.saldo
    },
    extrato (state) {
      return state.extrato
    },
    transacoes (state, getters) {
      let transacoes = getters.extrato.map(t => ({
        ...t,
        dataFormatada: new Date(t.data).toUTCString(),
        mensagem: `${t.tipo} de R$${t.valor}${t.conta? ' para a conta ' + t.conta : ''}`,
      }))

      return transacoes
    }
  },
  mutations: {
    descontarSaldo (state, payload) {
      state.saldo -= payload
    },
    incrementarSaldo (state, payload) {
      state.saldo += payload
    },
    registrarTransacao (state, payload) {
      const data = Date.now()
      state.extrato = [{...payload, data}, ...state.extrato]
    }
  },
  actions: {
    descontarSaldo (context, payload) {
      if (context.state.saldo < payload) {
        console.error('Saldo insuficiente')
      } else if (payload <= 0) {
        console.error('Valor negativo')
      } else {
        context.commit('descontarSaldo', payload)
        context.commit('registrarTransacao', {
          tipo: 'Saque',
          cor: 'error',
          valor: payload
        })
      }
    },
    incrementarSaldo (context, payload) {
      if (payload <= 0) {
        console.error('Valor negativo')
      } else {
        context.commit('incrementarSaldo', payload)
        context.commit('registrarTransacao', {
          tipo: 'Depósito',
          cor: 'success',
          valor: payload
        })
      }
    },
    realizarTransferencia (context, {conta, valor}) {
      if (valor <= 0) {
        console.error('Valor negativo')
      } else {
        context.commit('descontarSaldo', valor)
        context.commit('registrarTransacao', {
          tipo: 'Transferência',
          cor: 'info',
          valor,
          conta
        })
      }
    }
  },
  modules: {
  }
})
