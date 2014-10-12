<?php
namespace common\controllers;

use Yii;
use yii\helpers\Json;
use yii\web\Controller;
/**
 * Site controller
 */
class BaseController extends Controller
{
    const MOB_STATUS_AUTH = 'auth';
    const MOB_STATUS_UNAUTH = 'unauth';
    const MOB_STATUS_ERROR = 'error';
    const MOB_STATUS_SUCCESS = 'success';

    const URL_MAIL_PAY = '/mail/pay/';

    public static $sessionDuration = 99999999;

    public function beforeAction($action)
    {
        return parent::beforeAction($action);
    }

    public function render($view, $params = [])
    {
        if ($this->isMobileApp()) {
            try {
                $this->layout = 'api';
                return parent::render('app/'.$view, $params);
            }
            catch (\Exception $e) {
            }
        }
        return parent::render($view, $params);
    }

    public function goHome()
    {
        if ($this->isMobileApp()) {
            return '';
        }
        return parent::goHome();
    }

    public function goBack($defaultUrl = NULL)
    {
        if ($this->isMobileApp()) {
            return '';
        }
        return parent::goBack($defaultUrl);
    }

    public function isMobileApp() {
//        return true;
        if (strpos($_SERVER['HTTP_USER_AGENT'], 'Pirojok')!==false) {
            return true;
        }
        return false;
    }

    public function mobileAuthStatus() {
        $userData = $this->getUserObject();

        $data = [
            'status' => self::MOB_STATUS_AUTH,
            'user' => [
                'name' => $userData->username,
                'email' => $userData->email,
                'lastdate' => $userData->updated_at,
            ]
        ];
        return Json::encode($data);
    }

    public function mobileUnAuthStatus($mess) {
        $data = [
            'status' => self::MOB_STATUS_UNAUTH,
            'desc' => $mess
        ];
        return Json::encode($data);
    }


    public function mobileOkStatus($data) {
        $data = [
            'status' => self::MOB_STATUS_SUCCESS,
            'data' => $data
        ];
        return Json::encode($data);
    }


    public function mobileErrorStatus($mess) {
        $data = [
            'status' => self::MOB_STATUS_ERROR,
            'desc' => $mess
        ];
        return Json::encode($data);
    }

    public function getUserObject() {
        return \common\models\User::findIdentity(Yii::$app->getUser()->id);
    }


    /**
     * @param $mail \common\models\Mail
     * @return string|array
     */
    public function goPayForMail(\common\models\Mail $mail)
    {
        if ($this->isMobileApp()) {
            $data = $mail->getDataInfo();
            return $this->mobileOkStatus($data);
        }
        return Yii::$app->getResponse()->redirect(self::URL_MAIL_PAY.$mail->id);
    }
}
