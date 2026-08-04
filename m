Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF1F20E702
	for <linux-cxl@vger.kernel.org>; Tue,  4 Aug 2026 22:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785882488; cv=none; b=Gj80C2PB3c7kciNLMBzAPdjr+TCIeQlt2Wrv7bFAkrIuTGywNrejtSjIQwcq6xSJ4Dwwh9CZhZpk8LVu++/CxhvImnV1Eccxg0d+cKy4VLmD0MHkxiYCori/RvvrZnmg7LZTdqyx3kBXtwx93VmDHJw/QMwu0jIjlVfQhXIb7ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785882488; c=relaxed/simple;
	bh=76QXQKK+30e3wGX0Yoy9+NbjMQ2gPz7SUR1CzXloeC0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aSC06dFK931O+8dH4WMJvIlHB1Zu3I265lVwlAfycEpJYXor/PlWuo15yaf/FotcZiCX7FsnehthOxhP2sCnn+jbjqs4fMkzdRt2jUoATe28OklUTt7+MzB5ElHG/u/CPckps6eY857lqG2zP0PtAziL+7o9TTcBKS00YYVChqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rn2oY+YU; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rn2oY+YU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785882486; x=1817418486;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=76QXQKK+30e3wGX0Yoy9+NbjMQ2gPz7SUR1CzXloeC0=;
  b=Rn2oY+YURCW4XoteDfrTWd0ffeVSJq3/YtgBb/gr8wu6zomoKUpdPonG
   X/0HqRQPgMDA0IWkaAyVp2s7nIxxMJG7fiI1Q+pibsZhVd1vbOQDIj5WL
   91NctfBrDdVh0ggZm2iWk7SKupSCJN5cU9nIVl5NmLlzDGuB/hTMyLdqM
   AHkEV/2Dqoj29dQCtXNlXdrkI4WQ8QGnTuFPp3rSi/tVfZgIIqo2afAc9
   zc2qGUMTOiyNm2MS00q3ps9kUNRwO/0sowxINCS9M7iVu/t2g608UI8GE
   qpAr5zBhA5vVoiHnuXzZG0xKpxabaNVtBDVkNkSt9EemQgBTmz2GndteE
   w==;
X-CSE-ConnectionGUID: zH9ZL3zIRYi5JkIdxdoYzA==
X-CSE-MsgGUID: 2fmDGYS+RP+wUZ8cZgz//g==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="111996546"
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="111996546"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 15:28:05 -0700
X-CSE-ConnectionGUID: t58bTF8+RMWaRP2xAeZy4Q==
X-CSE-MsgGUID: J69XDVaiQUG72EX8KebJZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="261062355"
Received: from jmaxwel1-mobl.amr.corp.intel.com (HELO [10.125.109.7]) ([10.125.109.7])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 15:28:04 -0700
Message-ID: <30e839e7-20b7-4d68-8fb7-bf6ee333c2b5@intel.com>
Date: Tue, 4 Aug 2026 15:28:03 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/8] cxl: Add HDM-DB region creation
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: jic23@kernel.org, alison.schofield@intel.com, icheng@nvidia.com,
 benjamin.cheatham@amd.com, alucerop@amd.com, dongjoo.seo1@samsung.com,
 linux-cxl@vger.kernel.org
References: <20260728144136.709882-1-dave@stgolabs.net>
 <20260728144136.709882-5-dave@stgolabs.net>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260728144136.709882-5-dave@stgolabs.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/28/26 7:41 AM, Davidlohr Bueso wrote:
