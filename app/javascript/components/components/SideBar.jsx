import React, {Component} from 'react';
import PropTypes from 'prop-types';
import { connect } from 'react-redux';
import uuid from 'uuid';
import StarRatingComponent from 'react-star-rating-component';

class SideBar extends Component {
    static propTypes = {
        movies: PropTypes.object.isRequired
    }

    parseTitleize = (title) => {
        return title.charAt(0).toUpperCase() + title.slice(1)
    }

    parseStar = (item) => {
        const isInteger = parseInt(item)

        return !isInteger ? (<span>{item}</span>) : (
            <StarRatingComponent
                name={"raring" + uuid()}
                value={isInteger}
            />
        )
    }

    render() {
        const { movies } = this.props;

        return (
            <aside className="col-md-2 blog-sidebar">
                {
                    Object.keys(movies.aggs).map(item =>
                        <div className="pb-4" key={uuid()}>
                            <h3 className="pb-4 font-italic border-bottom">{this.parseTitleize(item)}</h3>
                            <ol className="list-unstyled mb-0">
                                {
                                    Object.keys(movies.aggs[item]).map(bucket =>
                                        <li key={item + uuid()}>
                                            <a href="#">{this.parseStar(bucket)} <span>({movies.aggs[item][bucket]})</span></a>
                                        </li>
                                    )
                                }
                            </ol>
                        </div>
                    )
                }
            </aside>
        );
    }
}

const initMapStateToProps = ({movies}) => {
    return {
        movies
    }
}

export default connect(initMapStateToProps)(SideBar);