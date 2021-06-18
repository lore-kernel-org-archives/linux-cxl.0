Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40CB1C48BDF
	for <linux-cxl@archiver.kernel.org>; Fri, 18 Jun 2021 14:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E7636100A
	for <linux-cxl@archiver.kernel.org>; Fri, 18 Jun 2021 14:14:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233485AbhFRORA (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 18 Jun 2021 10:17:00 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3285 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbhFRORA (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 18 Jun 2021 10:17:00 -0400
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4G60w00SRLz6GBPb;
        Fri, 18 Jun 2021 22:01:36 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 18 Jun 2021 16:14:49 +0200
Received: from localhost (10.52.125.28) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 18 Jun
 2021 15:14:48 +0100
Date:   Fri, 18 Jun 2021 15:14:39 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [RFC PATCH 3/5] cxl/memdev: Determine CXL.mem capability
Message-ID: <20210618151439.0000498a@Huawei.com>
In-Reply-To: <20210618005200.997804-4-ben.widawsky@intel.com>
References: <20210618005200.997804-1-ben.widawsky@intel.com>
        <20210618005200.997804-4-ben.widawsky@intel.com>
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

On Thu, 17 Jun 2021 17:51:58 -0700
Ben Widawsky <ben.widawsky@intel.com> wrote:

> If the "upstream" port of the endpoint is an enumerated downstream CXL
> port the memdev driver can bind. This is useful for region
> configuration/creation because it provides a way for the region code to
> determine if the memdev is actually CXL capable.
> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
I can't resist commenting even when mostly looking at the basic
form a patch. So some trivial stuff in here ;)

Jonathan

> ---
>  drivers/cxl/acpi.c |  9 ++++++++-
>  drivers/cxl/core.c |  5 +++++
>  drivers/cxl/cxl.h  |  1 +
>  drivers/cxl/mem.c  | 41 ++++++++++++++++++++++++++++++++++++++++-
>  drivers/cxl/mem.h  |  5 +----
>  5 files changed, 55 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index cf7c26fb2578..6192739fcf43 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -7,6 +7,7 @@
>  #include <linux/acpi.h>
>  #include <linux/pci.h>
>  #include "cxl.h"
> +#include "mem.h"
>  
>  /* Encode defined in CXL 2.0 8.2.5.12.7 HDM Decoder Control Register */
>  #define CFMWS_INTERLEAVE_WAYS(x)	(1 << (x)->interleave_ways)
> @@ -398,9 +399,15 @@ static int cxl_acpi_probe(struct platform_device *pdev)
>  	if (rc)
>  		goto out;
>  
> -	if (IS_ENABLED(CONFIG_CXL_PMEM))
> +	if (IS_ENABLED(CONFIG_CXL_PMEM)) {
>  		rc = device_for_each_child(&root_port->dev, root_port,
>  					   add_root_nvdimm_bridge);
> +		if (rc)
> +			goto out;
> +	}
> +
> +	rc = bus_rescan_devices(&cxl_bus_type);
> +
>  out:
>  	acpi_put_table(cedt_table);
>  	return rc;
> diff --git a/drivers/cxl/core.c b/drivers/cxl/core.c
> index 16a671722d4e..0a54c6eb84eb 100644
> --- a/drivers/cxl/core.c
> +++ b/drivers/cxl/core.c
> @@ -303,6 +303,11 @@ static const struct device_type cxl_port_type = {
>  	.groups = cxl_port_attribute_groups,
>  };
>  
> +bool is_cxl_port(struct device *dev)
> +{
> +	return dev->type == &cxl_port_type;

Reuse this in to_cxl_port() for the sanity check..

> +}
> +
>  struct cxl_port *to_cxl_port(struct device *dev)
>  {
>  	if (dev_WARN_ONCE(dev, dev->type != &cxl_port_type,
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index ce4b241c5dda..1a3800616f4a 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -285,6 +285,7 @@ int cxl_add_dport(struct cxl_port *port, struct device *dport, int port_id,
>  
>  struct cxl_decoder *to_cxl_decoder(struct device *dev);
>  bool is_root_decoder(struct device *dev);
> +bool is_cxl_port(struct device *dev);
>  struct cxl_decoder *
>  devm_cxl_add_decoder(struct device *host, struct cxl_port *port, int nr_targets,
>  		     resource_size_t base, resource_size_t len,
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 2997a03abcb6..cbf18df24109 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -2,6 +2,7 @@
>  /* Copyright(c) 2021 Intel Corporation. All rights reserved. */
>  #include <linux/device.h>
>  #include <linux/module.h>
> +#include <linux/pci.h>
>  #include "mem.h"
>  
>  /**
> @@ -13,9 +14,42 @@
>   * mechanisms.
>   */
>  
> +static int port_match(struct device *dev, const void *data)
> +{
> +	struct cxl_dport *dport;
> +	struct cxl_port *port;
> +	int ret = 0;
> +
> +	if (!is_cxl_port(dev))
> +		return 0;
> +
> +	port = to_cxl_port(dev);
> +
> +	device_lock(&port->dev);
> +	list_for_each_entry(dport, &port->dports, list)
> +		if (dport->dport == data) {
> +			ret = 1;
> +			break;
> +		}
> +
> +	device_unlock(&port->dev);
> +
> +	return ret;
> +}
> +
>  static int cxl_memdev_probe(struct device *dev)
>  {
> -	return -EOPNOTSUPP;
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +	struct cxl_mem *cxlm = cxlmd->cxlm;
> +	struct device *pdev_parent = cxlm->pdev->dev.parent;
> +	struct device *port_dev;
> +
> +	port_dev =
> +		bus_find_device(&cxl_bus_type, NULL, pdev_parent, port_match);
> +	if (!port_dev)
> +		return -ENODEV;
> +
> +	return 0;
>  }
>  
>  static void cxl_memdev_remove(struct device *dev)
> @@ -29,6 +63,11 @@ static struct cxl_driver cxl_memdev_driver = {
>  	.id = CXL_DEVICE_ENDPOINT,
>  };
>  
> +bool is_cxl_capable(struct cxl_memdev *cxlmd)
> +{
> +	return cxlmd->dev.driver == &cxl_memdev_driver.drv;
> +}

I'll just assume this will end up here directly in the non rfc
version.  In general, I think you've broken this series into
too many small patches, making it harder to see overall shape.

> +
>  static __init int cxl_memdev_init(void)
>  {
>  	return cxl_driver_register(&cxl_memdev_driver);
> diff --git a/drivers/cxl/mem.h b/drivers/cxl/mem.h
> index 2c20c1ccd6b8..e9333c2ea745 100644
> --- a/drivers/cxl/mem.h
> +++ b/drivers/cxl/mem.h
> @@ -84,10 +84,7 @@ struct cxl_mem {
>  	struct range ram_range;
>  };
>  
> -static inline bool is_cxl_capable(struct cxl_memdev *cxlmd)
> -{
> -	return false;
> -}
> +bool is_cxl_capable(struct cxl_memdev *cxlmd);
>  bool is_cxl_memdev(struct device *dev);
>  
>  #endif /* __CXL_MEM_H__ */

