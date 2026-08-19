Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263723A901C;
	Wed, 19 Aug 2026 15:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787154918; cv=none; b=C9uV4NUVnCLuyMUuCS2ZWpAK+rd9D60BPgtJv+PvhsgL9mzURPmSr0AvHxPJcltA8iKZpkmIajig/1x9TTgtchL1kTJEzO699Yivpxgjfd2BJD1pAb3ydF/7dUkJnRurhNMPFjOstuaFB/cO42aj/ZEM0wFiVqmb2wrvKoZjQc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787154918; c=relaxed/simple;
	bh=qxqn7m7ZLLRRC53/D8WOrstBLxaLCsQvDegIHZPa+2I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fr+wgyDCZLZw4/T88fjpXFmyc1Tb6jgrhCZ6Sx/q8k6QTO0R8Z+0LTUE6KQyh+X201tDUyMHLgcvWYo5HuSd82C/tj++eIS4jW2zaJ9cINP8ZYX6ji8KSQNHs3WpAZLj3ZBJ06PP4dsx4EY9gpgsa96Yk3UYIu9ZMwZ+gJE9PV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PslL6K79; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PslL6K79"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787154916; x=1818690916;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qxqn7m7ZLLRRC53/D8WOrstBLxaLCsQvDegIHZPa+2I=;
  b=PslL6K79NEGZuVf2N3z+Lf2UsDQMM7SXITieL9OAtM5+NylOFRHkH3mU
   4/u3WclDMTqCaofDztbdQ6r0wTKew0q+Cu+ClCveu9/s2/V61sCszCzmD
   HFYJg55qSmh4W7guLnyhSnBnyXdeD5R4kmRiKgcu1KeytdLmb18zN+SCE
   m/mI6eUBDuXrgSaAOGGaJHqxLqbxBZWNmBVlRHjEoUM4rgxMaa8iVqVGz
   EBzSQX3kvln89Y8xKLclrbVcgkIs2i2hJhjfNJqtQPgDkLHPHrwYtYDX/
   +1Oh5WXHqyh1DYOMX+GMILGoKTFTpHyF5ZeNcJV4lpb5LhgJIHYYuO+hw
   w==;
X-CSE-ConnectionGUID: BMRzZB7aQGGJpyAXewF1KA==
X-CSE-MsgGUID: 4+Jfyw+QTviOQSx4IoiaQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="98837849"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="98837849"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 08:55:13 -0700
X-CSE-ConnectionGUID: qThtE1DkTum9RWeNE2jmkQ==
X-CSE-MsgGUID: WjIYr2ekTfKjekejChpscw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="295503192"
Received: from aschende-mobl.amr.corp.intel.com (HELO [10.125.108.13]) ([10.125.108.13])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 08:55:11 -0700
Message-ID: <96c5d90a-4503-45d1-99c6-4bedae3165bc@intel.com>
Date: Wed, 19 Aug 2026 08:55:10 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/7] cxl/memdev: Don't overwrite the error from an
 earlier partition poison query
To: Richard Cheng <icheng@nvidia.com>, dave@stgolabs.net, jic23@kernel.org,
 alison.schofield@intel.com, vishal.l.verma@intel.com
Cc: iweiny@kernel.org, ming.li@zohomail.com, gourry@gourry.net,
 rrichter@amd.com, linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 kees@kernel.org, newtonl@nvidia.com, kristinc@nvidia.com,
 kaihengf@nvidia.com, kobak@nvidia.com
References: <20260813034538.13189-1-icheng@nvidia.com>
 <20260813034538.13189-6-icheng@nvidia.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260813034538.13189-6-icheng@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/12/26 8:45 PM, Richard Cheng wrote:
> cxl_get_poison_by_memdev() queries Get Poison List per partition but
> never checks the result inside the loop, so a later partition's success
> overwrites an earlier partition's failure and the whole scan reports
> success while that partition's poison went unlisted. Before the loop
> conversion the PMEM query returned early on error. Stop the loop on any
> error not already tolerated as a RAM -EFAULT.
> 
> Fixes: be5cbd084027 ("cxl: Kill enum cxl_decoder_mode")
> Signed-off-by: Richard Cheng <icheng@nvidia.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>


> ---
> Changelog:
> 
> v1->v2:
>     - New added patch ( sashiko-bot's report )
> ---
>  drivers/cxl/core/memdev.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index b3419df586b9..e39b3d13fd56 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -231,6 +231,8 @@ static int cxl_get_poison_by_memdev(struct cxl_memdev *cxlmd)
>  		 */
>  		if (rc == -EFAULT && cxlds->part[i].mode == CXL_PARTMODE_RAM)
>  			rc = 0;
> +		if (rc)
> +			break;
>  	}
>  	return rc;
>  }

