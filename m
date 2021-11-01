Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D910C433EF
	for <linux-cxl@archiver.kernel.org>; Mon,  1 Nov 2021 17:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B5B560E54
	for <linux-cxl@archiver.kernel.org>; Mon,  1 Nov 2021 17:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbhKARkV (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 1 Nov 2021 13:40:21 -0400
Received: from mga12.intel.com ([192.55.52.136]:44807 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231496AbhKARkU (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Mon, 1 Nov 2021 13:40:20 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10154"; a="211122455"
X-IronPort-AV: E=Sophos;i="5.87,200,1631602800"; 
   d="scan'208";a="211122455"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2021 10:36:23 -0700
X-IronPort-AV: E=Sophos;i="5.87,200,1631602800"; 
   d="scan'208";a="599102794"
Received: from ahedgesx-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.133.93])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2021 10:36:22 -0700
Date:   Mon, 1 Nov 2021 10:36:21 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Chet Douglas <chet.r.douglas@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [RFC PATCH v2 08/28] cxl/port: Introduce a port driver
Message-ID: <20211101173621.rylmmmlw3uttskak@intel.com>
References: <20211022183709.1199701-1-ben.widawsky@intel.com>
 <20211022183709.1199701-9-ben.widawsky@intel.com>
 <CAPcyv4g9AUzNihcYJ3AzwZ+UnFquOf1VWX3fZgb-77ZNteFTAA@mail.gmail.com>
 <CAPcyv4jUDXuV-R8HFzJb1K5HK6xaGMor3JH-4AFKJqPJk9FtdA@mail.gmail.com>
 <CAPcyv4gpA=DH0SQvRdmF6dY01mZ1S-gGEWTSDbb+0ajYtyNv0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4gpA=DH0SQvRdmF6dY01mZ1S-gGEWTSDbb+0ajYtyNv0A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 21-10-31 11:10:23, Dan Williams wrote:
> On Sun, Oct 31, 2021 at 10:53 AM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > On Fri, Oct 29, 2021 at 6:37 PM Dan Williams <dan.j.williams@intel.com> wrote:
> > [..]
> > >
> > > Proposed infrastructure for a new cxl_port_decoder_autoremove():
> > >
> > > diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> > > index 3163167ecc3a..78f8313a1069 100644
> > > --- a/drivers/cxl/acpi.c
> > > +++ b/drivers/cxl/acpi.c
> > > @@ -374,6 +374,11 @@ static int add_root_nvdimm_bridge(struct device
> > > *match, void *data)
> > >         return 1;
> > >  }
> > >
> > > +static void clear_cxl_topology_host(void *data)
> > > +{
> > > +       set_cxl_topology_host(NULL);
> > > +}
> > > +
> > >  static int cxl_acpi_probe(struct platform_device *pdev)
> > >  {
> > >         int rc;
> > > @@ -382,6 +387,11 @@ static int cxl_acpi_probe(struct platform_device *pdev)
> > >         struct acpi_device *adev = ACPI_COMPANION(host);
> > >         struct cxl_cfmws_context ctx;
> > >
> > > +       set_cxl_topology_host(host);
> > > +       rc = devm_add_action_or_reset(host, clear_cxl_topology_host, host);
> > > +       if (rc)
> > > +               return rc;
> > > +
> > >         root_port = devm_cxl_add_port(host, host, CXL_RESOURCE_NONE, NULL);
> > >         if (IS_ERR(root_port))
> > >                 return PTR_ERR(root_port);
> > > diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
> > > index 17a4fff029f8..3146b6aa0a2f 100644
> > > --- a/drivers/cxl/core/bus.c
> > > +++ b/drivers/cxl/core/bus.c
> > > @@ -3,6 +3,7 @@
> > >  #include <linux/io-64-nonatomic-lo-hi.h>
> > >  #include <linux/device.h>
> > >  #include <linux/module.h>
> > > +#include <linux/rwsem.h>
> > >  #include <linux/pci.h>
> > >  #include <linux/slab.h>
> > >  #include <linux/idr.h>
> > > @@ -563,6 +564,84 @@ int cxl_decoder_autoremove(struct device *host,
> > > struct cxl_decoder *cxld)
> > >  }
> > >  EXPORT_SYMBOL_NS_GPL(cxl_decoder_autoremove, CXL);
> > >
> > > +void trigger_decoder_autoremove(void *data)
> > > +{
> > > +       struct cxl_decoder *cxld = data;
> > > +       struct device *host = get_cxl_topology_host();
> > > +
> > > +       /* The topology host driver beat us to the punch */
> > > +       if (!host)
> > > +               return;
> >
> > This can be dropped or turned into a WARN_ON() because something is
> > wrong if the port removal is being triggered after the topology host
> > has already went away.
> 
> It further occurs to me that if all ports are guaranteed to be torn
> down by topology host removal, then we might not even need to play
> these games at all. cxl_acpi is already unregistering all of its child
> ports, we just need the property that if a port adds a child port it
> remove it. Then I don't think we even need cxl_topology_host games.

I think having a handle to the "topology_host" is still valuable since I used it
to do the CFMWS lookup. Perhaps you have a different solution for that and I'll
see it later.

Is the suggestion here to have unregister_port() be responsible for doing an
unregister_dev for all children that are ports, or do you mean something else?
