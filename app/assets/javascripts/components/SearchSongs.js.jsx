class SearchSongs extends React.Component{
  constructor(props){
    super(props);
    this.state = { results: [], selected: null };
    this.search = this.search.bind(this);
    this.showAdd = this.showAdd.bind(this)
  }
  search(){
    if(this.refs.song_query.value.length >= 3){
      $.ajax({
        url: '/songs/search',
        type: 'GET',
        data: { song_query: this.refs.song_query.value }
      }).success( data => {
        this.setState({ searchResults: data, selected: null })
      });
    } else {
      this.setState({ searchResults: null, selected: null })
    }
  }
  showAdd(i){
    if(this.state.selected == i){
      console.log('removing select')
      this.setState({ selected: null })
    } else {
      console.log('selecting ' + i)
      this.setState({ selected: i })
    }
  }
  results(){
    if(this.state.searchResults){
      let results = this.state.searchResults.map( (song, i) => {
        let key = 'song' + song.id;
        let selected = (this.state.selected == i) ? true : false
        return(
          <Song key={key}
                addSong={this.props.addSong}
                room={this.props.room}
                playlist={this.props.playlist}
                index={i}
                selected={selected}
                showAdd={this.showAdd}
                {...song}/>
        );
      })
      return( results )
    } else {
      return(
        <p>Enter the name of a song above to search</p>
      )
    }
  }
  render(){
    return(
      <div className='panel'>
        <div className='panel-head'>
          <h3>Add Songs</h3>
        </div>
        <div className='panel-body'>
          <input placeholder='Search songs' ref='song_query' onChange={this.search}></input>
          <div className='row'>
            { this.results() }
          </div>
        </div>
      </div>
    )
  }
}
