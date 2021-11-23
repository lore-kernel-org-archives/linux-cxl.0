Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20246C433EF
	for <linux-cxl@archiver.kernel.org>; Tue, 23 Nov 2021 22:36:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236366AbhKWWjw (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 23 Nov 2021 17:39:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbhKWWjv (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 23 Nov 2021 17:39:51 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45470C061714
        for <linux-cxl@vger.kernel.org>; Tue, 23 Nov 2021 14:36:43 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id z6so683379pfe.7
        for <linux-cxl@vger.kernel.org>; Tue, 23 Nov 2021 14:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b1stxAQaJMQ5uNT0h90s9ZiMnlvnROVdKPv81CN21oI=;
        b=g7uNTz0Gf8RFtyINdye0ogz27ivKZwS1j/5ETeDW4WWUNcVvq1XYSVv7OvNk7/Eqg4
         wroSTt8iKE0IvcajR0oRieACVGqrVcRiROuS25fk8ppFMfZF2VK5wZc+1xgJyVNass7d
         4+Q2Cie3GFli3hqmF+UKqxuFVt2VSpplc/fLgs6++iFebSrAQ4RWgPrgQYFMlcbGhz5Y
         vg1S265dZ1ywjPXA2DKTKYcFT6UfVAipLyA5AWg5VYjmWHT8E8kM6HHNGbauFgHd19fP
         psr/4g1FcBvn5ZsfuEGACIAB3KegkuA5OMc4wE4CHE9ZvWpW/RHsHszjK8zyzWmAnw+3
         abFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b1stxAQaJMQ5uNT0h90s9ZiMnlvnROVdKPv81CN21oI=;
        b=Q7bjzcZOQSwEou03IUFbpHuQvaGKKDhUyc/69ebh7gY+ysVEJOutSCJoo8Qb8G3VN7
         pHK7jsAU09hZDAysuUPAlVO8kn0uB30zT235rYMyKtmHichOZHnqwNvtWhBnMRY/W11d
         xBdUfjnGQ+6zughy0jd2juvLXiDSAF8zq5XO0bJiWgZPqiwf146RdJzmIETRcVMyIuvN
         kmPwf2NBFiz6L2fdc1BbguC+jwiRuAvYN6zCi5bD4f/H+5FSM8fSCl3fvKkoULS7u+Du
         AuCKW0EssYesVkq8HGz57N0IbaUVAPp+m8JqnfNnvroKzLBe0g0r3X+CaizrgHg9D5XT
         2yrA==
X-Gm-Message-State: AOAM531hP0YggPtDbBi6MPc923wTFRsm6AXWHb6ABUtiU03rILh1HYgG
        5rLg5XA6+P2M9iC5bcK5/Jui/7QXrVS6qj9ADVGwzg==
X-Google-Smtp-Source: ABdhPJyD+CR+jWo0jKsLqS2tqEjW8yAC9Xwqm/Ma1K63/+YZiyZGn+87pUhZovsJcLbBFBUxM4lIut8fuHMJ/tQsNrg=
X-Received: by 2002:a63:8141:: with SMTP id t62mr4423911pgd.5.1637707002691;
 Tue, 23 Nov 2021 14:36:42 -0800 (PST)
MIME-Version: 1.0
References: <20211120000250.1663391-21-ben.widawsky@intel.com>
 <20211123182128.GA2230781@bhelgaas> <20211123220315.itoh4izu56yrrjlh@intel.com>
In-Reply-To: <20211123220315.itoh4izu56yrrjlh@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 23 Nov 2021 14:36:32 -0800
Message-ID: <CAPcyv4h7h3oJTEorMhL6MMD5FYbSxaWs6tb3-w=JWxhR=j77+A@mail.gmail.com>
Subject: Re: [PATCH 20/23] cxl/port: Introduce a port driver
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-cxl@vger.kernel.org,
        Linux PCI <linux-pci@vger.kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Nov 23, 2021 at 2:03 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
[..]
> > I hope this driver is not modeled on the PCI portdrv.  IMO, that was a
> > design error, and the "port service drivers" (PME, hotplug, AER, etc)
> > should be directly integrated into the PCI core instead of pretending
> > to be independent drivers.
>
> I'd like to understand a bit about why you think it was a design error. The port
> driver is intended to be a port services driver, however I see the services
> provided as quite different than the ones you mention. The primary service
> cxl_port will provide from here on out is the ability to manage HDM decoder
> resources for a port. Other independent drivers that want to use HDM decoder
> resources would rely on the port driver for this.
>
> It could be in CXL core just the same, but I don't see too much of a benefit
> since the code would be almost identical. One nice aspect of having the port
> driver outside of CXL core is it would allow CXL devices which do not need port
> services (type-1 and probably type-2) to not need to load the port driver. We do
> not have examples of such devices today but there's good evidence they are being
> built. Whether or not they will even want CXL core is another topic up for
> debate however.
>
> I admit Dan and I did discuss putting this in either its own port driver, or
> within core as a port driver. My inclination is, less is more in CXL core; but
> perhaps you will be able to change my mind.

No, I don't think Bjorn is talking about whether the driver is
integrated into cxl_core.ko vs its own cxl_port.ko. IIUC this goes
back to the original contention about have /sys/bus/cxl at all:

https://lore.kernel.org/r/CAPcyv4iu8D-hJoujLXw8a4myS7trOE1FcUhESLB_imGMECVfrg@mail.gmail.com

Unlike pcieportdrv where the functionality is bounded to a single
device instance with relatively simpler hierarchical coordination of
the memory space and services. CXL interleaving is both a foreign
concept to the PCIE core and an awkward fit for the pci_bus_type
device model. CXL uses the cxl_bus_type and bus drivers to coordinate
CXL operations that have cross PCI device implications.

Outside of that I think the auxiliary device driver model, of which
the PCIE portdrv model is an open-coded form, is a useful construct
for separation of concerns. That said, I do want to hear more about
what trouble it has caused though to make sure that CXL does not trip
over the same issues longer term.

[..]
> > > +static void rescan_ports(struct work_struct *work)
> > > +{
> > > +   if (bus_rescan_devices(&cxl_bus_type))
> > > +           pr_warn("Failed to rescan\n");
> >
> > Needs some context.  A bare "Failed to rescan" in the dmesg log
> > without a clue about who emitted it is really annoying.
> >
> > Maybe you defined pr_fmt() somewhere; I couldn't find it easily.
> >
>
> I actually didn't know about pr_fmt() trick, so thanks for that. I'll improve
> this message to be more useful and contextual.

I am skeptical that this implementation of the workqueue properly
synchronizes with workqueue shutdown concerns, but I have not had a
chance to dig in too deep on this patchset.

Regardless, it is not worth reporting a rescan failure, because those
are to be expected here. The rescan attempts to rescan when a
constraint changes, there is no guarantee that all constraints are met
just because one constraint changed, so rescan failures
(device_attach() failures) are not interesting to report. The
individual driver probe failure reporting is sufficient.
