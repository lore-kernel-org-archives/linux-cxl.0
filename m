Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831BC2FF147
	for <linux-cxl@vger.kernel.org>; Tue,  9 Sep 2025 20:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757451492; cv=none; b=nc5rB1T77DQ2jdUIyEDQ1IYfCCTrQb/rb6AI4YEUFFjFviHGJQ24j7M1tCjec+YwQPzlMseCNV/lgDrnoY2AXva9dBezTMS918R3YeimNCAsRwf6rBsECwY4RCfrSOH+hpEevpYix1D6i08dPskOR91rwtW/SEM58MG6KMeREcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757451492; c=relaxed/simple;
	bh=uqdYHO0OQmo97EKpZP5U5Sr5NFlbdCdKfLpjnQm/4Vg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qhAzN65jDjHVvQcFqH7pw+SVi++T21FgLgLOuJKQJTlgugFDj3C+mZ2fUEVfvb46McHnBEHLy2fkaI1nhRm2nrGT52xXjCPOcWgoPpJHxPQ07P6fTJYAf8LdTbIv854lwMuWVptqXme8VlvZS8sr6CRRqRPMedlpm4PqNJy3pBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MHYG5WaV; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MHYG5WaV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757451491; x=1788987491;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=uqdYHO0OQmo97EKpZP5U5Sr5NFlbdCdKfLpjnQm/4Vg=;
  b=MHYG5WaVels6UGdxfgM8IAFujLQKikFQu5sT3kV6JaZGq01U8w8upeKi
   Q4eNALTBev7gvehO+JEaiVuiXgBz2CLrnoY2/Y2miWOWkJGvl0Eudywxc
   KlW8u6xBnSHI9pJr4dUMi9cNbmJ25+LS9bF54aKEE61CzkFLJQoW4s9BC
   2T7OnksBLS+FwAKXWy6/A8bJ7m7agVyzwnkXYSeMh59X69EVpGoL6KCRG
   4MmociUtrNp8w9D8xXKJxH20TOG+bK0OINsNXZTtwQksYsy2u1LdhzkoB
   rpY10xZXbjKzoZJchA4yPMs0erayxQlfalsGQjJOLExCpIfGVw/4Xaett
   g==;
X-CSE-ConnectionGUID: YZgIF69aTJOQde7a+6Ofmw==
X-CSE-MsgGUID: 73bfFgAVTFOG/D1Z85cjlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11548"; a="77205700"
X-IronPort-AV: E=Sophos;i="6.18,252,1751266800"; 
   d="scan'208";a="77205700"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 13:58:11 -0700
X-CSE-ConnectionGUID: OYAlznqATKaRnqat97k6Zg==
X-CSE-MsgGUID: 1TmsSYMNQF6nVEf2f6/Jqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,252,1751266800"; 
   d="scan'208";a="172783859"
Received: from msatwood-mobl.amr.corp.intel.com (HELO [10.125.110.155]) ([10.125.110.155])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 13:58:09 -0700
Message-ID: <62bc178e-5c13-45d1-af9c-502b18625153@intel.com>
Date: Tue, 9 Sep 2025 13:58:08 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 09/18] cxl/core: Add function for getting CXL cache
 info
To: Ben Cheatham <Benjamin.Cheatham@amd.com>, linux-cxl@vger.kernel.org
References: <20250812212921.9548-1-Benjamin.Cheatham@amd.com>
 <20250812212921.9548-10-Benjamin.Cheatham@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250812212921.9548-10-Benjamin.Cheatham@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/12/25 2:29 PM, Ben Cheatham wrote:
> Add a function for getting common CXL.cache information. This
> information will be stored in the struct cxl_cache_state member
> (cinfo) of struct cxl_dev_state for easy access by endpoint drivers.
> 
> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
> ---
>  drivers/cxl/core/pci.c | 45 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h      |  7 +++++++
>  drivers/cxl/cxlcache.h |  2 ++
>  drivers/cxl/cxlpci.h   |  4 ++++
>  4 files changed, 58 insertions(+)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 717e25131db7..2279c2690c59 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -7,6 +7,7 @@
>  #include <linux/pci.h>
>  #include <linux/pci-doe.h>
>  #include <linux/aer.h>
> +#include <cxlcache.h>
>  #include <cxlpci.h>
>  #include <cxlmem.h>
>  #include <cxl.h>
> @@ -1187,3 +1188,47 @@ int cxl_port_update_total_dports(struct cxl_port *port)
>  	return 0;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_port_update_total_dports, "CXL");
> +
> +int cxl_accel_get_cache_info(struct cxl_dev_state *cxlds)

