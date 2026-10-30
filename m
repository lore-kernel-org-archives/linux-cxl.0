Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793382283;
	b=yqb25UhKuEJKtieKFge7vDbBO6gNvoYIgN+Vf5jQyuA6jSfDEv8MoYuzuJM2x01onntX
	 xJamjQB8sgaFZ4AK1CpeK1HZgchNJOyKyWAB5KSu5bGsKuIdwnnpsdCDeUAFZZdvRw/OO
	 FG4yPAiekDVLbBKdwb9eK2ej0/TAeSk1eeqQcW2FNaYhf3lTZBr8QHh/r8ngedtNDTvr7
	 HkbA0hy2fedW+byoF1sCS94Dm/fEJtsaevYpbxmD3e+//BAlf7biRhX8KYQWJSY9zm8eO
	 ZDZJ0WhE99Vvq8ZrEVVgK4kQxBjN3LtIlTkSLFhrZZuRZAwpU2o/+sf25DQKCh0M39g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793382283;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=uyz/moT4XWk2hg7FT4YB9Yk/YINtl//XwejBwFZqG4E=;
	b=K6FMFjBzIJ3md4T3+jD0iQ3GVgW8JqbsmAs3+vKrAPvnYx2WGZOWpDEEgBeoyRxGHnz3
	 6TKCpmhAIIFC3ht97o5KoinL8DIIcB8OBcwMGUE28wSW6n0X5MK/wXjZbFSKgdxfBJZWV
	 eRHqBc1eqeFmPAPIknfTh9bj2sDu3Z2zTfpw2zdqtvHPAyY2X11Oc0yM1th/6tlyccMYL
	 XJu97o7e34vz7CdQw3zISm+OwOQmBalfF1ZWB0dUXciYczbHfYPgfK6Ky4MsXxwoLSMRb
	 iSC/caJUbWQynQ5rE0kLLkXhX2bi+8JFqYNELPU4/+DvjurszPrGVbU3satYQjP+36A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nOVqdeeF;
	arc=none smtp.remote-ip=192.198.163.17
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5E1606A327;
	Fri, 30 Oct 2026 17:44:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA5E1606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nOVqdeeF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793382281; x=1824918281;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7VTKQF8YjTNjE0dGQhTtouqOFNuMnHUVbZ0R3zxvUp8=;
  b=nOVqdeeFJgeOIzWO2TmaUgnt5B7wvXC1BwAajb7QX+VfCGHQBpIgez5M
   9O2TNlOEJkf/iBiheRnPEI9m2/ZjvonCbknaedtrBrCqgqn9hpIqTcFZk
   gu5Ih6kPd6Txo28s3qbsPaHAI6ZzQgiUe69hLgxG4RMLBQD9NnEES4aPf
   +T3c61f+nh3Rq3nqhYApICYI5LPwdmXsSDVR3xp2CeOHdYarBOkmHFTV7
   359dy3GsaYZuIR5GV70OZg50P+UvRaHzOUfJedwO7Z9DLhzzLTIKE8eyR
   RkT3bpD8wHM4deoQ9xMdrHM1MoN68qwyfDz4klzPZvYFWJ3jXQc7dmhfm
   w==;
X-CSE-ConnectionGUID: sTikJxK0QgebyNyhzSeF7Q==
X-CSE-MsgGUID: S+wMicyfQXO/FYYyyrtzXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11951"; a="2168751"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2168751"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 10:44:40 -0700
X-CSE-ConnectionGUID: 9BReUaZYTiely0xeakXeAA==
X-CSE-MsgGUID: MTULlDgyR3qmJkmyy7unuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="5514963"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.109.85]) ([10.125.109.85])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 10:44:39 -0700
Message-ID: <8afa233c-13c3-478e-89d2-1d3f87ec7c08@intel.com>
Date: Fri, 30 Oct 2026 10:44:36 -0700
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/edac: Mask DPA flags in the event record cache key
To: Jongwon Lee <ai@linux.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jic23@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>
Cc: Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>,
 Richard Cheng <icheng@nvidia.com>, Shiju Jose <shiju.jose@huawei.com>,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261030072721.31970-1-ai@linux.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20261030072721.31970-1-ai@linux.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/30/26 12:27 AM, Jongwon Lee wrote:
> The low bits of the DPA in a General Media or DRAM event record are
> flags: bit 0 is VOLATILE and bit 1 is NOT_REPAIRABLE. The trace events
> report the DPA with CXL_DPA_MASK applied, but cxl_store_rec_gen_media()
> and cxl_store_rec_dram() use the raw value as the xarray key.
> 
> User space reads the DPA from the trace event and writes it to the
> mem_repair dpa attribute. If the record had any flag set, xa_load()
> misses it and the repair fails with -EINVAL. The raw key also lets a
> repair go through for a record the device marked NOT_REPAIRABLE, if the
> DPA is written with bit 1 set.
> 
> Key the records by the masked DPA and skip records marked
> NOT_REPAIRABLE.
> 
> Co-developed with Claude Code.

