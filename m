Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56AF3C433ED
	for <linux-cxl@archiver.kernel.org>; Wed, 31 Mar 2021 16:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A40661029
	for <linux-cxl@archiver.kernel.org>; Wed, 31 Mar 2021 16:05:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbhCaQFD (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 31 Mar 2021 12:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232301AbhCaQEm (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 31 Mar 2021 12:04:42 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F26CC061574
        for <linux-cxl@vger.kernel.org>; Wed, 31 Mar 2021 09:04:42 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id jy13so30893380ejc.2
        for <linux-cxl@vger.kernel.org>; Wed, 31 Mar 2021 09:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/K8jhwDcWdtQO8TgpjZZoFEiAtw8FI9cBvy1a1rTDN8=;
        b=n98YQxI+8gd6h3kZzKYrEF739lerNLf9t8oyCoS2TJyNMaNFL6UJhBu/UuusrT4qiF
         4IiTkSg4USBePHxB+IYW/b9H74TqaoiTSLaPyMsY58DnwNmx1m2p2nInVBop5vaFoFqF
         1gTDhuJ2bUKv3YWP0erWmiFTAGXG7WuKr01VIR8J6Mn3aR9e3BW4qHcpjTLr/2rJ1hOy
         /SaZ0obFL7QqVEpsM0+l+1cNkCBrcElevYRJokNDUp0KeLWBDXbm2uBLsx7+M6U6K9Ar
         IJMgFpN0v9+iBI3vNt5IqaYv+CspHhLfbmjIrqkJzx+nLicb0UeJ3uECqj3eL39YZV+a
         2PNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/K8jhwDcWdtQO8TgpjZZoFEiAtw8FI9cBvy1a1rTDN8=;
        b=H82gwqqN01k6ll1Pk1+lI3Akk12grg1YkMfa7kMxG7wKRuFOeUq+Gi4bPLcUbVfgM2
         GNy58Sh+DeI3TEMmEIYr+0NpiFb1od2DzDnj+NNoyZkam3UzLKAnUZEjwC4Op1ecN+pY
         8WGSj+U4B30vApvRvlhC06Oc1SdmC4r56JyMEw/q1qf1W/zHFmLq8R7D5U/GwMm0oLOA
         NHfQ37FubKjcbIruLTVkGfDeskHoTPXCK/BKIenXuRCxfX46+FQURe1fQ90kcSQJ1hfl
         +cOOcuafXqyXsZt4EJnMF4pAai1+q8mZ4pQz7+lhCZcNmzviaMxRl5uorzsiiJs87n/B
         bj/Q==
X-Gm-Message-State: AOAM533m3W1BtxKagzBsaHPoEVmUJvdgxBRMqfthCFDCYIqnhfNaAF1n
        Ej8zR6DQg7hxTiw5+zWtjjFuwthjFRX/ETpiKllPwg==
X-Google-Smtp-Source: ABdhPJx2vS46/Y5jbwBa9EENsyxfekhK0CyN/G/O6mqN+sRR/ycmUklyCtiEkx+kxNfBjLDHmIy1v6PK0IqgLLQq6+4=
X-Received: by 2002:a17:906:ae88:: with SMTP id md8mr4161716ejb.264.1617206681177;
 Wed, 31 Mar 2021 09:04:41 -0700 (PDT)
MIME-Version: 1.0
References: <161714738634.2168142.10860201861152789544.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161714740233.2168142.11116065966198937093.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20210331130953.GG1463678@nvidia.com>
In-Reply-To: <20210331130953.GG1463678@nvidia.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 31 Mar 2021 09:04:32 -0700
Message-ID: <CAPcyv4inZaSRk-eiyeRLfUOrwyD=YVLW6bdUVJ239X099n1S=Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] cxl/mem: Do not rely on device_add() side effects
 for dev_set_name() failures
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-cxl@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Mar 31, 2021 at 6:10 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Tue, Mar 30, 2021 at 04:36:42PM -0700, Dan Williams wrote:
> > +static int cxl_mem_add_memdev(struct cxl_mem *cxlm)
> > +{
> > +     struct cxl_memdev *cxlmd;
> > +     struct device *dev;
> > +     struct cdev *cdev;
> > +     int rc;
> > +
> > +     cxlmd = cxl_memdev_alloc(cxlm);
> > +     if (IS_ERR(cxlmd))
> > +             return PTR_ERR(cxlmd);
> > +
> > +     dev = &cxlmd->dev;
> > +     rc = dev_set_name(dev, "mem%d", cxlmd->id);
> > +     if (rc)
> > +             goto err;
> >
> > +     cdev = &cxlmd->cdev;
> >       cxl_memdev_activate(cxlmd, cxlm);
> >       rc = cdev_device_add(cdev, dev);
> >       if (rc)
> > -             goto err_add;
> > +             goto err;
>
> It might read nicer to have the error unwind here just call cxl_memdev_unregister()

Perhaps, but I don't think cdev_del() and device_del() are prepared to
deal with an object that was not successfully added.

>
> > -     return devm_add_action_or_reset(&pdev->dev, cxl_memdev_unregister,
> > +     return devm_add_action_or_reset(dev->parent, cxl_memdev_unregister,
> >                                       cxlmd);
>
> Since that is what the error unwind does at this point.

Right, but at this point the code knows that cdev_del() and
device_del() will receive an object in the appropriate state.

>
> >
> > -err_add:
> > +err:
> >       /*
> >        * The cdev was briefly live, shutdown any ioctl operations that
> >        * saw that state.
> >        */
> >       cxl_memdev_shutdown(cxlmd);
>
> Then this doesn't need to be a function
>
> But it is OK as is

Unless I'm missing something I think it's required to use only
put_device() to cleanup after cdev_device_add() failure, but yes I
don't like that cxl_memdev_shutdown() needs to be open coded like
this.

>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Appreciate it.
