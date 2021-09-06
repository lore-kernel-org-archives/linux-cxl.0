Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B5F7C433F5
	for <linux-cxl@archiver.kernel.org>; Mon,  6 Sep 2021 09:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3017160EE6
	for <linux-cxl@archiver.kernel.org>; Mon,  6 Sep 2021 09:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234759AbhIFJLb (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 6 Sep 2021 05:11:31 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3751 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbhIFJL3 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 6 Sep 2021 05:11:29 -0400
Received: from fraeml709-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4H32cp3VwXz67cQG;
        Mon,  6 Sep 2021 17:08:26 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Mon, 6 Sep 2021 11:10:23 +0200
Received: from localhost (10.52.120.86) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 6 Sep 2021
 10:10:22 +0100
Date:   Mon, 6 Sep 2021 10:10:23 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Ben Widawsky <ben.widawsky@intel.com>,
        <alison.schofield@intel.com>
Subject: Re: [PATCH 6/6] cxl/registers: Fix Documentation warning
Message-ID: <20210906101023.000072ec@Huawei.com>
In-Reply-To: <163072206675.2250120.3527179192933919995.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <163072203373.2250120.8373702699578427249.stgit@dwillia2-desk3.amr.corp.intel.com>
        <163072206675.2250120.3527179192933919995.stgit@dwillia2-desk3.amr.corp.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.120.86]
X-ClientProxiedBy: lhreml741-chm.china.huawei.com (10.201.108.191) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 3 Sep 2021 19:21:06 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Commit 0f06157e0135 ("cxl/core: Move register mapping infrastructure")
> neglected to add a DOC header for the new drivers/core/regs.c file.
> 
> Reported-by: Ben Widawsky <ben.widawsky@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Same grumpy comment applies to this one.

Otherwise description is fine.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  Documentation/driver-api/cxl/memory-devices.rst |    2 +-
>  drivers/cxl/core/regs.c                         |   15 ++++++++++++++-
>  2 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/driver-api/cxl/memory-devices.rst b/Documentation/driver-api/cxl/memory-devices.rst
> index df799cdf1c3f..50ebcda17ad0 100644
> --- a/Documentation/driver-api/cxl/memory-devices.rst
> +++ b/Documentation/driver-api/cxl/memory-devices.rst
> @@ -43,7 +43,7 @@ CXL Core
>     :doc: cxl pmem
>  
>  .. kernel-doc:: drivers/cxl/core/regs.c
> -   :internal:
> +   :doc: cxl registers
>  
>  External Interfaces
>  ===================
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index 8535a7b94f28..41de4a136ecd 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -1,12 +1,25 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /* Copyright(c) 2020 Intel Corporation. */
> -

hmm

>  #include <linux/io-64-nonatomic-lo-hi.h>
>  #include <linux/device.h>
>  #include <linux/slab.h>
>  #include <linux/pci.h>
>  #include <cxlmem.h>
>  
> +/**
> + * DOC: cxl registers
> + *
> + * CXL device capabilities are enumerated by PCI DVSEC (Designated
> + * Vendor-specific) and / or descriptors provided by platform firmware.
> + * They can be defined as a set like the device and component registers
> + * mandated by CXL Section 8.1.12.2 Memory Device PCIe Capabilities and
> + * Extended Capabilities, or they can be individual capabilities
> + * appended to bridged and endpoint devices.
> + *
> + * Provide common infrastructure for enumerating and mapping these
> + * discrete capabilities.
> + */
> +
>  /**
>   * cxl_probe_component_regs() - Detect CXL Component register blocks
>   * @dev: Host device of the @base mapping
> 

