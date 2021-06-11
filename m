Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2685AC48BE0
	for <linux-cxl@archiver.kernel.org>; Fri, 11 Jun 2021 13:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD7D7613FA
	for <linux-cxl@archiver.kernel.org>; Fri, 11 Jun 2021 13:53:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbhFKNzq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 11 Jun 2021 09:55:46 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3225 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbhFKNzq (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 11 Jun 2021 09:55:46 -0400
Received: from fraeml735-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4G1hwN1n5Rz6L4wD;
        Fri, 11 Jun 2021 21:47:00 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml735-chm.china.huawei.com (10.206.15.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 11 Jun 2021 15:53:46 +0200
Received: from localhost (10.52.127.35) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 11 Jun
 2021 14:53:44 +0100
Date:   Fri, 11 Jun 2021 14:53:31 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [RFC PATCH 0/4] Region Creation
Message-ID: <20210611145331.0000366e@Huawei.com>
In-Reply-To: <20210611141136.000013ab@Huawei.com>
References: <20210610185725.897541-1-ben.widawsky@intel.com>
        <20210611141136.000013ab@Huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.52.127.35]
X-ClientProxiedBy: lhreml750-chm.china.huawei.com (10.201.108.200) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 11 Jun 2021 14:11:36 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Thu, 10 Jun 2021 11:57:21 -0700
> Ben Widawsky <ben.widawsky@intel.com> wrote:
> 
> > CXL interleave sets and non-interleave sets are described via regions. A region
> > is specified in the CXL 2.0 specification and the purpose is to create a
> > standardized way to preserve the region across reboots.  
> 
> A specific section reference would be helpful.
> 
> > 
> > Introduced here is the basic mechanism to create and configure and delete a CXL
> > region. Configuring a region simply means giving it a size, offset within the
> > CFMWS window, UUID, and a target list. Enabling/activating a region, which
> > ultimately means programming the HDM decoders in the chain, is left for later
> > work.
> > 
> > The patches are only minimally tested so far in QEMU emulation and so x1
> > interleave is all that's supported.  
> 
> I'm guessing this is why it's an RFC rather than a final submission?
> 
> If you can call out the RFC reasons in a cover letter it is helpful
> as saves people wondering what specifically you want comments on.

Hi Ben,

Having read through them all, I think this needs more thought than
I feel up to on a Friday afternoon.  Will get back to you on v2
perhaps.

Jonathan

> 
> > 
> > Here is a sample topology (also in patch #4)
> > 
> >     decoder1.0
> >     ├── create_region
> >     ├── delete_region
> >     ├── devtype
> >     ├── locked
> >     ├── region1.0:0
> >     │   ├── offset
> >     │   ├── size
> >     │   ├── subsystem -> ../../../../../../../bus/cxl
> >     │   ├── target0
> >     │   ├── uevent
> >     │   ├── uuid
> >     │   └── verify
> >     ├── size
> >     ├── start
> >     ├── subsystem -> ../../../../../../bus/cxl
> >     ├── target_list
> >     ├── target_type
> >     └── uevent
> > 
> > Ben Widawsky (4):
> >   cxl/region: Add region creation ABI
> >   cxl/region: Create attribute structure / verify
> >   cxl: Move cxl_memdev conversion helper to mem.h
> >   cxl/region: Introduce concept of region configuration
> > 
> >  Documentation/ABI/testing/sysfs-bus-cxl       |  59 +++
> >  .../driver-api/cxl/memory-devices.rst         |   8 +
> >  drivers/cxl/Makefile                          |   2 +-
> >  drivers/cxl/core.c                            |  71 ++++
> >  drivers/cxl/cxl.h                             |  11 +
> >  drivers/cxl/mem.h                             |  26 ++
> >  drivers/cxl/pci.c                             |   5 -
> >  drivers/cxl/region.c                          | 400 ++++++++++++++++++
> >  8 files changed, 576 insertions(+), 6 deletions(-)
> >  create mode 100644 drivers/cxl/region.c
> >   
> 

