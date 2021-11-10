Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A55C433EF
	for <linux-cxl@archiver.kernel.org>; Wed, 10 Nov 2021 21:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8578461247
	for <linux-cxl@archiver.kernel.org>; Wed, 10 Nov 2021 21:03:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233176AbhKJVGo (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 10 Nov 2021 16:06:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233167AbhKJVGo (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 10 Nov 2021 16:06:44 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B574C061766
        for <linux-cxl@vger.kernel.org>; Wed, 10 Nov 2021 13:03:56 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id t21so4045552plr.6
        for <linux-cxl@vger.kernel.org>; Wed, 10 Nov 2021 13:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4OX0J3wvoqc71Bumf/BBGCto5+/PZE5rBI+nulFr3As=;
        b=3MC/CzeNYGBiO0+pwhuzXMKzBCsV3ADi0QU8JfsHeZV/3C9xVqzHuXptddOhcEHItS
         ZUhhRfUozvr6ChxSrDyejNQhughE0nHrPU3orCgpJF/WVLNj69CoZ6FA8X/UATP3OfA7
         1OpNHkByj1xiiC4Kg5RNCxwxzsoG0Vst+iKOAn4fH9KwLy/guSygZofdtNynb16N8aBs
         WcqdgdeZeWXkUmPjLACjlewuQbnoVGwgIIrKLFGVyS4MZsyfs2O9X70sb8ep6XiJNyJz
         Q0tTaPh6hMvQYWzbb7JZQbFcJgvZg3RxKTbXUSEp4PmR6adP2TDNnGILxd396kAZ2xKJ
         /pxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4OX0J3wvoqc71Bumf/BBGCto5+/PZE5rBI+nulFr3As=;
        b=WP4INlr5EXxon/u8VXIJqsiuk6Dsle9WAgzYqNeTq49LIZ23bLu1XWXBmScA1eDbuI
         oP871tQOi6YD/3nuDTE8cqh1HJUCAeXTzScPTAuifiG4+XW8AqYG4rU1wK6brxqxCYZD
         DYSqiFiVAWYTjpT1gh6/uJMQEiE2FOXdSrxVwJqMswV6zIE3nrvoasyz3p1RunJJum2z
         XGfeZejvkb6htgHKUMWGcp9tSLPIv/ybsD4s1wyf2WM7Bfdwt2mnV+LbEIVpkXY3DsXA
         n2zlQgByAAZmGJxMmdSf+4eCPn4KzIh7p6gNp4z0+egPsXvyKds7eAfziGDN0qS6+Tix
         Js/w==
X-Gm-Message-State: AOAM5333Yg5t50FfwNwVmwsoHQgmB+SJK5ndAMRxStImbgRU4klgINOL
        cmhAFaX74HReKLE6ySU2BiF1ecX64B3f4IWcxffSHg==
X-Google-Smtp-Source: ABdhPJzOiypytkx9XcgEg+7wfg4A7PzzZ1Fod84uTq9tet7s7rpNEyHeamZfHXquQDTH+sG/x7d5+iozZ7nNaq+Vm14=
X-Received: by 2002:a17:90b:1e07:: with SMTP id pg7mr2151804pjb.93.1636578235580;
 Wed, 10 Nov 2021 13:03:55 -0800 (PST)
MIME-Version: 1.0
References: <20211022183709.1199701-1-ben.widawsky@intel.com>
 <20211022183709.1199701-16-ben.widawsky@intel.com> <20211103160821.0000479e@Huawei.com>
 <20211110174923.5cdbfyyoixbhiqjt@intel.com> <20211110181055.00005779@Huawei.com>
In-Reply-To: <20211110181055.00005779@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 10 Nov 2021 13:03:44 -0800
Message-ID: <CAPcyv4goFku6+GD=MTnzFNUy6Y0-L-4nNwO2_26Y+jr2bBqFZQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 15/28] cxl/core: Introduce API to scan switch ports
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>, linux-cxl@vger.kernel.org,
        Chet Douglas <chet.r.douglas@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Nov 10, 2021 at 10:11 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Wed, 10 Nov 2021 09:49:23 -0800
> Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> > On 21-11-03 16:08:21, Jonathan Cameron wrote:
> > > On Fri, 22 Oct 2021 11:36:56 -0700
> > > Ben Widawsky <ben.widawsky@intel.com> wrote:
> > >
> > > > The CXL drivers encapsulate the components that direct memory traffic in
> > > > an entity known as a cxl_port. Compute Express Link specifies three such
> > > > components: hostbridge (ie. a collection of root ports), switches, and
> > > > endpoints. There are currently drivers that create these ports for the
> > > > hostbridges and the endpoints (cxl_acpi and cxl_mem). The new API
> > > > introduced allows callers to initiate a scan down from the hostbridge
> > > > and create ports for switches in the CXL topology.
> > > >
> > > > The intended user of this API is for endpoint devices. An endpoint
> > > > device will need to determine if it is CXL.mem capable, which requires
> > > > all components in the path from hostbridge to the endpoint to be CXL.mem
> > > > capable. Once an endpoint device determines it's connected to a CXL
> > > > capable root port, it can call this API to fill in all the ports in
> > > > between the hostbridge and itself.
> > > >
> > > > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > >
> > > This is an unusual enough thing to be doing on PCI that I'd suggest
> > > making sure to cc linux-pci + Bjorn for next version of this...
> > > Shall we say, this makes me nervous and more eyes might be good :)
> > >
> > > One trivial inline.
> >
> > Makes sense, just this patch or the whole series?
>
> The nervousness was just this patch IIRC.

I would copy linux-pci on the whole thing. The parallel universe that
drivers/cxl/ needs and is attaching to PCI objects in the device tree
should at least be something PCI developers are aware of, especially
when we come back to talk about Native PCI hotplug interactions with
CXL.
