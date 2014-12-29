<?php
/**
 * Created by PhpStorm.
 * User: virhi
 * Date: 28/12/14
 * Time: 16:44
 */

namespace Virhi\DomainBundle\Entity;


class Data extends Entity
{
    protected $titre;

    /**
     * @return mixed
     */
    public function getTitre()
    {
        return $this->titre;
    }

    /**
     * @param mixed $titre
     */
    public function setTitre($titre)
    {
        $this->titre = $titre;
    }

}