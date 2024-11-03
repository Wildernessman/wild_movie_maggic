#!/bin/bash

# Create the directory structure
mkdir -p movie-recommendation-app/img movie-recommendation-app/data

# Create index.html
cat <<EOL > movie-recommendation-app/index.html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Movie Recommendation Engine</title>
  <link rel="stylesheet" href="style.css">
</head>
<body>
  <header>
    <img src="img/movielogo.jpg" alt="Movie Recommendation Logo" id="logo">
    <h1>Movie Recommendation Engine</h1>
  </header>
  <main>
    <section class="search-section">
      <input type="text" id="search-input" placeholder="Search for a movie">
      <button id="search-btn">Search</button>
    </section>
    <section class="recommendation-section">
      <h2>Recommended Movies</h2>
      <div id="recommendation-container"></div>
    </section>
  </main>
  <script src="script.js"></script>
</body>
</html>
EOL

# Create style.css
cat <<EOL > movie-recommendation-app/style.css
body {
  font-family: Arial, sans-serif;
  margin: 0;
  padding: 0;
}

header {
  background-color: #333;
  color: #fff;
  padding: 20px;
  text-align: center;
  display: flex;
  align-items: center;
  justify-content: center;
}

#logo {
  width: 50px; /* Adjust as needed */
  height: auto;
  margin-right: 20px; /* Space between logo and title */
  vertical-align: middle;
}

main {
  padding: 20px;
}

.search-section {
  display: flex;
  justify-content: center;
  margin-bottom: 20px;
}

.search-section input,
.search-section button {
  padding: 10px;
  font-size: 16px;
}

.recommendation-section {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  grid-gap: 20px;
}

.movie-card {
  background-color: #f5f5f5;
  border-radius: 5px;
  box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
  padding: 10px;
  text-align: center;
}

.movie-card img {
  width: 100%;
  height: 300px;
  object-fit: cover;
  border-radius: 5px;
}

.movie-card h3 {
  margin-top: 10px;
}
EOL

# Create script.js
cat <<EOL > movie-recommendation-app/script.js
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
        moviePoster.src = 'img/' + movie.poster;
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
EOL

# Create movies.json
cat <<EOL > movie-recommendation-app/data/movies.json
{
  "movies": [
    { "title": "The shawshank Redemption", "poster": "shawshank-redemption.jpg" },
    { "title": "The Godfather", "poster": "the-godfather.jpg" },
    { "title": "The Dark Knight", "poster": "the-dark-knight.jpg" },
    { "title": "Inception", "poster": "inception.jpg" },
    { "title": "Forrest Gump", "poster": "forrest-gump.jpg" },
    { "title": "The Matrix", "poster": "the-matrix.jpg" },
    { "title": "Star Wars: Episode IV - A New Hope", "poster": "star-wars.jpg" },
    { "title": "Jurassic Park", "poster": "jurassic-park.jpg" },
    { "title": "The Lord of the Rings: The Fellowship of the Ring", "poster": "the-fellowship-of-the-ring.jpg" },
    { "title": "The Silence of the Lambs", "poster": "the-silence-of-the-lambs.jpg" }
  ]
}
EOL

echo "Movie recommendation app setup complete!"