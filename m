Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D575BC4332F
	for <linux-cxl@archiver.kernel.org>; Tue, 14 Sep 2021 21:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBC3E61209
	for <linux-cxl@archiver.kernel.org>; Tue, 14 Sep 2021 21:18:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235326AbhINVTa (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 14 Sep 2021 17:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235415AbhINVTU (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 14 Sep 2021 17:19:20 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376A6C0613EE
        for <linux-cxl@vger.kernel.org>; Tue, 14 Sep 2021 14:16:56 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id g13-20020a17090a3c8d00b00196286963b9so3285226pjc.3
        for <linux-cxl@vger.kernel.org>; Tue, 14 Sep 2021 14:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jBwDA/ErLIDdu9O9SYU4CQzLY5YQQYi96b4HqA8zEOg=;
        b=ymVxLSxntmCex2iOuR1Af0qb+ZYKjDkLJJBG4Yix1JHfO241X9mIyo31b5E4GHh0YC
         XfvRIcTtCXNnZoF/rpfwPGrqsfX6jB/xLb9XkIaxKBFiwFS4q+UVqMnwJbiDcfHIXmZW
         SKKpvQt5emjPo30cqo/GK0vZBUzxVqldt8t4aIg3hxrOJSxRJBX3qk6SctKldZrNPd04
         253gpNeAYSX4cljJBTxPN7IritJ/U6EpB2QBQof/uHQV+F870s3I5VHv6E3E1WgOVH0f
         AWpJd+uh2hp9dnojf7URe5+BLr2ZpIaNOguw8QMLvg7v5l6YKSeBY8YXtKEOq1jBaqvP
         UAJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jBwDA/ErLIDdu9O9SYU4CQzLY5YQQYi96b4HqA8zEOg=;
        b=vtYJtizSdTs5Fyx4t/CPYNVahRiqLA/uKzpoJz7+3Qmj/2NFb7RSmLfyvPCYCBq/b8
         aVo9jJqAf1+D+IL50FAoKMiLxKQTedgnm05HqhiE2ly+ijznZen9K09ikG7rCuUnXOFO
         /xrRJclh+Bl3DHGIxLfD7pPkz9h1hE2tnG1lO+cvff37ELVxQjTa6d79no2Zm+j4elz3
         ZojXELl0THGnBQ7A3ypYpiiSKoGoDE5sdcUcaA0G2lN/lLlD1E7+6W+d4C3KAW+B+S4U
         Nr2npck/w35vZQ27lnChtqQKAaRW9xFoNvJjpCMNV9fQdugJ+Tuu3+LHPJ1G7+30Ff66
         8ixg==
X-Gm-Message-State: AOAM530gP+66GR7oQcqo7NOLyjZEILoMrZyGX5GQOdpsoIJo8wGOoHr/
        zUyVpGCgQHvSoU5O6JJkUk0fv6A0wMLgcCS3sOmaJg==
X-Google-Smtp-Source: ABdhPJwNbGLX50LIB5DPTVHeZuGS+NGNREa0vxHkxd1RDgJ67moxMPKeJ14C5qLzKpmhyCH3yMdqgG2jmFPPpOM+rhU=
X-Received: by 2002:a17:902:cec8:b0:13b:9ce1:b3ef with SMTP id
 d8-20020a170902cec800b0013b9ce1b3efmr8113297plg.4.1631654215629; Tue, 14 Sep
 2021 14:16:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210902195017.2516472-1-ben.widawsky@intel.com>
 <20210902195017.2516472-5-ben.widawsky@intel.com> <CAPcyv4gbVtZywtzYVFS_KAQ_aHGHDQtke=eeVSv3pdz=CfVOhA@mail.gmail.com>
 <20210913161149.ggbd5jmro2davaq5@intel.com> <CAPcyv4jpp5cfQnNVa34gY7tOtM4ZNBvzYDOqoBPEmv1-_qk=bQ@mail.gmail.com>
 <20210913231921.w2rujefmewgraopi@intel.com>
In-Reply-To: <20210913231921.w2rujefmewgraopi@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 14 Sep 2021 14:16:44 -0700
Message-ID: <CAPcyv4hMS_O+19Qb8pEX0DpPBZQL7zP0Lyukk9j0EmSXf_igEw@mail.gmail.com>
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

On Mon, Sep 13, 2021 at 4:19 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> On 21-09-13 15:07:44, Dan Williams wrote:
> > On Mon, Sep 13, 2021 at 9:11 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
> > >
> > > On 21-09-10 12:19:24, Dan Williams wrote:
> > > > On Thu, Sep 2, 2021 at 12:50 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
> > > > >
> > > > > Endpoints have decoders too. It is useful to share the same
> > > > > infrastructure from cxl_core. Endpoints do not have dports (downstream
> > > > > targets), only the underlying physical medium. As a result, some special
> > > > > casing is needed.
> > > > >
> > > > > There is no functional change introduced yet as endpoints don't actually
> > > > > enumerate decoders yet.
> > > > >
> > > > > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > > > > ---
> > > > >  drivers/cxl/core/bus.c | 29 +++++++++++++++++++++++++----
> > > > >  1 file changed, 25 insertions(+), 4 deletions(-)
> > > > >
> > > > > diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
> > > > > index 8d5061b0794d..6202ce5a5ac2 100644
> > > > > --- a/drivers/cxl/core/bus.c
> > > > > +++ b/drivers/cxl/core/bus.c
> > > > > @@ -175,6 +175,12 @@ static const struct attribute_group *cxl_decoder_switch_attribute_groups[] = {
> > > > >         NULL,
> > > > >  };
> > > > >
> > > > > +static const struct attribute_group *cxl_decoder_endpoint_attribute_groups[] = {
> > > > > +       &cxl_decoder_base_attribute_group,
> > > > > +       &cxl_base_attribute_group,
> > > > > +       NULL,
> > > > > +};
> > > > > +
> > > > >  static void cxl_decoder_release(struct device *dev)
> > > > >  {
> > > > >         struct cxl_decoder *cxld = to_cxl_decoder(dev);
> > > > > @@ -184,6 +190,12 @@ static void cxl_decoder_release(struct device *dev)
> > > > >         kfree(cxld);
> > > > >  }
> > > > >
> > > > > +static const struct device_type cxl_decoder_endpoint_type = {
> > > > > +       .name = "cxl_decoder_endpoint",
> > > > > +       .release = cxl_decoder_release,
> > > > > +       .groups = cxl_decoder_endpoint_attribute_groups,
> > > > > +};
> > > > > +
> > > > >  static const struct device_type cxl_decoder_switch_type = {
> > > > >         .name = "cxl_decoder_switch",
> > > > >         .release = cxl_decoder_release,
> > > > > @@ -196,6 +208,11 @@ static const struct device_type cxl_decoder_root_type = {
> > > > >         .groups = cxl_decoder_root_attribute_groups,
> > > > >  };
> > > > >
> > > > > +static bool is_endpoint_decoder(struct device *dev)
> > > > > +{
> > > > > +       return dev->type == &cxl_decoder_endpoint_type;
> > > > > +}
> > > > > +
> > > > >  bool is_root_decoder(struct device *dev)
> > > > >  {
> > > > >         return dev->type == &cxl_decoder_root_type;
> > > > > @@ -472,7 +489,7 @@ struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port, int nr_targets)
> > > > >         struct device *dev;
> > > > >         int rc = 0;
> > > > >
> > > > > -       if (nr_targets > CXL_DECODER_MAX_INTERLEAVE || nr_targets < 1)
> > > > > +       if (nr_targets > CXL_DECODER_MAX_INTERLEAVE)
> > > > >                 return ERR_PTR(-EINVAL);
> > > > >
> > > > >         cxld = kzalloc(struct_size(cxld, target, nr_targets), GFP_KERNEL);
> > > > > @@ -491,8 +508,11 @@ struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port, int nr_targets)
> > > > >         dev->parent = &port->dev;
> > > > >         dev->bus = &cxl_bus_type;
> > > > >
> > > > > +       /* Endpoints don't have a target list */
> > > > > +       if (nr_targets == 0)
> > > > > +               dev->type = &cxl_decoder_endpoint_type;
> > > >
> > > > Do you also plan to introduce the concept of endpoint ports, and if
> > > > yes should that come before this patch? That would seem to be more
> > > > robust than, for example, allowing a switch port to carry an endpoint
> > > > decoder object as this allows.
> > >
> > > I didn't see a need as of yet to differentiate between endpoint ports and other
> > > ports. I don't entirely understand what you mean by "allowing a switch port to
> > > carry an endpoint decoder" means. Can you please elaborate?
> >
> > If endpoint ports were an explicit type then this check could make
> > sure that someone did not pass nr_targets set to 0 where the @port
> > argument is referring to a switch where the target_list must be
> > specified.
> >
> > Either that, or a comment in kernel-doc for this routine about the
> > special meaning of nr_targets == 0 and expected usage.
>
> Well, since Jonathan also brought up a concern here perhaps I should entertain
> other ideas. I suppose future versions of the spec could break things, but as it
> stands today the only CXL component that implements decoders that can have a 0
> value for this are endpoint devices (T2 or T3, or LD). I think it's fine to wait
> until we have a second reason to make an endpoint port type and update kdocs for
> now, but maybe it will also be a natural fit with a proper port driver.

"Document only" sounds good to me.
