Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497753009C7
	for <linux-cxl@vger.kernel.org>; Wed, 10 Dec 2025 18:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765390804; cv=none; b=LD4piqDj1O9+sJ2wDoHFRjk/sNHFRjcw+jdR/CFwxe1cOfFa2adPZSySgUu3Dm/NDa+AjXHJpwjoM+UD/kY6NuNMj++cm1knGfrWDcrDlv6yuhrhcFHOuAS1xYG4bVDU6/atzPi6I6FNASDOvnmcNz9cQgL+/fWst1oZL9D4MzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765390804; c=relaxed/simple;
	bh=nuaXqQWebuTE7r2tecRXfY7cUN9gU8XXBxTPlLCOoFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AgmU7NGkB3WYyqxh8YAkJrDCEPlEJfGU44KYRwYKkB06F8tJ+tnK9OUxatDkCEwnkZdZpmMz+GRKQz3LHq/xNyoXN59gTrrTby5d3YhmjfkeZE+4KGNpRL/kxEB72tNhxF3u+3n51VSI16eKOXyChSp8nxuFZ8OMfLBSCAHjnTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B1j19XIh; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B1j19XIh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765390801; x=1796926801;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nuaXqQWebuTE7r2tecRXfY7cUN9gU8XXBxTPlLCOoFI=;
  b=B1j19XIhz7DbbqNMwf4ZOgdVOMMymaEoztgafkb0025TbcikFG6EjtC2
   eH+khnC6n+LAp8wS2aiTpSa9eWB3L3r/4MCD4TxwwMfm5ZvvWiSxgkjr9
   Ij71kQEV41Aa9ztV+RtCuYZvNfOwGRLKuL/0/Teur/+dEfDUwexEmFdYH
   lWA4WTDczGQg5Vx33IHY1M9aOfNu+qfNYfIKYNjDJCi3uoQVihJWt7vjw
   29exWqcEEk1pjgRYztVdYJT9nsXuUMCbmS6HV+4RNQskymtsemcVXxQdk
   9e2oomXMiIvJ9b5FIxLoeoVR6PtrhPW7U4jmGV/1Q+0o6MQabe6zK0S2G
   Q==;
X-CSE-ConnectionGUID: NZEA7/ZYQAGFdQEDZRcYLA==
X-CSE-MsgGUID: Bc68coJHQNC81UOGPh4lVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11638"; a="84974743"
X-IronPort-AV: E=Sophos;i="6.20,264,1758610800"; 
   d="scan'208";a="84974743"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2025 10:20:01 -0800
X-CSE-ConnectionGUID: 7ACIsEJ6QS2f2l1up3P3Pg==
X-CSE-MsgGUID: H+JD1HwaQiGVOZASkxUNxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,264,1758610800"; 
   d="scan'208";a="227233046"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO [10.125.109.138]) ([10.125.109.138])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2025 10:20:01 -0800
Message-ID: <b7971d26-3108-4e31-9b7e-9b9d0e063012@intel.com>
Date: Wed, 10 Dec 2025 11:19:59 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/7] libcxl: Add debugfs path to CXL context
To: Ben Cheatham <Benjamin.Cheatham@amd.com>, nvdimm@lists.linux.dev
Cc: linux-cxl@vger.kernel.org, alison.schofield@intel.com
References: <20251209171404.64412-1-Benjamin.Cheatham@amd.com>
 <20251209171404.64412-2-Benjamin.Cheatham@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20251209171404.64412-2-Benjamin.Cheatham@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/9/25 10:13 AM, Ben Cheatham wrote:
> Find the CXL debugfs mount point and add it to the CXL library context.
> This will be used by poison and procotol error library functions to
> access the information presented by the filesystem.
> 
> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
> ---
>  cxl/lib/libcxl.c | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
> index cafde1c..3718b76 100644
> --- a/cxl/lib/libcxl.c
> +++ b/cxl/lib/libcxl.c
> @@ -54,6 +54,7 @@ struct cxl_ctx {
>  	struct kmod_ctx *kmod_ctx;
>  	struct daxctl_ctx *daxctl_ctx;
>  	void *private_data;
> +	const char *debugfs;
>  };
>  
>  static void free_pmem(struct cxl_pmem *pmem)
> @@ -240,6 +241,43 @@ CXL_EXPORT void *cxl_get_private_data(struct cxl_ctx *ctx)
>  	return ctx->private_data;
>  }
>  
> +static const char *get_debugfs_dir(void)

I would suggest taking a look at setmntent()/getmntent() usages. Probably easier than trying to open code this and do it yourself here. You should be able to pass "/proc/mounts" to setmntent() and then do everything through a loop of getmntent().

DJ

> +{
> +	char *dev, *dir, *type, *debugfs_dir = NULL;
> +	char line[PATH_MAX + 256 + 1];
> +	FILE *fp;
> +
> +	fp = fopen("/proc/mounts", "r");
> +	if (!fp)
> +		return debugfs_dir;
> +
> +	while (fgets(line, sizeof(line), fp)) {
> +		dev = strtok(line, " \t");
> +		if (!dev)
> +			break;
> +
> +		dir = strtok(NULL, " \t");
> +		if (!dir)
> +			break;
> +
> +		type = strtok(NULL, " \t");
> +		if (!type)
> +			break;
> +
> +		if (!strcmp(type, "debugfs")) {
> +			debugfs_dir = calloc(strlen(dir) + 1, 1);
> +			if (!debugfs_dir)
> +				break;
> +
> +			strcpy(debugfs_dir, dir);
> +			break;
> +		}
> +	}
> +
> +	fclose(fp);
> +	return debugfs_dir;
> +}
> +
>  /**
>   * cxl_new - instantiate a new library context
>   * @ctx: context to establish
> @@ -295,6 +333,7 @@ CXL_EXPORT int cxl_new(struct cxl_ctx **ctx)
>  	c->udev = udev;
>  	c->udev_queue = udev_queue;
>  	c->timeout = 5000;
> +	c->debugfs = get_debugfs_dir();
>  
>  	return 0;
>  
> @@ -350,6 +389,7 @@ CXL_EXPORT void cxl_unref(struct cxl_ctx *ctx)
>  	kmod_unref(ctx->kmod_ctx);
>  	daxctl_unref(ctx->daxctl_ctx);
>  	info(ctx, "context %p released\n", ctx);
> +	free((void *)ctx->debugfs);
>  	free(ctx);
>  }
>  

