export default class LRUCache {
  constructor(capacity) {
    this.cache = {}
    this.lastUsedQueue = []
    this.capacity = capacity
  }

  get(key) {
    if (key in this.cache) {
      const keyIdx = this.lastUsedQueue.indexOf(key)
      this.lastUsedQueue.splice(keyIdx, 1)
      this.lastUsedQueue.unshift(key)
      return this.cache[key]
    }
    return -1
  }

  put(key, value) {
    if (key in this.cache) {
      delete this.cache[key]
      let keyIdx = this.lastUsedQueue.indexOf(key)
      this.lastUsedQueue.splice(keyIdx, 1)
    }

    if (this.lastUsedQueue.length >= this.capacity) {
      const keyToBeRemoved = this.lastUsedQueue.pop()
      delete this.cache[keyToBeRemoved]
    }

    this.cache[key] = value
    this.lastUsedQueue.unshift(key)
  }
}
