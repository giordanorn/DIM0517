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
        mensagem: `${t.tipo} de R$${t.valor}`
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
      context.commit('descontarSaldo', payload)
      context.commit('registrarTransacao', {
        tipo: 'Saque',
        valor: payload
      })
    },
    incrementarSaldo (context, payload) {
      context.commit('incrementarSaldo', payload)
      context.commit('registrarTransacao', {
        tipo: 'Depósito',
        valor: payload
      })
    }
  },
  modules: {
  }
})
