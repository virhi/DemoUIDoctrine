<?php
/**
 * Created by PhpStorm.
 * User: virhi
 * Date: 11/07/2014
 * Time: 19:48
 */

namespace Virhi\DomainBundle\Entity;


class Entity
{
    protected $id;

    /**
     * @param mixed $id
     */
    public function setId($id)
    {
        $this->id = $id;
    }

    /**
     * @return mixed
     */
    public function getId()
    {
        return $this->id;
    }

}