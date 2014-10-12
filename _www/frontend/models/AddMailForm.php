<?php
namespace frontend\models;

use common\models\Mail;
use common\models\User;
use yii\base\Model;
use yii\web\UploadedFile;
use Yii;

/**
 * Signup form
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
class AddMailForm extends Model
{
    public $mess;
    public $images;
    public $lat;
    public $long;
    public $cost;
    public $timeout = Mail::TIMEOUT_DEFAULT;

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            ['mess', 'required'],
            ['mess', 'string', 'min' => 6, 'max' => 5000],

            ['timeout', 'default', 'value' => Mail::TIMEOUT_DEFAULT],
            ['timeout', 'in', 'range' => array_keys(Mail::$enum_timeout)],

            [['images'], 'file', 'extensions' => 'gif, jpg, png', 'maxFiles'=>3],
        ];
    }

    /**
     * Signs user up.
     *
     * @return Mail|null the saved model or null if saving fails
     */
    public function addNewMail()
    {
        $images = UploadedFile::getInstances($this, 'images');
        if ($this->validate()) {
            $model = new Mail();
            $model->user_id = Yii::$app->getUser()->id;
            $model->mess = $this->mess;
            $model->timeout = $this->timeout;
            $model->timeout2 = MAIL::TIMEOUT2_DEFAULT;
            $model->to_user_id = null;
            $model->to_email = null;
            $model->to_lat = null;
            $model->to_long = null;
            $model->has_video = null;
            if ($images && count($images)) {
                $model->has_img = true;
            }
            $model->setScenario(Mail::SCENARIO_ADD);
            if($model->save()) {
                return $model;
                if ($images) {
                    exit('TODO - save IMAGE');
//                    $this->images->saveAs('uploads/img/' . $model->id . '.' . $this->images->extension);
//                    foreach ($files as $file) {
//
//                        $_model = new UploadForm();
//
//                        $_model->file = $file;
//
//                        if ($_model->validate()) {
//                            $_model->file->saveAs('uploads/' . $_model->file->baseName . '.' . $_model->file->extension);
//                        } else {
//                            foreach ($_model->getErrors('file') as $error) {
//                                $model->addError('file', $error);
//                            }
//                        }
//                    }
//
//                    if ($model->hasErrors('file')){
//                        $model->addError(
//                            'file',
//                            count($model->getErrors('file')) . ' of ' . count($files) . ' files not uploaded'
//                        );
//                    }
                }
            }
            return $model;
        }

        return $this;
    }
}
