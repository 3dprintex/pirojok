<?php
use yii\helpers\Html;
use yii\bootstrap\ActiveForm;

/* @var $this yii\web\View */
/* @var $form yii\bootstrap\ActiveForm */
/* @var $model \frontend\models\SignupForm */

$this->title = 'Add mail';
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="site-signup">
    <h1><?= Html::encode($this->title) ?></h1>

    <p>Here must be rule</p>

    <div class="row">
        <div class="col-lg-5">
            <?php
            if ($model->hasErrors()) { //it is necessary to see all the errors for all the files.
                echo '<pre>';
                print_r($model->getErrors());
                echo '</pre>';
            }
            ?>
            <?php $form = ActiveForm::begin(['id' => 'form-mail-add','options' => ['enctype' => 'multipart/form-data']]); ?>
                <?= $form->field($model, 'mess') ?>

                <?= $form->field($model, 'timeout')->dropDownList(\common\models\Mail::$enum_timeout) ?>

                <?= $form->field($model, 'images[]')->fileInput(['multiple' => '']) ?>
                <div class="form-group">
                    <?= Html::submitButton('Create', ['class' => 'btn btn-primary', 'name' => 'send-button']) ?>
                </div>
            <?php ActiveForm::end(); ?>
        </div>
    </div>
</div>
