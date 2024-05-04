<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
            </div><!-- /.row -->
        </div><!-- /.container-fluid -->
    </div>
    <!-- /.content-header -->
    <!-- Main content -->
    <section class="content">
        <div class="container-fluid">
            <div class="row">
                <div class="col-12">
                    <!-- Horizontal Form -->
                    <div class="card card-info">
                        <div class="card-header">
                            <h3 class="card-title">Kullanıcı Güncelleme İşlemi</h3>
                        </div>
                        <!-- /.card-header -->
                        <!-- form start -->
                        <form class="form-horizontal" method="POST" action="<?php echo base_url("Users/update/{$item->id}") ?>">
                            <div class="card-body">
                                <div class="form-group row">
                                    <label for="email" class="col-sm-2 col-form-label">Email:</label>
                                    <div class="col-sm-10">
                                        <input type="email" name="email" class="form-control" id="email" value="<?php echo isset($formError) ? set_value("email") : $item->email; ?>" placeholder="Email Adresini Giriniz.">
                                        <?php if (isset($formError)) { ?>
                                            <small><?php echo form_error("email"); ?></small>
                                        <?php } ?>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="name" class="col-sm-2 col-form-label">İsim:</label>
                                    <div class="col-sm-10">
                                        <input type="text" name="name" class="form-control" id="name" value="<?php echo isset($formError) ? set_value("name") : $item->name; ?>" placeholder="İsmini Giriniz.">
                                        <?php if (isset($formError)) { ?>
                                            <small><?php echo form_error("name"); ?></small>
                                        <?php } ?>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="surname" class="col-sm-2 col-form-label">Soyisim:</label>
                                    <div class="col-sm-10">
                                        <input type="text" name="surname" class="form-control" id="surname" value="<?php echo isset($formError) ? set_value("surname") : $item->surname; ?>" placeholder="Soyismini Giriniz.">
                                        <?php if (isset($formError)) { ?>
                                            <small><?php echo form_error("surname"); ?></small>
                                        <?php } ?>
                                    </div>
                                </div>
                                <!-- Eski şifre alanı -->
                                <div class="form-group row">
                                    <label for="old_password" class="col-sm-2 col-form-label">Eski Şifre:</label>
                                    <div class="col-sm-10">
                                        <input type="password" name="old_password" class="form-control" id="old_password" placeholder="Eski Şifrenizi Giriniz.">
                                        <?php if (isset($formError)) { ?>
                                            <small><?php echo form_error("old_password"); ?></small>
                                        <?php } ?>
                                    </div>
                                </div>
                                <!-- Yeni şifre alanları -->
                                <div class="form-group row">
                                    <label for="new_password" class="col-sm-2 col-form-label">Yeni Şifre:</label>
                                    <div class="col-sm-10">
                                        <input type="password" name="new_password" class="form-control" id="new_password" placeholder="Yeni Şifrenizi Giriniz.">
                                        <?php if (isset($formError)) { ?>
                                            <small><?php echo form_error("new_password"); ?></small>
                                        <?php } ?>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="re_new_password" class="col-sm-2 col-form-label">Yeni Şifre Tekrar:</label>
                                    <div class="col-sm-10">
                                        <input type="password" name="re_new_password" class="form-control" id="re_new_password" placeholder="Yeni Şifrenizi Tekrar Giriniz.">
                                        <?php if (isset($formError)) { ?>
                                            <small><?php echo form_error("re_new_password"); ?></small>
                                        <?php } ?>
                                    </div>
                                </div>
                            </div>
                            <!-- /.card-body -->
                            <div class="card-footer">
                                <button type="submit" class="btn btn-info">Kaydet</button>
                                <a href="<?php echo base_url("Users") ?>" class="btn btn-default float-right">Vazgeç</a>
                            </div>
                            <!-- /.card-footer -->
                        </form>
                    </div>
                    <!-- /.card -->
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
