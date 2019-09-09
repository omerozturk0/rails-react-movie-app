import axios from "app/javascript/packs/axios";

const csrfToken = document.querySelector("meta[name=csrf-token]").content
axios.defaults.headers.common['X-CSRF-Token'] = csrfToken

export default axios.create({
    timeout: 100000
});