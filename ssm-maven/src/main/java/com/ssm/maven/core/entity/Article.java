package com.ssm.maven.core.entity;

import java.io.Serializable;

public class Article implements Serializable {
    private String id;
    private String articleTitle;
    private String articleCreateDate;
    private String articleContent;
    private int articleClassID;
    private int isTop;
    private String addName;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getArticleTitle() {
        return articleTitle;
    }

    public void setArticleTitle(String articleTitle) {
        this.articleTitle = articleTitle;
    }

    public String getArticleCreateDate() {
        return articleCreateDate;
    }

    public void setArticleCreateDate(String articleCreateDate) {
        this.articleCreateDate = articleCreateDate;
    }

    public String getArticleContent() {
        return articleContent;
    }

    public void setArticleContent(String articleContent) {
        this.articleContent = articleContent;
    }

    public int getArticleClassID() {
        return articleClassID;
    }

    public void setArticleClassID(int articleClassID) {
        this.articleClassID = articleClassID;
    }

    public int getIsTop() {
        return isTop;
    }

    public void setIsTop(int isTop) {
        this.isTop = isTop;
    }

    public String getAddName() {
        return addName;
    }

    public void setAddName(String addName) {
        this.addName = addName;
    }

    @Override
    public String toString() {
        return "Article{" +
                "id='" + id + '\'' +
                ", articleTitle='" + articleTitle + '\'' +
                ", articleCreateDate='" + articleCreateDate + '\'' +
                ", articleContent='" + articleContent + '\'' +
                ", articleClassID=" + articleClassID +
                ", isTop=" + isTop +
                ", addName='" + addName + '\'' +
                '}';
    }
}
