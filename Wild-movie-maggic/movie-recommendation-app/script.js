// Load movie data from a JSON file
fetch('data/movies.json')
  .then(response => response.json())
  .then(data => {
    const movies = data.movies;

    const searchInput = document.getElementById('search-input');
    const searchBtn = document.getElementById('search-btn');
    const recommendationContainer = document.getElementById('recommendation-container');

    function displayMovieRecommendations(searchTerm) {
      recommendationContainer.innerHTML = '';

      const filteredMovies = movies.filter(movie =>
        movie.title.toLowerCase().includes(searchTerm.toLowerCase())
      );

      filteredMovies.forEach(movie => {
        const movieCard = document.createElement('div');
        movieCard.classList.add('movie-card');

        const moviePoster = document.createElement('img');
        moviePoster.src = 'img/' + movie.poster; // Ensure this matches your filename
        moviePoster.alt = movie.title;

        const movieTitle = document.createElement('h3');
        movieTitle.textContent = movie.title;

        movieCard.appendChild(moviePoster);
        movieCard.appendChild(movieTitle);
        recommendationContainer.appendChild(movieCard);
      });
    }

    searchBtn.addEventListener('click', () => {
      const searchTerm = searchInput.value;
      displayMovieRecommendations(searchTerm);
    });

    displayMovieRecommendations('');
  })
  .catch(error => {
    console.error('Error loading movie data:', error);
  });