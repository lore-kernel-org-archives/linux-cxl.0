Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65198221F13;
	Tue, 13 Jan 2026 23:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768346157; cv=none; b=SnpnwwbSsbYc3brKiwCmi/kkC2tZ+AZ2ayGhaeGfRPdHIybw9VRi8ZPIlLc5/0BrAQvN3Ptvy0CZAagfqk4OAUMf9Z4McMtt91nhza83IUq4FCtt4EFLSMN9Lc/fJUq2sR4+hlJ3++wdfF0GxdrMu8ebTFdUq6ctRa4bxX2saaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768346157; c=relaxed/simple;
	bh=S1XnTvxxj7lQ2AIYO/iF4KNlozCGU2r1PYxBzTYLDps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I15BcT8pmEVgr44nfU1CMdWkxf+opAoxLItRi/0i+ibg7VzevOAZuvygn9FHhn7SDNW9/349Xfsw505AAR061VbZjvNgeBE+kr4nqLBAV1RwGrdQCruN4oVMm8cI5BFhZR2DfNOuSUV3tzNhBDjQj/EBnvds17FEFMC0yQcB/QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PGBP4hcm; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PGBP4hcm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768346156; x=1799882156;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=S1XnTvxxj7lQ2AIYO/iF4KNlozCGU2r1PYxBzTYLDps=;
  b=PGBP4hcma7qDkkDV7J8R6mYv4m3aAnVxQhP1BPtlACFYVcYX/nfTcRCM
   arkafcnJYQEynkPpL6aL//efMRkZdtkfnuQ1EvybhTtYrKJ2/ntQWk1In
   TUtvc8h8ND4wBb55ZIBrhd2lDdU+mTlTvovJ67Zh1YI01iy2DRlIF2K2O
   YBkZiKkU77+btEWbrJbKO89dzsOfaz1bVdXyyLhfUDzmiDPEQgJk0CYNy
   kZWy2cJ4X/0/fPFRqiIpfZWExU8ItHzT11KMRY+SSmuVKQEEV80M2t23G
   hZPdvdsQsplBhTu7ru43HXBIYGoJxtb/VU1KwA5NRtDl5kodFBHqKnCJ3
   Q==;
X-CSE-ConnectionGUID: 3HBx93gFSgKH5K0+0iypIQ==
X-CSE-MsgGUID: hYjFUP+6RjamejvQe/VaIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="69563140"
X-IronPort-AV: E=Sophos;i="6.21,224,1763452800"; 
   d="scan'208";a="69563140"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 15:15:56 -0800
X-CSE-ConnectionGUID: OH4xNStBSBSm75/UlTNXSQ==
X-CSE-MsgGUID: uugig+8FQRGuliG8poXLcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,224,1763452800"; 
   d="scan'208";a="209359939"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.110.189]) ([10.125.110.189])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 15:15:54 -0800
Message-ID: <0989c4eb-a32b-48bb-b6b8-a2ec5e43d008@intel.com>
Date: Tue, 13 Jan 2026 16:15:53 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 13/13] cxl: Disable HPA/SPA translation handlers for
 Normalized Addressing
To: Robert Richter <rrichter@amd.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Davidlohr Bueso <dave@stgolabs.net>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gregory Price <gourry@gourry.net>,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Terry Bowman <terry.bowman@amd.com>, Joshua Hahn <joshua.hahnjy@gmail.com>
References: <20260110114705.681676-1-rrichter@amd.com>
 <20260110114705.681676-14-rrichter@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260110114705.681676-14-rrichter@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/10/26 4:46 AM, Robert Richter wrote:
> The root decoder provides the callbacks hpa_to_spa and spa_to_hpa to
> perform Host Physical Address (HPA) and System Physical Address
> translations, respectively. The callbacks are required to convert
> addresses when HPA != SPA. XOR interleaving depends on this mechanism,
> and the necessary handlers are implemented.
> 
> The translation handlers are used for poison injection
> (trace_cxl_poison, cxl_poison_inject_fops) and error handling
> (cxl_event_trace_record).
> 
> In AMD Zen5 systems with Normalized Addressing, endpoint addresses are
> not SPAs, and translation handlers are required for these features to
> function correctly.
> 
> Now, as ACPI PRM translation could be expensive in tracing or error
> handling code paths, do not yet enable translations to avoid its
> intensive use. Instead, disable those features which are used only for
> debugging and enhanced logging.
> 
> Introduce the flag CXL_REGION_F_NORM_ADDR that indicates Normalized
> Addressing for a region and use it to disable poison injection and DPA
> to HPA conversion.
> 
> Note: Dropped unused CXL_DECODER_F_MASK macro.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/core/atl.c    |  3 +++
>  drivers/cxl/core/region.c | 33 +++++++++++++++++++++++++--------
>  drivers/cxl/cxl.h         |  9 ++++++++-
>  3 files changed, 36 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cxl/core/atl.c b/drivers/cxl/core/atl.c
> index 09d0ea1792d9..13f1118dc026 100644
> --- a/drivers/cxl/core/atl.c
> +++ b/drivers/cxl/core/atl.c
> @@ -169,8 +169,11 @@ static int cxl_prm_setup_root(struct cxl_root *cxl_root, void *data)
>  	 * decoders in the BIOS would prevent a capable kernel (or
>  	 * other operating systems) from shutting down auto-generated
>  	 * regions and managing resources dynamically.
> +	 *
> +	 * Indicate that Normalized Addressing is enabled.
>  	 */
>  	cxld->flags |= CXL_DECODER_F_LOCK;
> +	cxld->flags |= CXL_DECODER_F_NORM_ADDR;

