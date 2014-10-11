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

    public function getUserObject() {
        return \common\models\User::findIdentity(Yii::$app->getUser()->id);
    }
}
