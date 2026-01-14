Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F616335573;
	Wed, 14 Jan 2026 18:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768415318; cv=none; b=Xo8u3EKabWniboBY8zf8i0/SVM96iMMydFeScoQygJ5BRuvg4ftO1kB4W+6pSvGer3AVYBZvAItPPLg0Al4wG4eUrWQPriZNnvhH/rO92EJNmxTbpo2aimNbQqiZTqsEtH+7LgMGVaMFxLLNPbqc/tknrDQ79WalZoLkA+MphRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768415318; c=relaxed/simple;
	bh=B/l+hdSo79efToV/S32HPqIwFRrs6gJDZL0DKV6l+H8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=affmVVeHaBJD/upzq01f+DZVM1K5QL6TlNTj56wXR2YXHH132/vO9sPLoVMEm7bjC+nySTiyYqmYCbcJP1scUl3arKt7Fgvl9aaB2mPVx6KwBgf+6nYgNNBuT9uZzujuiPRh0GwKr8b7GNmGcZ40Kn3RWSqyalDwS63o20vNtt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R9siDhfQ; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R9siDhfQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768415314; x=1799951314;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=B/l+hdSo79efToV/S32HPqIwFRrs6gJDZL0DKV6l+H8=;
  b=R9siDhfQNhfOmeNa5juK7bcr1oDHdejYVEHnYvOosCVtDTw52AxXZi25
   JK0/802Fsulrr9HZySxX1P/FQhTfzilMcSm0IbQ8VeJD8+d216VGwDLGC
   jBZNu6g885fyPcwUpoNo5NrH/6Sx10Vg7+WGfiTtgWPaGZnXb/05zhhCN
   4NJZRy89qzdrexiWyM5kLn2U3/bAKD77mlkagC8kjeBeOfIUv6VcLv0uI
   fN4TzIZ1pgcI2Eln9GRcGQhlGglxoX2urDQJr4AniwZ26aPFbUICNRWEU
   QBoTBHGY7Mw04vOnhV44YBLjmiOInbOZhC5bZUz43+s9EDmUceyaAO2MO
   g==;
X-CSE-ConnectionGUID: uf2QV3KkRtyb3WbYlrDCaw==
X-CSE-MsgGUID: vg1Is335QfKIDeYQzg0ekA==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="68930171"
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="68930171"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 10:28:33 -0800
X-CSE-ConnectionGUID: J7cBc3OdSr2TX79N/Cl/Qg==
X-CSE-MsgGUID: +vxRPwiLTpCL85r57SjVFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="205014197"
Received: from dwoodwor-mobl2.amr.corp.intel.com (HELO [10.125.111.5]) ([10.125.111.5])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 10:28:32 -0800
Message-ID: <c3ea841a-a220-438b-84c3-cabb73da94d4@intel.com>
Date: Wed, 14 Jan 2026 11:28:31 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 13/13] cxl: Disable HPA/SPA translation handlers for
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
References: <20260114164837.1076338-1-rrichter@amd.com>
 <20260114164837.1076338-14-rrichter@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260114164837.1076338-14-rrichter@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/14/26 9:48 AM, Robert Richter wrote:
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
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>

As you mentioned commit log needs updating, otherwise
Reviewed-by: Dave Jiang <dave.jiang@intel.com>


> ---
>  drivers/cxl/core/atl.c    |  3 +++
>  drivers/cxl/core/region.c | 33 +++++++++++++++++++++++++--------
>  drivers/cxl/cxl.h         |  9 ++++++++-
>  3 files changed, 36 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cxl/core/atl.c b/drivers/cxl/core/atl.c
> index 09d0ea1792d9..310668786189 100644
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
> +	cxld->flags |= CXL_DECODER_F_NORMALIZED_ADDRESSING;
>  
>  	ctx->hpa_range = hpa_range;
>  	ctx->interleave_ways = ways;
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 80cd77f0842e..8e92b491d686 100644
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
> +	if (test_bit(CXL_DECODER_F_NORMALIZED_ADDRESSING, &cxld->flags))
> +		set_bit(CXL_REGION_F_NORMALIZED_ADDRESSING, &cxlr->flags);
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
> +	if (test_bit(CXL_REGION_F_NORMALIZED_ADDRESSING, &cxlr->flags))
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
> +	if (test_bit(CXL_REGION_F_NORMALIZED_ADDRESSING, &cxlr->flags))
> +		return 0;
> +
>  	/* Create poison attributes if all memdevs support the capabilities */
>  	for (int i = 0; i < p->nr_targets; i++) {
>  		struct cxl_endpoint_decoder *cxled = p->targets[i];
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 20b0fd43fa7b..de30a87600be 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -332,7 +332,7 @@ int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev, struct cxl_dport *dport);
>  #define CXL_DECODER_F_TYPE3 BIT(3)
>  #define CXL_DECODER_F_LOCK  BIT(4)
>  #define CXL_DECODER_F_ENABLE    BIT(5)
> -#define CXL_DECODER_F_MASK  GENMASK(5, 0)
> +#define CXL_DECODER_F_NORMALIZED_ADDRESSING BIT(6)
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
> +#define CXL_REGION_F_NORMALIZED_ADDRESSING 3
> +
>  /**
>   * struct cxl_region - CXL region
>   * @dev: This region's device

