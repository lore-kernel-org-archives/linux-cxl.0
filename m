Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69C4349CCC;
	Mon, 13 Jul 2026 17:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783964000; cv=none; b=uDF3bYGjfMmFfx0CG5LBYddHCPZ8DYzjMWvsJolG017M5UhLcgv8czJ53iBxDvbSkFa94GTEsdWCHbQLTujg3Rbmd3/rLrQpbEUSPiSjD7PV3NWCKSanrGMgwDQvndbGVlQtMTrTmKYN552O6TrVx9oxdlGTUMytW8gpQqesuzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783964000; c=relaxed/simple;
	bh=LaV/OutoklX+MJ3Y0gYdCVyJjKAF5auKb+w7Ri4ep18=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZXAMDbUPLkm4/yv3imTHqKDP5lCLVySdReyGvIjF+j58XJNNaoWlDHpcCd0Ex8nmr1jmePrg/drGlqAZdnkl3x/SH1ZlSnY3YHF7PGOXPkXUM1pYE0wsWbISK+RrWV7tpl/81nJDlX1Ut+KhK3bN74dJ/lHEpa30sQ9c1ikL+kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NzrVk2df; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NzrVk2df"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783963999; x=1815499999;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LaV/OutoklX+MJ3Y0gYdCVyJjKAF5auKb+w7Ri4ep18=;
  b=NzrVk2dfVl12MEbZClyYex05SLeM7JFOBYnEiOsArBF/u70L6hdlSIZM
   7COG4+vF1xIP4Y6B3ILNWzVS4V87VswGvGAiOFsdC8OfIFstmd0Gk/hpo
   77Pj7AfGlujJ9GQ5w5L0eYRiOtFV/yVRTcbE8TsiP+el2aQ+44ksY+vRw
   gjfTaEOzRgUO12jb9usXS4Q9Y1JWzHFQmbkQy9qyjyscXxKewvSh51Xy2
   zdvYogWrdhxbJJiXSO5MEtCERvpRSyyKmW3AptjG4u/q4PkCdl2XHbWX4
   u6+2IypEQFrpi25zmudN7CxygT9BHonQ6Lc/93tM9ELVyrjUf8Paf6rdC
   A==;
X-CSE-ConnectionGUID: mjFbjnvuTaaCC3wAN/CPIA==
X-CSE-MsgGUID: xwi0QC5jSkeS7/b2opzQDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84543552"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84543552"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 10:33:18 -0700
X-CSE-ConnectionGUID: qnKDtzRnRWGCDFXMhAXLhw==
X-CSE-MsgGUID: 5PRNnafCTh2Ebz2rO9iHrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="251667078"
Received: from gabaabhi-mobl2.amr.corp.intel.com (HELO [10.125.108.69]) ([10.125.108.69])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 10:32:58 -0700
Message-ID: <ee05ecc2-11e4-477d-b57d-5fe17d19e38a@intel.com>
Date: Mon, 13 Jul 2026 10:32:57 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/memdev: Fix firmware upload exact-fit handling
To: guzebing <guzebing1612@gmail.com>, dave@stgolabs.net, jic23@kernel.org,
 alison.schofield@intel.com, vishal.l.verma@intel.com, djbw@kernel.org,
 iweiny@kernel.org, ming.li@zohomail.com
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260713112744.2543829-1-guzebing1612@gmail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260713112744.2543829-1-guzebing1612@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/13/26 4:27 AM, guzebing wrote:
> From: Guzebing <Guzebing1612@gmail.com>
> 
> cxl_fw_prepare() classifies a firmware image as a one-shot transfer
> only when its Transfer FW input payload is smaller than the mailbox
> payload size. An image that exactly fills the payload is therefore
> treated as a multi-part transfer.
> 
> The firmware loader invokes cxl_fw_write() only once for that image.
> Since both offset == 0 and remaining == 0, the multi-part action
> selection sends INITIATE, never sends END, and then attempts to activate
> the target slot.
> 
> Include equality in the one-shot classification so exact-fit images use
> the FULL action.
> 
> Fixes: 9521875bbe00 ("cxl: add a firmware update mechanism using the sysfs firmware loader")
> Signed-off-by: Guzebing <Guzebing1612@gmail.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/core/memdev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 33a3d2e7b13af..45e7d2be17e09 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -921,7 +921,7 @@ static enum fw_upload_err cxl_fw_prepare(struct fw_upload *fwl, const u8 *data,
>  	if (!size)
>  		return FW_UPLOAD_ERR_INVALID_SIZE;
>  
> -	mds->fw.oneshot = struct_size(transfer, data, size) <
> +	mds->fw.oneshot = struct_size(transfer, data, size) <=
>  			    cxl_mbox->payload_size;
>  
>  	if (cxl_mem_get_fw_info(mds))

