class Search extends React.Component{
  constructor(props){
    super(props);
    this.state = { results: [] };
    this.search = this.search.bind(this);
  }
  search(){
    if(this.refs.playlist_query.value.length >= 3){
      $.ajax({
        url: '/playlists/search',
        type: 'GET',
        data: { playlist_query: this.refs.playlist_query.value }
      }).success( data => {
        this.setState({ searchResults: data })
      });
    } else {
      this.setState({ searchResults: null})
    }
  }
  results(){
    if(this.state.searchResults){
      let results = this.state.searchResults.map( playlist => {
        let key = 'playlist' + playlist.id;
        return(
          <Playlist key={key} {...playlist}/>
        );
      })
      return( results )
    } else {
      return(
        <p>Enter the name of a playlist above to search</p>
      )
    }
  }
  render(){
    return(
      <div className='panel'>
        <div className='panel-head'>
          <h3>Search</h3>
        </div>
        <div className='panel-body'>
          <input placeholder='Search playlists' ref='playlist_query' onChange={this.search}></input>
          <div className='row'>
            { this.results() }
          </div>
        </div>
      </div>
    )
  }
}
