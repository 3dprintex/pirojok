<?php
/* @var $this yii\web\View */
$data = [
    'status' => common\controllers\BaseController::MOB_STATUS_UNAUTH,
    'form' => [
        '_csrf' => \Yii::$app->request->getCsrfToken()
    ]
];
echo \yii\helpers\Json::encode($data);