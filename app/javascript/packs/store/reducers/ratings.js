const initialState = {
    rated: false,
    failed: false,
    rating: {},
    error: {}
}

export default (state = initialState, { type, payload }) => {
    switch (type) {
        case 'RATE_MOVIE_PENDING':
            return {
                ...state,
                rated: false,
                failed: false
            }

        case 'RATE_MOVIE_FULFILLED':
            return {
                ...state,
                rated: true,
                failed: false,
                rating: payload.data.data
            }

        case 'RATE_MOVIE_REJECTED':
            return {
                ...state,
                error: payload.response.data,
                rated: false,
                failed: true
            }

        default:
            return state;
    }
}