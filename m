Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720931DF968;
	Fri, 18 Apr 2025 16:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744994314; cv=none; b=DAi/RHtNKr1gMK5eJH9c7t1c2NhoEYhlOVj0iX96G97XRE+REwO2+jdRvYe9KWrFayiEC591SwyJ1OFC2rSaQ38ovwViITDandPalj7oFbypCnQfi0tzGJUkAiIgdI8X8Awl7XRg6bMPoUpYnSwbhHcbRdxiVwsg5cjclolKQyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744994314; c=relaxed/simple;
	bh=DAIIt6eRSIzIJLTvfxaGOkPKtc1ZafUVlq7juo2C4hw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cRhLvwTCbYwTkQMQt0thigf2t9xBWTCmyT2hFm5CEOxXOAs27FtismJNNUTinZw03UeoPvVwErx3hLgLwMBgnqOWQ67RbNsboOZWD8bJN2aElk/vj2wE5sb6oa1VF5CqyUezFNcM6Wrxe5Qr//YH9eqfV3Gb9TZpBasIIjAyYPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=chyBpRXQ; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="chyBpRXQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744994312; x=1776530312;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DAIIt6eRSIzIJLTvfxaGOkPKtc1ZafUVlq7juo2C4hw=;
  b=chyBpRXQk0e0kDxF4AP/E6Ki2O+0e4mmoMIGZH7y4KW70Qp4bM3HlvOd
   DxvPl2mw/3T+NYbb3ALcpbAXpAthSyXO/dn9H7pwv3OwBRMlr+x3ygFmg
   nR4uVgrG0sMMipnU7BsAjVU6+T6FN2S752bOn+BOmI6ssDAEFndPWZ8eO
   frWyB85QmdIQveMZ1HxHYTEGhiMwahJ3P/Td+86KeF9Q8zrIq+CIw3Vs1
   583kmiUkz7jHQ1l+ZR6bZbzpFVJQiJXz4qGzA4oHLjwwc7OvsZpt3vQJn
   G7Cg/s0JRexwS4vOY/4VAT+D0DPF/fIJAYbdTKqanu5tQ/nM8GFTApesl
   w==;
X-CSE-ConnectionGUID: 0O0B1LnPTH+emeIBZz+GIQ==
X-CSE-MsgGUID: j8AJ/HDZR6uHEIATe9EA0w==
X-IronPort-AV: E=McAfee;i="6700,10204,11407"; a="57287776"
X-IronPort-AV: E=Sophos;i="6.15,222,1739865600"; 
   d="scan'208";a="57287776"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 09:38:31 -0700
X-CSE-ConnectionGUID: rhxGGFi9RuyasET+Dyyu8Q==
X-CSE-MsgGUID: 7PZSg75KR3iF05yDhhAWfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,222,1739865600"; 
   d="scan'208";a="132046673"
Received: from dwoodwor-mobl2.amr.corp.intel.com (HELO [10.125.110.182]) ([10.125.110.182])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 09:38:31 -0700
Message-ID: <e2ef92a1-3f9d-4c03-8528-be4c45449511@intel.com>
Date: Fri, 18 Apr 2025 09:38:27 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] cxl/feature: Update out_len in set feature failure
 case
To: Li Ming <ming.li@zohomail.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250410024521.514095-1-ming.li@zohomail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250410024521.514095-1-ming.li@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/9/25 7:45 PM, Li Ming wrote:
> CXL subsystem supports userspace to configure features via fwctl
> interface, it will configure features by using Set Feature command.
> Whatever Set Feature succeeds or fails, CXL driver always needs to
> return a structure fwctl_rpc_cxl_out to caller, and returned size is
> updated in a out_len parameter. The out_len should be updated not only
> when the set feature succeeds, but also when the set feature fails.
> 
> Fixes: eb5dfcb9e36d ("cxl: Add support to handle user feature commands for set feature")
> Signed-off-by: Li Ming <ming.li@zohomail.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>

Applied to cxl/fixes

> ---
> base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8 v6.15-rc1
> 
> v3:
> - Add fixes tag
> v2:
> - Adjust changelog
> ---
>  drivers/cxl/core/features.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
> index fcc624cefe89..63f24f032209 100644
> --- a/drivers/cxl/core/features.c
> +++ b/drivers/cxl/core/features.c
> @@ -540,13 +540,13 @@ static void *cxlctl_set_feature(struct cxl_features_state *cxlfs,
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

