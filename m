Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51440C433EF
	for <linux-cxl@archiver.kernel.org>; Wed, 24 Nov 2021 00:40:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbhKXAn1 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 23 Nov 2021 19:43:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbhKXAn1 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 23 Nov 2021 19:43:27 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D50C061714
        for <linux-cxl@vger.kernel.org>; Tue, 23 Nov 2021 16:40:18 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id p18so422179plf.13
        for <linux-cxl@vger.kernel.org>; Tue, 23 Nov 2021 16:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x60Xz0mkS57X48j482rWr3Rf1pfRVTsLKSyPPWK2n7o=;
        b=PP/37UqeWqTr4zwflvUMn4A13jKlcRadpeHxCgfdqsltijGxLQJ1PO2JakPNwr6kHm
         1US4XJGWoioEgLS+RXeliDnOcXlF+2X3Mu4pPMvuBUZwlQU17z25HkskICW7WuNHwhUE
         WiZ9Cd3F6KC6WqyPj5bDSDUanNxH2yA1IV2bARaUIIuTfYBdVlMmhyU1vLhTZkdqgoke
         dgyrgHmJv+ssQAT6d9PY95Xf+R/IlzwsW8MEXKB24E+c8G4GjBpdJDZXys2n5e4wILo1
         SuxeqQ6EnYffqbsKSQge+sQumy/U4AlnbAcJSGCGehqWRXHPWoYM1n1P8hUCQAVdbhsD
         M5vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x60Xz0mkS57X48j482rWr3Rf1pfRVTsLKSyPPWK2n7o=;
        b=K+Ku1Wn7Ow3YsQ9Vz+eio//pwsfiySELXKRfIA9GUV1zT9bNHxvTIGwrzZwyNjuALe
         HoaKs+girXp0r1NI08BLamWt59rCK8wCQbb5julIXFrFzsrO9WjTP6d0RDliWUcEB5If
         TMoZ9ocYpttlwzLxC1T7Tp0KmVSN3k5ksppUwjcozfNWidTE5R6FzeYZUfxmnhZ/hlJl
         P6kBoaMjX0GNRVtkXIhKpc+8GHx0OyzzftO0puqWATO031wXTFzbXcaDXPpQ1PO/+LYH
         /MbZZw4mOE6IhcVzK05hUD0OryI/bwk1n1mVqHIbhc/82J0jIl3XTvT6VS5M9sPB1nrA
         CGtA==
X-Gm-Message-State: AOAM530JA3SjhEYpYCob9A9Q8XDLvk4YaPbZcdp0sU0Mcgxp4me/NHIO
        ALDk81obqJ21F9PqvhRml/ZDpu9xpgH+pHCNVp3QFQ==
X-Google-Smtp-Source: ABdhPJzfjgUAWFKANfRT1itwVNc2NbH7evF2wVZUdpMMPt2dfZQlRdKcEQLH2LOS8/MV0JEEqcNjm5d6ZU9o26CT9po=
X-Received: by 2002:a17:90a:e7ca:: with SMTP id kb10mr9008554pjb.8.1637714417799;
 Tue, 23 Nov 2021 16:40:17 -0800 (PST)
MIME-Version: 1.0
References: <CAPcyv4h7h3oJTEorMhL6MMD5FYbSxaWs6tb3-w=JWxhR=j77+A@mail.gmail.com>
 <20211123235557.GA2247853@bhelgaas>
In-Reply-To: <20211123235557.GA2247853@bhelgaas>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 23 Nov 2021 16:40:06 -0800
Message-ID: <CAPcyv4g0=zz8BtB9DRW0FGsRRvgGwEaQcgbmXDhJ3DwNFS9Z+g@mail.gmail.com>
Subject: Re: [PATCH 20/23] cxl/port: Introduce a port driver
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Ben Widawsky <ben.widawsky@intel.com>, linux-cxl@vger.kernel.org,
        Linux PCI <linux-pci@vger.kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Nov 23, 2021 at 3:56 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Christoph, since he has opinions about portdrv;
