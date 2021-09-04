Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E837CC433F5
	for <linux-cxl@archiver.kernel.org>; Sat,  4 Sep 2021 00:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C671660F91
	for <linux-cxl@archiver.kernel.org>; Sat,  4 Sep 2021 00:27:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241508AbhIDA2Y (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 3 Sep 2021 20:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236089AbhIDA2Y (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 3 Sep 2021 20:28:24 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B92FC061575
        for <linux-cxl@vger.kernel.org>; Fri,  3 Sep 2021 17:27:23 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id z24-20020a17090acb1800b0018e87a24300so682077pjt.0
        for <linux-cxl@vger.kernel.org>; Fri, 03 Sep 2021 17:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cNqDHc4DeYDGoAd0mq4iZzi3XtF93Dyr7S8yiUymZy4=;
        b=S9eQD39d/wC1WmPQTiYTbBoL18qPM6NxOwn9akdNmjyqoOL6wDDsiNbPpEbYg8tmIV
         Hs7+NJHyqFKV5BvwiLYhTVemIhQsCJ9AtKkNmvhhexcHmkWi8r0K7unkHnzou2Q6mrXX
         4EhNUdjSJKL3FbKNEP4bEBIkup7X/fJsC6AqCSEPuUnIG8YGSCle9vzqV5LYpP0jogIM
         Eufsn7kwVZT+Ijc6OljG3ChcR8IQC4DiwkztNBuiXosT+wNJXFYZzPur/WH8RVdI1sfM
         XjERGtEqU2xMPVMREr+pBAFZsx2StTznZXnMwe7VlmVevv9emGEq7XfinN6dDQGFGFHL
         cmjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cNqDHc4DeYDGoAd0mq4iZzi3XtF93Dyr7S8yiUymZy4=;
        b=ieoJqv6p8i8hdbHZnS7y90aVO3jD5Lj/3v2fYJJKlX8O04568o6V1H3XfMaa52oPWz
         zDTJPwEKVpZvp60Zmg0Wxd+ag+aeA5Mzy0QALAS6TJkLEdupAypz8bLiOqyfCIuu4E2Y
         NtcXldQdIsF3xdxQXtZv9v99uDmNnFG0k2HsLiT286sNKZLGaQgYEl66ikfBPEk32snG
         YzjlJuQvJgy2WOpm3xRKR+86HubTmbBpSs53LzizXvF+sBQNzyq0nJlCzFOjnZk9cb5E
         4/+jQq7VALij4Ynl4bJ3qTO5lQpZJiUsGRs2A3cOIz9vey3frjqGYJlneWP6WSvunqMP
         6Ntg==
X-Gm-Message-State: AOAM533NJex7gn4hVTqMYUof7CCjmf8zOWlgjixFabwADh8GaOf7S+dX
        IcuX3++bIX9H/3HuVbN2L036+91lr8f5B8pogPvtkA==
X-Google-Smtp-Source: ABdhPJy8buIuPi3rlRkUgeB5khkdH2y3gtKF5o9jtPNmZurcJvD0pWMBuZ6mox8x/mfA2SdT0Lx89rlJA0PLhOnKD6I=
X-Received: by 2002:a17:902:7611:b029:12b:e55e:6ee8 with SMTP id
 k17-20020a1709027611b029012be55e6ee8mr1218794pll.4.1630715243053; Fri, 03 Sep
 2021 17:27:23 -0700 (PDT)
MIME-Version: 1.0
References: <162982112370.1124374.2020303588105269226.stgit@dwillia2-desk3.amr.corp.intel.com>
 <162982127644.1124374.2704629829686138331.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20210903143345.00006c60@Huawei.com> <CAPcyv4iaff7_YH1OG-yn4vnDbh-QF1DgLdGr8E4LT1bBBvX-yQ@mail.gmail.com>
 <20210903190133.000003e2@Huawei.com>
In-Reply-To: <20210903190133.000003e2@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 3 Sep 2021 17:27:12 -0700
Message-ID: <CAPcyv4hTHq6BRek_5bMn0jbz2bQ=8Kd6EaBjsc6s2=snY5ws5g@mail.gmail.com>
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

On Fri, Sep 3, 2021 at 11:01 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Fri, 3 Sep 2021 09:26:09 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
>
> > On Fri, Sep 3, 2021 at 6:34 AM Jonathan Cameron
> > <Jonathan.Cameron@huawei.com> wrote:
> > >
> > > On Tue, 24 Aug 2021 09:07:56 -0700
> > > Dan Williams <dan.j.williams@intel.com> wrote:
> > >
> > > > The kbuild robot reports:
> > > >
> > > >     drivers/cxl/core/bus.c:516:1: warning: stack frame size (1032) exceeds
> > > >     limit (1024) in function 'devm_cxl_add_decoder'
> > > >
> > > > It is also the case the devm_cxl_add_decoder() is unwieldy to use for
> > > > all the different decoder types. Fix the stack usage by splitting the
> > > > creation into alloc and add steps. This also allows for context
> > > > specific construction before adding.
> > > >
> > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > >
> > > Trivial comment inline - otherwise looks like a nice improvement.
> > >
> > > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > >
> > > > ---
> > > >  drivers/cxl/acpi.c     |   74 ++++++++++++++++++++---------
> > > >  drivers/cxl/core/bus.c |  124 +++++++++++++++---------------------------------
> > > >  drivers/cxl/cxl.h      |   15 ++----
> > > >  3 files changed, 95 insertions(+), 118 deletions(-)
> > > >
> > >
> > > > @@ -268,6 +275,7 @@ static int add_host_bridge_uport(struct device *match, void *arg)
> > > >       struct cxl_port *port;
> > > >       struct cxl_dport *dport;
> > > >       struct cxl_decoder *cxld;
> > > > +     int single_port_map[1], rc;
> > > >       struct cxl_walk_context ctx;
> > > >       struct acpi_pci_root *pci_root;
> > > >       struct cxl_port *root_port = arg;
> > > > @@ -301,22 +309,42 @@ static int add_host_bridge_uport(struct device *match, void *arg)
> > > >               return -ENODEV;
> > > >       if (ctx.error)
> > > >               return ctx.error;
> > > > +     if (ctx.count > 1)
> > > > +             return 0;
> > > >
> > > >       /* TODO: Scan CHBCR for HDM Decoder resources */
> > > >
> > > >       /*
> > > > -      * In the single-port host-bridge case there are no HDM decoders
> > > > -      * in the CHBCR and a 1:1 passthrough decode is implied.
> > > > +      * Per the CXL specification (8.2.5.12 CXL HDM Decoder Capability
> > > > +      * Structure) single ported host-bridges need not publish a decoder
> > > > +      * capability when a passthrough decode can be assumed, i.e. all
> > > > +      * transactions that the uport sees are claimed and passed to the single
> > > > +      * dport. Default the range a 0-base 0-length until the first CXL region
> > > > +      * is activated.
> > > >        */
> > >
> > > Is comment in right place or should it be up with the ctx.count > 1
> >
> > This comment is specifically about the implicit decoder, right beneath
> > the comment, that is registered in the ctx.count == 1 case. Perhaps
> > you were reacting to the spec reference which is generic, but later
> > sentences make it clear this comment is about an exception noted in
> > that spec reference?
>
> More that the conditional is above that leads to us getting here.
> Probably thrown off by Diff having added the new block that follows this
> after the removed block rather than before it.
>
> I'm fine with how you have it here.
>

Thanks, although I am going to leave your reviewed-by off for now
because I am going to fold this with this fixup patch that arrived
later which makes some significant changes:

https://lore.kernel.org/r/163002073312.1700305.17017280228713298614.stgit@dwillia2-desk3.amr.corp.intel.com
