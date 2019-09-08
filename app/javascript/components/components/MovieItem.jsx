import React, {Component} from 'react';
import PropTypes from 'prop-types';
import { connect } from "react-redux";
import StarRatingComponent from 'react-star-rating-component';
import { rateMovie } from "../store/actions/ratings";
import { fetchMovies } from "../store/actions/movies";

class MovieItem extends Component {
    static propTypes = {
        movie: PropTypes.object.isRequired,
        ratings: PropTypes.object.isRequired
    }

    starClicked = (nextValue, prevValue, name) => {
        this.props.rateMovie({
            movie_id: name.split('_')[1],
            value: nextValue
        })

        const url = window.location.pathname;
        setTimeout(() => this.props.fetchMovies(url), 2000)
    }

    render() {
        const { movie } = this.props;

        return (
            <div className="col-md-6">
                <div
                    className="row no-gutters border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">
                    <div className="col p-4 d-flex flex-column position-static">
                        <strong className="d-inline-block mb-2 text-primary">{movie.attributes.category.title}</strong>
                        <h3 className="mb-0">{movie.attributes.title}</h3>
                        <div className="mb-1 text-muted">{movie.attributes['created-at-short']}</div>
                        <p className="card-text mb-auto">{movie.attributes.text}</p>
                        <div className="card-text mb-auto text-right">
                            <StarRatingComponent
                                name={"rating_" + movie.id}
                                value={parseInt(movie.attributes['avg-ratings'])}
                                onStarClick={this.starClicked}
                            />
                        </div>
                    </div>
                    <div className="col-auto d-none d-lg-block">
                        <img src={movie.attributes['image-url'] + '?random=' + movie.id} className="card-img-top"/>
                    </div>
                </div>
            </div>
        );
    }
}

const initMapStateToProps = ({ratings}) => {
    return {
        ratings
    }
}

const initMapDispatchToProps = ({
    rateMovie,
    fetchMovies
})

export default connect(initMapStateToProps, initMapDispatchToProps)(MovieItem);