import React, {Component} from 'react';
import PropTypes from 'prop-types';
import { connect } from 'react-redux';
import {fetchMovies} from "../store/actions/movies";

class Paginate extends Component {
    static propTypes = {
        movies: PropTypes.object.isRequired
    }

    clieckedPaginatePrevLink = () => {
        const url = this.props.movies.links.prev
        this.props.fetchMovies(url)
    }

    clieckedPaginateNextLink = () => {
        const url = this.props.movies.links.next
        this.props.fetchMovies(url)
    }

    render() {
        const { movies } = this.props

        return (
            <nav className="blog-pagination d-flex justify-content-between">
                <a
                    className={!movies.links.prev ? 'btn btn-outline-secondary disabled' : 'btn btn-outline-primary'}
                    onClick={this.clieckedPaginatePrevLink}
                >Prev</a>
                <a
                    className={!movies.links.next ? 'btn btn-outline-secondary disabled' : 'btn btn-outline-primary'}
                    onClick={this.clieckedPaginateNextLink}
                >Next</a>
            </nav>
        );
    }
}

const initMapStateToProps = ({movies}) => {
    return {
        movies,
    }
}

const initMapDispatchToProps = ({
    fetchMovies
})

export default connect(initMapStateToProps, initMapDispatchToProps)(Paginate);