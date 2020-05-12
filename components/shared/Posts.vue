<template>
    <div class="rounded-lg bg-white h-auto overflow-hidden shadow-lg mb-4 cursor-pointer" @click="isOpen=!isOpen;">
        <div class="flex justify-start px-6 pt-4">
            <div class="bg-gray-300 h-12 w-12 rounded-full cursor-pointer"></div>
            <p class="text-gray-900 text-sm leading-none pl-4 pt-4">Jonathan Reinink</p>
            <p class="text-xs justify end ml-auto pt-4">{{date}}</p>
        </div>
        <div class="px-6 py-4">
            <p v-if="caption" class="text-gray-700 text-base">
            {{caption}}
            </p>
            <p v-else class="text-gray-700 text-base">
            {{body}}
            </p>
        </div>
        <img v-if="url" class="w-full" :src="url" alt="Sunset in the mountains">
        
        <transition name="modal">
            <div class="overlay" v-if="isOpen">
            <PostDetails
            v-bind:p_id="p_id"
            v-bind:url="url"
            v-bind:caption="caption"
            v-bind:body="body"
            v-bind:date="date"
            @click.capture="isOpen=false;"></PostDetails>
            </div>
        </transition>
    </div>
</template>

<script>
import PostDetails from './PostDetails.vue'

export default {
    props: ['p_id','url','caption','body','date'],
    components: {
        PostDetails
    },
    data() {
        return {
            isOpen: false
        }
    }
}
</script>

<style scoped>
.fadeIn-enter {
  opacity: 0;
}

.fadeIn-leave-active {
  opacity: 0;
  transition: all 0.2s step-end;
}

.fadeIn-enter .modal,
.fadeIn-leave-active.modal {
  transform: scale(1.1);
}

.overlay {
  position: fixed;
  top: 0;
  left: 0;
  display: flex;
  justify-content: center;
  align-items: center;
  width: 100%;
  height: 100%;
  background: #00000094;
  z-index: 999;
  transition: opacity 0.2s ease;
}
</style>