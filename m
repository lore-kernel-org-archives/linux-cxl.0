Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35BE4C433F5
	for <linux-cxl@archiver.kernel.org>; Mon, 13 Sep 2021 22:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1445161056
	for <linux-cxl@archiver.kernel.org>; Mon, 13 Sep 2021 22:07:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244386AbhIMWJM (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 13 Sep 2021 18:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234740AbhIMWJL (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 13 Sep 2021 18:09:11 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E9AC061574
        for <linux-cxl@vger.kernel.org>; Mon, 13 Sep 2021 15:07:55 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id f3-20020a17090a638300b00199097ddf1aso593031pjj.0
        for <linux-cxl@vger.kernel.org>; Mon, 13 Sep 2021 15:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DlCsUMDE2tScoyh2sgbiu/s0d/iESIMMXI3Fp/NGUoI=;
        b=AIgR+0DRKYbfsCS7r8Vpil92rxvvGmOnTqUzN7mdKvabaNsmMouel31t18w94F0o6B
         j3/WTKJ+rO2Kd9kIwnX0qcNeAGxSsEJ/SaaEgL9XEbjQZFFPcCB3A7QLsEb6ixDi0z5S
         u8Q7bLYWXMVBTTI88qhOPkTdiCr9nFrOeDqE229ozyzsEFuPU0WiPIHsS3LjSO8qQzWn
         eXxT2K4Zl6dy0AYQRf9uPRHj1BeoWECMo0iRxaaDr9r99jWPdvF3/jZKOjIPBNrLPQMM
         Ljenv5qdfBMvO/RiT/VJrpGeG9bl+ftLlua3CNmUrCggjbfBJ7GJIboFnrsSagrf96bI
         Nyeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DlCsUMDE2tScoyh2sgbiu/s0d/iESIMMXI3Fp/NGUoI=;
        b=hPFuPPgoEAYQ2d1P51gStOh5MIPl81knMt9gW2Jmz3Q1UWtGnw9CUQi8/itY3Mho7+
         r/eKcZbjKuX+M78Ey8ZHvKVl/9eV08xTulFPJE18D5u6xQMDUrvjuLRdoIxxjmuC9k7P
         /fiUwEBbTVmKK/Z1tdJE2BhlgE4AD+Glr3hSeJFjz5xoeTooYtYLzwOSeKhalgehknFt
         ftSHIVgMgEk7ZBeqbJwuNg0DPcbfoA9NhCpwIC+P8JLJg+vgfrLI21aIEzkm+nCWRuPt
         27Mjfz+sJ/PdMtWe6QBMjrM5VIBe8aHvS7cOjLyL08VzXWybT74pGDu78UGcxpbLQusb
         ozeQ==
X-Gm-Message-State: AOAM532fZoNXjVSezhlvwu+ZHWxi5yqJ368e6K1zm7QJ7YAx8geJczw1
        qf+LFCF02YfvPNOWbIJwc0l8oep+QaTO5dk8usQSkY+r+Lc=
X-Google-Smtp-Source: ABdhPJyBnGE9w4694UHcx6kw/Hn4gbcPayctc58CEgWAmZGxH16RUH3i6Lp8AalDCB/hOaE+czqlesCSSC1UMO1Cc7w=
X-Received: by 2002:a17:902:bd8d:b0:13a:8c8:a2b2 with SMTP id
 q13-20020a170902bd8d00b0013a08c8a2b2mr12335461pls.89.1631570875348; Mon, 13
 Sep 2021 15:07:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210902195017.2516472-1-ben.widawsky@intel.com>
 <20210902195017.2516472-5-ben.widawsky@intel.com> <CAPcyv4gbVtZywtzYVFS_KAQ_aHGHDQtke=eeVSv3pdz=CfVOhA@mail.gmail.com>
 <20210913161149.ggbd5jmro2davaq5@intel.com>
In-Reply-To: <20210913161149.ggbd5jmro2davaq5@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 13 Sep 2021 15:07:44 -0700
Message-ID: <CAPcyv4jpp5cfQnNVa34gY7tOtM4ZNBvzYDOqoBPEmv1-_qk=bQ@mail.gmail.com>
Subject: Re: [PATCH 04/13] cxl: Introduce endpoint decoders
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Sep 13, 2021 at 9:11 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> On 21-09-10 12:19:24, Dan Williams wrote:
> > On Thu, Sep 2, 2021 at 12:50 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
> > >
> > > Endpoints have decoders too. It is useful to share the same
> > > infrastructure from cxl_core. Endpoints do not have dports (downstream
> > > targets), only the underlying physical medium. As a result, some special
> > > casing is needed.
> > >
> > > There is no functional change introduced yet as endpoints don't actually
> > > enumerate decoders yet.
> > >
> > > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > > ---
> > >  drivers/cxl/core/bus.c | 29 +++++++++++++++++++++++++----
> > >  1 file changed, 25 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
> > > index 8d5061b0794d..6202ce5a5ac2 100644
> > > --- a/drivers/cxl/core/bus.c
> > > +++ b/drivers/cxl/core/bus.c
> > > @@ -175,6 +175,12 @@ static const struct attribute_group *cxl_decoder_switch_attribute_groups[] = {
> > >         NULL,
> > >  };
> > >
> > > +static const struct attribute_group *cxl_decoder_endpoint_attribute_groups[] = {
> > > +       &cxl_decoder_base_attribute_group,
> > > +       &cxl_base_attribute_group,
> > > +       NULL,
> > > +};
> > > +
> > >  static void cxl_decoder_release(struct device *dev)
> > >  {
> > >         struct cxl_decoder *cxld = to_cxl_decoder(dev);
> > > @@ -184,6 +190,12 @@ static void cxl_decoder_release(struct device *dev)
> > >         kfree(cxld);
> > >  }
> > >
> > > +static const struct device_type cxl_decoder_endpoint_type = {
> > > +       .name = "cxl_decoder_endpoint",
> > > +       .release = cxl_decoder_release,
> > > +       .groups = cxl_decoder_endpoint_attribute_groups,
> > > +};
> > > +
> > >  static const struct device_type cxl_decoder_switch_type = {
> > >         .name = "cxl_decoder_switch",
> > >         .release = cxl_decoder_release,
> > > @@ -196,6 +208,11 @@ static const struct device_type cxl_decoder_root_type = {
> > >         .groups = cxl_decoder_root_attribute_groups,
> > >  };
> > >
> > > +static bool is_endpoint_decoder(struct device *dev)
> > > +{
> > > +       return dev->type == &cxl_decoder_endpoint_type;
> > > +}
> > > +
> > >  bool is_root_decoder(struct device *dev)
> > >  {
> > >         return dev->type == &cxl_decoder_root_type;
> > > @@ -472,7 +489,7 @@ struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port, int nr_targets)
> > >         struct device *dev;
> > >         int rc = 0;
> > >
> > > -       if (nr_targets > CXL_DECODER_MAX_INTERLEAVE || nr_targets < 1)
> > > +       if (nr_targets > CXL_DECODER_MAX_INTERLEAVE)
> > >                 return ERR_PTR(-EINVAL);
> > >
> > >         cxld = kzalloc(struct_size(cxld, target, nr_targets), GFP_KERNEL);
> > > @@ -491,8 +508,11 @@ struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port, int nr_targets)
> > >         dev->parent = &port->dev;
> > >         dev->bus = &cxl_bus_type;
> > >
> > > +       /* Endpoints don't have a target list */
> > > +       if (nr_targets == 0)
> > > +               dev->type = &cxl_decoder_endpoint_type;
> >
> > Do you also plan to introduce the concept of endpoint ports, and if
> > yes should that come before this patch? That would seem to be more
> > robust than, for example, allowing a switch port to carry an endpoint
> > decoder object as this allows.
>
> I didn't see a need as of yet to differentiate between endpoint ports and other
> ports. I don't entirely understand what you mean by "allowing a switch port to
> carry an endpoint decoder" means. Can you please elaborate?

If endpoint ports were an explicit type then this check could make
sure that someone did not pass nr_targets set to 0 where the @port
argument is referring to a switch where the target_list must be
specified.

Either that, or a comment in kernel-doc for this routine about the
special meaning of nr_targets == 0 and expected usage.
