Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30853C4338F
	for <linux-cxl@archiver.kernel.org>; Wed, 11 Aug 2021 17:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02FDD6104F
	for <linux-cxl@archiver.kernel.org>; Wed, 11 Aug 2021 17:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbhHKRmj (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 11 Aug 2021 13:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbhHKRmi (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 11 Aug 2021 13:42:38 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18C8C061765
        for <linux-cxl@vger.kernel.org>; Wed, 11 Aug 2021 10:42:14 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id j1so4682480pjv.3
        for <linux-cxl@vger.kernel.org>; Wed, 11 Aug 2021 10:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IeNL9bjLZPrc6ii1+wc5VLScUfw86O349rFJBfezm/U=;
        b=xxheOztLd5to3QQ4b3JGrhLNwLiFu3lw953AppxJjNnbNfmb0CShHtylW/M2D61atI
         NDDlwlZsLFQdzo4v79tPbwI2n5Y1e9Cl8aVn55+8bh33JijRBEuQOMJqK8PojUywpTRS
         8w0Usjpv8J1tAEK53R6Q0hnaK+NsXul+/i1pUowngyFS0LTN9NXq0r2MJNCFyV/Idxq2
         T6fEDVg/LYu9zGwLzqDOSoAO9URZw/6ZjyShVhnWF+egOl7fa9LU7X9Q8ogXER53kPIs
         IseiFodVf0g8r+diWTWoYvzFl8FqyL0wnKxXk9zI2DSfrpPdsIttSGj+oYe+XWhGAURF
         Gzsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IeNL9bjLZPrc6ii1+wc5VLScUfw86O349rFJBfezm/U=;
        b=d1nz70acAphwrBig4TOhrfMIZBMsiRiQEGP58UROHBR+gTYiLut1v99v46aCBEl+IS
         4jccPk8C4vsKDxp8xQKPnAFhNPy27Eo3Nu975FLJw6TOMGsUOsyoEI1ACSWULbw2dqHZ
         t8FVXGX4P4cly9njMh1WQPeoBQI/ZFACy7H2su4H4Bpe7+O0VdXBJIOx3dJJOZ0V/1Qv
         O5TGTJM785nNYsCLC/AegtKIlBPJfO0KWsJ92HIN0Tv5WxMGPnVZ90DtAxk9I+gQYT/4
         vJ8I8nyKdOkZqwFKoWhD45YMUMqCV5v9gRm8uzs9sGmW0tp8gqsAQdaSqFqb36aWxxZ4
         0bZA==
X-Gm-Message-State: AOAM531Ht4Xqj62kvAxbIrVsyNvfNOsCx/iBI6A727qACdeKFbT30WlF
        J/bkJUPDku1bAVKJq/08gx+tYrDEzgL7rXelAv2ZPQ==
X-Google-Smtp-Source: ABdhPJw0MUexdq/nOVxQIMcZ0NqIOkg9tKnb0+pvNmqBdO+XZaFDnqiLD0cE9FqIyjrX8f+Tt6WDCjRMCZnCviSX7zA=
X-Received: by 2002:a63:3c7:: with SMTP id 190mr73332pgd.240.1628703734293;
 Wed, 11 Aug 2021 10:42:14 -0700 (PDT)
MIME-Version: 1.0
References: <162854806653.1980150.3354618413963083778.stgit@dwillia2-desk3.amr.corp.intel.com>
 <162854808363.1980150.11628345983283480967.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20210811182706.00003bee@Huawei.com>
In-Reply-To: <20210811182706.00003bee@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 11 Aug 2021 10:42:03 -0700
Message-ID: <CAPcyv4iYa2FqW0V3k+Tt=SRJCBYhe6qCkTupwveGQCmvYucjYA@mail.gmail.com>
Subject: Re: [PATCH 03/23] libnvdimm/labels: Introduce label setter helpers
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, Linux NVDIMM <nvdimm@lists.linux.dev>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Aug 11, 2021 at 10:27 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Mon, 9 Aug 2021 15:28:03 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
>
> > In preparation for LIBNVDIMM to manage labels on CXL devices deploy
> > helpers that abstract the label type from the implementation. The CXL
> > label format is mostly similar to the EFI label format with concepts /
> > fields added, like dynamic region creation and label type guids, and
> > other concepts removed like BLK-mode and interleave-set-cookie ids.
> >
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>
> Hi Dan,
>
> Only thing on this patch is whether it might be better to put get /set pairs
> together rather than all the get functions, then all the set functions?
>
> If looking at this code in future it would make it a little easier to quickly
> see they are match pairs.

Sure, easy to do.

>
> Your code though, so if you prefer it like this, I don't really care!
>
> Fine either way with me.
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> > ---
> >  drivers/nvdimm/label.c          |   61 +++++++++++++++++------------------
> >  drivers/nvdimm/namespace_devs.c |    2 +
> >  drivers/nvdimm/nd.h             |   68 +++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 98 insertions(+), 33 deletions(-)
> >
>
> ...
>
> > diff --git a/drivers/nvdimm/nd.h b/drivers/nvdimm/nd.h
> > index b3feaf3699f7..416846fe7818 100644
> > --- a/drivers/nvdimm/nd.h
> > +++ b/drivers/nvdimm/nd.h
> > @@ -47,6 +47,14 @@ static inline u8 *nsl_get_name(struct nvdimm_drvdata *ndd,
> >       return memcpy(name, nd_label->name, NSLABEL_NAME_LEN);
> >  }
> >
> > +static inline u8 *nsl_set_name(struct nvdimm_drvdata *ndd,
> > +                            struct nd_namespace_label *nd_label, u8 *name)
> > +{
> > +     if (!name)
> > +             return name;
>
> Nitpick: Obviously same thing, but my eyes parse
>                 return NULL;

Ok.

>
> more easily as a clear "error" return.
>
> > +     return memcpy(nd_label->name, name, NSLABEL_NAME_LEN);
> > +}
> > +
> ...
