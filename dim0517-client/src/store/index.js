import Vue from 'vue'
import Vuex from 'vuex'
import axios from 'axios'

const API_URL = "https://dim0517-api.herokuapp.com/"
let api = axios.create({
  baseURL: API_URL,
  headers: {
    'Content-Type': 'application/json'
  }
})

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
    selecionarConta (state, { id, valor }) {
      state.idContaSelecionada = id
      state.contas[id-1].account.balance = valor
    },
    realizarSaque (state, {id, valor}) {
      state.contas[id - 1].account.balance -= valor
    },
    realizarDeposito (state, { valor }) {
      state.contas[state.idContaSelecionada - 1].account.balance += valor
    },
    registrarTransacao (state, {tipo, valor, id, cor, destino}) {
      const data = Date.now()
      const dataFormatada = new Date(data).toUTCString()
      const mensagem = `${tipo} de R$${valor}${tipo === 'Transferência' ? ` para ${destino.first_name} ${destino.last_name} 
        | Conta ${destino.account.account_number} Agência ${destino.account.bank_number}`: ''}`
      state.contas[id - 1].extract = [
        {tipo, valor, dataFormatada, mensagem, cor},
        ...state.contas[id - 1].extract
      ]
    }
  },
  actions: {
    selecionarConta (context, { id }) {
      api.get(`/accounts/${id}/balance`)
        .then(res => {
          const valor = parseFloat(res.data.message.slice(16))
          context.commit('selecionarConta', { id, valor })
        })
        .catch(err => {
          console.error(err)
        })
    },
    realizarSaque (context, {id, valor}) {
      if (valor <= 0) {
        console.error('Valor negativo')
        return
      }

      api.post(`/accounts/${id}/withdraw`, { value: valor })
        .then(res => {
          console.log(res)
          context.commit('realizarSaque', { id, valor })
          context.commit('registrarTransacao', {
            tipo: 'Saque',
            cor: 'error',
            valor,
            id
          })
        })
        .catch(err => {
          console.error(err)
        })
    },
    realizarDeposito (context, {id, valor}) {
      if (valor <= 0) {
        console.error('Valor negativo')
        return
      }

      api.post(`/accounts/${id}/deposit`, { value: valor })
        .then(res => {
          console.log(res)
          context.commit('realizarDeposito', { valor })
          context.commit('registrarTransacao', {
            tipo: 'Depósito',
            cor: 'success',
            id,
            valor
          })
        })
        .catch(err => {
          console.error(err)
        })
    },
    realizarTransferencia (context, {id, valor, destino}) {
      if (valor <= 0) {
        console.error('Valor negativo')
        return
      } 
      
      const contaDestino = context.state.contas.find(conta => {
        return conta.account.account_number === destino.conta
          && conta.account.bank_number === destino.agencia
      })

      api.post(`/accounts/${id}/transfer`, { value: valor, receiver_id: contaDestino.id })
        .then(res => {
          console.log(res)
          context.commit('realizarSaque', {
            id,
            valor
          })
          context.commit('registrarTransacao', {
            tipo: 'Transferência',
            cor: 'info',
            id,
            valor,
            destino: contaDestino
          })
        })
    }
  },
  modules: {
  }
})
