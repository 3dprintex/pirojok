<?php
namespace common\models;

use Yii;
use yii\behaviors\TimestampBehavior;
use yii\db\ActiveRecord;

/**
 * User model
 *
 * @property integer $id        pk
 * @property integer $user_id
 * @property string $mess
 * @property bool $has_img
 * @property bool $has_video
 * @property integer $to_user_id
 * @property string $to_email
 * @property float $to_geo_lat
 * @property float $to_geo_long
 * @property integer $created_at
 * @property integer $updated_at
 * @property integer $status
 * @property integer $timeout
 * @property integer $cost
 */
class Mail extends ActiveRecord
{
    // Статус письма
    const STATUS_NEW = 0;
    const STATUS_SEND = 1;
    const STATUS_READY = 2;

    // Время жизни письма
    public static $enum_timeout = [
        604800 => 'неделя',
        18748800 => 'месяц',
        112492800 => '6 месяцев',
        31536000 => 'год',
        0 => 'навсегда',
    ];

    // Время в течении которого должно произойти хотябы одна передача
    public static $enum_timeout2 = [
        86400 => 'день',
        604800 => 'неделя',
        18748800 => 'месяц',
        112492800 => '6 месяцев',
    ];
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'mail';
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
