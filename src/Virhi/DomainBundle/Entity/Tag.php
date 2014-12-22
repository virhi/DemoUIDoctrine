<?php
/**
 * Created by PhpStorm.
 * User: virhi
 * Date: 11/07/2014
 * Time: 21:03
 */

namespace Virhi\DomainBundle\Entity;


class Tag extends Entity
{
    protected $titre;

    protected $description;

    public function __toString()
    {
        return $this->titre;
    }

    /**
     * @param mixed $description
     */
    public function setDescription($description)
    {
        $this->description = $description;
    }

    /**
     * @return mixed
     */
    public function getDescription()
    {
        return $this->description;
    }

    /**
     * @param mixed $titre
     */
    public function setTitre($titre)
    {
        $this->titre = $titre;
    }

    /**
     * @return mixed
     */
    public function getTitre()
    {
        return $this->titre;
    }

}