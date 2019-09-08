const initialState = {
    fetched: false,
    movies: [],
    links: {},
    aggs: {},
    error: {}
}

export default (state = initialState, { type, payload }) => {
    switch (type) {
        case 'FETCH_MOVIES_PENDING':
            return {
                ...state,
                fetched: false
            }

        case 'FETCH_MOVIES_FULFILLED':
            return {
                ...state,
                movies: payload.data.data,
                links: payload.data.links,
                aggs: payload.data.meta.aggs,
                fetched: true
            }

        case 'FETCH_MOVIES_REJECTED':
            return {
                ...state,
                error: payload.response.data,
                fetched: false
            }

        default:
            return state;
    }
}