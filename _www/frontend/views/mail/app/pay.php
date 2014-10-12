<?php
/* @var $this yii\web\View */
$data = [
    'status' => common\controllers\BaseController::MOB_STATUS_AUTH,
    'form' => [
        \Yii::$app->request->csrfParam => \Yii::$app->request->getCsrfToken(),
        'send-button' => true,
    ]
];
echo \yii\helpers\Json::encode($data);