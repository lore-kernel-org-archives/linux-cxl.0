Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A98262816
	for <linux-cxl@vger.kernel.org>; Fri, 14 Feb 2025 16:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739552236; cv=none; b=QgxWLgcALNz89/4d89oeRTEUFePTKZg8a+mkMtmSAUPkjvy1P0YjemwlH5YEplkAd3CJiRd1faCivwOr2+VupoLk63PqI7k3SQGMXTCI2g02N9ctGXxMbpLSRF1PdChrkU6yODv59/C/UXR4NidP3BjctQ/k81vzBKjLkDEt7JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739552236; c=relaxed/simple;
	bh=zBnQXjhCw7Y6srsm7Pm7hKjWLU/YR7cFoDfWUvFUD+g=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G34yQKeh8hLaxv/vobJxsZAEb1Q00IW7diClJb1unG9baobbFa/FhR1epTCPmhIPvi8Yu5hef7sIHL8GjEs8g1ryVD02GUaMLu1xpnw+dBwUiw3jaVXHVXQQPcSW/0a/exRcbkOwMujVN91LbZ7WtODtpcpVSDTouIrPXSUwAyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YvdTx5SVqz6HJg8;
	Sat, 15 Feb 2025 00:55:49 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 928B3140A77;
	Sat, 15 Feb 2025 00:57:11 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 14 Feb
 2025 17:57:11 +0100
Date: Fri, 14 Feb 2025 16:57:09 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Srirangan Madhavan <smadhavan@nvidia.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Zhi Wang <zhiw@nvidia.com>, "Vishal Aslot"
	<vaslot@nvidia.com>, Shanker Donthineni <sdonthineni@nvidia.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v1 1/1] cxl: add support for cxl reset
Message-ID: <20250214165709.00002008@huawei.com>
In-Reply-To: <20250207090327.172478-2-smadhavan@nvidia.com>
References: <20250207090327.172478-1-smadhavan@nvidia.com>
	<20250207090327.172478-2-smadhavan@nvidia.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 7 Feb 2025 01:03:27 -0800
Srirangan Madhavan <smadhavan@nvidia.com> wrote:

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
Hi Sriranagan,

Various style related comments inline.  My main suggestion is
to match local style of the file you are editing where possible.
Also look for duplication of defines etc.

I haven't checked the spec for precise sequence but will
do that on a v2 once the more superficial stuff is tidied up.

Thanks,

Jonathan


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
File seems to at least at first glance use reverse xmas tree.
So do that here as well.

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

Single line comment.

> +	rc = pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVCAP,
> +				  &cap);
One line. It is under 80 chars anyway.

> +	if (rc)
> +		return rc;
> +
> +	if (!(cap & PCI_DVSEC_CXL_DEVCAP_CACHE_CAPABLE))
> +		return 0;
> +
> +	/*
> +	 * Disable cache.
> +	 * WB and invalidate cahce if capability is advertised.

cache

> +	 */
> +	rc = pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVCTL2,
> +				  &reg);

One line. It fits I think.

> +	if (rc)
> +		return rc;
> +	val = reg | PCI_DVSEC_CXL_DEVCTL2_DISABLE_CACHING;

I'd do this in place in reg.

> +
> +	if (cap & PCI_DVSEC_CXL_DEVCAP_CACHE_WB_INVALIDATE)
> +		val = reg | PCI_DVSEC_CXL_DEVCTL2_INIT_CACHE_WB_INVALIDATE;

I think intent is keep disable caching set for this one?
If not use an else to make that clear.

> +	pci_write_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVCTL2,
> +			      val);

Single line.  Check all the code for this.


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

Spaces around +

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
Local style is reverse xmas and spaces after { and before } in lines
like this (well the one I could find anyway).

> +
> +	/*
> +	 * Check if CXL Reset MEM CLR is supported.
> +	 */
Single line comment is fine.

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

Single line comment.

> +	rc = pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVCAP,
> +				  &reg);
> +	if (rc)
> +		return rc;
> +	timeout_ms = reset_timeouts_ms[FIELD_GET(PCI_DVSEC_CXL_DEVCAP_CXL_RST_TIMEOUT_MASK, reg)];

Rather long line. I'd be tempted to use a local variable for the FIELD_GET()

> +
> +	/*
> +	 * Write reset config
Single line comment.
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
Extra space before W and I think fits on single line anyway.
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

	/* Check if CXL Reset is supported. */

> +	rc = pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVCAP,
> +				  &reg);

One line. It is under 80 chars.

> +	if (rc)
> +		return -ENOTTY;
> +
> +	if (~(reg & PCI_DVSEC_CXL_DEVCAP_CXL_RST))

Using ~ for a single bit is unusual. I'd go with 

if (reg & PCI_DVSEC_CXL_DEVCAP_CXL_RST == 0)
or !(reg & ...)



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

We need to deduplicate the stuff in here and drivers/cxl/cxlpci.h
as CXL_DVSEC_PCIE_DEVICE

I have not complaints about promoting this if it is going to be used
by PCI core code, but I don't want to see two lots of definitions
for the same registers. Given there are a lot of renames
etc, do that as a precursor patch.



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

