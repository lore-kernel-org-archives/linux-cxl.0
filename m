Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32732C77B7A
	for <linux-cxl@archiver.kernel.org>; Tue,  6 Jun 2023 13:04:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234231AbjFFNEZ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 6 Jun 2023 09:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbjFFNEY (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 6 Jun 2023 09:04:24 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F188EA
        for <linux-cxl@vger.kernel.org>; Tue,  6 Jun 2023 06:04:23 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Qb9fD09Qxz6J75V;
        Tue,  6 Jun 2023 21:04:04 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 6 Jun
 2023 14:04:20 +0100
Date:   Tue, 6 Jun 2023 14:04:19 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <ira.weiny@intel.com>,
        <navneet.singh@intel.com>
Subject: Re: [PATCH 08/19] cxl/port: Enumerate flit mode capability
Message-ID: <20230606140419.00007a54@Huawei.com>
In-Reply-To: <168592154146.1948938.12085726872761686977.stgit@dwillia2-xfh.jf.intel.com>
References: <168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com>
        <168592154146.1948938.12085726872761686977.stgit@dwillia2-xfh.jf.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Sun, 04 Jun 2023 16:32:21 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Per CXL 3.0 Section 9.14 Back-Invalidation Configuration, in order to
> enable an HDM-DB range (CXL.mem region with device initiated
> back-invalidation support), all ports in the path between the endpoint and
> the host bridge must be in 256-bit flit-mode.
> 
> Even for typical Type-3 class devices it is useful to enumerate link
> capabilities through the chain for debug purposes.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

A few minor comments. In particularly that the field you have in here doesn't
distinguish between 256 byte flits and otherwise.  That's done with the PCI spec
field not this one which is about latency optimization.

> ---
>  drivers/cxl/core/hdm.c  |    2 +
>  drivers/cxl/core/pci.c  |   84 +++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/port.c |    6 +++
>  drivers/cxl/cxl.h       |    2 +
>  drivers/cxl/cxlpci.h    |   25 +++++++++++++-
>  drivers/cxl/port.c      |    5 +++
>  6 files changed, 122 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index ca3b99c6eacf..91ab3033c781 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -3,8 +3,10 @@
>  #include <linux/seq_file.h>
>  #include <linux/device.h>
>  #include <linux/delay.h>
> +#include <linux/pci.h>
>  
>  #include "cxlmem.h"
> +#include "cxlpci.h"
>  #include "core.h"
I'm not following why link related patch should change includes in hdm relate c file?
Maybe later once you use it this makes sense?


>  
>  /**
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 67f4ab6daa34..b62ec17ccdde 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -519,6 +519,90 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,

> +
> +int cxl_probe_link(struct cxl_port *port)
> +{
> +	struct pci_dev *pdev = cxl_port_to_pci(port);
> +	u16 cap, en, parent_features;
> +	struct cxl_port *parent_port;
> +	struct device *dev;
> +	int rc, dvsec;
> +	u32 hdr;
> +
> +	if (!pdev) {
> +		/*
> +		 * Assume host bridges support all features, the root
> +		 * port will dictate the actual enabled set to endpoints.
> +		 */
> +		return 0;
> +	}
> +
> +	dev = &pdev->dev;
> +	dvsec = pci_find_dvsec_capability(pdev, PCI_DVSEC_VENDOR_ID_CXL,
> +					  CXL_DVSEC_FLEXBUS_PORT);
> +	if (!dvsec) {
> +		dev_err(dev, "Failed to enumerate port capabilities\n");
> +		return -ENXIO;
> +	}
> +
> +	/*
> +	 * Cache the link features for future determination of HDM-D or
> +	 * HDM-DB support
> +	 */
> +	rc = pci_read_config_dword(pdev, dvsec + PCI_DVSEC_HEADER1, &hdr);
> +	if (rc)
> +		return rc;
> +
> +	rc = pci_read_config_word(pdev, dvsec + CXL_DVSEC_FLEXBUS_CAP_OFFSET,
> +				  &cap);
> +	if (rc)
> +		return rc;
> +
> +	rc = pci_read_config_word(pdev, dvsec + CXL_DVSEC_FLEXBUS_STATUS_OFFSET,
> +				  &en);
> +	if (rc)
> +		return rc;
> +
> +	if (PCI_DVSEC_HEADER1_REV(hdr) < 2)
> +		cap &= ~CXL_DVSEC_FLEXBUS_REV2_MASK;
> +
> +	if (PCI_DVSEC_HEADER1_REV(hdr) < 1)
> +		cap &= ~CXL_DVSEC_FLEXBUS_REV1_MASK;

I talk about this below, but I'd not normally expect to see this.
Anyone who used those bits out of usage defined by later specs has buggy 
hardware and should quirk it rather than having it built in here.

