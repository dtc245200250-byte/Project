const movies = [
    {
        id: 1,
        title: "Doraemon - Tập mở đầu",
        views: 12400,
        viewsLabel: "12.4K lượt xem",
        updated: "Cập nhật hôm nay",
        date: 6,
        quality: "HD 720p",
        description: "Video mẫu dùng để minh họa khu vực phát phim bằng thẻ video. Bạn có thể thay đường dẫn bằng video hoạt hình của riêng mình.",
        video: "https://www.w3schools.com/html/mov_bbb.mp4",
        youtube: "https://www.youtube.com/embed/aqz-KE-bpKQ"
    },
    {
        id: 2,
        title: "Cuộc phiêu lưu của thỏ con",
        views: 9800,
        viewsLabel: "9.8K lượt xem",
        updated: "Cập nhật hôm qua",
        date: 5,
        quality: "HD 720p",
        description: "Bản demo thứ hai trong danh sách phim. Nội dung và nguồn video có thể được thay bằng dữ liệu thật khi triển khai.",
        video: "https://www.w3schools.com/html/mov_bbb.mp4",
        youtube: "https://www.youtube.com/embed/aqz-KE-bpKQ"
    },
    {
        id: 3,
        title: "Thế giới kỳ diệu",
        views: 18700,
        viewsLabel: "18.7K lượt xem",
        updated: "2 ngày trước",
        date: 4,
        quality: "FullHD 1080p",
        description: "Ví dụ về cách hiển thị chất lượng FullHD trong danh sách phim.",
        video: "https://www.w3schools.com/html/mov_bbb.mp4",
        youtube: "https://www.youtube.com/embed/aqz-KE-bpKQ"
    },
    {
        id: 4,
        title: "Bạn nhỏ khám phá thiên nhiên",
        views: 7200,
        viewsLabel: "7.2K lượt xem",
        updated: "3 ngày trước",
        date: 3,
        quality: "HD 720p",
        description: "Mục phim demo cho thao tác tìm kiếm, sắp xếp và thay đổi nội dung đang phát.",
        video: "https://www.w3schools.com/html/mov_bbb.mp4",
        youtube: "https://www.youtube.com/embed/aqz-KE-bpKQ"
    },
    {
        id: 5,
        title: "Robot và những người bạn",
        views: 22100,
        viewsLabel: "22.1K lượt xem",
        updated: "5 ngày trước",
        date: 2,
        quality: "FullHD 1080p",
        description: "Ví dụ có lượng xem cao để kiểm tra chế độ sắp xếp theo lượt xem.",
        video: "https://www.w3schools.com/html/mov_bbb.mp4",
        youtube: "https://www.youtube.com/embed/aqz-KE-bpKQ"
    },
    {
        id: 6,
        title: "Chuyến tàu tuổi thơ",
        views: 5400,
        viewsLabel: "5.4K lượt xem",
        updated: "1 tuần trước",
        date: 1,
        quality: "HD 720p",
        description: "Mục cuối cùng trong danh sách mẫu, phù hợp để kiểm tra bộ lọc tìm kiếm.",
        video: "https://www.w3schools.com/html/mov_bbb.mp4",
        youtube: "https://www.youtube.com/embed/aqz-KE-bpKQ"
    }
];

const state = {
    search: "",
    sort: "newest",
    selectedId: 1
};

const movieList = document.getElementById("movieList");
const movieCount = document.getElementById("movieCount");
const searchInput = document.getElementById("searchInput");
const sortSelect = document.getElementById("sortSelect");
const mainVideo = document.getElementById("mainVideo");
const youtubeFrame = document.getElementById("youtubeFrame");
const playerTitle = document.getElementById("playerTitle");
const playerDescription = document.getElementById("playerDescription");
const playerViews = document.getElementById("playerViews");
const playerUpdated = document.getElementById("playerUpdated");
const qualityBadge = document.getElementById("qualityBadge");
const menuToggle = document.querySelector(".menu-toggle");
const headLink = document.querySelector(".head-link");

function getFilteredMovies() {
    const keyword = state.search.trim().toLowerCase();

    const filtered = movies.filter(movie =>
        movie.title.toLowerCase().includes(keyword)
    );

    if (state.sort === "views") {
        return filtered.sort((a, b) => b.views - a.views);
    }

    return filtered.sort((a, b) => b.date - a.date);
}

function renderMovies() {
    const filteredMovies = getFilteredMovies();
    movieCount.textContent = filteredMovies.length;

    if (filteredMovies.length === 0) {
        movieList.innerHTML = '<div class="movie-item"><strong>Không tìm thấy phim.</strong></div>';
        return;
    }

    movieList.innerHTML = filteredMovies.map(movie => {
        const active = movie.id === state.selectedId ? " active" : "";

        return `
            <button class="movie-item${active}" type="button" data-id="${movie.id}">
                <div class="movie-top">
                    <div class="movie-title">${movie.title}</div>
                    <span class="movie-quality">${movie.quality}</span>
                </div>
                <div class="movie-meta">
                    <span>${movie.viewsLabel}</span>
                    <span>${movie.updated}</span>
                </div>
            </button>
        `;
    }).join("");

    document.querySelectorAll(".movie-item[data-id]").forEach(item => {
        item.addEventListener("click", () => {
            state.selectedId = Number(item.dataset.id);
            renderMovies();
            updatePlayer();
        });
    });
}

function updatePlayer() {
    const movie = movies.find(item => item.id === state.selectedId);

    if (!movie) {
        return;
    }

    playerTitle.textContent = movie.title;
    playerDescription.textContent = movie.description;
    playerViews.textContent = movie.viewsLabel;
    playerUpdated.textContent = movie.updated;
    qualityBadge.textContent = movie.quality;

    mainVideo.pause();
    mainVideo.src = movie.video;
    mainVideo.load();

    youtubeFrame.src = movie.youtube;

    window.scrollTo({
        top: document.getElementById("movies").offsetTop - 80,
        behavior: "smooth"
    });
}

searchInput.addEventListener("input", event => {
    state.search = event.target.value;
    renderMovies();
});

sortSelect.addEventListener("change", event => {
    state.sort = event.target.value;
    renderMovies();
});

menuToggle.addEventListener("click", () => {
    headLink.classList.toggle("is-open");
});

headLink.addEventListener("click", event => {
    if (event.target.matches("a")) {
        headLink.classList.remove("is-open");
    }
});

renderMovies();
updatePlayer();