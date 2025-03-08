const feedbackInput = document.getElementById('feedbackInput');
const submitFeedback = document.getElementById('submitFeedback');
const historyList = document.getElementById('historyList');
const textareaContainer = document.getElementById('textareaContainer');
const feedbackTextarea = document.getElementById('feedbackTextarea');

submitFeedback.addEventListener('click', () => {
    const feedback = feedbackInput.value.trim();
    if (feedback) {
        const listItem = document.createElement('li');
        listItem.textContent = feedback;
        historyList.appendChild(listItem);

        feedbackTextarea.value = feedback;
        textareaContainer.style.display = 'block';

        feedbackInput.value = '';
    }
});