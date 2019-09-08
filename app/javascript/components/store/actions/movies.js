import axios from "../../axios";
import qs from 'qs';

export function fetchMovies(apiPath, params = {}) {
    let path = apiPath === '/' ? '/movies' : apiPath

    if (path.indexOf('.json') === -1) {
        path += '.json'
    }

    if (Object.keys(params).length > 0) {
        params = qs.stringify(params)
        path += `?${params}`
    }

    return dispatch => {
        dispatch({
            type: 'FETCH_MOVIES',
            payload: axios.get(path)
        })
    }
}