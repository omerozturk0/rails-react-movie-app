import React, {Component} from 'react';
import PropTypes from 'prop-types';
import { connect } from "react-redux";
import { fetchMovies } from "../store/actions/movies";
import MovieItem from "./MovieItem";
import { Alert, InputGroup, FormControl } from "react-bootstrap";
import Paginate from "./Paginate";

class MovieList extends Component {
    static propTypes = {
        movies: PropTypes.object.isRequired,
        ratings: PropTypes.object.isRequired
    }

    state = {
        search_query: ''
    }

    componentDidMount() {
        const url = window.location.pathname;
        this.props.fetchMovies(url)
    }

    changeSearchValue = (data) => {
        this.setState({[data.target.id]: data.target.value})
        const url = window.location.pathname;
        setTimeout(() => {
            this.props.fetchMovies(url, {
                search: this.state.search_query
            })
        }, 1000)
    }

    render() {
        const { movies, ratings } = this.props;
        let alertBody;

        if (ratings.failed) {
            if (typeof ratings.error === 'object') {
                alertBody = Object.keys(ratings.error).map((error, key) => <Alert variant="danger" key={key} dismissible={true}>{ratings.error[error]}</Alert>)
            } else {
                alertBody = <Alert variant="danger" dismissible={true}>{ratings.error}</Alert>
            }
        }

        if (ratings.rated) {
            alertBody = (
                <Alert variant="success" dismissible={true}>
                    You successfully rated by {ratings.rating.attributes.value} point.
                </Alert>
            )
        }

        return (
            <div className="col-md-10 blog-main">
                <h3 className="pb-4 mb-4 font-italic border-bottom">
                    Popular Movies
                </h3>

                { alertBody }

                <div className="mb2">
                    <InputGroup className="mb-3">
                        <InputGroup.Prepend>
                            <InputGroup.Text id="basic-addon1">Search</InputGroup.Text>
                        </InputGroup.Prepend>
                        <FormControl
                            id="search_query"
                            onChange={this.changeSearchValue}
                        />
                    </InputGroup>
                </div>

                <div className="row mb-2">
                    {
                        movies.movies.map(item =>
                            <MovieItem movie={item} key={item.id} />
                        )
                    }
                </div>

                { movies.fetched ? <Paginate /> : '' }
            </div>
        );
    }
}

const initMapStateToProps = ({movies, ratings}) => {
    return {
        movies,
        ratings
    }
}

const initMapDispatchToProps = ({
    fetchMovies
})

export default connect(initMapStateToProps, initMapDispatchToProps)(MovieList);