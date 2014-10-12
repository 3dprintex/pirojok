<?php
namespace common\models;

use Yii;
use yii\behaviors\TimestampBehavior;
use yii\db\ActiveRecord;

/**
 * User model
 *
 * @property integer $id
 * @property integer $user_id
 * @property integer $to_user_id
 * @property integer $status
 * @property string $mess
 * @property bool $has_img
 * @property bool $has_video
 * @property float $lat
 * @property float $long
 * @property integer $created_at
 * @property integer $updated_at
 */
class MailComm extends ActiveRecord
{
    // Статус письма
    const STATUS_NEW = 0;
    const STATUS_SEND = 1;
    const STATUS_READY = 2;

    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'mail_comm';
    }

    /**
     * @inheritdoc
     */
    public function behaviors()
    {
        return [
            TimestampBehavior::className(),
        ];
    }
}
