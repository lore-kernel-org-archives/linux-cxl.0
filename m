Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E162AC48BE6
	for <linux-cxl@archiver.kernel.org>; Wed, 16 Jun 2021 16:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5E3361356
	for <linux-cxl@archiver.kernel.org>; Wed, 16 Jun 2021 16:32:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbhFPQe7 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 16 Jun 2021 12:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbhFPQe5 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 16 Jun 2021 12:34:57 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70817C061760
        for <linux-cxl@vger.kernel.org>; Wed, 16 Jun 2021 09:32:45 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id h12so2659074pfe.2
        for <linux-cxl@vger.kernel.org>; Wed, 16 Jun 2021 09:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LgEvtax5sgfmjjrhgKwKQwSVaBY+DvlQnT1NfAz1r9g=;
        b=1hcP+YAeAqS7ogKiZuC3JOg0nrRosmlQ+/IxyYf9p4F0pHW4TcuQefQCO86PNAAWy1
         +IOvR/7EL4bbgif/BwOuHFbnEIgOYc5lkobTM9TRoOsIzZfHtSUiWe0vLkFq9FgEjzyZ
         ByxXRhl9VgLrG2EVdC85CsSFHZbCkxnjcTuJJlxdDQ8+N2hUZ1sJXEBXP5MEfRykqAlK
         E8meQUJGqUb8qr3bFM6hITb+bowuxf6WG5TxBXG09NyZakyYHPxIerAYpODSo9xquRW7
         XdFB1CKn7Ekzy+udsg2u/M33tbZ1MJYZHRxlESye7+e3nBCfFzNYpXG4iqhgDXx/cfex
         LY+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LgEvtax5sgfmjjrhgKwKQwSVaBY+DvlQnT1NfAz1r9g=;
        b=LFvBoNia/ZJxbXvK1Yyc8w++lmk2T4pggU0PzfFTdmC6erPzk5s5Q5vk3Pwp8ABbzm
         RmRuiKDlPRDbOGG8dI9npoONMzW0PLYbXBA0lJBEYKZhoTQJM2Hv0wjCOQLdcZe7Skwy
         iGYF41e9+YXUV3uIMDO59DsKf8kQx65WFdByynMytCMM//Cs5DqvjHpx/54Ih/Rj2Kbi
         ti11Tv26dnWkWLQRnH+kttRG3eXBvTf1lmoY1QPtqfF6UtAhvq8u7FuwF5hloyklLPgD
         uHGq7mYEvMqSM+7/PYhWQBLPOMt91OMwdvxUauhXCAxQAaYW22kdn/d7Z05ie0yHUUd3
         X+Ow==
X-Gm-Message-State: AOAM531wpZsarbqzrnKjKW2eMvmxeX6CRiM6Q8Ym1HH9Vj3+KoajWsCC
        kkfq63jbVaqFWzKbIAwBY2StbF3qDP9/5mPttL1UKQ==
X-Google-Smtp-Source: ABdhPJyZvZL0A0K44zy/aMo4UY4FYkRWBOijbl8gbJYaH2WDdTs7d+pPN30OUFs00aZSFvvgfpO+hxC4Wgxuat0VkIY=
X-Received: by 2002:a62:8647:0:b029:2c4:b8d6:843 with SMTP id
 x68-20020a6286470000b02902c4b8d60843mr590229pfd.71.1623861164908; Wed, 16 Jun
 2021 09:32:44 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1623800340.git.alison.schofield@intel.com>
 <48f1b59105e46f04b38347fc1555bb5c8d654cff.1623800340.git.alison.schofield@intel.com>
 <20210616161740.k4nxeh3bmem56gwa@intel.com>
