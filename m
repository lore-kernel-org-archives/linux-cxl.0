Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22646C433F5
	for <linux-cxl@archiver.kernel.org>; Wed, 10 Nov 2021 17:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F25E761037
	for <linux-cxl@archiver.kernel.org>; Wed, 10 Nov 2021 17:49:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbhKJRwN (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 10 Nov 2021 12:52:13 -0500
Received: from mga05.intel.com ([192.55.52.43]:13016 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232460AbhKJRwM (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Wed, 10 Nov 2021 12:52:12 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10164"; a="318925820"
X-IronPort-AV: E=Sophos;i="5.87,224,1631602800"; 
   d="scan'208";a="318925820"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2021 09:49:25 -0800
X-IronPort-AV: E=Sophos;i="5.87,224,1631602800"; 
   d="scan'208";a="534125502"
Received: from rwmcguir-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.137.122])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2021 09:49:24 -0800
Date:   Wed, 10 Nov 2021 09:49:23 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, Chet Douglas <chet.r.douglas@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [RFC PATCH v2 15/28] cxl/core: Introduce API to scan switch ports
Message-ID: <20211110174923.5cdbfyyoixbhiqjt@intel.com>
References: <20211022183709.1199701-1-ben.widawsky@intel.com>
 <20211022183709.1199701-16-ben.widawsky@intel.com>
 <20211103160821.0000479e@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211103160821.0000479e@Huawei.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 21-11-03 16:08:21, Jonathan Cameron wrote:
> On Fri, 22 Oct 2021 11:36:56 -0700
> Ben Widawsky <ben.widawsky@intel.com> wrote:
> 
> > The CXL drivers encapsulate the components that direct memory traffic in
> > an entity known as a cxl_port. Compute Express Link specifies three such
> > components: hostbridge (ie. a collection of root ports), switches, and
> > endpoints. There are currently drivers that create these ports for the
> > hostbridges and the endpoints (cxl_acpi and cxl_mem). The new API
> > introduced allows callers to initiate a scan down from the hostbridge
> > and create ports for switches in the CXL topology.
> > 
> > The intended user of this API is for endpoint devices. An endpoint
> > device will need to determine if it is CXL.mem capable, which requires
> > all components in the path from hostbridge to the endpoint to be CXL.mem
> > capable. Once an endpoint device determines it's connected to a CXL
> > capable root port, it can call this API to fill in all the ports in
> > between the hostbridge and itself.
> > 
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> 
> This is an unusual enough thing to be doing on PCI that I'd suggest
> making sure to cc linux-pci + Bjorn for next version of this...
> Shall we say, this makes me nervous and more eyes might be good :)
> 
> One trivial inline.

Makes sense, just this patch or the whole series?

> > ---
> >  .../driver-api/cxl/memory-devices.rst         |   6 +
> >  drivers/cxl/core/Makefile                     |   1 +
> >  drivers/cxl/core/bus.c                        | 145 ++++++++++++++++++
> >  drivers/cxl/core/pci.c                        |  99 ++++++++++++
> >  drivers/cxl/cxl.h                             |   2 +
> >  drivers/cxl/pci.h                             |   6 +
> >  drivers/cxl/port.c                            |   2 +-
> >  tools/testing/cxl/Kbuild                      |   1 +
> >  8 files changed, 261 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/cxl/core/pci.c
> > 
> ...
> 
> > diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
> > index c7e1894d503b..f10e7d5b22a4 100644
> > --- a/drivers/cxl/core/bus.c
> > +++ b/drivers/cxl/core/bus.c
> ...
> > +static struct cxl_port *find_cxl_port(struct pci_dev *usp)
> > +{
> > +	struct device *port_dev;
> > +
> > +	if (!pci_is_pcie(usp) || pci_pcie_type(usp) != PCI_EXP_TYPE_UPSTREAM)
> > +		return NULL;
> > +
> > +	port_dev = bus_find_device(&cxl_bus_type, NULL, usp, match_port);
> > +	if (port_dev)
> > +		return to_cxl_port(port_dev);
> 
> Flip this logic to make it more readable.
> 	if (!port_dev)
> 		return NULL;
> 
> > +
> > +	return NULL;
> > +}
> > +
