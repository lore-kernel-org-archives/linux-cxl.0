Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A9EEC433EF
	for <linux-cxl@archiver.kernel.org>; Wed, 18 May 2022 16:42:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240344AbiERQl7 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 18 May 2022 12:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240334AbiERQlz (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 18 May 2022 12:41:55 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04BFB275EE
        for <linux-cxl@vger.kernel.org>; Wed, 18 May 2022 09:41:55 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id w8so477480pga.9
        for <linux-cxl@vger.kernel.org>; Wed, 18 May 2022 09:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NBk9liXdLS0NKnHa5cSCk1kHKDiXrcfTxdoTksvpPWo=;
        b=fUCD6krc+E+FJOgYtBHguGGd/auEJCOh9wjeb/iiDXjFK4976AgWL812smQ4g8RynY
         E6/8NypNp3IanTb08rCFXbD3MnolGhM7f0+P+nS8/a8lSbcGHL+p8AfejdD5B+aqYvmw
         M00e8SjUwYYac4FrgiEzlSFUvAK4xYgdDUGzVIPUSaB1QGAQjhQmVozTV81jAekXVdLI
         mKvUHLwvu70b9QvKkH1sou79HcHhIeeIAQfid3Qpp3VQAgUnZLPT+atprGxBfU7zoIQp
         th+EUy90nXjvBtHZ//5wWv7VQps3wKJAfRJME4wmK7ealZRNOCJqp5gCD0pLKD1AseFL
         yvLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NBk9liXdLS0NKnHa5cSCk1kHKDiXrcfTxdoTksvpPWo=;
        b=Hvq8kjTxQyq9Iv05sWYayEAtjns1u4OZlrKtBnN5EcRMbeLj62GTWjCn+KFf2jvoGv
         GkyPEUYvI5WLnoPg1TUgOUHQbcXfVKHQ2fftYfqHQEz1X7KBvuKL9CNi7c07GbnKaHt/
         y2igM4gtmh2ci1p87flednzq0F8I6t1n9oi7dENvRDNubdquQeCv3rXGltCwj/Ar1KMj
         6Z/ePoENb8YcCT3H7hIfVhMJC8S5jRIk1MGn9AMiXM3tZO6o4H7ve4R6ej930wdAHC4u
         UAcco3BuvNZKdfiTkc4GhyIgaHYxvWHwerpyXySXYV2eKli9psY5MJ3xc3GxGlFxc1Z5
         cTUg==
X-Gm-Message-State: AOAM530ZM99dTmpH2qQlDIGlC7Qthi+EYkWK38sGg+Ece3DaNeOc+RSl
        +l3ySzuaMYYYpNwJcI/8OF8oIrzyiZQemvnF6T+WIQ==
X-Google-Smtp-Source: ABdhPJzUjB5Ylk3PrWUqr/WSM7qXoPTR7P7aoMQDfdSaMH6Xm76vX3AZXEla03jLgoKnoi50QRzx3ePplaskPOR3Nps=
X-Received: by 2002:a63:e648:0:b0:3f2:7ade:8f86 with SMTP id
 p8-20020a63e648000000b003f27ade8f86mr322639pgj.40.1652892114552; Wed, 18 May
 2022 09:41:54 -0700 (PDT)
MIME-Version: 1.0
References: <165237925642.3832067.15995008431029494571.stgit@dwillia2-desk3.amr.corp.intel.com>
 <165237928334.3832067.16326444799383620141.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20220518171305.000033c4@Huawei.com>
In-Reply-To: <20220518171305.000033c4@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 18 May 2022 09:41:43 -0700
Message-ID: <CAPcyv4ib5-9W+dvHBgO5y06Gwt69NJXPc8b+GsuF-wiYT9iuPw@mail.gmail.com>
Subject: Re: [PATCH 05/14] cxl/mem: Validate port connectivity before dvsec ranges
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, May 18, 2022 at 9:15 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Thu, 12 May 2022 11:14:43 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
>
> > In preparation for validating DVSEC ranges against the platform declared
> > CXL memory ranges (ACPI CFMWS) move port enumeration before the
> > endpoint's decoder validation. Ultimately this logic will move to the
> > port driver, but create a bisect point before that larger move.
> >
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  drivers/cxl/mem.c |   36 ++++++++++++++++++------------------
> >  1 file changed, 18 insertions(+), 18 deletions(-)
> >
> > diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> > index fed7f10ef9b2..80e75a410499 100644
> > --- a/drivers/cxl/mem.c
> > +++ b/drivers/cxl/mem.c
> > @@ -140,22 +140,6 @@ static int cxl_mem_probe(struct device *dev)
> >       if (work_pending(&cxlmd->detach_work))
> >               return -EBUSY;
> >
> > -     rc = cxlds->wait_media_ready(cxlds);
> > -     if (rc) {
> > -             dev_err(dev, "Media not active (%d)\n", rc);
> > -             return rc;
> > -     }
> > -
> > -     /*
> > -      * If DVSEC ranges are being used instead of HDM decoder registers there
> > -      * is no use in trying to manage those.
> > -      */
> > -     if (!cxl_hdm_decode_init(cxlds)) {
> > -             dev_err(dev,
> > -                     "Legacy range registers configuration prevents HDM operation.\n");
> > -             return -EBUSY;
> > -     }
> > -
> >       rc = devm_cxl_enumerate_ports(cxlmd);
> >       if (rc)
> >               return rc;
> > @@ -171,16 +155,32 @@ static int cxl_mem_probe(struct device *dev)
> >               dev_err(dev, "CXL port topology %s not enabled\n",
> >                       dev_name(&parent_port->dev));
> >               rc = -ENXIO;
> > -             goto out;
> > +             goto unlock;
> >       }
> >
> >       rc = create_endpoint(cxlmd, parent_port);
> > -out:
> > +unlock:
>
> Trivial but I think this rename of the label would be better in the earlier
> patch where you first added the if (rc) below.
> I suppose it is arguable that the previous patch is a fix so should be minimal
> though so I'm not that bothered if you leave it here.
>

True, the rename is just as much a part of what "9ea4dcf49878 PM: CXL:
Disable suspend" was missing as the fix, I'll go ahead and make the
adjustment.
