Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22AF185B52
	for <linux-cxl@vger.kernel.org>; Tue, 17 Sep 2024 21:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726610291; cv=none; b=TtnoyLAKLzh2be4ksSDFcQKmgTXP1Xr3obLZ2Q8ABYXZZPAuWORolcFFF2vTzTdxpSkMQFvz07DuyyY+uFcCVWf8MolIL7vZ6OIgngrjkjWxbmqRcgDY8eNlkAR+BWrpkqD5uSz2te613g0RbLm6AfbIntgIb3+04iI1T9v0kwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726610291; c=relaxed/simple;
	bh=PRI3Ytmx/FFqTGrkgLEdUN3ii4ogY/Os+O88OODLkMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YnO3Z7Kn2lO08s5FqbAU0Uimt1KDxqWzaqiXKNLuBcGPJnZyxOTY7yvIh4q4bQ1iwXeVRhf4UK/tYxfVbnY/ivaSy1EiMNhYao2qE5378ozeQ9UI2Un66IiLhO11ECCMCjwAZLPk2d+Kr0KBJF2mHVXwGILbBLc4vZoe39inPwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=igLvhg1P; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="igLvhg1P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726610290; x=1758146290;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PRI3Ytmx/FFqTGrkgLEdUN3ii4ogY/Os+O88OODLkMI=;
  b=igLvhg1P0VJmrtXwrkSFMbnGYn3yXGGRZO7/I0ggM+qZW09t25dc7rf7
   0gYE79VKnYCYvBWp2qaCtaVfoZt37FY20pw/ofTGnrNyBOS1DNWWgUsd9
   EKE7KuBN13HHnSAnHDLbNKcuhKJGQHWrkVQR7Nj2pJyIgcxbj6KYUVkZR
   FuNf4I6XoX9VDRMzcBuWmPEnk3LuKYnSdFQh6eQkkiXZwq3kaDXLy/QF0
   83mst5RiKY4wFYCwZF04cFtyEqWEYTcfxeaq6lD4xgl4qHY602L8X6wcN
   49N1kxVLzuJnM8BJNS5gHFFrPlZ+TpLEsWMQKmFV1veoVsbZjya7GfCXg
   Q==;
X-CSE-ConnectionGUID: /1VsPR6VQEOJK2mQu/g+1A==
X-CSE-MsgGUID: 2wBFNnxfQ1eRco6UzQOZqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11198"; a="48007804"
X-IronPort-AV: E=Sophos;i="6.10,235,1719903600"; 
   d="scan'208";a="48007804"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2024 14:58:09 -0700
X-CSE-ConnectionGUID: pWF9RCFcQHuU4uQhsTaaNg==
X-CSE-MsgGUID: MRMXST3TT2SuPfBsPwxj6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,235,1719903600"; 
   d="scan'208";a="106787769"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.109.105])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2024 14:58:09 -0700
Date: Tue, 17 Sep 2024 14:58:07 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
	ira.weiny@intel.com, vishal.l.verma@intel.com,
	Jonathan.Cameron@huawei.com, dave@stgolabs.net
Subject: Re: [PATCH] cxl: Fix comment regarding cxl_query_cmd() return data
Message-ID: <Zun7b3hdS5cloLgl@aschofie-mobl2.lan>
References: <20240913223216.3234173-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913223216.3234173-1-dave.jiang@intel.com>

On Fri, Sep 13, 2024 at 03:32:16PM -0700, Dave Jiang wrote:
> The code indicates that the min of n_commands and total commands
> is returned. The comment incorrectly says it's the max(). Correct
> comment to min().

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/mbox.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 2626f3fff201..8598199efa09 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -542,7 +542,7 @@ int cxl_query_cmd(struct cxl_memdev *cxlmd,
>  		return put_user(ARRAY_SIZE(cxl_mem_commands), &q->n_commands);
>  
>  	/*
> -	 * otherwise, return max(n_commands, total commands) cxl_command_info
> +	 * otherwise, return min(n_commands, total commands) cxl_command_info
>  	 * structures.
>  	 */
>  	cxl_for_each_cmd(cmd) {
> -- 
> 2.46.0
> 
> 
