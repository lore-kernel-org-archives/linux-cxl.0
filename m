Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBC2238D58
	for <linux-cxl@vger.kernel.org>; Fri,  7 Feb 2025 15:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738941582; cv=none; b=C5D+KW66BG+inu9G0/e1XBafQOselB9TNAN1/oUCAuv2Ec/3kPCieLQ+wWWqL7+QickEE7WzmKw6XW16b1ufcA5LM9dx76E5vymwO0KpQOTw9e/uGixPtguYXW1/xGfr2IgmoxjVYZfoOMo2bCwuHfrVuIsEd9KHmu7DsbtSyvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738941582; c=relaxed/simple;
	bh=MLUCZOoThPreHUbrSerh2KK07xZCOXcgRliY+45w30E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dOMJHtEIWtbmPCoy2+wSpQNKlUEfCqZzQLYdVDO5aPOFM07LQjYFjgy+NAdJUWUB2DF8Mru0VCwvoHuXQwH7R1rsyGfkzLW5DnUV5UY+arHPxV6FTedkjtQNubAkEfit03EYsG3YvHXpg5xceXwp/6PRb0UlMUh5wN+LnM0svTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c4BI3DxU; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c4BI3DxU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738941580; x=1770477580;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MLUCZOoThPreHUbrSerh2KK07xZCOXcgRliY+45w30E=;
  b=c4BI3DxUvE/Acp47zVfj+8diIVPaTLzMW/zw9iH7ir/yWpmxDcxKto7Q
   SfqF8fQcmvc3/3jufBHyfTlEN1me8FghCa/Pw07lK6mxI10TYrvprssGT
   Wd+OIhndGcHNpXH0smxjEsF8rRfbbVrefxMH/0CDKpLTcFz3xWbNPAEs+
   jLd0wSjWE5tb3FrHayOv7Y6ffFbfVzm862eWRzIWrXDZaZFCY9Or45NXY
   czoHgL+ru0kv8kflS38+NTFrBXlorOqf3ttGY4Yy2Ivcz5HmdgepwSBTz
   hKjzSebIa1vwaTfbqbNghwMA83yV8dHucO8TnHy6rT7RQ8ti/recUw+iY
   A==;
X-CSE-ConnectionGUID: ogGtS2TpRbeIX54Zh5fI4w==
X-CSE-MsgGUID: Fyss0h78T325l4apTyDRmQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="57121936"
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; 
   d="scan'208";a="57121936"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 07:19:39 -0800
X-CSE-ConnectionGUID: VLHaNYU9RDCe4rFTG2MbSw==
X-CSE-MsgGUID: cbJHQ/gjTHa/qj4eZIXeNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; 
   d="scan'208";a="111513547"
Received: from agladkov-desk.ger.corp.intel.com (HELO [10.125.111.68]) ([10.125.111.68])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 07:19:39 -0800
Message-ID: <8350db9a-60d6-4d22-8cfe-7350242dd129@intel.com>
Date: Fri, 7 Feb 2025 08:19:37 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] cxl: add support for cxl reset
To: Srirangan Madhavan <smadhavan@nvidia.com>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>
Cc: Zhi Wang <zhiw@nvidia.com>, Vishal Aslot <vaslot@nvidia.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, linux-cxl@vger.kernel.org
References: <20250207090327.172478-1-smadhavan@nvidia.com>
 <20250207090327.172478-2-smadhavan@nvidia.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250207090327.172478-2-smadhavan@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/7/25 2:03 AM, Srirangan Madhavan wrote:
> This change adds the support and implements the CXL reset
> steps as laid out by the CXL Spec v3.1 Sections 9.6 & 9.7.
> 
> With support for Type 2 devices being introduced, more devices will
> require finer-grained reset mechanisms beyond bus-wide reset methods.
> 
> This change defines the necessary CXL DVSEC register macros.
> For devices that support CXL Reset, cache lines are disabled, WB+I is
> asserted, wait for cache invalid status, Mem Clr bit is asserted and
> finally reset is initiated.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Hi Srirangan,
Given this patch touches PCI code, it needs to also cc Bjorn and linux-pci. The expectation is it would go through the pci subsystem for upstream with review tags from the CXL maintainers. Thanks!

DJ

