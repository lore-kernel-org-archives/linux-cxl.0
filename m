Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8CBBC48BDF
	for <linux-cxl@archiver.kernel.org>; Fri, 18 Jun 2021 14:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 965F86121D
	for <linux-cxl@archiver.kernel.org>; Fri, 18 Jun 2021 14:27:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234400AbhFRO3r (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 18 Jun 2021 10:29:47 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3287 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233934AbhFRO3q (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 18 Jun 2021 10:29:46 -0400
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4G61Kf6zfwz6H6m7;
        Fri, 18 Jun 2021 22:20:22 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 18 Jun 2021 16:27:31 +0200
Received: from localhost (10.52.125.28) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 18 Jun
 2021 15:27:31 +0100
Date:   Fri, 18 Jun 2021 15:27:21 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [RFC PATCH 0/5] Introduce memdev driver
Message-ID: <20210618152721.00006b71@Huawei.com>
In-Reply-To: <20210618005200.997804-1-ben.widawsky@intel.com>
References: <20210618005200.997804-1-ben.widawsky@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.125.28]
X-ClientProxiedBy: lhreml748-chm.china.huawei.com (10.201.108.198) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 17 Jun 2021 17:51:55 -0700
Ben Widawsky <ben.widawsky@intel.com> wrote:

> The concept of the memdev has existed since the initial support for CXL.io
> landed in 5.12. Here, supported is furthered by adding a driver that is capable
> of reporting whether or not the device is also CXL.mem capable. With this, the
> region driver is able to consume these devices for programming interleave (or
> x1) sets. Unlike the region driver, no explicit sysfs interaction is needed to
> utilize this driver.
> 
> The logic encapsulated here checks two things:
> 1. The device itself is CXL.mem enabled.

Need comments in relevant places to say checking if it is enabled,
not capable.

> 2. The device's upstream is CXL.mem enabled [1].
> 
> What's currently missing is for the cxlmem driver to add the device as an
> upstream port (since it has HDM decoders). I'm still working out those details.
> HDM decoder programming still remains undone as well, and isn't pertinent to
> this series perse.
> 
> The patches are based on top of my region patches [2].
> 
> The code itself is pretty rough for now, and so I'm mostly looking for feedback
> as to whether or not the memdev driver is serving its purpose and checking what
> needs to be checked on bind. If however you come along something glaringly bad,
> or feel like reviewing not fully tested code (I know it builds), by all means...

:) 

> 
> [1]: This series doesn't actually add real support for switches which would also
> need to make the determination of CXL.mem enabling.

Any plans to do the QEMU stuff needed for a switch?  I guess it's going to get
messy if you want the hdm decoders to 'work' but should be fairly trivial to make them look
plausible from an interfaces point of view.

> [2]: https://lore.kernel.org/linux-cxl/20210617173655.430424-1-ben.widawsky@intel.com/
> 
> 
> Ben Widawsky (5):
>   cxl/region: Only allow CXL capable targets
>   cxl/mem: Introduce CXL mem driver
>   cxl/memdev: Determine CXL.mem capability
>   cxl/pci: Export CXL DVSEC functionality
>   cxl/mem: Check that the device is CXL.mem capable
> 
>  drivers/cxl/Makefile |   3 +-
>  drivers/cxl/acpi.c   |   9 +++-
>  drivers/cxl/core.c   |   7 +++
>  drivers/cxl/cxl.h    |   2 +
>  drivers/cxl/mem.c    | 102 +++++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/mem.h    |   3 ++
>  drivers/cxl/pci.c    |   7 ++-
>  drivers/cxl/pci.h    |   7 ++-
>  drivers/cxl/region.c |  12 ++++-
>  9 files changed, 147 insertions(+), 5 deletions(-)
>  create mode 100644 drivers/cxl/mem.c
> 

