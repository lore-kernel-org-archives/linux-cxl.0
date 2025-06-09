Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD14120AF98;
	Mon,  9 Jun 2025 16:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749487263; cv=none; b=LBp5yxvWmCuFxUq2Y5fKIhWNlck9DKjIHNGjW5YnPxJbfhqkEv59IKCMocuTb195zecUBSlfF1GZYLsNP+PS8LsZCVO231+X9kKnogCM7t9RBjCSo5CBtiiLBubSU5SrDIY4uh1Cw3T2qvzsA/pqYGXwMY3g6BbNgi7KZlBU2Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749487263; c=relaxed/simple;
	bh=ha7ECEKCMCDchRfPNYxpMZ6Vo/9sNn6p8DDILVKCivQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LJLj+x7uzdtO7r70zrGN6w/yOR+1tdU1PlbFwEtSZxWgA5Q25qce/AzGCPAKal61q4t6M58eD3Ti5SmxBsvDUve7YxDmGqWIGzSW6RChfKMfGKXk48orpOnSEgcq1v3bo+tymOhhwTQy3D6cw2MB70eq4GBAC/4beUbtWat+Sko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N6PIfZuG; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N6PIfZuG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749487262; x=1781023262;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ha7ECEKCMCDchRfPNYxpMZ6Vo/9sNn6p8DDILVKCivQ=;
  b=N6PIfZuGEJBVni9Flwj6d0zMers+NHS0KVCZEarvPEHHM5vPr2hrxJed
   lMmR8aylGzRrUPF3FH2l1Dk7zUAUkvGF/bXZWHdY4NtzK2qr8wja6pgE3
   YFio3mxp7zGyTr9dgsew3bPrzaSKCcRknvLm9yo4y+V83mK1dVdAlyLsw
   hjZM8/MDzvAYvyc4WUVIvJRfu1mfMbGQLV+ycLiBfr9Uf6PDio2d5HWlZ
   4Xg3RijsNOoECqXKgXwHPg4f1chpuA6M42jX71+ggdDGVg5I56QzlbheD
   GioEk9i67nc0WskuRtuqwA9o0tnoXnoj+iGNxJG1FxzHUCM4IX5UQwJpQ
   A==;
X-CSE-ConnectionGUID: Vyp5unAwS4KOF1pO+uDOKA==
X-CSE-MsgGUID: GmMEUPJDR062VIsPpJL7/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="55236806"
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; 
   d="scan'208";a="55236806"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 09:40:02 -0700
X-CSE-ConnectionGUID: A+m0HTtnQYO99xJMx+aCrA==
X-CSE-MsgGUID: fJ3h8UzPQai2LhrzdDauZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; 
   d="scan'208";a="151440305"
Received: from msatwood-mobl.amr.corp.intel.com (HELO [10.125.111.99]) ([10.125.111.99])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 09:40:01 -0700
Message-ID: <a130fe6b-7b16-4ece-aa87-3d10d0f9efb3@intel.com>
Date: Mon, 9 Jun 2025 09:39:58 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next] cxl: fix return value in
 cxlctl_validate_set_features()
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Shiju Jose <shiju.jose@huawei.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Li Ming <ming.li@zohomail.com>,
 Fan Ni <fan.ni@samsung.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <aDbFPSCujpJLY1if@stanley.mountain>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <aDbFPSCujpJLY1if@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/28/25 1:11 AM, Dan Carpenter wrote:
> The cxlctl_validate_set_features() function is type bool.  It's supposed
> to return true for valid requests and false for invalid.  However, this
> error path returns ERR_PTR(-EINVAL) which is true when it was intended to
> return false.
> 
> Fixes: f76e0bbc8bc3 ("cxl: Update prototype of function get_support_feature_info()")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Applied to cxl/fixes

> ---
>  drivers/cxl/core/features.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
> index 6f2eae1eb126..7c750599ea69 100644
> --- a/drivers/cxl/core/features.c
> +++ b/drivers/cxl/core/features.c
> @@ -544,7 +544,7 @@ static bool cxlctl_validate_set_features(struct cxl_features_state *cxlfs,
>  	u32 flags;
>  
>  	if (rpc_in->op_size < sizeof(uuid_t))
> -		return ERR_PTR(-EINVAL);
> +		return false;
>  
>  	feat = cxl_feature_info(cxlfs, &rpc_in->set_feat_in.uuid);
>  	if (IS_ERR(feat))

