// Xử lý khi form được submit
document.getElementById('surveyForm').addEventListener('submit', function (e) {
    e.preventDefault();

    // Thu thập dữ liệu từ form
    const formData = new FormData(e.target);
    const surveyData = {
        title: formData.get('title'),
        description: formData.get('description'),
        questions: formData.getAll('questions[]'),
    };

    // Thêm khảo sát vào danh sách
    const listSurveys = document.getElementById('listSurveys');
    const newSurvey = document.createElement('li');
    newSurvey.innerHTML = `
        <div class="survey-item">
            <h4>${surveyData.title}</h4>
            <p>${surveyData.description}</p>
            <div class="questions-list">
                ${surveyData.questions.map((q, index) => `
                    <div class="question-item">
                        <span>Câu ${index + 1}:</span>
                        <p>${q}</p>
                    </div>
                `).join('')}
            </div>
        </div>
    `;
    listSurveys.appendChild(newSurvey);

    // Reset form
    e.target.reset();
});

// Thêm câu hỏi mới
document.getElementById('addQuestion').addEventListener('click', function () {
    const questionsContainer = document.getElementById('questionsContainer');
    const questionCount = questionsContainer.querySelectorAll('input').length + 1;

    const newQuestion = document.createElement('div');
    newQuestion.innerHTML = `
        <label for="question${questionCount}">Câu hỏi ${questionCount}:</label>
        <input type="text" id="question${questionCount}" name="questions[]" required />
    `;
    questionsContainer.appendChild(newQuestion);
});
