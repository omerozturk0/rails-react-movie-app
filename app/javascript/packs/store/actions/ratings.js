import axios from "../../axios";

export function rateMovie(data) {
    return dispatch => {
        dispatch({
            type: 'RATE_MOVIE',
            payload: axios.post('/ratings.json', data)
        })
    }
}