Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00302C433EF
	for <linux-cxl@archiver.kernel.org>; Mon,  1 Nov 2021 17:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBBC2610FC
	for <linux-cxl@archiver.kernel.org>; Mon,  1 Nov 2021 17:54:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbhKAR4v (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 1 Nov 2021 13:56:51 -0400
Received: from mga06.intel.com ([134.134.136.31]:19931 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231378AbhKAR4v (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Mon, 1 Nov 2021 13:56:51 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10154"; a="291909928"
X-IronPort-AV: E=Sophos;i="5.87,200,1631602800"; 
   d="scan'208";a="291909928"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2021 10:54:17 -0700
X-IronPort-AV: E=Sophos;i="5.87,200,1631602800"; 
   d="scan'208";a="500139298"
Received: from ahedgesx-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.133.93])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2021 10:54:17 -0700
Date:   Mon, 1 Nov 2021 10:54:16 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Chet Douglas <chet.r.douglas@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [RFC PATCH v2 08/28] cxl/port: Introduce a port driver
Message-ID: <20211101175416.yunihgjtmhtsf24v@intel.com>
References: <20211022183709.1199701-1-ben.widawsky@intel.com>
 <20211022183709.1199701-9-ben.widawsky@intel.com>
 <CAPcyv4g9AUzNihcYJ3AzwZ+UnFquOf1VWX3fZgb-77ZNteFTAA@mail.gmail.com>
 <20211101175314.lrq3ccqkts725bjt@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211101175314.lrq3ccqkts725bjt@intel.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 21-11-01 10:53:15, Ben Widawsky wrote:
> On 21-10-29 18:37:36, Dan Williams wrote:
> > On Fri, Oct 22, 2021 at 11:37 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
> > >
> > >  obj-$(CONFIG_CXL_PCI) += cxl_pci.o
> > >  obj-$(CONFIG_CXL_ACPI) += cxl_acpi.o
> > >  obj-$(CONFIG_CXL_PMEM) += cxl_pmem.o
> > > @@ -7,3 +8,4 @@ obj-$(CONFIG_CXL_PMEM) += cxl_pmem.o
> > >  cxl_pci-y := pci.o
> > >  cxl_acpi-y := acpi.o
> > >  cxl_pmem-y := pmem.o
> > > +cxl_port-y := port.o
> > > diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> > > index b972abc9f6ef..d61397055e9f 100644
> > > --- a/drivers/cxl/acpi.c
> > > +++ b/drivers/cxl/acpi.c
> > > @@ -491,3 +491,4 @@ static struct platform_driver cxl_acpi_driver = {
> > >  module_platform_driver(cxl_acpi_driver);
> > >  MODULE_LICENSE("GPL v2");
> > >  MODULE_IMPORT_NS(CXL);
> > > +MODULE_SOFTDEP("pre: cxl_port");
> > 
> > Why does cxl_acpi depend on cxl_port being loaded at this point? I
> > think this wants to wait for a future patch where cxl_acpi uses port
> > driver services.
> 
> As of this patch it does use port driver services. cxl/acpi: Map single port
> host bridge component registers made that the case.
> 
> [snip]
> 

My mistake... I had the order changed locally. Ignore this comment.

