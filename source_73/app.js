const movieItems = [...document.querySelectorAll(".movie-item")];
const searchInput = document.getElementById("searchInput");
const movieCount = document.getElementById("movieCount");
const playerTitle = document.getElementById("playerTitle");
const html5Player = document.getElementById("html5Player");
const youtubePlayer = document.getElementById("youtubePlayer");
const emptyPlayer = document.getElementById("emptyPlayer");

function stopPlayers() {
    html5Player.pause();
    youtubePlayer.src = "";
}

function playMovie(item) {
    movieItems.forEach((movie) => movie.classList.remove("active"));
    item.classList.add("active");

    const type = item.dataset.type;
    const title = item.dataset.title;
    const source = item.dataset.source;

    playerTitle.textContent = title;
    emptyPlayer.style.display = "none";

    if (type === "youtube") {
        html5Player.style.display = "none";
        youtubePlayer.style.display = "block";
        youtubePlayer.src = "https://www.youtube.com/embed/" + source + "?autoplay=0&rel=0";
        html5Player.pause();
    } else {
        youtubePlayer.style.display = "none";
        youtubePlayer.src = "";
        html5Player.style.display = "block";
        html5Player.src = source;
        html5Player.load();
        html5Player.play().catch(() => {});
    }
}

movieItems.forEach((item) => {
    item.addEventListener("click", () => playMovie(item));
});

function filterMovies() {
    const query = searchInput.value.trim().toLowerCase();
    let visibleCount = 0;

    movieItems.forEach((item) => {
        const title = item.dataset.title.toLowerCase();
        const visible = title.includes(query);
        item.style.display = visible ? "flex" : "none";

        if (visible) {
            visibleCount += 1;
        }
    });

    movieCount.textContent = visibleCount + " phim";
}

searchInput.addEventListener("input", filterMovies);

window.addEventListener("load", () => {
    playMovie(movieItems[0]);
});
