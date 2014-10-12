<?php
namespace frontend\controllers;

use common\models\Mail;
use Yii;
use frontend\models\AddMailForm;

/**
 * Site controller
 */
class MailController extends \common\controllers\BaseController
{
    /**
     * @inheritdoc
     */
//    public function behaviors()
//    {
//        return [
//            'access' => [
//                'class' => AccessControl::className(),
//                'only' => ['logout', 'signup', 'login'],
//                'rules' => [
//                    [
//                        'actions' => ['signup', 'login'],
//                        'allow' => true,
//                        'roles' => ['?'],
//                    ],
//                    [
//                        'actions' => ['logout'],
//                        'allow' => true,
//                        'roles' => ['@'],
//                    ],
//                ],
//            ],
//            'verbs' => [
//                'class' => VerbFilter::className(),
//                'actions' => [
//                    'logout' => ['post'],
//                ],
//            ],
//        ];
//    }

    /**
     * @inheritdoc
     */
    public function beforeAction($action)
    {
        if (\Yii::$app->user->isGuest) {
            if ($this->isMobileApp()) {
                return $this->mobileAuthStatus();
            }
            return $this->goHome();
        }
        return parent::beforeAction($action);
    }

    public function actionIndex()
    {
        return $this->render('index');
    }

    public function actionAdd()
    {
        $model = new AddMailForm();
        try {
            if ($model->load(Yii::$app->request->post())) {
                $mail = $model->addNewMail();
                if (!$mail->hasErrors()) {
                        return $this->goPayForMail($mail);
                }
                elseif ($this->isMobileApp()) {
                    return $this->mobileErrorStatus($mail->getErrors());
                }
            }
        } catch (\Exception $e) {
            if ($this->isMobileApp()) {
                return $this->mobileErrorStatus($e->getMessage());
            }
            else {
                throw $e;
            }
        }

        return $this->render('add_mail', [
            'model' => $model,
        ]);
    }


    public function actionPay($id)
    {
        $model = Mail::findOne(['id'=>(int) $id]);
        return $this->render('pay', ['model' => $model]);
    }

}
