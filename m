Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55705146A68;
	Wed,  9 Apr 2025 15:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744213081; cv=none; b=APQegdzuCeNk4ERuBzLSNwUwLQjWQFhazXwSXQ+UcPP0+osdWrLNgj4ioQYFBYav8kOFPT8s8j3BG382QAWDU1sLpXaQUkbsw/LqDuPrY809yHxBveVJ0ynojvQX09WVdjqCG6lpUqiIRDLFVs3IfG1Brj0OUHX+ZIsQjNoQI8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744213081; c=relaxed/simple;
	bh=Np4BTx1MWkMz2bIXuqdoxHghOz7aK/DoTriXQNuO/CI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NtezyLOzczFuTiR++UbM83v55++hDzmX5KDRRfttvV0T/u4uSXzMZRYyzPpG4KDNzq5G7Y3XSSs9EgnduRCKlhDQS7Mc9DOeT2HSfoqfK/C+pVAdcnIvXO6RxElh5obGnticwQVHshsljG94DSzi0DOixuq8bUk8aaDUFQaf8V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jCTbsY2V; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jCTbsY2V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744213076; x=1775749076;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Np4BTx1MWkMz2bIXuqdoxHghOz7aK/DoTriXQNuO/CI=;
  b=jCTbsY2VW6GEnX23PbhrK5E4gP1WOhO5hKHNDxhZ4B6Fg5wR5RsL+V3N
   SI469Ew2769mGUOLChxYR8nl9tNoHSmqJqc+4byGCQDx5YtbgnGf6a6iB
   bAfZqAz71qOWLSLd8ASB9fkYP4PUcaVyqbUJdZZ4Z7w4TEVWf/PClE3Dn
   Ks34K1vpTEex/24yvX/QrxRAiOd9LrEXEerBn3Cb7o+1Y/BGhu74tzfah
   O3qQWw9pv7nd+rN3yze1VcWl6l+WDZFw4eouj4nxWd5LZYF/NyIyTUbhC
   nNW3QdtmEeX7cnSuFOBJ+tyV0U0eCDbWOWhDoLxxNkT6zRUZkEwP0n+1k
   Q==;
X-CSE-ConnectionGUID: X0jivdV3Qwqqlxpu9Mcilg==
X-CSE-MsgGUID: FKHVxARZS5S1zPqTMSmS5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11399"; a="49490694"
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; 
   d="scan'208";a="49490694"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 08:37:56 -0700
X-CSE-ConnectionGUID: ISocaCiRTZOLLHKbMJqlbg==
X-CSE-MsgGUID: +RLLekkYQECZ/2bqbblf3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; 
   d="scan'208";a="129144844"
Received: from ldmartin-desk2.corp.intel.com (HELO [10.125.111.236]) ([10.125.111.236])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 08:37:54 -0700
Message-ID: <1be19059-e879-4404-a68a-10093fef7522@intel.com>
Date: Wed, 9 Apr 2025 08:37:53 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] cxl/feature: Update out_len in set feature failure
 case
To: Li Ming <ming.li@zohomail.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250409022521.510146-1-ming.li@zohomail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250409022521.510146-1-ming.li@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/8/25 7:25 PM, Li Ming wrote:
> CXL subsystem supports userspace to configure features via fwctl
> interface, it will configure features by using Set Feature command.
> Whatever Set Feature succeeds or fails, CXL driver always needs to
> return a structure fwctl_rpc_cxl_out to caller, and returned size is
> updated in a out_len parameter. The out_len should be updated not only
> when the set feature succeeds, but also when the set feature fails.

Good catch! Can you add a Fixes tag please? Otherwise 
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> 
> Signed-off-by: Li Ming <ming.li@zohomail.com>
> ---
> base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8 v6.15-rc1
> 
> v2:
> - Adjust changelog
> ---
>  drivers/cxl/core/features.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
> index f4daefe3180e..066dfc29a3dd 100644
> --- a/drivers/cxl/core/features.c
> +++ b/drivers/cxl/core/features.c
> @@ -528,13 +528,13 @@ static void *cxlctl_set_feature(struct cxl_features_state *cxlfs,
>  	rc = cxl_set_feature(cxl_mbox, &feat_in->uuid,
>  			     feat_in->version, feat_in->feat_data,
>  			     data_size, flags, offset, &return_code);
> +	*out_len = sizeof(*rpc_out);
>  	if (rc) {
>  		rpc_out->retval = return_code;
>  		return no_free_ptr(rpc_out);
>  	}
>  
>  	rpc_out->retval = CXL_MBOX_CMD_RC_SUCCESS;
> -	*out_len = sizeof(*rpc_out);
>  
>  	return no_free_ptr(rpc_out);
>  }

