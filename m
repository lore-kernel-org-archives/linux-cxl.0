Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44034C48BD1
	for <linux-cxl@archiver.kernel.org>; Fri, 11 Jun 2021 23:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D4506124C
	for <linux-cxl@archiver.kernel.org>; Fri, 11 Jun 2021 23:26:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbhFKX2Q (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 11 Jun 2021 19:28:16 -0400
Received: from mail-pj1-f51.google.com ([209.85.216.51]:39881 "EHLO
        mail-pj1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbhFKX2P (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 11 Jun 2021 19:28:15 -0400
Received: by mail-pj1-f51.google.com with SMTP id w14-20020a17090aea0eb029016e9e0e7983so170564pjy.4
        for <linux-cxl@vger.kernel.org>; Fri, 11 Jun 2021 16:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NRPaXiyWw09i4FXsXzqTGbFV36hQVYFvFNIq5L13HVo=;
        b=FecO0yDtUwufaEcPlqy4EvBDXv0RG+KrLKiBFSYxjyG7826p3FI0Txr93bsf36KUql
         u0VSY9bYf99yfiKwO+k+AzZmcy/w9wrpq7BYt9y68w1sXDlJWBizWLI0o1821dq+ULgY
         EbXCr/9vx+C7B15jLrA+pNMz2HQRnjA7bMMof5WdQ6gvr48bjQnME8zYbD6uOKEyd5B4
         mH0lCxV0HaR59FNvBiJd/JLBWYD+6y/mQ7Eo8ZteR56oXA0xaQ33oVjXT3LIWigiqQC5
         VgE/Ol9IydQU4zzsl44R5qssD7KLzrI53xjwE3XEiRA+QECuAlLxKKLJwFms6ClAsmy9
         WM7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NRPaXiyWw09i4FXsXzqTGbFV36hQVYFvFNIq5L13HVo=;
        b=D5eyXAPNll4FBy7CgU/9MLQ2RRMsNcp/wDSExDtLRCxynjCXqbdDVvvWk9cMtn+Z0A
         z8YbktUUMTpSeIxqkeGNgujmqmVMukoMaWyuXhcj2O9eDacqPdwuGJAuOe6hnMryfXxb
         hOz6JDWM19ectO7toq68/sGeKDBqbizlDUnZDgh74t/707lCOoJ+q8KVbkOdN2O66u69
         PGDVW6kvK7yXb5XCYBysIcAQkm55N8SIqmZmWvopUyPeOR199Vaia7xzkSCPgoeKV7Hp
         T0ugS2/6wNF99D7v1tS06oq+Y95wS4YvI19FtGEFtZ6H9ZNuXNWKLmZdrIrPgRa9izPz
         Qkbw==
X-Gm-Message-State: AOAM533GCTruN0pkSAyQye1bJBOg7WT0MzM4C9AlX+xIdacl2tPiVqYP
        8BtFSxGeed8Z9xyJ0L8sPldgKAqqg0eDXg0MyyJiPw==
X-Google-Smtp-Source: ABdhPJxCPzOzrMWRfLG9k8FkShRI4spGXhm00FuDBb34f3l5OwsnwcU13r6GTa2DeuH5FPnYh3tMmwiGKdHQz0DH4mM=
X-Received: by 2002:a17:902:b497:b029:115:e287:7b55 with SMTP id
 y23-20020a170902b497b0290115e2877b55mr5941567plr.79.1623453916871; Fri, 11
 Jun 2021 16:25:16 -0700 (PDT)
MIME-Version: 1.0
References: <162336395765.2462439.11368504490069925374.stgit@dwillia2-desk3.amr.corp.intel.com>
 <162336396329.2462439.16556923116284874437.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20210611174736.ttzpk5uniyoyd4vw@intel.com> <CAPcyv4i7_RhfiYMX=QP2Ts4ye1Q2e0=_aBCP4rsuopo=0HWKVw@mail.gmail.com>
 <20210611192829.bwdj322uwlsbdrjs@intel.com>
In-Reply-To: <20210611192829.bwdj322uwlsbdrjs@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 11 Jun 2021 16:25:05 -0700
Message-ID: <CAPcyv4gwUiQLfPGe9kKi7JJdbSk-aaSywo29x=kFKdeEROdMcQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] cxl/core: Add cxl-bus driver infrastructure
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, Linux NVDIMM <nvdimm@lists.linux.dev>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Jun 11, 2021 at 12:28 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> On 21-06-11 11:55:39, Dan Williams wrote:
> > On Fri, Jun 11, 2021 at 10:47 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
> > >
> > > On 21-06-10 15:26:03, Dan Williams wrote:
> > > > Enable devices on the 'cxl' bus to be attached to drivers. The initial
> > > > user of this functionality is a driver for an 'nvdimm-bridge' device
> > > > that anchors a libnvdimm hierarchy attached to CXL persistent memory
> > > > resources. Other device types that will leverage this include:
> > > >
> > > > cxl_port: map and use component register functionality (HDM Decoders)
> > >
> > > Since I'm looking at this now, perhaps I can open the discussion here. Have you
> > > thought about how this works yet? Right now I'm thinking there are two "drivers":
> > > cxl_port: Switches (and ACPI0016)
> > > cxl_mem: The memory device's HDM decoders
> > >
> > > For port, probe() will figure out that the thing is an upstream port, call
> > > cxl_probe_component_regs and then call devm_cxl_add_port(). I think that's
> > > straight forward.
> >
> > I was expecting cxl_port_driver.probe() comes *after* port discovery.
> > Think of it like PCI discovery. Some agent does the hardware topology
> > scan to add devices, in this case devm_cxl_add_port(), and that
> > triggers cxl_port_driver to load. So the initial enumeration done by
> > the cxl_acpi driver will populate the first two levels of the port
> > hierarchy with port objects and populate their component register
> > physical base addresses. For any other port deeper in the hierarchy I
> > was expecting that to be scanned after the discovery of a cxl_memdev
> > that is not attached to the current hierarchy. So, for example imagine
> > a config like:
> >
> > Platform --> Host Bridge --> Switch --> Endpoint
> >
> > ...where in sysfs that's modeled as:
> >
> > root0 --> port1 --> port2 --> port3
> >
> > Where port3 is assuming that the CXL core models the device's
> > connection to the topology as yet another cxl_port. At the beginning
> > of time after cxl_acpi has loaded but before cxl_pci has discovered
> > the endpoint the topology is:
> >
> > root0 --> port1
> >
> > Upon the detection of the endpoint the CXL core can assume that all
> > intermediary switches between the root and this device have been
> > registered as PCI devices. So, it follows that endpoint device arrival
> > triggers "cxl_bus_rescan()" that goes and enumerates all the CXL
> > resources in the topology to produce:
> >
> > root0 --> port1 --> port2 --> port3
> >
>
> Ah, I had written about scan/rescan in an earlier version of my email but
> dropped it. I was actually going to suggest it being a sysfs attr, but I'm fine
> with it being implicit so long as...
>
> How do we assert that cxl_pci doesn't run before cxl_acpi has done anything?

I don't think we need to, or it's broken if the driver load order
matters. The nvdimm enabling code is an example of how to handle this.
The cxl_nvdimm object can be registered before the cxl_nvdimm_bridge,
or after, does not matter. If the cxl_nvdimm comes first it will
trigger the cxl_nvdimm_driver to load. The cxl_nvdimm_driver.probe()
routine finds no bridge present and probe() returns with a failure.
When the bridge arrives it does a rescan  of the cxl_bus_type device
list and if it finds a cxl_nvdimm it re-triggers
cxl_nvdimm_driver.probe(). This time through cxl_nvdimm_driver.probe()
finds the bridge and registers the real nvdimm on the nvdimm_bus.

> I
> like the idea that the endpoint device can simply ask cxl_acpi to rescan, I just
> don't see how it works. I suppose we can queue up the requests to rescan in
> cxl_acpi if the ordering can't be guaranteed.

I think this means that the devm_cxl_add_port() would be triggered by
cxl_memdev_driver.probe() if and only if the parent pci_device of the
CXL endpoint is listed as a dport. If the cxl_memdev is registered
first the search it will search for the CXL root port on the
cxl_bus_type device list. If that fails then cxl_memdev_driver.probe()
fails. If that succeeds it asks the root to scan to the CXL endpoint
parent pci_device and return the confirmation that it is registered as
a dport. If that fails then the device is plugged into a pure PCIe
slot.

When cxl_acpi loads it retriggers all cxl_memdev_driver.probe() to
reconsider all cxl_memdev instances that failed to probe previously.

>
> > > For the memory device we've already probed the thing via class code so there is
> > > no need to use this driver registration, however, I think it would be nice to do
> > > so. Is there a clean way to do that?
> >
> > The PCI device associated with the endpoint is already probed, but the
> > cxl_memdev itself can have a driver on the CXL bus. So I think the
> > cxl_memdev driver should try to register a cxl_port after telling
> > cxl_acpi to rescan. If a check like "is_cxl_dport(pdev->dev.parent)"
> > for the endpoint returns false it means that the cxl_bus_rescan()
> > failed to enumerate the CXL topology to this endpoint and this
> > endpoint is limited to only CXL.io operation.
>
> What is going to invoke the memdev driver's probe? That is where we're talking
> about putting that is_cxl_dport(...) right? That is the part that tripped me up
> and inspired the original email FWIW.

I *think* I worked that out above, but yes please do poke at it to see
if it holds up.
