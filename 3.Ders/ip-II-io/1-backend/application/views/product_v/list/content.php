<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1 class="m-0">Dashboard</h1>
          </div><!-- /.col -->
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="#">Home</a></li>
              <li class="breadcrumb-item active">Dashboard v1</li>
            </ol>
          </div><!-- /.col -->
        </div><!-- /.row -->
      </div><!-- /.container-fluid -->
    </div>
    <!-- /.content-header -->

    <section class="content">
      <div class="container-fluid">
        <div class="row">
          <div class="col-12">
            <div class="card">
              <div class="card-header">
                <div class="row">
                  <div class="col-md-6">
                    <h3 class="card-title">Ürün Kategorileri Listesi</h3>
                  </div>
                  <div class="col-md-6 text-right">
                    <a href="<?php echo base_url("Product/new_form");?>" class="btn btn-success btn-xs mb-2">
                    <i class="fas fa-plus"></i>Yeni Kategori Ekle</a>
                  </div>
                
                </div>

              </div>
              <!-- /.card-header -->
              <div class="card-body">
                <table id="example1" class="table table-bordered table-striped">
                  <thead>
                  <tr>
                    <th>ID</th>
                    <th>Ürün Kategorisi</th>
                    <th>Durum</th>
                    <th>Oluşturma tarihi</th>
                    <th>İşlemler</th>
                  </tr>
                  </thead>
                  <tbody>
                    <?php foreach($items as $item) {  ?>
                  <tr>
                    <td><?php echo $item->id; ?></td>
                    <td><?php echo $item->title; ?></td>
                    <td><?php echo $item->is_active == 0 ? "Pasif" : "Aktif"; ?></td>
                    <td><?php echo $item->created_at; ?></td>
                    <td>
                      <button class="btn btn-danger">SİL</button>
                      <button class="btn btn-primary">GÜNCELLE</button>
                    </td>
                  </tr>
                  <?php }?>
                  </tbody>
                </table>
              </div>
              <!-- /.card-body -->
            </div>
            <!-- /.card -->
            
          </div>
          <!-- /.col -->
        </div>
        <!-- /.row -->
      </div>
      <!-- /.container-fluid -->
    </section>
  </div>
  <!-- /.content-wrapper -->