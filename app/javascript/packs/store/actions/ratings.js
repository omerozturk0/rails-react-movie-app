import axios from 'axios';

const csrfToken = document.querySelector("meta[name=csrf-token]").content
axios.defaults.headers.common['X-CSRF-Token'] = csrfToken

export function rateMovie(data) {
    return dispatch => {
        dispatch({
            type: 'RATE_MOVIE',
            payload: axios.post('/ratings.json', data)
        })
    }
}