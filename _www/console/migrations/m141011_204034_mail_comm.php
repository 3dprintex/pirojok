<?php

use yii\db\Schema;
use yii\db\Migration;

class m141011_204034_mail_comm extends Migration
{
    public function up()
    {
        $tableOptions = null;
        if ($this->db->driverName === 'mysql') {
            // http://stackoverflow.com/questions/766809/whats-the-difference-between-utf8-general-ci-and-utf8-unicode-ci
            $tableOptions = 'CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE=MyISAM';
        }

        $this->createTable('mail', [
            'id' => Schema::TYPE_PK,
            'user_id' => Schema::TYPE_INTEGER . ' NOT NULL',
            'mess' => Schema::TYPE_TEXT,
            'has_img' => Schema::TYPE_BOOLEAN . '',
            'has_video' => Schema::TYPE_BOOLEAN . '',

            'status' => Schema::TYPE_SMALLINT . ' NOT NULL DEFAULT 0',
            'created_at' => Schema::TYPE_INTEGER . ' NOT NULL',
            'updated_at' => Schema::TYPE_INTEGER . ' NOT NULL',
            'timeout' => Schema::TYPE_INTEGER . ' NOT NULL',
            'timeout2' => Schema::TYPE_INTEGER . ' NOT NULL',
            'cost' => Schema::TYPE_INTEGER . ' NOT NULL',

            'to_lat' => Schema::TYPE_FLOAT. '',
            'to_long' => Schema::TYPE_FLOAT. '',
            'to_user_id' => Schema::TYPE_INTEGER. '',
            'to_email' => Schema::TYPE_STRING. '(128)',

        ], $tableOptions);

        $this->createTable('mail_comm', [
            'id' => Schema::TYPE_PK,
            'mail_id' => Schema::TYPE_INTEGER . ' NOT NULL',
            'user_id' => Schema::TYPE_INTEGER . ' NOT NULL',
            'to_user_id' => Schema::TYPE_INTEGER. '',
            'mess' => Schema::TYPE_TEXT,
            'has_img' => Schema::TYPE_BOOLEAN . '',
            'has_video' => Schema::TYPE_BOOLEAN . '',

            'status' => Schema::TYPE_SMALLINT . ' NOT NULL DEFAULT 0',
            'created_at' => Schema::TYPE_INTEGER . ' NOT NULL',
            'updated_at' => Schema::TYPE_INTEGER . ' NOT NULL',
            'lat' => Schema::TYPE_FLOAT. '',
            'long' => Schema::TYPE_FLOAT. '',

        ], $tableOptions);

        $this->createTable('transit', [
            'id' => Schema::TYPE_PK,
            'mail_id' => Schema::TYPE_INTEGER . ' NOT NULL',
            'from_user_id' => Schema::TYPE_INTEGER . ' NOT NULL',
            'to_user_id' => Schema::TYPE_INTEGER. '',
            'mess' => Schema::TYPE_TEXT,
            'has_img' => Schema::TYPE_BOOLEAN . '',
            'has_video' => Schema::TYPE_BOOLEAN . '',

            'status' => Schema::TYPE_SMALLINT . ' NOT NULL DEFAULT 0',
            'created_at' => Schema::TYPE_INTEGER . ' NOT NULL',
            'updated_at' => Schema::TYPE_INTEGER . ' NOT NULL',
            'lat' => Schema::TYPE_FLOAT. '',
            'long' => Schema::TYPE_FLOAT. '',

        ], $tableOptions);


        $this->createTable('transit_comm', [
            'id' => Schema::TYPE_PK,
            'transit_id' => Schema::TYPE_INTEGER . ' NOT NULL',
            'user_id' => Schema::TYPE_INTEGER . ' NOT NULL',
            'to_user_id' => Schema::TYPE_INTEGER. '',
            'mess' => Schema::TYPE_TEXT,
            'has_img' => Schema::TYPE_BOOLEAN . '',
            'has_video' => Schema::TYPE_BOOLEAN . '',

            'status' => Schema::TYPE_SMALLINT . ' NOT NULL DEFAULT 0',
            'created_at' => Schema::TYPE_INTEGER . ' NOT NULL',
            'updated_at' => Schema::TYPE_INTEGER . ' NOT NULL',
            'lat' => Schema::TYPE_FLOAT. '',
            'long' => Schema::TYPE_FLOAT. '',

        ], $tableOptions);

        $this->createTable('img', [
            'id' => Schema::TYPE_PK,
            'model_id' => Schema::TYPE_INTEGER . ' NOT NULL',
            'model_type' => Schema::TYPE_SMALLINT . ' NOT NULL',
            'user_id' => Schema::TYPE_INTEGER. ' NOT NULL',
            'info' => Schema::TYPE_TEXT,
            'status' => Schema::TYPE_SMALLINT . ' NOT NULL DEFAULT 0',
            'created_at' => Schema::TYPE_INTEGER . ' NOT NULL',
            'updated_at' => Schema::TYPE_INTEGER . ' NOT NULL',
            'lat' => Schema::TYPE_FLOAT. ' NOT NULL',
            'long' => Schema::TYPE_FLOAT. ' NOT NULL',
            'name' => Schema::TYPE_STRING. '(255) NOT NULL',
            'ext' => Schema::TYPE_STRING. '(32) NOT NULL',
            'size' => Schema::TYPE_INTEGER. ' NOT NULL',

        ], $tableOptions);
    }

    public function down()
    {
        echo "m141011_204034_mail_comm cannot be reverted.\n";

        return false;
    }
}
