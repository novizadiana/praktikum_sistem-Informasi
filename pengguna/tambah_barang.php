<?php
session_start();
include '../koneksi.php';



if (isset($_POST['submit'])) {

    mysqli_query($koneksi, "
    INSERT INTO barang
    (nama_barang,status_barang,penyimpanan_barang,harga_barang)
    VALUES
    (
    '$_POST[nama]',
    '$_POST[status]',
    '$_POST[penyimpanan]',
    '$_POST[harga]'
    )
    ");

    header("Location: index.php");
}
?>

<!DOCTYPE html>
<html>

<head>
    <title>Tambah Barang</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>

    <div class="container mt-5">

        <div class="card">

            <div class="card-header">
                <h4>Tambah Barang</h4>
            </div>

            <div class="card-body">

                <form method="POST">

                    <div class="mb-3">
                        <label>Nama Barang</label>
                        <input type="text" name="nama" class="form-control">
                    </div>

                    <div class="mb-3">
                        <label>Status</label>
                        <input type="text" name="status" class="form-control">
                    </div>

                    <div class="mb-3">
                        <label>Penyimpanan</label>
                        <input type="text" name="penyimpanan" class="form-control">
                    </div>

                    <div class="mb-3">
                        <label>Harga</label>
                        <input type="number" name="harga" class="form-control">
                    </div>

                    <button type="submit" name="submit" class="btn btn-primary">
                        Simpan
                    </button>

                    <a href="dashboard.php" class="btn btn-secondary">
                        Kembali
                    </a>

                </form>

            </div>
        </div>

    </div>

</body>

</html>