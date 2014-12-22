<?php
/**
 * Created by PhpStorm.
 * User: virhi
 * Date: 11/07/2014
 * Time: 20:06
 */

namespace Virhi\DomainBundle\Entity;


class Post extends Entity
{
    protected $titre;

    protected $sousTitre;

    protected $description;

    protected $post;

    protected $tags;

    /**
     * @param mixed $post
     */
    public function setPost($post)
    {
        $this->post = $post;
    }

    /**
     * @return mixed
     */
    public function getPost()
    {
        return $this->post;
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
     * @param mixed $sousTitre
     */
    public function setSousTitre($sousTitre)
    {
        $this->sousTitre = $sousTitre;
    }

    /**
     * @return mixed
     */
    public function getSousTitre()
    {
        return $this->sousTitre;
    }

    /**
     * @param mixed $tags
     */
    public function setTags($tags)
    {
        $this->tags = $tags;
    }

    /**
     * @return mixed
     */
    public function getTags()
    {
        return $this->tags;
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