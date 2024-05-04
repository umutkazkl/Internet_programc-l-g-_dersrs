<?php
class Users_Model extends CI_Model
{

    public function __construct()
    {
        parent::__construct();
    }

    /* Tabloya veri ekleyen fonksiyon */
    public function add($data = array())
    {
        return $this->db->insert("users", $data);
    }

    /* Tablodaki tüm kayıtları çeken fonksiyon */

    public function getAll($order = "id ASC")
    {
        return $this->db->order_by($order)->get("users")->result();
    }

    /* Sadece istenen kaydı çeken */

    public function get($where = array())
    {
        return $this->db->where($where)->get("users")->row();
    }


    public function delete($where = array())
    {
        return $this->db->where($where)->delete("users");
    }

    public function update($where = array(), $data = array())
    {
        return $this->db->where($where)->update("users", $data);
    }

    // Eski şifrenin doğruluğunu kontrol etmek için
    public function check_password($id, $password) {
        $user = $this->db->get_where('users', array('id' => $id))->row();
        if ($user) {
            return $user->password === md5($password);
        }
        return false;
    }

}

?>
