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
                                    movies.aggs[item].buckets.map(bucket =>
                                        <li key={item + uuid()}>
                                            <a href="#">{this.parseStar(bucket.key)} <span>({bucket['doc-count']})</span></a>
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