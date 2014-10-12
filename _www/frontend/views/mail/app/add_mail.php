<?php
/* @var $this yii\web\View */
$data = [
    'status' => common\controllers\BaseController::MOB_STATUS_UNAUTH,
    'form' => [
        \Yii::$app->request->csrfParam => \Yii::$app->request->getCsrfToken(),
        'signup-button' => true,
    ]
];
echo \yii\helpers\Json::encode($data);