> A region inherits its coherency from the chosen root decoder: HDM-DB
> if the root has CXL_DECODER_F_BI, otherwise HDM-H.
> 
> Surface the topology through read-only sysfs:
> 
>   - decoderX.Y/cap_bi (root): CFMWS BI restriction.
>   - decoderX.Y/bi (endpoint): '1' when configured for HDM-DB.
> 
> cxl_region_attach() rejects endpoints whose device or HDM cannot
> serve the region's type; target_type is inherited from cxlr->type
> in cxl_rr_assign_decoder() and restored to the endpoint default on
> detach and on a failed attach.
> 
> The HDM Decoder Control BI bit is set at commit time only when the
> target_type is DEVMEM and the BI capability is advertised
> (cxlds->bi for endpoints, root F_BI for switches).
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  Documentation/ABI/testing/sysfs-bus-cxl | 18 ++++++--
>  drivers/cxl/acpi.c                      | 15 +++++++
>  drivers/cxl/core/hdm.c                  | 23 ++++++++++
>  drivers/cxl/core/port.c                 | 39 +++++++++++++++--
>  drivers/cxl/core/region.c               | 57 +++++++++++++++++++------
>  drivers/cxl/cxl.h                       |  5 +++
>  6 files changed, 136 insertions(+), 21 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index 16a9b3d2e2c0..370c6fd7d245 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -297,7 +297,7 @@ Description:
>  		Each entry in the list is a dport id.
>  
>  
> -What:		/sys/bus/cxl/devices/decoderX.Y/cap_{pmem,ram,type2,type3}
> +What:		/sys/bus/cxl/devices/decoderX.Y/cap_{pmem,ram,type2,type3,bi}
>  Date:		June, 2021
>  KernelVersion:	v5.14
>  Contact:	linux-cxl@vger.kernel.org
> @@ -306,8 +306,9 @@ Description:
>  		represents a fixed memory window identified by platform
>  		firmware. A fixed window may only support a subset of memory
>  		types. The 'cap_*' attributes indicate whether persistent
> -		memory, volatile memory, accelerator memory, and / or expander
> -		memory may be mapped behind this decoder's memory window.
> +		memory, volatile memory, accelerator memory, expander memory,
> +		and / or back-invalidate (HDM-DB) memory may be mapped behind
> +		this decoder's memory window.
>  
>  
>  What:		/sys/bus/cxl/devices/decoderX.Y/target_type
> @@ -426,6 +427,17 @@ Description:
>  		current cached value.
>  
>  
> +What:		/sys/bus/cxl/devices/decoderX.Y/bi
> +Date:		July, 2026
> +KernelVersion:	v7.3
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) Shows '1' if this endpoint decoder is currently configured
> +		for HDM-DB (device-managed coherency with back-invalidate).
> +		The HDM-DB state is inherited from the region the decoder is
> +		attached to, which is in turn set from the chosen root
> +		decoder's CFMWS BI restriction (see cap_bi).
> +
>  What:		/sys/bus/cxl/devices/decoderX.Y/delete_region
>  Date:		May, 2022
>  KernelVersion:	v6.0
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 3b818adbd38b..eceb8dd97df2 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -152,6 +152,8 @@ static unsigned long cfmws_to_decoder_flags(int restrictions)
>  		flags |= CXL_DECODER_F_PMEM;
>  	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_FIXED)
>  		flags |= CXL_DECODER_F_LOCK;
> +	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_BI)
> +		flags |= CXL_DECODER_F_BI;
>  
>  	return flags;
>  }
> @@ -198,6 +200,12 @@ static int cxl_acpi_cfmws_verify(struct device *dev,
>  		dev_dbg(dev, "CFMWS length %d greater than expected %d\n",
>  			cfmws->header.length, expected_len);
>  
> +	if ((cfmws->restrictions & ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM) &&
> +	    (cfmws->restrictions & ACPI_CEDT_CFMWS_RESTRICT_BI)) {
> +		dev_err(dev, "CFMWS cannot have both HDM-H and HDM-DB\n");
> +		return -EINVAL;
> +	}
> +
>  	return 0;
>  }
>  
> @@ -437,7 +445,14 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
>  
>  	cxld = &cxlrd->cxlsd.cxld;
>  	cxld->flags = cfmws_to_decoder_flags(cfmws->restrictions);
> +	/* host-only wins if firmware sets both coherency restrictions */
>  	cxld->target_type = CXL_DECODER_HOSTONLYMEM;
> +	if (cxld->flags & CXL_DECODER_F_TYPE2) {
> +		if (cxld->flags & CXL_DECODER_F_TYPE3)
> +			dev_dbg(dev, "CFMWS has both HDM-H and HDM-D\n");
> +		else
> +			cxld->target_type = CXL_DECODER_DEVMEM;
> +	}
>  	cxld->hpa_range = (struct range) {
>  		.start = cfmws->base_hpa,
>  		.end = cfmws->base_hpa + cfmws->window_size - 1,
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 9da8aa211609..f437fe15c6df 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -705,9 +705,25 @@ static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
>  
>  static void cxld_set_type(struct cxl_decoder *cxld, u32 *ctrl)
>  {
> +	bool bi = cxld->target_type == CXL_DECODER_DEVMEM;
> +
> +	if (bi) {
> +		if (is_endpoint_decoder(&cxld->dev)) {
> +			struct cxl_endpoint_decoder *cxled =
> +				to_cxl_endpoint_decoder(&cxld->dev);
> +			struct cxl_dev_state *cxlds =
> +				cxled_to_memdev(cxled)->cxlds;
> +
> +			bi = cxlds->bi;
> +		} else if (cxld->region) {
> +			bi = cxl_root_decoder_is_bi(cxld->region->cxlrd);
> +		}
> +	}
> +
>  	u32p_replace_bits(ctrl,
>  			  !!(cxld->target_type == CXL_DECODER_HOSTONLYMEM),
>  			  CXL_HDM_DECODER0_CTRL_HOSTONLY);
> +	u32p_replace_bits(ctrl, bi, CXL_HDM_DECODER0_CTRL_BI);
>  }
>  
>  static void cxlsd_set_targets(struct cxl_switch_decoder *cxlsd, u64 *tgt)
> @@ -970,6 +986,13 @@ static int cxl_setup_hdm_decoder_from_dvsec(
>  	return 0;
>  }
>  
> +/*
> + * HDMs that advertise support for both coherency modes
> + * (CXL_HDM_DECODER_COHERENCY_BOTH) default to host-only; the region
> + * attach path switches target_type to device-coherent if the region's
> + * root decoder has the CFMWS BI bit set. Only HDMs that strictly
> + * support device-coherent mode default to HDM-DB.
> + */
>  enum cxl_decoder_type cxled_default_type(struct cxl_endpoint_decoder *cxled)
>  {
>  	struct cxl_dev_state *cxlds = cxled_to_memdev(cxled)->cxlds;
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 7817109026b1..2dbd8c24f968 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -131,6 +131,7 @@ CXL_DECODER_FLAG_ATTR(cap_ram, CXL_DECODER_F_RAM);
>  CXL_DECODER_FLAG_ATTR(cap_type2, CXL_DECODER_F_TYPE2);
>  CXL_DECODER_FLAG_ATTR(cap_type3, CXL_DECODER_F_TYPE3);
>  CXL_DECODER_FLAG_ATTR(locked, CXL_DECODER_F_LOCK);
> +CXL_DECODER_FLAG_ATTR(cap_bi, CXL_DECODER_F_BI);
>  
>  static ssize_t target_type_show(struct device *dev,
>  				struct device_attribute *attr, char *buf)
> @@ -233,6 +234,26 @@ static ssize_t mode_store(struct device *dev, struct device_attribute *attr,
>  }
>  static DEVICE_ATTR_RW(mode);
>  
> +static ssize_t bi_show(struct device *dev, struct device_attribute *attr,
> +		       char *buf)
> +{
> +	struct cxl_endpoint_decoder *cxled = to_cxl_endpoint_decoder(dev);
> +	struct cxl_dev_state *cxlds = cxled_to_memdev(cxled)->cxlds;
> +	struct cxl_region *cxlr;
> +
> +	guard(rwsem_read)(&cxl_rwsem.region);
> +	/*
> +	 * An endpoint decoder is HDM-DB when the device advertises BI
> +	 * (cxlds->bi) and it is attached to a device-coherent (DEVMEM)
> +	 * region whose root decoder advertises the CFMWS BI restriction.
> +	 */
> +	cxlr = cxled->cxld.region;
> +	return sysfs_emit(buf, "%d\n", cxlds->bi && cxlr &&
> +			  cxled->cxld.target_type == CXL_DECODER_DEVMEM &&
> +			  cxl_root_decoder_is_bi(cxlr->cxlrd));
> +}
> +static DEVICE_ATTR_RO(bi);
> +
>  static ssize_t dpa_resource_show(struct device *dev, struct device_attribute *attr,
>  			    char *buf)
>  {
> @@ -329,6 +350,7 @@ static struct attribute *cxl_decoder_root_attrs[] = {
>  	&dev_attr_cap_ram.attr,
>  	&dev_attr_cap_type2.attr,
>  	&dev_attr_cap_type3.attr,
> +	&dev_attr_cap_bi.attr,
>  	&dev_attr_target_list.attr,
>  	&dev_attr_qos_class.attr,
>  	SET_CXL_REGION_ATTR(create_pmem_region)
> @@ -339,16 +361,24 @@ static struct attribute *cxl_decoder_root_attrs[] = {
>  
>  static bool can_create_pmem(struct cxl_root_decoder *cxlrd)
>  {
> -	unsigned long flags = CXL_DECODER_F_TYPE3 | CXL_DECODER_F_PMEM;
> +	unsigned long flags = cxlrd->cxlsd.cxld.flags;
> +	unsigned long hdm_h, hdm_db;
>  
> -	return (cxlrd->cxlsd.cxld.flags & flags) == flags;
> +	hdm_h = CXL_DECODER_F_TYPE3 | CXL_DECODER_F_PMEM;
> +	hdm_db = CXL_DECODER_F_TYPE2 | CXL_DECODER_F_BI | CXL_DECODER_F_PMEM;
> +
> +	return (flags & hdm_h) == hdm_h || (flags & hdm_db) == hdm_db;
>  }
>  
>  static bool can_create_ram(struct cxl_root_decoder *cxlrd)
>  {
> -	unsigned long flags = CXL_DECODER_F_TYPE3 | CXL_DECODER_F_RAM;
> +	unsigned long flags = cxlrd->cxlsd.cxld.flags;
> +	unsigned long hdm_h, hdm_db;
> +
> +	hdm_h = CXL_DECODER_F_TYPE3 | CXL_DECODER_F_RAM;
> +	hdm_db = CXL_DECODER_F_TYPE2 | CXL_DECODER_F_BI | CXL_DECODER_F_RAM;
>  
> -	return (cxlrd->cxlsd.cxld.flags & flags) == flags;
> +	return (flags & hdm_h) == hdm_h || (flags & hdm_db) == hdm_db;
>  }
>  
>  static umode_t cxl_root_decoder_visible(struct kobject *kobj, struct attribute *a, int n)
> @@ -402,6 +432,7 @@ static const struct attribute_group *cxl_decoder_switch_attribute_groups[] = {
>  static struct attribute *cxl_decoder_endpoint_attrs[] = {
>  	&dev_attr_target_type.attr,
>  	&dev_attr_mode.attr,
> +	&dev_attr_bi.attr,
>  	&dev_attr_dpa_size.attr,
>  	&dev_attr_dpa_resource.attr,
>  	SET_CXL_REGION_ATTR(region)
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 1e211542b6b6..840acc330ede 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1130,16 +1130,11 @@ static int cxl_rr_assign_decoder(struct cxl_port *port, struct cxl_region *cxlr,
>  	}
>  
>  	/*
> -	 * Endpoints should already match the region type, but backstop that
> -	 * assumption with an assertion. Switch-decoders change mapping-type
> -	 * based on what is mapped when they are assigned to a region.
> +	 * Endpoint decoders inherit their type from cxlr->type; broken
> +	 * pairings were already rejected by the coherency checks in
> +	 * cxl_region_attach(). Switch-decoders change mapping-type based
> +	 * on what is mapped when they are assigned to a region.
>  	 */
> -	dev_WARN_ONCE(&cxlr->dev,
> -		      port == cxled_to_port(cxled) &&
> -			      cxld->target_type != cxlr->type,
> -		      "%s:%s mismatch decoder type %d -> %d\n",
> -		      dev_name(&cxled_to_memdev(cxled)->dev),
> -		      dev_name(&cxld->dev), cxld->target_type, cxlr->type);
>  	cxld->target_type = cxlr->type;
>  	cxl_rr->decoder = cxld;
>  	return 0;
> @@ -1827,6 +1822,8 @@ static int cxl_region_attach_position(struct cxl_region *cxlr,
>  	for (iter = cxled_to_port(cxled); !is_cxl_root(iter);
>  	     iter = to_cxl_port(iter->dev.parent))
>  		cxl_port_detach_region(iter, cxlr, cxled);
> +	/* undo cxl_rr_assign_decoder() type inheritance */
> +	cxled->cxld.target_type = cxled_default_type(cxled);
>  	return rc;
>  }
>  
> @@ -2059,6 +2056,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  	struct cxl_region_params *p = &cxlr->params;
>  	struct cxl_port *ep_port, *root_port;
>  	struct cxl_dport *dport;
> +	struct cxl_hdm *cxlhdm;
>  	int rc = -ENXIO;
>  
>  	rc = check_interleave_cap(&cxled->cxld, p->interleave_ways,
> @@ -2108,10 +2106,31 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  		return -ENXIO;
>  	}
>  
> -	if (cxled->cxld.target_type != cxlr->type) {
> -		dev_dbg(&cxlr->dev, "%s:%s type mismatch: %d vs %d\n",
> -			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
> -			cxled->cxld.target_type, cxlr->type);
> +	/*
> +	 * Verify the device and HDM are capable of the region's flavor before
> +	 * proceeding. The endpoint decoder's target_type is then inherited
> +	 * from cxlr->type later in cxl_rr_assign_decoder().
> +	 */
> +	if (cxlr->type == CXL_DECODER_DEVMEM &&
> +	    cxl_root_decoder_is_bi(cxlrd) && !cxlds->bi) {
> +		dev_err(&cxlr->dev, "%s:%s BI not enabled on device\n",
> +			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev));
> +		return -ENXIO;
> +	}
> +
> +	cxlhdm = dev_get_drvdata(&ep_port->dev);
> +	if (!cxlhdm)
> +		return -ENXIO;
> +	if (cxlr->type == CXL_DECODER_HOSTONLYMEM &&
> +	    cxlhdm->supported_coherency == CXL_HDM_DECODER_COHERENCY_DEV) {
> +		dev_warn(&cxlr->dev, "%s:%s HDM is device-coherent only\n",
> +			 dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev));
> +		return -ENXIO;
> +	}
> +	if (cxlr->type == CXL_DECODER_DEVMEM &&
> +	    cxlhdm->supported_coherency == CXL_HDM_DECODER_COHERENCY_HOST) {
> +		dev_warn(&cxlr->dev, "%s:%s HDM is host-only coherent\n",
> +			 dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev));
>  		return -ENXIO;
>  	}
>  
> @@ -2327,6 +2346,8 @@ __cxl_decoder_detach(struct cxl_region *cxlr,
>  		.start = 0,
>  		.end = -1,
>  	};
> +	/* undo cxl_rr_assign_decoder() type inheritance */
> +	cxled->cxld.target_type = cxled_default_type(cxled);
>  
>  	get_device(&cxlr->dev);
>  	return cxlr;
> @@ -2823,6 +2844,7 @@ static ssize_t create_region_store(struct device *dev, const char *buf,
>  				   size_t len, enum cxl_partition_mode mode)
>  {
>  	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev);
> +	enum cxl_decoder_type target_type;
>  	struct cxl_region *cxlr;
>  	int rc, id;
>  
> @@ -2834,7 +2856,14 @@ static ssize_t create_region_store(struct device *dev, const char *buf,
>  	if ((rc = ACQUIRE_ERR(mutex_intr, &regions_lock)))
>  		return rc;
>  
> -	cxlr = __create_region(cxlrd, mode, id, CXL_DECODER_HOSTONLYMEM);
> +	/*
> +	 * The CFMWS dictates endpoint coherency: a BI-restricted Window
> +	 * produces an HDM-DB region; otherwise HDM-H.
> +	 */
> +	target_type = cxl_root_decoder_is_bi(cxlrd) ?
> +		CXL_DECODER_DEVMEM : CXL_DECODER_HOSTONLYMEM;
> +
> +	cxlr = __create_region(cxlrd, mode, id, target_type);
>  	if (IS_ERR(cxlr))
>  		return PTR_ERR(cxlr);
>  
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index c323c38d0da2..ec2203561446 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -300,6 +300,7 @@ int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev, struct cxl_dport *dport);
>  #define CXL_DECODER_F_LOCK  BIT(4)
>  #define CXL_DECODER_F_ENABLE    BIT(5)
>  #define CXL_DECODER_F_NORMALIZED_ADDRESSING BIT(6)
> +#define CXL_DECODER_F_BI    BIT(7)
>  #define CXL_DECODER_F_RESET_MASK (CXL_DECODER_F_ENABLE | CXL_DECODER_F_LOCK)
>  
>  enum cxl_decoder_type {
> @@ -826,6 +827,10 @@ static inline int cxl_root_decoder_autoremove(struct device *host,
>  {
>  	return cxl_decoder_autoremove(host, &cxlrd->cxlsd.cxld);
>  }
> +static inline bool cxl_root_decoder_is_bi(struct cxl_root_decoder *cxlrd)
> +{
> +	return cxlrd->cxlsd.cxld.flags & CXL_DECODER_F_BI;
> +}
>  int cxl_endpoint_autoremove(struct cxl_memdev *cxlmd, struct cxl_port *endpoint);
>  
>  /**

