Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37788C2B9F4
	for <linux-cxl@archiver.kernel.org>; Fri, 18 Jun 2021 00:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A945610CD
	for <linux-cxl@archiver.kernel.org>; Fri, 18 Jun 2021 00:34:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbhFRAgM (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 17 Jun 2021 20:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231695AbhFRAgL (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 17 Jun 2021 20:36:11 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704B2C061574
        for <linux-cxl@vger.kernel.org>; Thu, 17 Jun 2021 17:34:03 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id m13-20020a17090b068db02901656cc93a75so7076123pjz.3
        for <linux-cxl@vger.kernel.org>; Thu, 17 Jun 2021 17:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sBsI0Ga/NN/KtPk3dFWux6YWuZKnUPLZvZ+6gM/PS/k=;
        b=CFp1kzPh0m3TmTEgKe0/u6vqqhBn9yCDvETyLpMWpVIjkcIlsalJ3HDcBwnAQA+Ef9
         eV1Ce7fWdb9QQwUn33WysCNd6rEOcw2F0kA10YDzatWDgW7bu3wHdo3YiRAKdQ73e+qS
         p4b9wj9qRnsBd1neJWciGUR5AUxuCyFNZgXc+6/JLrDaOA/RPGK9+JLxq71saEWCSDMI
         NjmcLNbITgTlrdIOReT0M9z+xOw37ZCV2xvm0U/a84VlZJidcqkfOnk50iPg019SlAfn
         +cB/MPft/yUPSZt+IyYhnzkvQL3MmSk58owYYfGu/FSJ4QOSQPaUkVDABkGyW73UPGPR
         z4mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sBsI0Ga/NN/KtPk3dFWux6YWuZKnUPLZvZ+6gM/PS/k=;
        b=fnLfqh1fzIO+6rqzW8ieaaFuYm+Mr+AzsITG/04nLYFuHFUxTiQcA5I0iOhaLz0mn4
         lqTuSWmowj4rRLC/hJa9hBichBbs6Wx68LuTQb3ZFl8vXiSnToLawYUFQeaxy8FGnFGV
         NjR7+hf3KB/CIMbzjLjOifolkJFCCZmR7ON9l0pfNSFnt9xdUFpAdMF5cwcWU2ln1OsG
         IEB6cjVEN7GjX8vPXppxgWNFDKtbyYCalfMoaEBDo8DRCTtsHPU+rwU+xEKPH5VfcUS7
         Ilu3XmjufOOqfCFbSFqhiN9Qk6nxRSvqfEspxji+Romiv+LJmmmzQqfhrupWErceuXVU
         nLTA==
X-Gm-Message-State: AOAM533tETXUW9VGUMPP4OAhn1SNs1JLnmzL7tRVmGJOjfJvICHTOQpC
        1Spm015ySinRXD4FmEotHKIrcmMHaSSTnZ8DmIm+NmKFeHg=
X-Google-Smtp-Source: ABdhPJzjPJ8/NR2clBU6h8w0rhS1X5AGMoZGk7STSxiO/Z7LqjG/UeuiEku4dRaJE4AgJ0tdXIXt5FB4tBNVNl5o8PQ=
X-Received: by 2002:a17:90a:fc88:: with SMTP id ci8mr19250803pjb.13.1623976443076;
 Thu, 17 Jun 2021 17:34:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210618003009.956929-1-ben.widawsky@intel.com>
In-Reply-To: <20210618003009.956929-1-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 17 Jun 2021 17:33:52 -0700
Message-ID: <CAPcyv4jE5FPVH1+Gv+QzV2GF+piypCBvc5CTe6ZakdjXEZMCkQ@mail.gmail.com>
Subject: Re: [PATCH] cxl/pci: Rename CXL REGLOC ID
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Jun 17, 2021 at 5:30 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> The current naming is confusing and wrong. The Register Locator is
> identified by the DSVSEC identifier, not an offset.
>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>

LGTM.
