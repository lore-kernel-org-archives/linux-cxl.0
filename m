Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96AF2E784B9
	for <linux-cxl@archiver.kernel.org>; Mon,  2 Oct 2023 14:53:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237630AbjJBOxl (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 2 Oct 2023 10:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237886AbjJBOxk (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 2 Oct 2023 10:53:40 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E26B9D;
        Mon,  2 Oct 2023 07:53:37 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RzkSL5JBsz6K5sF;
        Mon,  2 Oct 2023 22:52:02 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 2 Oct
 2023 15:53:34 +0100
Date:   Mon, 2 Oct 2023 15:53:34 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Robert Richter <rrichter@amd.com>
CC:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Davidlohr Bueso" <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v11 11/20] cxl/pci: Add RCH downstream port AER register
 discovery
Message-ID: <20231002155334.00004e58@Huawei.com>
In-Reply-To: <20230927154339.1600738-12-rrichter@amd.com>
References: <20230927154339.1600738-1-rrichter@amd.com>
        <20230927154339.1600738-12-rrichter@amd.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 27 Sep 2023 17:43:30 +0200
Robert Richter <rrichter@amd.com> wrote:

> From: Terry Bowman <terry.bowman@amd.com>
> 
> Restricted CXL host (RCH) downstream port AER information is not currently
> logged while in the error state. One problem preventing the error logging
> is the AER and RAS registers are not accessible. The CXL driver requires
> changes to find RCH downstream port AER and RAS registers for purpose of
> error logging.
> 
> RCH downstream ports are not enumerated during a PCI bus scan and are
> instead discovered using system firmware, ACPI in this case.[1] The
> downstream port is implemented as a Root Complex Register Block (RCRB).
> The RCRB is a 4k memory block containing PCIe registers based on the PCIe
> root port.[2] The RCRB includes AER extended capability registers used for
> reporting errors. Note, the RCH's AER Capability is located in the RCRB
> memory space instead of PCI configuration space, thus its register access
> is different. Existing kernel PCIe AER functions can not be used to manage
> the downstream port AER capabilities and RAS registers because the port was
> not enumerated during PCI scan and the registers are not PCI config
> accessible.
> 
> Discover RCH downstream port AER extended capability registers. Use MMIO
> accesses to search for extended AER capability in RCRB register space.
> 
> [1] CXL 3.0 Spec, 9.11.2 - System Firmware View of CXL 1.1 Hierarchy
> [2] CXL 3.0 Spec, 8.2.1.1 - RCH Downstream Port RCRB
> 
> Co-developed-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>

This doesn't look right. IIRC Co-dev tag should be just
before the SoB.

> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>

New day, fresh questions....


> ---
>  drivers/cxl/core/core.h |  1 +
>  drivers/cxl/core/pci.c  |  6 ++++++
>  drivers/cxl/core/regs.c | 35 +++++++++++++++++++++++++++++++++++
>  3 files changed, 42 insertions(+)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 45e7e044cf4a..f470ef5c0a6a 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -73,6 +73,7 @@ struct cxl_rcrb_info;
>  resource_size_t __rcrb_to_component(struct device *dev,
>  				    struct cxl_rcrb_info *ri,
>  				    enum cxl_rcrb which);
> +u16 cxl_rcrb_to_aer(struct device *dev, resource_size_t rcrb);
>  
>  extern struct rw_semaphore cxl_dpa_rwsem;
>  
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 6ba3b7370816..4c6c5c7ba5a3 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -722,6 +722,12 @@ static bool cxl_report_and_clear(struct cxl_dev_state *cxlds)
>  
>  void devm_cxl_setup_parent_dport(struct device *host, struct cxl_dport *dport)
>  {
> +	struct device *dport_dev = dport->dport_dev;
> +	struct pci_host_bridge *host_bridge;
> +
> +	host_bridge = to_pci_host_bridge(dport_dev);
> +	if (host_bridge->native_cxl_error)
> +		dport->rcrb.aer_cap = cxl_rcrb_to_aer(dport_dev, dport->rcrb.base);
>  }
>  EXPORT_SYMBOL_NS_GPL(devm_cxl_setup_parent_dport, CXL);
>  
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index e0fbe964f6f0..6e502f02899b 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -470,6 +470,41 @@ int cxl_setup_regs(struct cxl_register_map *map)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_setup_regs, CXL);
>  
> +u16 cxl_rcrb_to_aer(struct device *dev, resource_size_t rcrb)
> +{
> +	void __iomem *addr;
> +	u16 offset = 0;
> +	u32 cap_hdr;
> +
> +	if (WARN_ON_ONCE(rcrb == CXL_RESOURCE_NONE))
> +		return 0;
> +
> +	if (!request_mem_region(rcrb, SZ_4K, dev_name(dev)))
> +		return 0;
> +
> +	addr = ioremap(rcrb, SZ_4K);
> +	if (!addr) {

Given this handling exists, below, perhaps a goto?
Also, why isn't this an error?  A comment would be good for that.

> +		release_mem_region(rcrb, SZ_4K);
> +		return 0;
> +	}
> +
> +	cap_hdr = readl(addr + offset);
> +	while (PCI_EXT_CAP_ID(cap_hdr) != PCI_EXT_CAP_ID_ERR) {
> +		offset = PCI_EXT_CAP_NEXT(cap_hdr);
> +		if (!offset)
> +			break;
> +		cap_hdr = readl(addr + offset);
> +	}
> +
> +	if (offset)

Add a comment / specification reference for why an offset of 0 is not valid.
Of the top of my head I'm not sure though there may be a requirement for
something else coming first...

> +		dev_dbg(dev, "found AER extended capability (0x%x)\n", offset);
> +
> +	iounmap(addr);
> +	release_mem_region(rcrb, SZ_4K);
> +
> +	return offset;
> +}
> +
>  resource_size_t __rcrb_to_component(struct device *dev, struct cxl_rcrb_info *ri,
>  				    enum cxl_rcrb which)
>  {