You can drop this now. Or just put it under ---

> 
> Fixes: 0b5ccb0de1e2 ("cxl/edac: Support for finding memory operation attributes from the current boot")
> Signed-off-by: Jongwon Lee <ai@linux.com>

Is this a real email address? Please use your actual email. 

> ---
> 
> Notes:
>     Tested on QEMU master (b574eaf) with a CXL type 3 device, region
>     committed, KASAN and PROVE_LOCKING on. DRAM events injected with
>     cxl-inject-dram-event at 0x1001, 0x2000 and 0x3002, then a repair
>     requested through mem_repair0..4. Same result for all five:
>     
>       DPA written   before    after
>       0x1000        -EINVAL   ok
>       0x1001        ok        -EINVAL
>       0x2000        ok        ok
>       0x3000        -EINVAL   -EINVAL
>       0x3002        ok        -EINVAL
>       0x5000        -EINVAL   -EINVAL
>     
>     No KASAN, lockdep or WARN output. Only DRAM events were injected; the
>     General Media path has the same change but was not exercised. Not
>     tested on real CXL hardware.
> 
>  drivers/cxl/core/edac.c | 25 +++++++++++++++++++------
>  1 file changed, 19 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
> index 34b81e8dfb..b3dfc33ca6 100644
> --- a/drivers/cxl/core/edac.c
> +++ b/drivers/cxl/core/edac.c
> @@ -918,6 +918,21 @@ struct cxl_mem_repair_attrbs {
>  	enum cxl_mem_repair_type repair_type;
>  };
>  
> +/*
> + * The low bits of the event record DPA are flags (VOLATILE, NOT_REPAIRABLE).
> + * Records are looked up by the DPA user space writes back, which comes from
> + * the trace event and has the flags masked off, so key them the same way.
> + */
> +static unsigned long cxl_rec_key(const struct cxl_event_media_hdr *hdr)
> +{
> +	return le64_to_cpu(hdr->phys_addr) & CXL_DPA_MASK;
> +}
> +
> +static bool cxl_rec_not_repairable(const struct cxl_event_media_hdr *hdr)
> +{
> +	return le64_to_cpu(hdr->phys_addr) & CXL_DPA_NOT_REPAIRABLE;
> +}
> +
>  static struct cxl_event_gen_media *
>  cxl_find_rec_gen_media(struct cxl_memdev *cxlmd,
>  		       struct cxl_mem_repair_attrbs *attrbs)
> @@ -929,7 +944,7 @@ cxl_find_rec_gen_media(struct cxl_memdev *cxlmd,
>  		return NULL;
>  
>  	rec = xa_load(&array_rec->rec_gen_media, attrbs->dpa);
> -	if (!rec)
> +	if (!rec || cxl_rec_not_repairable(&rec->media_hdr))
>  		return NULL;
>  
>  	if (attrbs->repair_type == CXL_PPR)
> @@ -950,7 +965,7 @@ cxl_find_rec_dram(struct cxl_memdev *cxlmd,
>  		return NULL;
>  
>  	rec = xa_load(&array_rec->rec_dram, attrbs->dpa);
> -	if (!rec)
> +	if (!rec || cxl_rec_not_repairable(&rec->media_hdr))
>  		return NULL;
>  
>  	validity_flags = get_unaligned_le16(rec->media_hdr.validity_flags);
> @@ -1105,8 +1120,7 @@ int cxl_store_rec_gen_media(struct cxl_memdev *cxlmd, union cxl_event *evt)
>  		return -ENOMEM;
>  
>  	old_rec = xa_store(&array_rec->rec_gen_media,
> -			   le64_to_cpu(rec->media_hdr.phys_addr), rec,
> -			   GFP_KERNEL);
> +			   cxl_rec_key(&rec->media_hdr), rec, GFP_KERNEL);
>  	if (xa_is_err(old_rec)) {
>  		kfree(rec);
>  		return xa_err(old_rec);
> @@ -1135,8 +1149,7 @@ int cxl_store_rec_dram(struct cxl_memdev *cxlmd, union cxl_event *evt)
>  		return -ENOMEM;
>  
>  	old_rec = xa_store(&array_rec->rec_dram,
> -			   le64_to_cpu(rec->media_hdr.phys_addr), rec,
> -			   GFP_KERNEL);
> +			   cxl_rec_key(&rec->media_hdr), rec, GFP_KERNEL);
>  	if (xa_is_err(old_rec)) {
>  		kfree(rec);
>  		return xa_err(old_rec);

