const revenueAndSpending = {
    labels: [
        'Tháng 1', 'Tháng 2', 'Tháng 3', 'Tháng 4',
        'Tháng 5', 'Tháng 6', 'Tháng 7', 'Tháng 8',
        'Tháng 9', 'Tháng 10', 'Tháng 11', 'Tháng 12'
    ],
    datasets: [
        {
            label: 'Doanh thu (triệu đồng)',
            data: [50, 70, 65, 80, 90, 100, 120, 110, 130, 140, 150, 170],
            backgroundColor: 'rgba(52, 152, 219, 0.8)',
            borderColor: 'rgba(41, 128, 185, 1)',
            borderWidth: 2,
        },
        {
            label: 'Chi tiêu (triệu đồng)',
            data: [40, 60, 55, 70, 80, 95, 85, 100, 120, 110, 125, 140],
            backgroundColor: 'rgba(231, 76, 60, 0.8)',
            borderColor: 'rgba(192, 57, 43, 1)',
            borderWidth: 2,
        },
    ],
};

const configRevenueAndSpending = {
    type: 'bar',
    data: revenueAndSpending,
    options: {
        responsive: true,
        plugins: {
            legend: {
                display: true,
                position: 'top',
                labels: {
                    font: {
                        size: 14,
                    },
                },
            },
        },
        scales: {
            x: {
                title: {
                    display: true,
                    text: 'Tháng',
                },
            },
            y: {
                beginAtZero: true,
                title: {
                    display: true,
                    text: 'Giá trị (triệu đồng)',
                },
            },
        },
    },
};

const ctx = document.getElementById('revenueChart').getContext('2d');
new Chart(ctx, configRevenueAndSpending);
