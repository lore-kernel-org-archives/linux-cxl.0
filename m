Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0DE1C433F5
	for <linux-cxl@archiver.kernel.org>; Wed, 18 May 2022 17:17:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240787AbiERRRV (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 18 May 2022 13:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240786AbiERRRT (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 18 May 2022 13:17:19 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748A619C390
        for <linux-cxl@vger.kernel.org>; Wed, 18 May 2022 10:17:15 -0700 (PDT)
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4L3KRL6vg1z6FGNg;
        Thu, 19 May 2022 01:17:02 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 18 May 2022 19:17:12 +0200
Received: from localhost (10.202.226.42) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 18 May
 2022 18:17:12 +0100
Date:   Wed, 18 May 2022 18:17:10 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Ariel Sibley <ariel.sibley@microchip.com>,
        <ira.weiny@intel.com>
Subject: Re: [PATCH v2 14/14] cxl/port: Enable HDM Capability after
 validating DVSEC Ranges
Message-ID: <20220518181710.000077fb@Huawei.com>
In-Reply-To: <165283418817.1033989.11273676872054815459.stgit@dwillia2-xfh>
References: <165237933127.3832067.12500546479146655886.stgit@dwillia2-desk3.amr.corp.intel.com>
        <165283418817.1033989.11273676872054815459.stgit@dwillia2-xfh>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhreml753-chm.china.huawei.com (10.201.108.203) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 17 May 2022 17:38:10 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> CXL memory expanders that support the CXL 2.0 memory device class code
> include an "HDM Decoder Capability" mechanism to supplant the "CXL DVSEC
> Range" mechanism originally defined in CXL 1.1. Both mechanisms depend
> on a "mem_enable" bit being set in configuration space before either
> mechanism activates. When the HDM Decoder Capability is enabled the CXL
> DVSEC Range settings are ignored.
> 
> Previously, the cxl_mem driver was relying on platform-firmware to set
> "mem_enable". That is an invalid assumption as there is no requirement
> that platform-firmware sets the bit before the driver sees a device,
> especially in hot-plug scenarios. Additionally, ACPI-platforms that
> support CXL 2.0 devices also support the ACPI CEDT (CXL Early Discovery
> Table). That table outlines the platform permissible address ranges for
> CXL operation. So, there is a need for the driver to set "mem_enable",
> and there is information available to determine the validity of the CXL
> DVSEC Ranges. While DVSEC Ranges are expected to be at least
> 256M in size, the specification (CXL 2.0 Section 8.1.3.8.4 DVSEC CXL
> Range 1 Base Low) allows for the possibilty of devices smaller than
> 256M. So the range [0, 256M) is considered active even if Memory_size
> is 0.
> 
> Arrange for the driver to optionally enable the HDM Decoder Capability
> if "mem_enable" was not set by platform firmware, or the CXL DVSEC Range
> configuration was invalid. Be careful to only disable memory decode if
> the kernel was the one to enable it. In other words, if CXL is backing
> all of kernel memory at boot the device needs to maintain "mem_enable"
> and "HDM Decoder enable" all the way up to handoff back to platform
> firmware (e.g. ACPI S5 state entry may require CXL memory to stay
> active).
> 
> Fixes: 560f78559006 ("cxl/pci: Retrieve CXL DVSEC memory info")
> Cc: Dan Carpenter <dan.carpenter@oracle.com>
> [dan: fix early terminiation of range-allowed loop]
> Cc: Ariel Sibley <ariel.sibley@microchip.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
> Changes since v1:
> - Fix range-allowed loop termination (Smatch / Dan)
That had me confused before I saw v2 :)

I'm not keen on the trick to do disallowed in the debug message...

Other than ongoing discussion around the range being always allowed
(or not) this looks good to me.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> - Clean up changeloe wording around why [0, 256M) is considered always
>   active (Ariel)
> 
>  drivers/cxl/core/pci.c |  163 ++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 151 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index a697c48fc830..528430da0e77 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -175,30 +175,164 @@ static int wait_for_valid(struct cxl_dev_state *cxlds)
>  	return -ETIMEDOUT;
>  }
>  
> +static int cxl_set_mem_enable(struct cxl_dev_state *cxlds, u16 val)
> +{
> +	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
> +	int d = cxlds->cxl_dvsec;
> +	u16 ctrl;
> +	int rc;
> +
> +	rc = pci_read_config_word(pdev, d + CXL_DVSEC_CTRL_OFFSET, &ctrl);
> +	if (rc < 0)
> +		return rc;
> +
> +	if ((ctrl & CXL_DVSEC_MEM_ENABLE) == val)
> +		return 1;
> +	ctrl &= ~CXL_DVSEC_MEM_ENABLE;
> +	ctrl |= val;
> +
> +	rc = pci_write_config_word(pdev, d + CXL_DVSEC_CTRL_OFFSET, ctrl);
> +	if (rc < 0)
> +		return rc;
> +
> +	return 0;
> +}
> +
> +static void clear_mem_enable(void *cxlds)
> +{
> +	cxl_set_mem_enable(cxlds, 0);
> +}
> +
> +static int devm_cxl_enable_mem(struct device *host, struct cxl_dev_state *cxlds)
> +{
> +	int rc;
> +
> +	rc = cxl_set_mem_enable(cxlds, CXL_DVSEC_MEM_ENABLE);
> +	if (rc < 0)
> +		return rc;
> +	if (rc > 0)
> +		return 0;
> +	return devm_add_action_or_reset(host, clear_mem_enable, cxlds);
> +}
> +
> +static bool range_contains(struct range *r1, struct range *r2)
> +{
> +	return r1->start <= r2->start && r1->end >= r2->end;
> +}
> +
> +/* require dvsec ranges to be covered by a locked platform window */
> +static int dvsec_range_allowed(struct device *dev, void *arg)
> +{
> +	struct range *dev_range = arg;
> +	struct cxl_decoder *cxld;
> +	struct range root_range;
> +
> +	if (!is_root_decoder(dev))
> +		return 0;
> +
> +	cxld = to_cxl_decoder(dev);
> +
> +	if (!(cxld->flags & CXL_DECODER_F_LOCK))
> +		return 0;
> +	if (!(cxld->flags & CXL_DECODER_F_RAM))
> +		return 0;
> +
> +	root_range = (struct range) {
> +		.start = cxld->platform_res.start,
> +		.end = cxld->platform_res.end,
> +	};
> +
> +	return range_contains(&root_range, dev_range);
> +}
> +
> +static void disable_hdm(void *_cxlhdm)
> +{
> +	u32 global_ctrl;
> +	struct cxl_hdm *cxlhdm = _cxlhdm;
> +	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
> +
> +	global_ctrl = readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
> +	writel(global_ctrl & ~CXL_HDM_DECODER_ENABLE,
> +	       hdm + CXL_HDM_DECODER_CTRL_OFFSET);
> +}
> +
> +static int devm_cxl_enable_hdm(struct device *host, struct cxl_hdm *cxlhdm)
> +{
> +	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
> +	u32 global_ctrl;
> +
> +	global_ctrl = readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
> +	writel(global_ctrl | CXL_HDM_DECODER_ENABLE,
> +	       hdm + CXL_HDM_DECODER_CTRL_OFFSET);
> +
> +	return devm_add_action_or_reset(host, disable_hdm, cxlhdm);
> +}
> +
>  static bool __cxl_hdm_decode_init(struct cxl_dev_state *cxlds,
>  				  struct cxl_hdm *cxlhdm,
>  				  struct cxl_endpoint_dvsec_info *info)
>  {
>  	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
> -	bool global_enable;
> +	struct cxl_port *port = cxlhdm->port;
> +	struct device *dev = cxlds->dev;
> +	struct cxl_port *root;
> +	int i, rc, allowed;
>  	u32 global_ctrl;
>  
>  	global_ctrl = readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
> -	global_enable = global_ctrl & CXL_HDM_DECODER_ENABLE;
>  
> -	if (!global_enable && info->mem_enabled)
> +	/*
> +	 * If the HDM Decoder Capability is already enabled then assume
> +	 * that some other agent like platform firmware set it up.
> +	 */
> +	if (global_ctrl & CXL_HDM_DECODER_ENABLE) {
> +		rc = devm_cxl_enable_mem(&port->dev, cxlds);
> +		if (rc)
> +			return false;
> +		return true;
> +	}
> +
> +	root = to_cxl_port(port->dev.parent);
> +	while (!is_cxl_root(root) && is_cxl_port(root->dev.parent))
> +		root = to_cxl_port(root->dev.parent);
> +	if (!is_cxl_root(root)) {
> +		dev_err(dev, "Failed to acquire root port for HDM enable\n");
>  		return false;
> +	}
> +
> +	for (i = 0, allowed = 0; info->mem_enabled && i < info->ranges; i++) {
> +		struct device *cxld_dev;
> +
> +		cxld_dev = device_find_child(&root->dev, &info->dvsec_range[i],
> +					     dvsec_range_allowed);
> +		dev_dbg(dev, "DVSEC Range%d %sallowed by platform\n", i,
> +			cxld_dev ? "" : "dis");

Ouch.  Not worth doing that to save a few chars. Makes the message
harder to grep for.

> +		if (!cxld_dev)
> +			continue;
> +		put_device(cxld_dev);
> +		allowed++;
> +	}
> +	put_device(&root->dev);
> +
> +	if (!allowed) {
> +		cxl_set_mem_enable(cxlds, 0);
> +		info->mem_enabled = 0;
> +	}
