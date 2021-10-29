Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB3C0C433EF
	for <linux-cxl@archiver.kernel.org>; Fri, 29 Oct 2021 21:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5E0561075
	for <linux-cxl@archiver.kernel.org>; Fri, 29 Oct 2021 21:20:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbhJ2VXO (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 29 Oct 2021 17:23:14 -0400
Received: from mga03.intel.com ([134.134.136.65]:61315 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230257AbhJ2VXN (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Fri, 29 Oct 2021 17:23:13 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10152"; a="230706027"
X-IronPort-AV: E=Sophos;i="5.87,193,1631602800"; 
   d="scan'208";a="230706027"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2021 14:20:44 -0700
X-IronPort-AV: E=Sophos;i="5.87,193,1631602800"; 
   d="scan'208";a="487721027"
Received: from applebex-mobl2.amr.corp.intel.com (HELO intel.com) ([10.252.137.25])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2021 14:20:44 -0700
Date:   Fri, 29 Oct 2021 14:20:42 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Chet Douglas <chet.r.douglas@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [RFC PATCH v2 01/28] cxl: Rename CXL_MEM to CXL_PCI
Message-ID: <20211029212042.so56mkjju3ja2k54@intel.com>
References: <20211022183709.1199701-1-ben.widawsky@intel.com>
 <20211022183709.1199701-2-ben.widawsky@intel.com>
 <CAPcyv4i_ZnMkTwOcg=94AO959Gzt1FFkirEO=FL3sjNcMsCAeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4i_ZnMkTwOcg=94AO959Gzt1FFkirEO=FL3sjNcMsCAeA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 21-10-29 13:15:46, Dan Williams wrote:
> On Fri, Oct 22, 2021 at 11:37 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
> >
> > With the upcoming introduction of a driver to control the non-PCI
> > aspects of CXL.mem, such as interleave set creation and configuration,
> > there will be an opportunity to disconnection control over CXL device
> 
> s/disconnection/disconnect/
> 
> > memory and CXL device manageability. CXL device manageability is
> > implemented by the cxl_pci driver. Doing this rename allows the CXL
> > memory driver to be enabled by a new config option independently of CXL
> > device manageability through CXL.io/PCI mechanisms.
> 
> That comes across a bit hard to parse to me, how about:
> 
> "The cxl_mem module was renamed cxl_pci in commit 21e9f76733a8 ("cxl:
> Rename mem to pci"). In preparation for adding an ancillary driver for
> cxl_memdev devices (registered on the cxl bus by cxl_pci), go ahead
> and rename CONFIG_CXL_MEM to CONFIG_CXL_PCI. Tree up the CXL_MEM name

I assume you meant s/tree/tee - right?

> for that new driver to manage generic CXL.mem endpoint operations."
> 
> > Suggested-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > ---
> >  drivers/cxl/Kconfig  | 13 ++++++-------
> >  drivers/cxl/Makefile |  2 +-
> >  2 files changed, 7 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> > index e6de221cc568..23773d0ac896 100644
> > --- a/drivers/cxl/Kconfig
> > +++ b/drivers/cxl/Kconfig
> > @@ -13,14 +13,13 @@ menuconfig CXL_BUS
> >
> >  if CXL_BUS
> >
> > -config CXL_MEM
> > -       tristate "CXL.mem: Memory Devices"
> > +config CXL_PCI
> > +       tristate "PCI manageability"
> 
> s/PCI manageability/CXL Memory Device: PCI Operations/
> 
> ...as I don't think an end user reading "PCI Manageability" would know
> that it supports basic memory expander enumeration and mailbox
> operations.
> 
> >         default CXL_BUS
> >         help
> > -         The CXL.mem protocol allows a device to act as a provider of
> > -         "System RAM" and/or "Persistent Memory" that is fully coherent
> > -         as if the memory was attached to the typical CPU memory
> > -         controller.
> > +         The CXL specification defines a set of interfaces which are controlled
> > +         through well known PCI configuration mechanisms. Such access is
> > +         referred to CXL.io in the specification.
> 
> The CXL specification defines a "CXL memory device" sub-class in the
> PCI "memory controller" base class of devices. Device's identified by
> this class code provide support for volatile and / or persistent
> memory to be mapped into the system address map (Host-managed Device
> Memory (HDM)).
> 
> >
> >           Say 'y/m' to enable a driver that will attach to CXL.mem devices for
> 
> This would need updating too...
> 
> s/CXL.mem devices /generic CXL memory expanders identified by the
> memory device class code/
> 
> ...to reduce confusion about this driver for generic type-3 vs vendor
> specific type-2 devices that also support CXL.mem
> 

Overall seems like an improvement to me. I'm not too fond of the word "generic"
though, both here and in the commit message. I think they work equally well just
deleting that word.

> >           configuration and management primarily via the mailbox interface. See
> > @@ -31,7 +30,7 @@ config CXL_MEM
> >
> >  config CXL_MEM_RAW_COMMANDS
> >         bool "RAW Command Interface for Memory Devices"
> > -       depends on CXL_MEM
> > +       depends on CXL_PCI
> >         help
> >           Enable CXL RAW command interface.
> >
> > diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
> > index d1aaabc940f3..cf07ae6cea17 100644
> > --- a/drivers/cxl/Makefile
> > +++ b/drivers/cxl/Makefile
> > @@ -1,6 +1,6 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >  obj-$(CONFIG_CXL_BUS) += core/
> > -obj-$(CONFIG_CXL_MEM) += cxl_pci.o
> > +obj-$(CONFIG_CXL_PCI) += cxl_pci.o
> >  obj-$(CONFIG_CXL_ACPI) += cxl_acpi.o
> >  obj-$(CONFIG_CXL_PMEM) += cxl_pmem.o
> >
> > --
> > 2.33.1
> >
