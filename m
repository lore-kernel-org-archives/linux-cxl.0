Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E895C4338F
	for <linux-cxl@archiver.kernel.org>; Mon,  2 Aug 2021 16:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B38D60F9C
	for <linux-cxl@archiver.kernel.org>; Mon,  2 Aug 2021 16:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbhHBQPb (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 2 Aug 2021 12:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbhHBQPa (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 2 Aug 2021 12:15:30 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBD5C06175F
        for <linux-cxl@vger.kernel.org>; Mon,  2 Aug 2021 09:15:21 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id mt6so25910771pjb.1
        for <linux-cxl@vger.kernel.org>; Mon, 02 Aug 2021 09:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=85SPVNaGae7zzS81+9DZlDiLyvnOSNynfojfJF/PFsw=;
        b=0Lc/PTTLm91h9UW4+PvaSKmS6QeHVvtb0pMPx0QRPXnrQ0hXOPX9YL5ePzeVkOZ838
         JuG+zbWP2K5AGeLhjwTW6OhW4YfyffS/IHZQmxTX+qImbGuAzbL/qfW3Q7r3AjzEieqR
         pjBKwIsT2qNCHOme618LX+P8jjafJSUBK8/l5pLPqePL5Rdns6QcZrbD+46wd+vVmIHg
         1X5MEZzMq8bXpWMB/D9s5p11LlKUremd0sGl7Kje9u0oDVMqFrWd4ORwaursRDgcQcxz
         gJVl6JRnzyaEMybPFxlsxjHPD1CrMesG166FP/PuiZiLIIPf6vjkbZ11emsopXXoyNIB
         itYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=85SPVNaGae7zzS81+9DZlDiLyvnOSNynfojfJF/PFsw=;
        b=IYQrtHIv+Fqak30rRDCXTHnL6H3VrD3+TuXbaIn6aU8RHAhWQkJ30yRvcit15GyIMl
         PlXDAiUtt6VOaigwfZmNjyP8O0tO2j4MZ5UwBOz8g6AiBbOPSEC6u9Br8/7Rqq7l0Xhe
         dA7+1z/elRIEqSDp//LMsDRsd7DGxJa548ZdbDxVI/r5AA+uQONDicZLrU22fRNlKiaZ
         Gf6e7E2pM96bgT1Ak0IOwNDU1FNwOHA0EVxm5fcS57iFghsxb0LRnbmSM9Qk93QZ4zcS
         1dUbQMKNEMXEDw5HCTY1oPtdvaT+8eAZfQ36Iouvp9fC2AkMXrUTaDSziuz4KkTX0zCY
         CZ1w==
X-Gm-Message-State: AOAM532buFpyzxzGWwGgPDsgz2snd/tETiYfL8l0imaIAKMs1zi4L5xt
        kOgqCTTvLlo3kAOEEo8a0BQGbw1I6Iq/ZF3Tlwaltw==
X-Google-Smtp-Source: ABdhPJyITXcH4thWc1ZRlCcIKFNnJ+fo45vO+Xpg6+QeVjgvthyCms9Tl7mpgxUmy8kvgBudtqoMUt1CvDdUXYSDUlk=
X-Received: by 2002:a17:90a:1196:: with SMTP id e22mr17840021pja.168.1627920920862;
 Mon, 02 Aug 2021 09:15:20 -0700 (PDT)
MIME-Version: 1.0
References: <162767561501.3322476.716972045397140827.stgit@dwillia2-desk3.amr.corp.intel.com>
 <162767564242.3322476.16483313353240361673.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20210802160424.0000641b@Huawei.com>
In-Reply-To: <20210802160424.0000641b@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 2 Aug 2021 09:15:10 -0700
Message-ID: <CAPcyv4jyNGrTDG=XGyqYtaCr+gLDjqUnmySD3zTiiTrNfwc51g@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] cxl/pci: Introduce cdevm_file_operations
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Aug 2, 2021 at 8:05 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Fri, 30 Jul 2021 13:07:22 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
>
> > In preparation for moving cxl_memdev allocation to the core, introduce
> > cdevm_file_operations to coordinate file operations shutdown relative to
> > driver data release.
> >
> > The motivation for moving cxl_memdev allocation to the core (beyond
> > better file organization of sysfs attributes in core/ and drivers in
> > cxl/), is that device lifetime is longer than module lifetime. The cxl_pci
> > module should be free to come and go without needing to coordinate with
> > devices that need the text associated with cxl_memdev_release() to stay
> > resident. The move will fix a use after free bug when looping driver
> > load / unload with CONFIG_DEBUG_KOBJECT_RELEASE=y.
> >
> > Another motivation for passing in file_operations to the core cxl_memdev
> > creation flow is to allow for alternate drivers, like unit test code, to
> > define their own ioctl backends.
> >
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>
> Hi Dan / Ben,
>
> One utterly trivial question inline, otherwise looks good.
>
> > ---
> >  drivers/cxl/mem.h |   15 ++++++++++++
> >  drivers/cxl/pci.c |   65 +++++++++++++++++++++++++++++++----------------------
> >  2 files changed, 53 insertions(+), 27 deletions(-)
> >
> > diff --git a/drivers/cxl/mem.h b/drivers/cxl/mem.h
> > index 8f02d02b26b4..77f4411c7c6a 100644
> > --- a/drivers/cxl/mem.h
> > +++ b/drivers/cxl/mem.h
> > @@ -34,6 +34,21 @@
> >   */
> >  #define CXL_MEM_MAX_DEVS 65536
> >
> > +/**
> > + * struct cdevm_file_operations - devm coordinated cdev file operations
> > + * @fops: typical file operations
>
> Why typical? Seems that simply saying "file operations" conveys the same
> information.  What is atypical here?

Hmm, I was thinking the need for an extra shutdown operation is
"atypical", but you're right this description does not add anything.
I'll change it too:

@fops: file operations that are synchronized against @shutdown
