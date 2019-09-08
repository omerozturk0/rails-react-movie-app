import axios from "axios";

const csrfToken = document.querySelector("meta[name=csrf-token]").content
axios.defaults.headers.common['X-CSRF-Token'] = csrfToken

export default axios.create({
    baseURL: 'http://localhost:3000',
    timeout: 100000
});