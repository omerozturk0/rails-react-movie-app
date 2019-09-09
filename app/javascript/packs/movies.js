import React from "react"
import ReactDOM from 'react-dom';
import PropTypes from "prop-types"
import { createStore, applyMiddleware, compose } from 'redux';
import { Provider } from 'react-redux';
import thunk from "redux-thunk";
import reduxPromise from 'redux-promise-middleware';
import rootReducer from "./store/rootReducer";
import { BrowserRouter } from 'react-router-dom';
import Turbolinks from 'turbolinks';

import App from './components/App'

const composeEnhancer = window.__REDUX_DEVTOOLS_EXTENSION_COMPOSE__ || compose;

const store = createStore(
    rootReducer,
    composeEnhancer(applyMiddleware(reduxPromise, thunk))
)

document.addEventListener('turbolinks:load', function () {
    Turbolinks.start()

    const dom = document.getElementById("movie-list")

    if (dom) {
        ReactDOM.render(
            <BrowserRouter>
                <Provider store={store}>
                    <App />
                </Provider>
            </BrowserRouter>,
            dom
        )
    }
})
