import Vue from 'vue';
import Vuetify from 'vuetify/lib';
import pt from 'vuetify/es5/locale/pt'
import colors from 'vuetify/lib/util/colors'

Vue.use(Vuetify);

export default new Vuetify({
  theme: {
    themes: {
      dark: {
        primary: colors.deepOrange,
        secondary: colors.deepOrange.darken4,
        error: colors.red.accent3,
        info: colors.blue,
        success: colors.green,
        warning: colors.yellow
      }
    },
    dark:true
  },
  lang: {
    locales: { pt },
    current: 'pt'
  },
  icons: {
    iconfont: 'fa'
  }
});
