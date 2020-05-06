Vue.component('app-header', {
  template: `<nav class="flex items-center justify-between flex-wrap bg-teal-500 p-4">
  <div class="flex items-center flex-shrink-0 text-white mr-6">
    <h1 class="font-semibold text-xl tracking-tight">Relatable</h1>
  </div>
</nav>`,
});

Vue.component('report-generator', {
  template: `<div @click="onClick" class="bg-gray-400 p-12 hover:bg-gray-600 cursor-pointer">
    Generate a report
  </div>`,
  methods: {
    onClick() {
      fetch('/api/generate-report', {
        method: 'GET',
        mode: 'cors',
      })
        .then((res) => {
          res
            .json()
            .then((result) => this.$emit('fetched-users', result.yolo))
            .catch((err) => console.err(err));
        })
        .catch((err) => {
          console.log(err);
        });
    },
  },
});

Vue.component('report-table', {
  props: ['report'],
  data() {
    return {
      filteredReport: [],
      searchTerm: '',
    };
  },
  template: `
  <div>
    <input v-model="searchTerm" class="bg-white focus:outline-none focus:shadow-outline border border-gray-300 rounded-lg py-2 px-4 block w-full appearance-none leading-normal" type="email">
    <div class="flex flex-wrap justify-between">
      <div v-for="user in report">
        <img
          class="h-48 lg:h-auto lg:w-48 flex-none bg-cover rounded-t lg:rounded-t-none lg:rounded-l text-center overflow-hidden"
          :src="user.profile_picture"
        />
        <div
          class="border-r border-b border-l border-gray-400 lg:border-l-0 lg:border-t lg:border-gray-400 bg-white rounded-b lg:rounded-b-none lg:rounded-r p-4 flex flex-col justify-between leading-normal"
        >
          <div class="mb-8">
            <div class="text-gray-900 font-bold text-xl mb-2">{{ user.name }}</div>
          </div>
          <div class="flex items-center">
            <div v-for="friend in user.friends">
              <img
                class="w-10 h-10 rounded-full mr-4"
                :src="friend.profile_picture"
              />
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>`,
});

Vue.component('dashboard', {
  template: `
  <div class="flex justify-center items-center">
    <report-generator v-if="!report.length" @fetched-users="logIt">
    </report-generator>
    <report-table v-else :report="report"></report-table>
  </div>`,
  data() {
    return {
      report: [],
    };
  },
  methods: {
    logIt(data) {
      this.report.push(
        {
          name: 'Ziddy Don',
          profile_picture: 'https://via.placeholder.com/400',
          friends: [
            {
              name: 'Kayon-Marie Douglas',
              profile_picture: 'https://via.placeholder.com/400',
            },
            {
              name: 'Rowan "BrokeBoi" Atkinson',
              profile_picture: 'https://via.placeholder.com/400',
            },
            {
              name: 'Nathan Downer',
              profile_picture: 'https://via.placeholder.com/400',
            },
          ],
        },
        {
          name: 'Rowan Atkinson',
          profile_picture: 'https://via.placeholder.com/400',
          friends: [
            {
              name: 'Kayon-Marie Douglas',
              profile_picture: 'https://via.placeholder.com/400',
            },
            {
              name: 'Zidane Wright',
              profile_picture: 'https://via.placeholder.com/400',
            },
            {
              name: 'Nathan Downer',
              profile_picture: 'https://via.placeholder.com/400',
            },
          ],
        },
        {
          name: 'Kayon-Marie Douglas',
          profile_picture: 'https://via.placeholder.com/400',
          friends: [
            {
              name: 'Zidane Wright',
              profile_picture: 'https://via.placeholder.com/400',
            },
            {
              name: 'Rowan "BrokeBoi" Atkinson',
              profile_picture: 'https://via.placeholder.com/400',
            },
            {
              name: 'Nathan Downer',
              profile_picture: 'https://via.placeholder.com/400',
            },
          ],
        },

        {
          name: 'Nathan Downer',
          profile_picture: 'https://via.placeholder.com/400',
          friends: [
            {
              name: 'Zidane Wright',
              profile_picture: 'https://via.placeholder.com/400',
            },
            {
              name: 'Rowan "BrokeBoi" Atkinson',
              profile_picture: 'https://via.placeholder.com/400',
            },
            {
              name: 'Kayon-Marie Douglas',
              profile_picture: 'https://via.placeholder.com/400',
            },
          ],
        },
      );
    },
  },
});

const app = new Vue({
  el: '#app',
});
