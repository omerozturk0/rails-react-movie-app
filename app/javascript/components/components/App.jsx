import React, {Component} from 'react';
import { Route } from 'react-router-dom';

import SideBar from "./SideBar";
import MovieList from "./MovieList";

class App extends Component {
    render() {
        return (
            <div className="row">
                <SideBar />
                <Route path={'/'} component={MovieList} />
            </div>
        );
    }
}

export default App;