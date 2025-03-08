function handleApprove(button) {
    const row = button.closest('tr');
    const statusCell = row.querySelector('.status');
    statusCell.textContent = 'Đã duyệt';
    statusCell.style.color = 'green';
    alert('Yêu cầu đã được duyệt!');
}

function handleReject(button) {
    const row = button.closest('tr');
    const statusCell = row.querySelector('.status');
    statusCell.textContent = 'Đã từ chối';
    statusCell.style.color = 'red';
    alert('Yêu cầu đã bị từ chối!');
}

function handleDetails(button) {
    const row = button.closest('tr');
    const requestId = row.cells[0].textContent;
    const customerName = row.cells[1].textContent;
    const reason = row.cells[3].textContent;
    const status = row.querySelector('.status').textContent;

    alert(`Chi tiết yêu cầu:\nMã đơn hàng: ${requestId}\nKhách hàng: ${customerName}\nLý do: ${reason}\nTrạng thái: ${status}`);
}
