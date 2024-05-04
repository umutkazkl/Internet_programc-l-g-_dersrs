    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
      <!-- Content Header (Page header) -->
      <section class="content-header">
        <div class="container-fluid">

        </div><!-- /.container-fluid -->
      </section>

      <!-- Main content -->
      <section class="content">
        <div class="container-fluid">
          <div class="row">
            <div class="col-md-12">

              <!-- Horizontal Form -->
              <div class="card card-info">
                <div class="card-header">
                  <h3 class="card-title">Yeni Kullanıcı Ekleme İşlemi</h3>
                </div>
                <!-- /.card-header -->
                <!-- form start -->
                <form class="form-horizontal" method="POST" action="<?php echo base_url("Users/save") ?>">
                  <div class="card-body">
                    <div class="form-group row">
                      <label for="email" class="col-sm-2 col-form-label">Kullanıcı Adı</label>
                      <div class="col-sm-10">
                        <input type="text" class="form-control" name="email" id="email" placeholder="Kullanıcı Adını Giriniz">
                      </div>
                    </div>
                    <?php if (isset($formError)) { ?>
                      <small><?php echo form_error("email"); ?></small>
                    <?php } ?>

                    <div class="form-group row">
                      <label for="name" class="col-sm-2 col-form-label">İsim</label>
                      <div class="col-sm-10">
                        <input type="text" class="form-control" name="name" id="name"  placeholder="Adınızı Giriniz">
                      </div>
                    </div>
                    <?php if (isset($formError)) { ?>
                      <small><?php echo form_error("name"); ?></small>
                    <?php } ?>

                    
                    <div class="form-group row">
                      <label for="surname" class="col-sm-2 col-form-label">Soyisim</label>
                      <div class="col-sm-10">
                        <input type="text" class="form-control" name="surname" id="surname"  placeholder="Soyadınızı Giriniz">
                      </div>
                    </div>
                    <?php if (isset($formError)) { ?>
                      <small><?php echo form_error("surname"); ?></small>
                    <?php } ?>
                    
                    
                    <div class="form-group row">
                      <label for="password" class="col-sm-2 col-form-label">Şifre Giriniz</label>
                      <div class="col-sm-10">
                        <input type="text" class="form-control" name="password" id="password" placeholder="Şifre Giriniz">
                      </div>
                    </div>
                    <?php if (isset($formError)) { ?>
                      <small><?php echo form_error("password"); ?></small>
                    <?php } ?>

                    <div class="form-group row">
                      <label for="re-password" class="col-sm-2 col-form-label">Şifre Tekrarını Giriniz</label>
                      <div class="col-sm-10">
                        <input type="text" class="form-control" name="re-password" id="re-password" placeholder="Şifrenizi Tekrar Giriniz">
                      </div>
                    </div>
                    <?php if (isset($formError)) { ?>
                      <small><?php echo form_error("re-password"); ?></small>
                    <?php } ?>
                    


                  </div>
                  <!-- /.card-body -->
                  <div class="card-footer">
                    <button type="submit" class="btn btn-info">Kaydet</button>
                    <a href="<?php echo base_url("Users") ?>" class="btn btn-default float-right">
                      İptal
                    </a>
                  </div>
                  <!-- /.card-footer -->
                </form>
              </div>

            </div>
            <!-- /.col -->
          </div>
          <!-- /.row -->
        </div>
        <!-- /.container-fluid -->
      </section>
      <!-- /.content -->
    </div>
    <!-- /.content-wrapper -->