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
 * @property float $to_lat
 * @property float $to_long
 * @property integer $created_at
 * @property integer $updated_at
 * @property integer $status
 * @property integer $timeout
 * @property integer $timeout2
 * @property integer $cost
 */
class Mail extends ActiveRecord
{
    // Статус письма
    const STATUS_NO_PAY = 0;
    const STATUS_NEW = 1;
    const STATUS_SEND = 2;
    const STATUS_OK = 3;

    const PAY_MIN = 30; // руб
    const TIMEOUT2_DEFAULT = 604800; // руб
    const TIMEOUT_DEFAULT = 31536000; // руб

    const SCENARIO_ADD = 'insert';

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

    public function rules()
    {
        return [
            [
                ['user_id','mess','has_img','timeout','timeout2','status','has_img','has_video','to_user_id','to_email','to_lat','to_long'],
                'safe', 'on' => self::SCENARIO_ADD],
        ];
    }

    public function getDataInfo()
    {
        $data = [
            'id' => $this->id,
            'mess' => $this->mess,
            'images' => $this->getImages(),
            'status' => $this->status,
            'cost' => $this->cost,
            'created_at' => $this->created_at,
            'timeout' => $this->timeout,
            'url_mail_pay' => \common\controllers\BaseController::URL_MAIL_PAY.$this->id,
            'need_pay' => (!$this->cost ? true : false)
        ];
        return $data;
    }
}
