Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B767C433F5
	for <linux-cxl@archiver.kernel.org>; Mon,  6 Sep 2021 09:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CEBD61050
	for <linux-cxl@archiver.kernel.org>; Mon,  6 Sep 2021 09:08:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241175AbhIFJJg (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 6 Sep 2021 05:09:36 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3750 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbhIFJJf (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 6 Sep 2021 05:09:35 -0400
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4H32Zc4f3Wz67dnT;
        Mon,  6 Sep 2021 17:06:32 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Mon, 6 Sep 2021 11:08:29 +0200
Received: from localhost (10.52.120.86) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 6 Sep 2021
 10:08:28 +0100
Date:   Mon, 6 Sep 2021 10:08:29 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Ben Widawsky <ben.widawsky@intel.com>,
        <alison.schofield@intel.com>
Subject: Re: [PATCH 5/6] cxl/pmem: Fix Documentation warning
Message-ID: <20210906100829.0000132f@Huawei.com>
In-Reply-To: <163072206163.2250120.11486436976516079516.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <163072203373.2250120.8373702699578427249.stgit@dwillia2-desk3.amr.corp.intel.com>
        <163072206163.2250120.11486436976516079516.stgit@dwillia2-desk3.amr.corp.intel.com>
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

On Fri, 3 Sep 2021 19:21:01 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Commit 06737cd0d216 ("cxl/core: Move pmem functionality") neglected to
> add a DOC header for the new drivers/cxl/core/pmem.c file.
> 
> Reported-by: Ben Widawsky <ben.widawsky@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Trivial comment inline, but otherwise looks fine to me.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huwei.com>



> ---
>  Documentation/driver-api/cxl/memory-devices.rst |    2 +-
>  drivers/cxl/core/pmem.c                         |   30 +++++++++++++++++++++--
>  2 files changed, 29 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/driver-api/cxl/memory-devices.rst b/Documentation/driver-api/cxl/memory-devices.rst
> index 46847d8c70a0..df799cdf1c3f 100644
> --- a/Documentation/driver-api/cxl/memory-devices.rst
> +++ b/Documentation/driver-api/cxl/memory-devices.rst
> @@ -40,7 +40,7 @@ CXL Core
>     :doc: cxl core
>  
>  .. kernel-doc:: drivers/cxl/core/pmem.c
> -   :internal:
> +   :doc: cxl pmem
>  
>  .. kernel-doc:: drivers/cxl/core/regs.c
>     :internal:
> diff --git a/drivers/cxl/core/pmem.c b/drivers/cxl/core/pmem.c
> index 69c97cc0d945..d24570f5b8ba 100644
> --- a/drivers/cxl/core/pmem.c
> +++ b/drivers/cxl/core/pmem.c
> @@ -1,13 +1,25 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /* Copyright(c) 2020 Intel Corporation. */
> -
>  #include <linux/device.h>
>  #include <linux/slab.h>
>  #include <cxlmem.h>
>  #include <cxl.h>
> -

Grumpy hat:  Unrelated changes, but honestly I don't really care
given the small size of the patch anyway.

>  #include "core.h"
>  
> +/**
> + * DOC: cxl pmem
> + *
> + * The core CXL PMEM infrastructure supports persistent memory
> + * provisioning and serves as a bridge to the LIBNVDIMM subsystem. A CXL
> + * 'bridge' device is added at the root of a CXL device topology if
> + * platform firmware advertises at least one persistent memory capable
> + * CXL window. That root-level bridge corresponds to a LIBNVDIMM 'bus'
> + * device. Then for each cxl_memdev in the CXL device topology a bridge
> + * device is added to host a LIBNVDIMM dimm object. When these bridges
> + * are registered native LIBNVDIMM uapis are translated to CXL
> + * operations, for example, namespace label access commands.
> + */
> +
>  static void cxl_nvdimm_bridge_release(struct device *dev)
>  {
>  	struct cxl_nvdimm_bridge *cxl_nvb = to_cxl_nvdimm_bridge(dev);
> @@ -85,6 +97,13 @@ static void unregister_nvb(void *_cxl_nvb)
>  	device_unregister(&cxl_nvb->dev);
>  }
>  
> +/**
> + * devm_cxl_add_nvdimm_bridge() - add the root of a LIBNVDIMM topology
> + * @host: platform firmware root device
> + * @port: CXL port at the root of a CXL topology
> + *
> + * Return: bridge device that can host cxl_nvdimm objects
> + */
>  struct cxl_nvdimm_bridge *devm_cxl_add_nvdimm_bridge(struct device *host,
>  						     struct cxl_port *port)
>  {
> @@ -173,6 +192,13 @@ static struct cxl_nvdimm *cxl_nvdimm_alloc(struct cxl_memdev *cxlmd)
>  	return cxl_nvd;
>  }
>  
> +/**
> + * devm_cxl_add_nvdimm() - add a bridge between a cxl_memdev and an nvdimm
> + * @host: same host as @cxlmd
> + * @cxlmd: cxl_memdev instance that will perform LIBNVDIMM operations
> + *
> + * Return: 0 on success negative error code on failure.
> + */
>  int devm_cxl_add_nvdimm(struct device *host, struct cxl_memdev *cxlmd)
>  {
>  	struct cxl_nvdimm *cxl_nvd;
> 