> ---
>  drivers/pci/pci.c             | 183 ++++++++++++++++++++++++++++++++++
>  include/linux/pci.h           |   2 +-
>  include/uapi/linux/pci_regs.h |  25 +++++
>  3 files changed, 209 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 869d204a70a3..cf6009f5bd6c 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5026,6 +5026,12 @@ static int pci_dev_reset_slot_function(struct pci_dev *dev, bool probe)
>  	return pci_reset_hotplug_slot(dev->slot->hotplug, probe);
>  }
>  
> +static u16 cxl_device_dvsec(struct pci_dev *dev)
> +{
> +	return pci_find_dvsec_capability(dev, PCI_VENDOR_ID_CXL,
> +					 PCI_DVSEC_CXL_DEV);
> +}
> +
>  static u16 cxl_port_dvsec(struct pci_dev *dev)
>  {
>  	return pci_find_dvsec_capability(dev, PCI_VENDOR_ID_CXL,
> @@ -5116,6 +5122,182 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
>  	return rc;
>  }
>  
> +static int cxl_reset_prepare(struct pci_dev *dev, u16 dvsec)
> +{
> +	u16 reg, val, cap;
> +	int rc;
> +	u32 timeout_us = 100, timeout_tot_us = 10000;
> +
> +	/*
> +	 * Wait for any pending transactions.
> +	 * Assuming this does cxl.io stuff.
> +	 */
> +	if (!pci_wait_for_pending_transaction(dev))
> +		pci_err(dev, "timed out waiting for pending transaction; performing cxl reset anyway\n");
> +
> +	/*
> +	 * Disable caching and then write back and invalidate lines.
> +	 */
> +	rc = pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVCAP,
> +				  &cap);
> +	if (rc)
> +		return rc;
> +
> +	if (!(cap & PCI_DVSEC_CXL_DEVCAP_CACHE_CAPABLE))
> +		return 0;
> +
> +	/*
> +	 * Disable cache.
> +	 * WB and invalidate cahce if capability is advertised.
> +	 */
> +	rc = pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVCTL2,
> +				  &reg);
> +	if (rc)
> +		return rc;
> +	val = reg | PCI_DVSEC_CXL_DEVCTL2_DISABLE_CACHING;
> +
> +	if (cap & PCI_DVSEC_CXL_DEVCAP_CACHE_WB_INVALIDATE)
> +		val = reg | PCI_DVSEC_CXL_DEVCTL2_INIT_CACHE_WB_INVALIDATE;
> +	pci_write_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVCTL2,
> +			      val);
> +
> +	/*
> +	 * From Section 9.6: "Software may leverage the cache size reported in
> +	 * the DVSEC CXL Capability2 register to compute a suitable timeout
> +	 * value".
> +	 * Given there is no conversion factor for cache size -> timeout,
> +	 * setting timer for default 10ms.
> +	 */
> +	do {
> +		if (timeout_tot_us < 0)
> +			return -ETIMEDOUT;
> +		usleep_range(timeout_us, timeout_us+1);
> +		timeout_tot_us -= timeout_us;
> +		rc = pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVCTL2,
> +					  &reg);
> +		if (rc)
> +			return rc;
> +	} while (!(reg & PCI_DVSEC_CXL_DEVSTATUS2_CACHE_INVALID));
> +
> +	return 0;
> +}
> +
> +/**
> + * cxl_reset_init - initiate a cxl reset
> + * @dev: device to reset
> + *
> + * Initiate a cxl reset.
> + */
> +static int cxl_reset_init(struct pci_dev *dev, u16 dvsec)
> +{
> +	u16 reg, val;
> +	u32 timeout_ms;
> +	int rc;
> +	u32 reset_timeouts_ms[] = {10, 100, 1000, 10000, 100000};
> +
> +	/*
> +	 * Check if CXL Reset MEM CLR is supported.
> +	 */
> +	rc = pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVCAP,
> +				  &reg);
> +	if (rc)
> +		return rc;
> +
> +	if (reg & PCI_DVSEC_CXL_DEVCAP_CXL_RST_MEM_CLR) {
> +		rc = pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVCTL2,
> +					  &reg);
> +		if (rc)
> +			return rc;
> +
> +		val = reg | PCI_DVSEC_CXL_DEVCTL2_CXL_RST_MEM_CLR_ENABLE;
> +		pci_write_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVCTL2,
> +				      val);
> +	}
> +
> +	/*
> +	 * Read timeout value
> +	 */
> +	rc = pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVCAP,
> +				  &reg);
> +	if (rc)
> +		return rc;
> +	timeout_ms = reset_timeouts_ms[FIELD_GET(PCI_DVSEC_CXL_DEVCAP_CXL_RST_TIMEOUT_MASK, reg)];
> +
> +	/*
> +	 * Write reset config
> +	 */
> +	rc = pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVCTL2,
> +				  &reg);
> +	if (rc)
> +		return rc;
> +
> +	val = reg | PCI_DVSEC_CXL_DEVCTL2_CXL_INIT_RST;
> +	pci_write_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVCTL2,
> +			      val);
> +
> +	/*
> +	 *  Wait till timeout and then check reset status is complete.
> +	 */
> +	msleep(timeout_ms);
> +	rc = pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVSTATUS2,
> +				  &reg);
> +	if (rc)
> +		return rc;
> +	if (reg & PCI_DVSEC_CXL_DEVSTATUS2_RST_ERR ||
> +	    ~reg & PCI_DVSEC_CXL_DEVSTATUS2_RST_COMPLETE)
> +		return -ETIMEDOUT;
> +
> +	/*
> +	 * Revert cashing disable.
> +	 */
> +	rc = pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVCTL2,
> +				  &reg);
> +	if (rc)
> +		return rc;
> +	val = (reg & (~PCI_DVSEC_CXL_DEVCTL2_DISABLE_CACHING));
> +	pci_write_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVCTL2,
> +			      val);
> +
> +	return 0;
> +}
> +
> +/**
> + * cxl_reset - initiate a cxl reset
> + * @dev: device to reset
> + * @probe: if true, return 0 if device can be reset this way
> + *
> + * Initiate a cxl reset on @dev.
> + */
> +static int cxl_reset(struct pci_dev *dev, bool probe)
> +{
> +	u16 dvsec, reg;
> +	int rc;
> +
> +	dvsec = cxl_device_dvsec(dev);
> +	if (!dvsec)
> +		return -ENOTTY;
> +
> +	/*
> +	 * Check if CXL Reset is supported.
> +	 */
> +	rc = pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVCAP,
> +				  &reg);
> +	if (rc)
> +		return -ENOTTY;
> +
> +	if (~(reg & PCI_DVSEC_CXL_DEVCAP_CXL_RST))
> +		return -ENOTTY;
> +
> +	if (probe)
> +		return 0;
> +
> +	rc = cxl_reset_prepare(dev, dvsec);
> +	if (rc)
> +		return rc;
> +
> +	return cxl_reset_init(dev, dvsec);
> +}
> +
>  void pci_dev_lock(struct pci_dev *dev)
>  {
>  	/* block PM suspend, driver probe, etc. */
> @@ -5202,6 +5384,7 @@ const struct pci_reset_fn_method pci_reset_fn_methods[] = {
>  	{ pci_dev_acpi_reset, .name = "acpi" },
>  	{ pcie_reset_flr, .name = "flr" },
>  	{ pci_af_flr, .name = "af_flr" },
> +	{ cxl_reset, .name = "cxl_reset" },
>  	{ pci_pm_reset, .name = "pm" },
>  	{ pci_reset_bus_function, .name = "bus" },
>  	{ cxl_reset_bus_function, .name = "cxl_bus" },
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 47b31ad724fa..efcb06598f26 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -51,7 +51,7 @@
>  			       PCI_STATUS_PARITY)
>  
>  /* Number of reset methods used in pci_reset_fn_methods array in pci.c */
> -#define PCI_NUM_RESET_METHODS 8
> +#define PCI_NUM_RESET_METHODS 9
>  
>  #define PCI_RESET_PROBE		true
>  #define PCI_RESET_DO_RESET	false
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 3445c4970e4d..52618c5b095d 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -1209,6 +1209,31 @@
>  #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_NEXT_INDEX	0xff000000
>  
>  /* Compute Express Link (CXL r3.1, sec 8.1.5) */
> +#define PCI_DVSEC_CXL_DEV				0
> +#define PCI_DVSEC_CXL_DEVCAP				0x0a
> +#define PCI_DVSEC_CXL_DEVCAP_CACHE_CAPABLE		0x00000001
> +#define PCI_DVSEC_CXL_DEVCAP_CACHE_WB_INVALIDATE	0x00000040
> +#define PCI_DVSEC_CXL_DEVCAP_CXL_RST			0x00000080
> +#define PCI_DVSEC_CXL_DEVCAP_CXL_RST_TIMEOUT_IND	0x8
> +#define PCI_DVSEC_CXL_DEVCAP_CXL_RST_TIMEOUT_MASK	0x00000700
> +#define PCI_DVSEC_CXL_DEVCAP_CXL_RST_MEM_CLR		0x00000800
> +#define PCI_DVSEC_CXL_DEVCTL				0x0c
> +#define PCI_DVSEC_CXL_DEVCTL2				0x10
> +#define PCI_DVSEC_CXL_DEVCTL2_DISABLE_CACHING		0x1
> +#define PCI_DVSEC_CXL_DEVCTL2_INIT_CACHE_WB_INVALIDATE	0x2
> +#define PCI_DVSEC_CXL_DEVCTL2_CXL_INIT_RST		0x4
> +#define PCI_DVSEC_CXL_DEVCTL2_CXL_RST_MEM_CLR_ENABLE	0x8
> +#define PCI_DVSEC_CXL_DEVSTATUS2			0x12
> +#define PCI_DVSEC_CXL_DEVSTATUS2_CACHE_INVALID		0x1
> +#define PCI_DVSEC_CXL_DEVSTATUS2_RST_COMPLETE		0x2
> +#define PCI_DVSEC_CXL_DEVSTATUS2_RST_ERR		0x4
> +#define PCI_DVSEC_CXL_DEVCAP2				0x16
> +#define PCI_DVSEC_CXL_DEVCAP2_CACHE_SIZE_UNIT		0x0000000F
> +#define PCI_DVSEC_CXL_DEVCAP2_CACHE_SIZE_UNIT_0		0x0
> +#define PCI_DVSEC_CXL_DEVCAP2_CACHE_SIZE_UNIT_1		0x40
> +#define PCI_DVSEC_CXL_DEVCAP2_CACHE_SIZE_UNIT_2		0x400
> +#define PCI_DVSEC_CXL_DEVCAP2_CACHE_SIZE(x)		(((x) & 0x0000FF00) >> 8)
> +
>  #define PCI_DVSEC_CXL_PORT				3
>  #define PCI_DVSEC_CXL_PORT_CTL				0x0c
>  #define PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR		0x00000001

