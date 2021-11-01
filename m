Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C15C433F5
	for <linux-cxl@archiver.kernel.org>; Mon,  1 Nov 2021 21:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2100A60F36
	for <linux-cxl@archiver.kernel.org>; Mon,  1 Nov 2021 21:45:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbhKAVsO (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 1 Nov 2021 17:48:14 -0400
Received: from mga02.intel.com ([134.134.136.20]:5269 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232199AbhKAVsN (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Mon, 1 Nov 2021 17:48:13 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10155"; a="218321435"
X-IronPort-AV: E=Sophos;i="5.87,200,1631602800"; 
   d="scan'208";a="218321435"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2021 14:45:39 -0700
X-IronPort-AV: E=Sophos;i="5.87,201,1631602800"; 
   d="scan'208";a="531334368"
Received: from jisears-mobl1.amr.corp.intel.com (HELO intel.com) ([10.252.137.88])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2021 14:45:39 -0700
Date:   Mon, 1 Nov 2021 14:45:38 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Chet Douglas <chet.r.douglas@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [RFC PATCH v2 11/28] cxl/acpi: Rescan bus at probe completion
Message-ID: <20211101214538.pn2ifizia4vkyeub@intel.com>
References: <20211022183709.1199701-1-ben.widawsky@intel.com>
 <20211022183709.1199701-12-ben.widawsky@intel.com>
 <CAPcyv4jm3Hp_XYkQiNYvwhF-S6-3k4qvs-a=4zS1YKukne1dnQ@mail.gmail.com>
 <20211101185602.apavn3je3nqbasx3@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211101185602.apavn3je3nqbasx3@intel.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 21-11-01 11:56:02, Ben Widawsky wrote:
> On 21-10-31 12:25:32, Dan Williams wrote:
> > On Fri, Oct 22, 2021 at 11:37 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
> > >
> > > Ensure that devices being probed before cxl_acpi has completed will get
> > > a second chance.
> > 
> > I think this is at the wrong level... more below.
> > >
> > > CXL drivers are brought up through two enumerable, asynchronous
> > > mechanism. The leaf nodes in the CXL topology, endpoints, are enumerated
> > > via PCI headers. The root node's enumeration is platform specific. The
> > > current defacto mechanism for enumerating the root node is through the
> > > presence of an ACPI device, ACPI0017.
> > >
> > > The primary job of a cxl_mem driver is to determine if CXL.mem traffic
> > > can be routed to/from the PCIe device that it is being probed. A
> > > prerequisite in this determination is that all CXL components in the
> > > path from root to leaf are capable of routing CXL.mem traffic. If the
> > > cxl_mem driver is probed before cxl_acpi is complete the driver will be
> > > unable to make this determination. To address this, cxl_acpi (or in the
> > > future, another platform specific driver) will rescan all devices to
> > > make sure the ordering is correct.
> > >
> > > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > > ---
> > >  drivers/cxl/acpi.c | 20 +++++++++++++++++++-
> > >  1 file changed, 19 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> > > index 625c5d95b83f..1cc3a74c16bd 100644
> > > --- a/drivers/cxl/acpi.c
> > > +++ b/drivers/cxl/acpi.c
> > > @@ -451,6 +451,14 @@ static u32 cedt_instance(struct platform_device *pdev)
> > >         return U32_MAX;
> > >  }
> > >
> > > +static void bus_rescan(struct work_struct *work)
> > > +{
> > > +       if (bus_rescan_devices(&cxl_bus_type))
> > > +               pr_err("Failed to rescan CXL bus\n");
> > > +}
> > > +
> > > +static DECLARE_WORK(deferred_bus_rescan, bus_rescan);
> > > +
> > >  static int cxl_acpi_probe(struct platform_device *pdev)
> > >  {
> > >         int rc;
> > > @@ -484,9 +492,19 @@ static int cxl_acpi_probe(struct platform_device *pdev)
> > >         if (rc)
> > >                 goto out;
> > >
> > > -       if (IS_ENABLED(CONFIG_CXL_PMEM))
> > > +       if (IS_ENABLED(CONFIG_CXL_PMEM)) {
> > >                 rc = device_for_each_child(&root_port->dev, root_port,
> > >                                            add_root_nvdimm_bridge);
> > > +               if (rc)
> > > +                       goto out;
> > > +       }
> > > +
> > > +       /*
> > > +        * While ACPI is scanning hostbridge ports, switches and memory devices
> > > +        * may have been probed. Those devices will need to know whether the
> > > +        * hostbridge is CXL capable.
> > > +        */
> > > +       schedule_work(&deferred_bus_rescan);
> > 
> > I think this belongs in port driver similar to the one in
> > drivers/cxl/pmem.c, because any port online event might mean that a
> > downstream port can now attach to the port driver. I prefer a local
> > ordered workqueue via queue_work() rather than the global unordered
> > workqueue primarily because it can be flushed without getting
> > entangled with other random work in the system, but also because the
> > ordered property is useful for comprehended hierarchical topology
> > events.
> 
> Makes sense. I was trying to limit the number of rescans that took place and I
> believe I convinced myself that the current patch does work properly. However,
> architecturally it makes more sense for the port driver to own this and
> realistically I assume many rescans will coalesce.
> 

Oh. I assume you want this rolled into (cxl/port: Introduce a port driver),
correct?

> > 
> > In any event this is missing flushing to prevent races between .text
> > removal at module_exit() and pending work.
> 