> Greg, Rafael, since they have good opinions about sysfs structure]
>
> On Tue, Nov 23, 2021 at 02:36:32PM -0800, Dan Williams wrote:
> > On Tue, Nov 23, 2021 at 2:03 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
> > [..]
> > > > I hope this driver is not modeled on the PCI portdrv.  IMO, that
> > > > was a design error, and the "port service drivers" (PME,
> > > > hotplug, AER, etc) should be directly integrated into the PCI
> > > > core instead of pretending to be independent drivers.
> > >
> > > I'd like to understand a bit about why you think it was a design
> > > error. The port driver is intended to be a port services driver,
> > > however I see the services provided as quite different than the
> > > ones you mention. The primary service cxl_port will provide from
> > > here on out is the ability to manage HDM decoder resources for a
> > > port. Other independent drivers that want to use HDM decoder
> > > resources would rely on the port driver for this.
> > >
> > > It could be in CXL core just the same, but I don't see too much of
> > > a benefit since the code would be almost identical. One nice
> > > aspect of having the port driver outside of CXL core is it would
> > > allow CXL devices which do not need port services (type-1 and
> > > probably type-2) to not need to load the port driver. We do not
> > > have examples of such devices today but there's good evidence they
> > > are being built. Whether or not they will even want CXL core is
> > > another topic up for debate however.
> > >
> > > I admit Dan and I did discuss putting this in either its own port
> > > driver, or within core as a port driver. My inclination is, less
> > > is more in CXL core; but perhaps you will be able to change my
> > > mind.
> >
> > No, I don't think Bjorn is talking about whether the driver is
> > integrated into cxl_core.ko vs its own cxl_port.ko. IIUC this goes
> > back to the original contention about have /sys/bus/cxl at all:
> >
> > https://lore.kernel.org/r/CAPcyv4iu8D-hJoujLXw8a4myS7trOE1FcUhESLB_imGMECVfrg@mail.gmail.com
>
> That question was about whether we want the same physical device to be
> represented both in the /sys/bus/pci hierarchy and the /sys/bus/cxl
> hierarchy.  That still seems a little weird to me, but I don't know
> enough about the CXL constraints to really object to it.
>
> My question here is more about whether you're going to use something
> like the pcie_port_service_register() model for supporting multiple
> drivers attached to the same physical device.
>
> The PCIe portdrv creates a /sys/bus/pci_express hierarchy parallel to
> the /sys/bus/pci hierarchy.  The pci_express hierarchy has a "device"
> for every service (hotplug, AER, DPC, PME, etc) (see
> pcie_device_init()).  This device creation is quite complicated and
> depends on whether the Port advertises a Capability, whether the
> platform has granted control to the OS, whether support is compiled
> in, etc.
>
> I think that was a mistake because these hotplug, AER, DPC, PME
> "devices" are not independent things.  They are optional features that
> can be added to a variety of devices, and those devices might have
> their own drivers.  For example, we want to write drivers for
> vendor-specific functionality like PMUs in switches, but we can't do
> that cleanly because portdrv claims them.
>
> The portdrv features are fully specified by the PCIe spec, so nothing
> is vendor-specific.  They share interrupts.  They share power state.
> They cannot be reset independently.  They are not addressable entities
> in the usual bus/device/function model.  They can't be removed or
> added like the underlying device can.  I wasn't there when they were
> designed, but from reading the spec, it seems like they were designed
> as optional features of a device, not as separate devices themselves.

Let me ask a clarifying question coming from the other direction that
resulted in the creation of the auxiliary bus architecture. Some
background. RDMA is a protocol that may run on top of Ethernet.
Consider the case where you have multiple generations of Ethernet
adapter devices, but they all support common RDMA functionality. You
only have the one PCI device to attach a unique Ethernet driver. What
is an idiomatic way to deploy a module that automatically loads and
attaches to the exported common functionality across adapters that
otherwise have a unique native driver for the hardware device?

Another example, the Native PCIe Enclosure Management (NPEM)
specification defines a handful of registers that can appear anywhere
in the PCIe hierarchy. How can you write a common driver that is
generically applicable to any given NPEM instance?

The auxiliary bus answer to those questions is to register an
auxiliary device to be driven by a common auxiliary driver across
hard-device generations from the same vendor or even across vendors.

For your example about a PCIe port PMU driver it ultimately requires
something to enumerate that capability and a library of code to
exercise that functionality. What is a more natural fit than a Linux
"device" and a Linux driver to coordinate attaching enabling code to a
standalone hardware capability?

PCIe portdrv may be awkward because there was never a real native
driver for the device to begin with and it all could have handled by
'pcie_portdriver' directly without registering more Linux devices, but
assigning self contained features to Linux devices otherwise seems a
useful idiom to me.

As for CXL, there is no analog of the PCIe portdrv pattern of just
having a device act as a multiplexer of features to other Linux
devices.
