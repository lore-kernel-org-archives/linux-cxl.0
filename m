Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12462C433EF
	for <linux-cxl@archiver.kernel.org>; Fri,  3 Sep 2021 16:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7BA760EC0
	for <linux-cxl@archiver.kernel.org>; Fri,  3 Sep 2021 16:26:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349956AbhICQ1V (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 3 Sep 2021 12:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349474AbhICQ1V (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 3 Sep 2021 12:27:21 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0465FC061575
        for <linux-cxl@vger.kernel.org>; Fri,  3 Sep 2021 09:26:21 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id j1so3963887pjv.3
        for <linux-cxl@vger.kernel.org>; Fri, 03 Sep 2021 09:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ytf2qKVJOpirHXnllSyl2KiVJt19ctCjez+4mJGSx9s=;
        b=kL9n1JmHNXqN0KPlHxbzGIfIiNAaXefiFpcKRMYbj6WOBcj7KTJz+PfN1B6IvpXAe6
         3Sj/fu9Gu3GpUwfeADQr6OgGurOu4WLF96bB8uIeEf6PXeQ0fjrS/F/MYZpwfQf5ZQSP
         paU14qxyqEPkrwUy0AXUQIdGdeKyYgL5ltchV06OVdMWBAt138WtpV285cymOAZ5gsnL
         yNEsWr+vt3iwsztoeSMy3bmc2s9s+Oke10JcTzvniQ3wXTG5wGPtse9HQAxb3jQfdJPg
         b5QryTmTFmyx2OVtm7OVMe1Ttrk954elWIb3tSo3IVzo+jTtEYfFZLwq1Oh9AqAPR/Jt
         i6ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ytf2qKVJOpirHXnllSyl2KiVJt19ctCjez+4mJGSx9s=;
        b=i3wDNJs5bm66hvvgvzYiag2UPsgwQc5FpGLhPlyhLcQR/vRG9r0oTJkX6dGhTKMBMv
         RHooyDkBs8OIc9OiyyT3VcEWCaM0JxaKCuSzZAsQi3AMXPCVsaGis6DBWMtS221B/F6i
         rkasbAXzvgxee2VskM/kfMQoDDs2MSISl0ELgDVnJl2R/h6pJ5U3U+wBtZ/AwS2dQT5N
         YpM5NZsm1s8h4I3LvR0L+nbnDmQpRF38CWkcWRhFJUmKrRv5YtOhKmtQL2DOTJh0mmvy
         z00S4+7I4nwslicTyi7gog9JcrBsKGxgJO8EU0INLCJ+CasDbV87hqjiUHYhFxxpPND8
         8CJA==
X-Gm-Message-State: AOAM530nXKwI8zJfMYyE0RBUx50UERTvYqrgV8z+Li04sLp4WTVNimbW
        lGequyRoWj98u22dAD2wkP8WHn9GCezF5HBux38jKQ==
X-Google-Smtp-Source: ABdhPJwcfmgPyxvuME3fy4RYFElLi4CQbOW6oPEBzF5AEdc8iRVVi41MV4dOTGEB+CxKbx7jqO6jfo3nDDTk5VAectA=
X-Received: by 2002:a17:90a:f695:: with SMTP id cl21mr1597569pjb.220.1630686380459;
 Fri, 03 Sep 2021 09:26:20 -0700 (PDT)
MIME-Version: 1.0
References: <162982112370.1124374.2020303588105269226.stgit@dwillia2-desk3.amr.corp.intel.com>
 <162982127644.1124374.2704629829686138331.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20210903143345.00006c60@Huawei.com>
In-Reply-To: <20210903143345.00006c60@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 3 Sep 2021 09:26:09 -0700
Message-ID: <CAPcyv4iaff7_YH1OG-yn4vnDbh-QF1DgLdGr8E4LT1bBBvX-yQ@mail.gmail.com>
Subject: Re: [PATCH v3 28/28] cxl/core: Split decoder setup into alloc + add
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Sep 3, 2021 at 6:34 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Tue, 24 Aug 2021 09:07:56 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
>
> > The kbuild robot reports:
> >
> >     drivers/cxl/core/bus.c:516:1: warning: stack frame size (1032) exceeds
> >     limit (1024) in function 'devm_cxl_add_decoder'
> >
> > It is also the case the devm_cxl_add_decoder() is unwieldy to use for
> > all the different decoder types. Fix the stack usage by splitting the
> > creation into alloc and add steps. This also allows for context
> > specific construction before adding.
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>
> Trivial comment inline - otherwise looks like a nice improvement.
>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

>
> > ---
> >  drivers/cxl/acpi.c     |   74 ++++++++++++++++++++---------
> >  drivers/cxl/core/bus.c |  124 +++++++++++++++---------------------------------
> >  drivers/cxl/cxl.h      |   15 ++----
> >  3 files changed, 95 insertions(+), 118 deletions(-)
> >
>
> > @@ -268,6 +275,7 @@ static int add_host_bridge_uport(struct device *match, void *arg)
> >       struct cxl_port *port;
> >       struct cxl_dport *dport;
> >       struct cxl_decoder *cxld;
> > +     int single_port_map[1], rc;
> >       struct cxl_walk_context ctx;
> >       struct acpi_pci_root *pci_root;
> >       struct cxl_port *root_port = arg;
> > @@ -301,22 +309,42 @@ static int add_host_bridge_uport(struct device *match, void *arg)
> >               return -ENODEV;
> >       if (ctx.error)
> >               return ctx.error;
> > +     if (ctx.count > 1)
> > +             return 0;
> >
> >       /* TODO: Scan CHBCR for HDM Decoder resources */
> >
> >       /*
> > -      * In the single-port host-bridge case there are no HDM decoders
> > -      * in the CHBCR and a 1:1 passthrough decode is implied.
> > +      * Per the CXL specification (8.2.5.12 CXL HDM Decoder Capability
> > +      * Structure) single ported host-bridges need not publish a decoder
> > +      * capability when a passthrough decode can be assumed, i.e. all
> > +      * transactions that the uport sees are claimed and passed to the single
> > +      * dport. Default the range a 0-base 0-length until the first CXL region
> > +      * is activated.
> >        */
>
> Is comment in right place or should it be up with the ctx.count > 1

This comment is specifically about the implicit decoder, right beneath
the comment, that is registered in the ctx.count == 1 case. Perhaps
you were reacting to the spec reference which is generic, but later
sentences make it clear this comment is about an exception noted in
that spec reference?
