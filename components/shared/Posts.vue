<template>
    <div class="flex flex-1 content-start w-full h-32 bg-white shadow-sm rounded-lg mb-4">
        <div class="h-32 lg:h-auto lg:w-34 flex-none bg-cover rounded-t lg:rounded-t-none lg:rounded-l text-center overflow-hidden">
            <img class="rounded-lg h-32 w-34" :src="url"> 
        </div>
        <div class="p-4 flex flex-col justify-between leading-normal">
            <div class="mb-4">
                <p class="text-gray-700 text-sm">{{caption}}</p>
            </div>
            <div class="flex items-end justify-end">
                <img class="w-10 h-10 rounded-full mr-4" src="/img/jonathan.jpg" alt="Avatar of Jonathan Reinink">
                <div class="text-sm">
                    <p class="text-gray-900 text-sm leading-none">Jonathan Reinink</p>
                    <p class="text-gray-600 text-xs">Aug 18</p>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
export default {
    props: ['url','caption','body','date']
}
</script>