In-Reply-To: <20210616161740.k4nxeh3bmem56gwa@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 16 Jun 2021 09:32:34 -0700
Message-ID: <CAPcyv4hNxAw99iNF_puwuYmegCGBR2mOUhQ_t56q_XZ0p7hjcw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] cxl/acpi: Use the ACPI CFMWS to create static
 decoder objects
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-cxl@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Jun 16, 2021 at 9:17 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> On 21-06-15 17:20:39, Alison Schofield wrote:
> > The ACPI CXL Early Discovery Table (CEDT) includes a list of CXL memory
> > resources in CXL Fixed Memory Window Structures (CFMWS). Retrieve each
> > CFMWS in the CEDT and add a cxl_decoder object to the root port (root0)
> > for each memory resource.
> >
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > ---
> >  drivers/cxl/acpi.c | 114 +++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 114 insertions(+)
> >
> > diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> > index b6d9cd45428c..e3aa356d4dcd 100644
> > --- a/drivers/cxl/acpi.c
> > +++ b/drivers/cxl/acpi.c
> > @@ -8,8 +8,120 @@
> >  #include <linux/pci.h>
> >  #include "cxl.h"
> >
> > +/* Encode defined in CXL 2.0 8.2.5.12.7 HDM Decoder Control Register */
> > +#define CFMWS_INTERLEAVE_WAYS(x)     (1 << (x)->interleave_ways)
> > +#define CFMWS_INTERLEAVE_GRANULARITY(x)      ((x)->granularity + 8)
> > +
> >  static struct acpi_table_header *cedt_table;
> >
> > +static unsigned long cfmws_to_decoder_flags(int restrictions)
> > +{
> > +     unsigned long flags = 0;
> > +
> > +     if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_TYPE2)
> > +             flags |= CXL_DECODER_F_TYPE2;
> > +     if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_TYPE3)
> > +             flags |= CXL_DECODER_F_TYPE3;
> > +     if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_VOLATILE)
> > +             flags |= CXL_DECODER_F_RAM;
> > +     if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_PMEM)
> > +             flags |= CXL_DECODER_F_PMEM;
> > +     if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_FIXED)
> > +             flags |= CXL_DECODER_F_LOCK;
> > +
> > +     return flags;
> > +}
>
> I know these flags aren't introduced by this patch, but I'm wondering if it
> makes sense to not just use the spec definitions rather than defining our own.
> It doesn't do much harm, but it's extra typing everytime the spec adds new flags
> and I don't really see the upside.

The flags are bounded by what's in HDM decoders, I don't see them
moving so fast that the kernel can not keep up. The rationale for the
split is the same as the split between ACPI NFIT and the LIBNVDIMM
core. The ACPI specifics are just one way to convey a common platform
attribute to the core.

In fact this was one of the main feedbacks of the initial "ND"
subsystem which eventually became LIBNVDIMM [1]. ND stood for "NFIT
Defined" and the arch split between ACPI specific and Linux
translation has paid off over the years.

[1]: https://lore.kernel.org/lkml/20150420070624.GB13876@gmail.com/


>
> > +
> > +static int cxl_acpi_cfmws_verify(struct device *dev,
> > +                              struct acpi_cedt_cfmws *cfmws)
> > +{
> > +     int expected_len;
> > +
> > +     if (cfmws->interleave_arithmetic != ACPI_CEDT_CFMWS_ARITHMETIC_MODULO) {
> > +             dev_err(dev, "CFMWS Unsupported Interleave Arithmetic\n");
> > +             return -EINVAL;
> > +     }
> > +
> > +     if (!IS_ALIGNED(cfmws->base_hpa, SZ_256M)) {
> > +             dev_err(dev, "CFMWS Base HPA not 256MB aligned\n");
> > +             return -EINVAL;
> > +     }
> > +
> > +     if (!IS_ALIGNED(cfmws->window_size, SZ_256M)) {
> > +             dev_err(dev, "CFMWS Window Size not 256MB aligned\n");
> > +             return -EINVAL;
> > +     }
> > +
> > +     expected_len = struct_size((cfmws), interleave_targets,
> > +                                CFMWS_INTERLEAVE_WAYS(cfmws));
> > +
> > +     if (expected_len != cfmws->header.length) {
>
> I'd switch this to:
> if (expected_len < cfmws->header.length)
>
> If it's too big, just print a dev_dbg.

Maybe call it min_len then?

[..]
> > +
> > +             cxld = devm_cxl_add_decoder(dev, root_port,
> > +                             CFMWS_INTERLEAVE_WAYS(cfmws),
> > +                             cfmws->base_hpa, cfmws->window_size,
> > +                             CFMWS_INTERLEAVE_WAYS(cfmws),
>
> Interesting... this made me question, how can we have a different number of
> targets and ways?

These settings can be changed later on a switch-level decoder, for a
root-level decoder these initial values are fixed.
