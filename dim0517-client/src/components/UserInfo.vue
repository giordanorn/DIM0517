<template lang="pug">
  v-card(tile, width="100%")
    .primary(style="height:200px")
      //- v-card-title.justify-center.align-center.flex-column(style="height:100%")
      v-card-title.justify-center.align-center.flex-column(style="height:100%")
        v-card.text-center(elevation="4")
          v-avatar.secondary(size='56')
            v-icon(dark) mdi-account-circle
          v-card-title.mt-1
            | João da Silva
</template>

<script>
  export default {
    name: 'UserInfo',

    data: () => ({
      //
    })
  }
</script>
