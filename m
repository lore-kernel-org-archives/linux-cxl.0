Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819282D063C;
	Fri, 15 Aug 2025 23:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755299552; cv=none; b=icHM+Sqa+G8uE+0NNgFpfKRXkymDmvisfzxyVTdNWJyLhqb1IEGGCASwi77VFaDwKIaaAcUFks1AQB2HX1CPf/b2Pd2DFY/Prq1/7saAB22I/q2gNPuTLG+xBppbM4bViksX8QYqtxaIu377xTozvohKvG9uyUp1jJAD7AVu4qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755299552; c=relaxed/simple;
	bh=RRuR3OFQf2n2yx2B3a0IxNF6FGX2OPl0/6D+nmHh0Ho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b8cQvmtKqcKPmRIHDvQ5B9RSqliy3ynboCEAOfi7m6vNfE+PaFztLLjtub2U+0x176aI1Ek1wtEbWL2Xx9+QI8DYaZv2bo7RuKDcGhkldsvgP0/DPlF1PIoYE42i4Ac6MCPnXfoYxy5Vfk+O1ARu3dzIlvEkfBz3upz+0wW5DhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nq6tGWlC; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nq6tGWlC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755299550; x=1786835550;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RRuR3OFQf2n2yx2B3a0IxNF6FGX2OPl0/6D+nmHh0Ho=;
  b=nq6tGWlC81Gcw5AdDIVFAAS/QEcRb50f6HG1uEjEwqg79wGLdbAbNuTd
   EkmISxnx/j6ATPwq9VxhTPK41NNJV9c3m4zvEOS++cqvolZickYRS5Hw9
   zrfiMyOFgp3G7ayTQnOt1fpsp2cGTj0/XPBZc2/9gUki8grYrjlCHetY5
   ULva/53et0UniSpXybXsVhtfuaSPKxDY4Vw/e1OhC+ahQrJJv7ThZl2uz
   E31P1Aoy7EeI/NgckExU8gybWAf+KB++psnq23E5XVaukQAhFPi572Fus
   b9RscjJz+4rVNaKvZD9oLnJ4fAGA8B33bxHGa7O9FkW3efHtAWdKH6RHZ
   g==;
X-CSE-ConnectionGUID: e/XSz46jSQuMtyGNCU/y5Q==
X-CSE-MsgGUID: IbxZEfoFTO28eJOldTXnug==
X-IronPort-AV: E=McAfee;i="6800,10657,11523"; a="57483605"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="57483605"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 16:12:30 -0700
X-CSE-ConnectionGUID: KXLnnIUuQ7GWWcMvzSHD1Q==
X-CSE-MsgGUID: E2jR7i5FTrqgIAiI4pxzEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="166336943"
Received: from anmitta2-mobl4.gar.corp.intel.com (HELO [10.247.119.183]) ([10.247.119.183])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 16:12:25 -0700
Message-ID: <9966a586-8ad2-4724-a37b-298ac0257985@intel.com>
Date: Fri, 15 Aug 2025 16:12:20 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 05/20] nvdimm/region_label: Add region label updation
 routine
To: Neeraj Kumar <s.neeraj@samsung.com>, linux-cxl@vger.kernel.org,
 nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org, gost.dev@samsung.com
Cc: a.manzanares@samsung.com, vishak.g@samsung.com, neeraj.kernel@gmail.com
References: <20250730121209.303202-1-s.neeraj@samsung.com>
 <CGME20250730121228epcas5p411e5cc6d29fb9417178dbd07a1d8f02d@epcas5p4.samsung.com>
 <20250730121209.303202-6-s.neeraj@samsung.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250730121209.303202-6-s.neeraj@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/30/25 5:11 AM, Neeraj Kumar wrote:
<snip>

> diff --git a/drivers/nvdimm/nd.h b/drivers/nvdimm/nd.h
> index 651847f1bbf9..15d94e3937f0 100644
> --- a/drivers/nvdimm/nd.h
> +++ b/drivers/nvdimm/nd.h
> @@ -322,6 +322,26 @@ static inline void nsl_set_region_uuid(struct nvdimm_drvdata *ndd,
>  		export_uuid(ns_label->cxl.region_uuid, uuid);
>  }
>  
> +static inline bool rgl_uuid_equal(struct cxl_region_label *rg_label,
> +				  const uuid_t *uuid)
> +{
> +	uuid_t tmp;
> +
> +	import_uuid(&tmp, rg_label->uuid);
> +	return uuid_equal(&tmp, uuid);

Why the extra copy via import_uuid() rather than directly compare rg_labe->uuid vs the uuid param?

DJ

> +}
> +
> +static inline u64 rgl_get_checksum(struct cxl_region_label *rg_label)
> +{
> +	return __le64_to_cpu(rg_label->checksum);
> +}
> +
> +static inline void rgl_set_checksum(struct cxl_region_label *rg_label,
> +				    u64 checksum)
> +{
> +	rg_label->checksum = __cpu_to_le64(checksum);
> +}
> +
>  bool nsl_validate_type_guid(struct nvdimm_drvdata *ndd,
>  			    struct nd_namespace_label *nd_label, guid_t *guid);
>  enum nvdimm_claim_class nsl_get_claim_class(struct nvdimm_drvdata *ndd,
> diff --git a/include/linux/libnvdimm.h b/include/linux/libnvdimm.h
> index 0a55900842c8..b06bd45373f4 100644
> --- a/include/linux/libnvdimm.h
> +++ b/include/linux/libnvdimm.h
> @@ -115,6 +115,13 @@ struct nd_interleave_set {
>  	u64 altcookie;
>  
>  	guid_t type_guid;
> +
> +	/* v2.1 region label info */
> +	uuid_t uuid;
> +	int interleave_ways;
> +	int interleave_granularity;
> +	struct resource *res;
> +	int nr_targets;
>  };
>  
>  struct nd_mapping_desc {
> @@ -302,6 +309,7 @@ int nvdimm_has_flush(struct nd_region *nd_region);
>  int nvdimm_has_cache(struct nd_region *nd_region);
>  int nvdimm_in_overwrite(struct nvdimm *nvdimm);
>  bool is_nvdimm_sync(struct nd_region *nd_region);
> +int nd_region_label_update(struct nd_region *nd_region);
>  
>  static inline int nvdimm_ctl(struct nvdimm *nvdimm, unsigned int cmd, void *buf,
>  		unsigned int buf_len, int *cmd_rc)