> +
> +	en &= cap;
> +	parent_port = to_cxl_port(port->dev.parent);
> +	parent_features = parent_port->features;
> +
> +	/* Enforce port features are plumbed through to the host bridge */
> +	port->features = en & CXL_DVSEC_FLEXBUS_ENABLE_MASK & parent_features;
> +
> +	dev_dbg(dev, "features:%s%s%s%s%s%s%s\n",
> +		en & CXL_DVSEC_FLEXBUS_CACHE_ENABLED ? " cache" : "",
> +		en & CXL_DVSEC_FLEXBUS_IO_ENABLED ? " io" : "",
> +		en & CXL_DVSEC_FLEXBUS_MEM_ENABLED ? " mem" : "",
> +		en & CXL_DVSEC_FLEXBUS_FLIT68_ENABLED ? " flit68" : "",
> +		en & CXL_DVSEC_FLEXBUS_MLD_ENABLED ? " mld" : "",
> +		en & CXL_DVSEC_FLEXBUS_FLIT256_ENABLED ? " flit256" : "",

Definitely want that text to be more explicit about latency optimized

> +		en & CXL_DVSEC_FLEXBUS_PBR_ENABLED ? " pbr" : "");
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_probe_link, CXL);
> +
>  #define CXL_DOE_TABLE_ACCESS_REQ_CODE		0x000000ff
>  #define   CXL_DOE_TABLE_ACCESS_REQ_CODE_READ	0
>  #define CXL_DOE_TABLE_ACCESS_TABLE_TYPE		0x0000ff00


> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index 7c02e55b8042..7f82ffb5b4be 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -45,8 +45,28 @@
>  /* CXL 2.0 8.1.7: GPF DVSEC for CXL Device */
>  #define CXL_DVSEC_DEVICE_GPF					5
>  
> -/* CXL 2.0 8.1.8: PCIe DVSEC for Flex Bus Port */
> -#define CXL_DVSEC_PCIE_FLEXBUS_PORT				7
> +/* CXL 3.0 8.2.1.3: PCIe DVSEC for Flex Bus Port */
> +#define CXL_DVSEC_FLEXBUS_PORT					7
> +#define   CXL_DVSEC_FLEXBUS_CAP_OFFSET		0xA
> +#define     CXL_DVSEC_FLEXBUS_CACHE_CAPABLE	BIT(0)
> +#define     CXL_DVSEC_FLEXBUS_IO_CAPABLE	BIT(1)
> +#define     CXL_DVSEC_FLEXBUS_MEM_CAPABLE	BIT(2)
> +#define     CXL_DVSEC_FLEXBUS_FLIT68_CAPABLE	BIT(5)

This one includes the stuff that makes it 2.0 rather than 1.1  Might need a longer
name to avoid miss use? (I checked the 1.1 spec and reserved so would be 0).

> +#define     CXL_DVSEC_FLEXBUS_MLD_CAPABLE	BIT(6)
> +#define     CXL_DVSEC_FLEXBUS_REV1_MASK		GENMASK(6, 5)

Unusual approach.. Shouldn't be needed as those bits were RsvdP so
no one should have set them and now we are supporting the new bits
so should be good without masking.

> +#define     CXL_DVSEC_FLEXBUS_FLIT256_CAPABLE	BIT(13)

Not just flit256, but the latency optimized one (split in two kind of
with separate CRCs)  So this name needs to be something like
FLEXBUS_LAT_OPT_FLIT256_CAPABLE


> +#define     CXL_DVSEC_FLEXBUS_PBR_CAPABLE	BIT(14)
> +#define     CXL_DVSEC_FLEXBUS_REV2_MASK		GENMASK(14, 13)
> +#define   CXL_DVSEC_FLEXBUS_STATUS_OFFSET	0xE
> +#define     CXL_DVSEC_FLEXBUS_CACHE_ENABLED	BIT(0)
> +#define     CXL_DVSEC_FLEXBUS_IO_ENABLED	BIT(1)
> +#define     CXL_DVSEC_FLEXBUS_MEM_ENABLED	BIT(2)
> +#define     CXL_DVSEC_FLEXBUS_FLIT68_ENABLED	BIT(5)

Again, not just FLIT68, but the VH stuff from CXL 2.0 as well.

> +#define     CXL_DVSEC_FLEXBUS_MLD_ENABLED	BIT(6)
> +#define     CXL_DVSEC_FLEXBUS_FLIT256_ENABLED	BIT(13)
Also latency optimized is key here, not 256 bit (though you need
that as well).

> +#define     CXL_DVSEC_FLEXBUS_PBR_ENABLED	BIT(14)
> +#define     CXL_DVSEC_FLEXBUS_ENABLE_MASK \
> +	(GENMASK(2, 0) | GENMASK(6, 5) | GENMASK(14, 13))
Ok - I guess the resvP requires this dance.
>  

