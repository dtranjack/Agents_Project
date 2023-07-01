// Select the image element
const slideImg = document.getElementById('cp-pht');

// Function to handle the scroll event
function handleScroll() {
    // Get the position of the image relative to the viewport
    const imgPosition = slideImg.getBoundingClientRect();

    // Check if the image is within the viewport
    if (imgPosition.top < window.innerHeight && imgPosition.bottom >= 0) {
        // Image is in view, fade it in and slide it in
        slideImg.style.opacity = '1';
        slideImg.style.transform = 'translateX(0)';
    } else {
        // Image is out of view, fade it out and slide it out
        slideImg.style.opacity = '0';
        slideImg.style.transform = 'translateX(-100%)';
    }
}

// Attach the scroll event listener
window.addEventListener('scroll', handleScroll);
