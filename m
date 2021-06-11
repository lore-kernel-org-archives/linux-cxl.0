Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 949BFC48BE0
	for <linux-cxl@archiver.kernel.org>; Fri, 11 Jun 2021 16:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76A2D613E3
	for <linux-cxl@archiver.kernel.org>; Fri, 11 Jun 2021 16:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbhFKQOM (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 11 Jun 2021 12:14:12 -0400
Received: from mga03.intel.com ([134.134.136.65]:40565 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229480AbhFKQOM (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Fri, 11 Jun 2021 12:14:12 -0400
IronPort-SDR: AK5UouYdkiCk8GhjwziUc9uEr90kJb/hRkqPEwkR6dO5AxLCXRA2vQRDH2bS2EXnLcCbH2DKAK
 SgVytr1C9FzQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10012"; a="205581269"
X-IronPort-AV: E=Sophos;i="5.83,265,1616482800"; 
   d="scan'208";a="205581269"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2021 09:12:14 -0700
IronPort-SDR: v/pRSBxfKFIH8jesJvGX76KOXD4NZZPB1OylN7XJ38rlrJUESgTUkRGnOp6gPVeGX0ohouTqqe
 NWcEzLklplGA==
X-IronPort-AV: E=Sophos;i="5.83,265,1616482800"; 
   d="scan'208";a="483316198"
Received: from chtanaka-mobl2.amr.corp.intel.com (HELO intel.com) ([10.252.138.239])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2021 09:12:14 -0700
Date:   Fri, 11 Jun 2021 09:12:11 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [RFC PATCH 0/4] Region Creation
Message-ID: <20210611161211.nte5a2an76d7ahrs@intel.com>
References: <20210610185725.897541-1-ben.widawsky@intel.com>
 <20210611141136.000013ab@Huawei.com>
 <20210611145331.0000366e@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210611145331.0000366e@Huawei.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 21-06-11 14:53:31, Jonathan Cameron wrote:
> On Fri, 11 Jun 2021 14:11:36 +0100
> Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> 
> > On Thu, 10 Jun 2021 11:57:21 -0700
> > Ben Widawsky <ben.widawsky@intel.com> wrote:
> > 
> > > CXL interleave sets and non-interleave sets are described via regions. A region
> > > is specified in the CXL 2.0 specification and the purpose is to create a
> > > standardized way to preserve the region across reboots.  
> > 
> > A specific section reference would be helpful.
> > 
> > > 
> > > Introduced here is the basic mechanism to create and configure and delete a CXL
> > > region. Configuring a region simply means giving it a size, offset within the
> > > CFMWS window, UUID, and a target list. Enabling/activating a region, which
> > > ultimately means programming the HDM decoders in the chain, is left for later
> > > work.
> > > 
> > > The patches are only minimally tested so far in QEMU emulation and so x1
> > > interleave is all that's supported.  
> > 
> > I'm guessing this is why it's an RFC rather than a final submission?
> > 
> > If you can call out the RFC reasons in a cover letter it is helpful
> > as saves people wondering what specifically you want comments on.
> 
> Hi Ben,
> 
> Having read through them all, I think this needs more thought than
> I feel up to on a Friday afternoon.  Will get back to you on v2
> perhaps.
> 
> Jonathan
> 

Thanks for looking. Totally fair too :-)

I'm mainly looking for feedback on the region creation and configuration from
ABI perspective. Nitty gritty code review can happen with the v1 submission.

> > 
> > > 
> > > Here is a sample topology (also in patch #4)
> > > 
> > >     decoder1.0
> > >     ├── create_region
> > >     ├── delete_region
> > >     ├── devtype
> > >     ├── locked
> > >     ├── region1.0:0
> > >     │   ├── offset
> > >     │   ├── size
> > >     │   ├── subsystem -> ../../../../../../../bus/cxl
> > >     │   ├── target0
> > >     │   ├── uevent
> > >     │   ├── uuid
> > >     │   └── verify
> > >     ├── size
> > >     ├── start
> > >     ├── subsystem -> ../../../../../../bus/cxl
> > >     ├── target_list
> > >     ├── target_type
> > >     └── uevent
> > > 
> > > Ben Widawsky (4):
> > >   cxl/region: Add region creation ABI
> > >   cxl/region: Create attribute structure / verify
> > >   cxl: Move cxl_memdev conversion helper to mem.h
> > >   cxl/region: Introduce concept of region configuration
> > > 
> > >  Documentation/ABI/testing/sysfs-bus-cxl       |  59 +++
> > >  .../driver-api/cxl/memory-devices.rst         |   8 +
> > >  drivers/cxl/Makefile                          |   2 +-
> > >  drivers/cxl/core.c                            |  71 ++++
> > >  drivers/cxl/cxl.h                             |  11 +
> > >  drivers/cxl/mem.h                             |  26 ++
> > >  drivers/cxl/pci.c                             |   5 -
> > >  drivers/cxl/region.c                          | 400 ++++++++++++++++++
> > >  8 files changed, 576 insertions(+), 6 deletions(-)
> > >  create mode 100644 drivers/cxl/region.c
> > >   
> > 
> 
