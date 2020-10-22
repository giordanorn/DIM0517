import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    saldo: 500,
    extrato: [],
    contas: [
      {
        id: 1,
        first_name: "John",
        last_name: "Johnson",
        email: "john@johnson",
        account: {
          id: 1,
          account_number: "00001",
          bank_number: "00000001",
          balance: 100.0,
          user_id: 1
        },
        extract: []
      },
      {
        id: 2,
        first_name: "Mary",
        last_name: "Adams",
        email: "mary@adams",
        account: {
          id: 2,
          account_number: "00002",
          bank_number: "00000001",
          balance: 200.0,
          user_id: 2
        },
        extract: []
      },
      {
        id: 3,
        first_name: "Billy",
        last_name: "Smith",
        email: "billy@smith",
        account: {
          id: 3,
          account_number: "00001",
          bank_number: "00000002",
          balance: 300.0,
          user_id: 3
        },
        extract: []
      },
    ],
    idContaSelecionada: 0
  },
  getters: {
    contas (state) {
      return state.contas
    },
    contaSelecionada (state) {
      if (state.idContaSelecionada > 0) {
        return state.contas[state.idContaSelecionada - 1]
      } else {
        return null
      }
    }
  },
  mutations: {
    selecionarConta (state, payload) {
      state.idContaSelecionada = payload
    },
    descontarSaldo (state, payload) {
      state.contas[payload.id - 1].account.balance -= payload.valor
    },
    incrementarSaldo (state, payload) {
      state.contas[payload.id - 1].account.balance += payload.valor
    },
    registrarTransacao (state, payload) {
      const data = Date.now()
      const dataFormatada = new Date(data).toUTCString()
      const mensagem = `${payload.tipo} de R$${payload.valor}${payload.tipo === 'Transferência' ? ' para a conta ' + payload.destino.account.account_number + ' agência ' + payload.destino.account.bank_number: ''}`
      state.contas[payload.conta.id - 1].extract = [
        {...payload, dataFormatada, mensagem},
        ...state.contas[payload.conta.id - 1].extract
      ]
    }
  },
  actions: {
    selecionarConta (context, payload) {
      context.commit('selecionarConta', payload)
    },
    descontarSaldo (context, payload) {
      if (payload.valor <= 0) {
        console.error('Valor negativo')
        return
      }

      const conta = context.state.contas.find(conta => {
        return conta.account.account_number === payload.conta
          && conta.account.bank_number === payload.agencia
      })

      if (!conta) {
        console.error('Conta não encontrada')
      } else if (conta.account.balance < payload.valor) {
        console.error('Saldo insuficiente')
      } else {
        context.commit('descontarSaldo', {
          id: conta.id,
          valor: payload.valor
        })
        context.commit('registrarTransacao', {
          tipo: 'Saque',
          cor: 'error',
          valor: payload.valor,
          conta
        })
      }
    },
    incrementarSaldo (context, payload) {
      if (payload.valor <= 0) {
        console.error('Valor negativo')
        return
      }

      const conta = context.state.contas.find(conta => {
        return conta.account.account_number === payload.conta
          && conta.account.bank_number === payload.agencia
      })

      if (!conta) {
        console.error('Conta não encontrada')
      } else {
        context.commit('incrementarSaldo', {
          id: conta.id,
          valor: payload.valor
        })
        context.commit('registrarTransacao', {
          tipo: 'Depósito',
          cor: 'success',
          conta,
          valor: payload.valor
        })
      }
    },
    realizarTransferencia (context, {origem, destino, valor}) {
      if (valor <= 0) {
        console.error('Valor negativo')
        return
      } 
      
      const contaOrigem = context.state.contas.find(conta => {
        return conta.account.account_number === origem.conta
          && conta.account.bank_number === origem.agencia
      })

      const contaDestino = context.state.contas.find(conta => {
        return conta.account.account_number === destino.conta
          && conta.account.bank_number === destino.agencia
      })

      if (!contaOrigem) {
        console.error('Conta origem não encontrada')
      } else if (!contaDestino) {
        console.error('Conta destino não encontrada')
      } else if (contaOrigem.account.balance < valor) {
        console.error('Saldo insuficiente')
      } else {
        context.commit('descontarSaldo', {
          id: contaOrigem.id,
          valor
        })
        context.commit('incrementarSaldo', {
          id: contaDestino.id,
          valor
        })
        context.commit('registrarTransacao', {
          tipo: 'Transferência',
          cor: 'info',
          valor,
          conta: contaOrigem,
          destino: contaDestino
        })
      }
    }
  },
  modules: {
  }
})
