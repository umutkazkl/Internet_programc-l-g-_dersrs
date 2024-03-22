<!DOCTYPE html>
<html lang="en">

<?php $this->load->view("includes/header"); ?>

<body class="hold-transition sidebar-mini layout-fixed">
    <div class="wrapper">

        <?php $this->load->view("includes/navbar"); ?>


        <?php $this->load->view("includes/sidebar"); ?>


        <?php $this->load->view("{$viewFolder}/{$subViewFolder}/content"); ?>


        <?php $this->load->view("includes/footer"); ?>