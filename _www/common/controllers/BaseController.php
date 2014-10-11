<?php
namespace common\controllers;

use Yii;
use yii\web\Controller;
/**
 * Site controller
 */
class BaseController extends Controller
{

    public function render($view, $params = [])
    {
        return parent::render($view, $params);
    }

    public function goHome()
    {
        return parent::goHome();
    }

}
