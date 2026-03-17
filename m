Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0307B35CB75;
	Tue, 17 Mar 2026 14:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773758902; cv=none; b=gvUORXd/26rwmPJYr2/5AmcXCJeVchNJdS3BrSF8EfArI/sJdfIxBgpEVEAOCXW9pbAWMSadaMBYBJzJ8mWWaR8DFbPN40/X5JjXe8YibJseY3Ej0LtywxnTncXImfBlW69IR/kXvLTl80BZzBuIHXmknj/C3LZtwUB4DL8HG0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773758902; c=relaxed/simple;
	bh=oVBHEN0W6U+YG/ccsn44CuP0rknA7FAKuzkqVBjwDUk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MJ7Ii59kwJ0y9eJZ/RFxxj7Rq4KUgECbMQTATUwfISow+1+gFXeBqonNP8Ix54CH3bfbbDGpRhSu1E+V6mplsB95kolUj2JXugo1GMoCSXzdXI6MqxkjoGzmkEfPzQxNBCZIU0Xn10N68ZRvDZ5XQA+AS6IesvAMJDQ1jPnPPHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dKh8Te2Y; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dKh8Te2Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773758900; x=1805294900;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oVBHEN0W6U+YG/ccsn44CuP0rknA7FAKuzkqVBjwDUk=;
  b=dKh8Te2Y+LBDwDvk3iLW9PfWSAzo5JPgldKMSYYCb5o7OrIYfTEeH8b6
   lIjWf+4NN3LJXDv0i7atnjBZxM53X4UhB1/6O3+JoaNPrQzGRZ7KZaouG
   7PSf+bRCSHvSt+T0bQgbSyUk34BKCT55nDJehbHV0A1GF9BrI2iWy2CBB
   +83MyKiS6rn0XJVOmrLWKImIr/mhjVMrp126QNNcZJrZ+nYE2NO0Nji4s
   pWwtC3lCGwD0DTQMfJZy36sbymmS1mQHFZ1WMBSkrv4b3oVodU3j+QuSj
   a7E2GPv0AxOhq1Mq8/mF23J6HeP4f4BpB3dBaMZ78FK212xuTxhvfo97P
   A==;
X-CSE-ConnectionGUID: cprjoE7dRH+4en/CUZzy3A==
X-CSE-MsgGUID: dCSetV4eTSW9vsNw8f9qcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="85421075"
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="85421075"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 07:48:19 -0700
X-CSE-ConnectionGUID: r1IneDCjRj+42unEe95B6g==
X-CSE-MsgGUID: 8/b/3FUCTSSS/5KDYsifVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="222343805"
Received: from schen9-mobl4.amr.corp.intel.com (HELO [10.125.108.169]) ([10.125.108.169])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 07:48:18 -0700
Message-ID: <2aa6594d-3277-4637-af6a-9be11400d05d@intel.com>
Date: Tue, 17 Mar 2026 07:48:17 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/acpi: Fix coding style issues in acpi.c
To: Teshan Kannangara <tpk.teshan@gmail.com>, dave@stgolabs.net
Cc: jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <ablFdTrypTz67N0D@the-machine>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <ablFdTrypTz67N0D@the-machine>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/17/26 5:13 AM, Teshan Kannangara wrote:
> Fix various coding style issues in drivers/cxl/acpi.c, including
> indentation, line wrapping, macro alignment, cast formatting,
> and conditional braces.

Hi Teshan,
Thank you for the code changes. While we appreciate it, I'm going to NAK the changes. For this sub-system, we are not going to make style changes or fixes unless it's part of functional code changes or refactor. The reason is to not introduce unnecessary churns to the code that can make fix backports difficult later on. Thanks.

DJ

> 
> No functional changes.
> 
> Signed-off-by: Teshan Kannangara <tpk.teshan@gmail.com>
> ---
>  drivers/cxl/acpi.c | 26 +++++++++++++++++---------
>  1 file changed, 17 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 127537628817..b54b962cf973 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -395,9 +395,16 @@ static void cxl_setup_extended_linear_cache(struct cxl_root_decoder *cxlrd)
>  	cxlrd->cache_size = cache_size;
>  }
>  
> -DEFINE_FREE(put_cxlrd, struct cxl_root_decoder *,
> -	    if (!IS_ERR_OR_NULL(_T)) put_device(&_T->cxlsd.cxld.dev))
> -DEFINE_FREE(del_cxl_resource, struct resource *, if (_T) del_cxl_resource(_T))
> +DEFINE_FREE
> +(put_cxlrd, struct cxl_root_decoder *,
> +if (!IS_ERR_OR_NULL(_T))
> +	put_device(&_T->cxlsd.cxld.dev))
> +
> +DEFINE_FREE
> +(del_cxl_resource, struct resource *,
> +if (_T)
> +	del_cxl_resource(_T))
> +
>  static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
>  			     struct cxl_cfmws_context *ctx)
>  {
> @@ -419,8 +426,8 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
>  	if (rc)
>  		return rc;
>  
> -	struct resource *res __free(del_cxl_resource) = alloc_cxl_resource(
> -		cfmws->base_hpa, cfmws->window_size, ctx->id++);
> +	struct resource *res __free(del_cxl_resource) =
> +		alloc_cxl_resource(cfmws->base_hpa, cfmws->window_size, ctx->id++);
>  	if (!res)
>  		return -ENOMEM;
>  
> @@ -542,7 +549,7 @@ static int cxl_get_chbs_iter(union acpi_subtable_headers *header, void *arg,
>  	struct cxl_chbs_context *ctx = arg;
>  	struct acpi_cedt_chbs *chbs;
>  
> -	chbs = (struct acpi_cedt_chbs *) header;
> +	chbs = (struct acpi_cedt_chbs *)header;
>  
>  	if (chbs->cxl_version == ACPI_CEDT_CHBS_VERSION_CXL11 &&
>  	    chbs->length != ACPI_CEDT_CHBS_LENGTH_CXL11)
> @@ -774,12 +781,12 @@ static void cxl_acpi_lock_reset_class(void *dev)
>  
>  static void cxl_set_public_resource(struct resource *priv, struct resource *pub)
>  {
> -	priv->desc = (unsigned long) pub;
> +	priv->desc = (unsigned long)pub;
>  }
>  
>  static struct resource *cxl_get_public_resource(struct resource *priv)
>  {
> -	return (struct resource *) priv->desc;
> +	return (struct resource *)(priv->desc);
>  }
>  
>  static void remove_cxl_resources(void *data)
> @@ -850,8 +857,9 @@ static int add_cxl_resources(struct resource *cxl_res)
>  				remove_resource(next);
>  				del_cxl_resource(next);
>  				next = _next;
> -			} else
> +			} else {
>  				next->start = new->end + 1;
> +			}
>  		}
>  	}
>  	return 0;

