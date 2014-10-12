<?php
use yii\helpers\Html;
use yii\bootstrap\ActiveForm;

/* @var $this yii\web\View */
/* @var $form yii\bootstrap\ActiveForm */
/* @var $model \frontend\models\SignupForm */

$this->title = 'Pay for mail';
$this->params['breadcrumbs'][] = $this->title;
$successURL = '';
$pay_id = Yii::$app->payment->id;
$amount = 30;
$target = 'test';
?>
<iframe frameborder="0" allowtransparency="true" scrolling="no" src="https://money.yandex.ru/embed/shop.xml?account=<?=$pay_id?>&quickpay=shop&payment-type-choice=on&writer=seller&targets=<?=$target?>&targets-hint=&default-sum=<?=$amount?>&button-text=01&mail=on&successURL=<?=$successURL?>" width="450" height="198"></iframe>
