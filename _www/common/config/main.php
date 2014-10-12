<?php
return [
    'vendorPath' => dirname(dirname(__DIR__)) . '/vendor',
    'components' => [
        'cache' => [
            'class' => 'yii\caching\FileCache',
        ],

        'payment' => [
            'class' => 'app\compot\Payment',
            'name' => 'pirojok',
            'token' => 'D5E5420AB98C1E33331F14E18AD9A320DB092BC63D467788B8649B3E2B2FC0AA',
            'id' => '4100198176118',
        ],
    ],
];
