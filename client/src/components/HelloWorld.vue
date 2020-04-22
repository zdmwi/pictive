<template>
  <div class="hello">{{ greeting }}</div>
</template>

<script>
export default {
  name: "HelloWorld",
  data() {
    return {
      greeting: ""
    };
  },
  props: {
    msg: String
  },
  created() {
    const url = "http://localhost:3000/";
    fetch(url)
      .then(async res => {
        this.greeting = await res.json();
      })
      .catch(e => console.log(e));
  }
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped lang="scss">
h3 {
  margin: 40px 0 0;
}
ul {
  list-style-type: none;
  padding: 0;
}
li {
  display: inline-block;
  margin: 0 10px;
}
a {
  color: #42b983;
}
</style>