IMO,
Spelling out NORMALIZED probably make the flag clearer the address is normalized vs a normal address.

DJ
>  
>  	ctx->hpa_range = hpa_range;
>  	ctx->interleave_ways = ways;
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 80cd77f0842e..8b68ccce1554 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1097,14 +1097,16 @@ static int cxl_rr_assign_decoder(struct cxl_port *port, struct cxl_region *cxlr,
>  	return 0;
>  }
>  
> -static void cxl_region_set_lock(struct cxl_region *cxlr,
> -				struct cxl_decoder *cxld)
> +static void cxl_region_setup_flags(struct cxl_region *cxlr,
> +				   struct cxl_decoder *cxld)
>  {
> -	if (!test_bit(CXL_DECODER_F_LOCK, &cxld->flags))
> -		return;
> +	if (test_bit(CXL_DECODER_F_LOCK, &cxld->flags)) {
> +		set_bit(CXL_REGION_F_LOCK, &cxlr->flags);
> +		clear_bit(CXL_REGION_F_NEEDS_RESET, &cxlr->flags);
> +	}
>  
> -	set_bit(CXL_REGION_F_LOCK, &cxlr->flags);
> -	clear_bit(CXL_REGION_F_NEEDS_RESET, &cxlr->flags);
> +	if (test_bit(CXL_DECODER_F_NORM_ADDR, &cxld->flags))
> +		set_bit(CXL_REGION_F_NORM_ADDR, &cxlr->flags);
>  }
>  
>  /**
> @@ -1218,7 +1220,7 @@ static int cxl_port_attach_region(struct cxl_port *port,
>  		}
>  	}
>  
> -	cxl_region_set_lock(cxlr, cxld);
> +	cxl_region_setup_flags(cxlr, cxld);
>  
>  	rc = cxl_rr_ep_add(cxl_rr, cxled);
>  	if (rc) {
> @@ -2493,7 +2495,7 @@ static struct cxl_region *cxl_region_alloc(struct cxl_root_decoder *cxlrd, int i
>  	device_set_pm_not_required(dev);
>  	dev->bus = &cxl_bus_type;
>  	dev->type = &cxl_region_type;
> -	cxl_region_set_lock(cxlr, &cxlrd->cxlsd.cxld);
> +	cxl_region_setup_flags(cxlr, &cxlrd->cxlsd.cxld);
>  
>  	return cxlr;
>  }
> @@ -3132,6 +3134,13 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
>  	u8 eiw = 0;
>  	int pos;
>  
> +	/*
> +	 * Conversion between SPA and DPA is not supported in
> +	 * Normalized Address mode.
> +	 */
> +	if (test_bit(CXL_REGION_F_NORM_ADDR, &cxlr->flags))
> +		return ULLONG_MAX;
> +
>  	for (int i = 0; i < p->nr_targets; i++) {
>  		if (cxlmd == cxled_to_memdev(p->targets[i])) {
>  			cxled = p->targets[i];
> @@ -3922,6 +3931,14 @@ static int cxl_region_setup_poison(struct cxl_region *cxlr)
>  	struct cxl_region_params *p = &cxlr->params;
>  	struct dentry *dentry;
>  
> +	/*
> +	 * Do not enable poison injection in Normalized Address mode.
> +	 * Conversion between SPA and DPA is required for this, but it is
> +	 * not supported in this mode.
> +	 */
> +	if (test_bit(CXL_REGION_F_NORM_ADDR, &cxlr->flags))
> +		return 0;
> +
>  	/* Create poison attributes if all memdevs support the capabilities */
>  	for (int i = 0; i < p->nr_targets; i++) {
>  		struct cxl_endpoint_decoder *cxled = p->targets[i];
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 20b0fd43fa7b..0ab0a86e1d4f 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -332,7 +332,7 @@ int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev, struct cxl_dport *dport);
>  #define CXL_DECODER_F_TYPE3 BIT(3)
>  #define CXL_DECODER_F_LOCK  BIT(4)
>  #define CXL_DECODER_F_ENABLE    BIT(5)
> -#define CXL_DECODER_F_MASK  GENMASK(5, 0)
> +#define CXL_DECODER_F_NORM_ADDR BIT(6)
>  
>  enum cxl_decoder_type {
>  	CXL_DECODER_DEVMEM = 2,
> @@ -525,6 +525,13 @@ enum cxl_partition_mode {
>   */
>  #define CXL_REGION_F_LOCK 2
>  
> +/*
> + * Indicate Normalized Addressing. Use it to disable SPA conversion if
> + * HPA != SPA and an address translation callback handler does not
> + * exist. Flag is needed by AMD Zen5 platforms.
> + */
> +#define CXL_REGION_F_NORM_ADDR 3
> +
>  /**
>   * struct cxl_region - CXL region
>   * @dev: This region's device