Maybe cxl_accel_read_cache_info() since the function doesn't return the cache info.
> +{
> +	struct cxl_cache_state *cstate = &cxlds->cstate;
> +	struct pci_dev *pdev;
> +	int dvsec, rc;
> +	u16 cap, cap2;
> +
> +	if (!dev_is_pci(cxlds->dev))
> +		return -EINVAL;
> +	pdev = to_pci_dev(cxlds->dev);
> +
> +	dvsec = cxlds->cxl_dvsec;
> +
> +	rc = pci_read_config_word(pdev, dvsec + CXL_DVSEC_CAP_OFFSET, &cap);
> +	if (rc)
> +		return rc;
> +
> +	if (!(cap & CXL_DVSEC_CACHE_CAPABLE))
> +		return -ENXIO;
> +
> +	rc = pci_read_config_word(pdev, dvsec + CXL_DVSEC_CAP2_OFFSET, &cap2);
> +	if (rc)
> +		return rc;
> +
> +	/* CXL 3.2 8.1.3.7 DVSEC CXL Capability2 for encoding */
> +	switch (FIELD_GET(CXL_DVSEC_CACHE_UNIT_MASK, cap2)) {
> +	case 1:
> +		cstate->unit = 64;

Do we need to keep the cache size unit around in 'cstate'? Maybe use a local variable for the size calculation later? Also, should this be SZ_64K and SZ_1M? The cache size is off by 1024 otherwise when it gets calculated below.

DJ

> +		break;
> +	case 2:
> +		cstate->unit = 1024;
> +		break;
> +	default:
> +		return -ENXIO;
> +	}
> +
> +	cstate->size = FIELD_GET(CXL_DVSEC_CACHE_SIZE_MASK, cap2) * cstate->unit;
> +	if (!cstate->size)
> +		return -ENXIO;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_accel_get_cache_info, "CXL");
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 0dc4e5c96459..1771c42a1e3b 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -753,6 +753,11 @@ struct cxl_dev_ops {
>  	int (*probe)(struct device *cxldev);
>  };
>  
> +struct cxl_cache_state {
> +	u64 size;
> +	u32 unit;
> +};
> +
>  /**
>   * struct cxl_dev_state - The driver device state
>   *
> @@ -774,6 +779,7 @@ struct cxl_dev_ops {
>   * @serial: PCIe Device Serial Number
>   * @type: Generic Memory Class device or Vendor Specific Memory device
>   * @cxl_mbox: CXL mailbox context
> + * @cstate: CXL cache state and capabilities
>   * @cxlfs: CXL features context
>   */
>  struct cxl_dev_state {
> @@ -791,6 +797,7 @@ struct cxl_dev_state {
>  	u64 serial;
>  	enum cxl_devtype type;
>  	struct cxl_mailbox cxl_mbox;
> +	struct cxl_cache_state cstate;
>  #ifdef CONFIG_CXL_FEATURES
>  	struct cxl_features_state *cxlfs;
>  #endif
> diff --git a/drivers/cxl/cxlcache.h b/drivers/cxl/cxlcache.h
> index 3ccbeba9fcd6..3880312cd49d 100644
> --- a/drivers/cxl/cxlcache.h
> +++ b/drivers/cxl/cxlcache.h
> @@ -20,4 +20,6 @@ static inline struct cxl_cachedev *to_cxl_cachedev(struct device *dev)
>  }
>  
>  bool is_cxl_cachedev(const struct device *dev);
> +
> +int cxl_accel_get_cache_info(struct cxl_dev_state *cxlds);
>  #endif
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index 7827a183128d..e5dd132be7e7 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -17,10 +17,14 @@
>  /* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
>  #define CXL_DVSEC_PCIE_DEVICE					0
>  #define   CXL_DVSEC_CAP_OFFSET		0xA
> +#define     CXL_DVSEC_CACHE_CAPABLE	BIT(0)
>  #define     CXL_DVSEC_MEM_CAPABLE	BIT(2)
>  #define     CXL_DVSEC_HDM_COUNT_MASK	GENMASK(5, 4)
>  #define   CXL_DVSEC_CTRL_OFFSET		0xC
>  #define     CXL_DVSEC_MEM_ENABLE	BIT(2)
> +#define   CXL_DVSEC_CAP2_OFFSET		0x16
> +#define     CXL_DVSEC_CACHE_UNIT_MASK	GENMASK(3, 0)
> +#define     CXL_DVSEC_CACHE_SIZE_MASK	GENMASK(15, 8)
>  #define   CXL_DVSEC_RANGE_SIZE_HIGH(i)	(0x18 + (i * 0x10))
>  #define   CXL_DVSEC_RANGE_SIZE_LOW(i)	(0x1C + (i * 0x10))
>  #define     CXL_DVSEC_MEM_INFO_VALID	BIT(0)

