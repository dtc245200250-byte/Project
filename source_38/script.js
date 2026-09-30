$(document).ready(function () {
    // MDB select
    $('.mdb-select').materialSelect();

    // Change navbar appearance after scrolling
    $(window).on('scroll', function () {
        $('.scrolling-navbar').toggleClass('scrolled', $(window).scrollTop() > 20);
    });

    // Close mobile navbar after selecting a section
    $('.navbar-nav .nav-link, .navbar-nav .btn').on('click', function () {
        $('.navbar-collapse').collapse('hide');
    });

    // Demo form validation
    $('#consultForm').on('submit', function (event) {
        event.preventDefault();

        if (this.checkValidity()) {
            $('#formMessage').removeClass('d-none');
            this.reset();
            $('.mdb-select').materialSelect();
        }
    });
});