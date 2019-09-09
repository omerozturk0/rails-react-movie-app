import { combineReducers } from "redux";

import movies from './reducers/movies';
import ratings from './reducers/ratings';

export default combineReducers({
    movies,
    ratings
})