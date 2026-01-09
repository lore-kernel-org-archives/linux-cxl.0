Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7780F50095F
	for <linux-cxl@vger.kernel.org>; Fri,  9 Jan 2026 17:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767980602; cv=none; b=pL04Y/RjOl4YggeN+niiR/v+jQtCXvgU1uZ92OUar+czg/e/ON2DTPS751gMUfc4IN8V2R7BDaZAwphVNnLanPhzpLYLmZvPbiNDRFqqNOZjgRcZGy47qLCq5kjZP6GNlrkW/4RPVYHWyq6ayPOprqaIBgTfR3X34QuS4wsBB3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767980602; c=relaxed/simple;
	bh=sIg09qYwBjZ55P4L+OEjpGlLOmI33H3IdANe5dyedr0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iIYcetgMvNqTtSBjuqdxRZ9sI90ZcS8LoPPKlzPikAtlB5K/YR3ahaJmFrZwJeg3FYhUslpTz2vHmhaCX4y7UTqBzm8XyIc/KyS5EKz/MEpFcb/IeZY6v4Gm+y8w9T/svPDA8RxviSuy00hpnpnhMXyI+qgCkoxp78hT8y5KEnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hht+N3M4; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hht+N3M4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767980599; x=1799516599;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sIg09qYwBjZ55P4L+OEjpGlLOmI33H3IdANe5dyedr0=;
  b=hht+N3M49rfzrUhNqmiDUuKvD2rwyoc3An9HscTZPsbCwbrnD9XB/qK4
   8XjUd6gnqNXkQIqcBDLHL0wCpKdJgkTmzKzXHKi7dzPCi5BeIDypsfeh6
   J4fJnxBg7nKtp3bDVHQf/JnnV6ES9QRGPvqG/A9jIstPeRxncbMwBHMlM
   T2OvsXex+ZYT7xXzmAY10TEr1IuCgqqS3Vh4f0mvpw3Vw6SYBq8933CWd
   2zZLEpnW2yFK5/R2qbhjjMCMENj1LmJCZte99E2BwIIEZwOferghoCmmx
   XApY5VNTulbrE6o3jlnK7TvLFuh+d98Xw15osiaaUI82O5bVbzPW8dCB5
   g==;
X-CSE-ConnectionGUID: 46CIA/JWRNypbCySUoJ+9w==
X-CSE-MsgGUID: nUjAxiN2TuW78NlQMxKoxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11666"; a="80815838"
X-IronPort-AV: E=Sophos;i="6.21,214,1763452800"; 
   d="scan'208";a="80815838"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2026 09:43:19 -0800
X-CSE-ConnectionGUID: joLq6xjGRd+WeBpVFiixnQ==
X-CSE-MsgGUID: /dkGd0iYQuuxXiHDnYrLig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,214,1763452800"; 
   d="scan'208";a="203439917"
Received: from agladkov-desk.ger.corp.intel.com (HELO [10.125.110.37]) ([10.125.110.37])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2026 09:43:18 -0800
Message-ID: <f685395a-7f54-43f5-b740-9751642d66b2@intel.com>
Date: Fri, 9 Jan 2026 10:43:17 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] libcxl: Add debugfs path to CXL context
To: Ben Cheatham <Benjamin.Cheatham@amd.com>, nvdimm@lists.linux.dev,
 alison.schofield@intel.com
Cc: linux-cxl@vger.kernel.org
References: <20260109160720.1823-1-Benjamin.Cheatham@amd.com>
 <20260109160720.1823-2-Benjamin.Cheatham@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260109160720.1823-2-Benjamin.Cheatham@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/9/26 9:07 AM, Ben Cheatham wrote:
> Find the CXL debugfs mount point and add it to the CXL library context.
> This will be used by poison and procotol error library functions to
> access the information presented by the filesystem.
> 
> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>


> ---
>  cxl/lib/libcxl.c | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
> index 32728de..6b7e92c 100644
> --- a/cxl/lib/libcxl.c
> +++ b/cxl/lib/libcxl.c
> @@ -8,6 +8,8 @@
>  #include <stdlib.h>
>  #include <dirent.h>
>  #include <unistd.h>
> +#include <mntent.h>
> +#include <string.h>
>  #include <sys/mman.h>
>  #include <sys/stat.h>
>  #include <sys/types.h>
> @@ -54,6 +56,7 @@ struct cxl_ctx {
>  	struct kmod_ctx *kmod_ctx;
>  	struct daxctl_ctx *daxctl_ctx;
>  	void *private_data;
> +	char *cxl_debugfs;
>  };
>  
>  static void free_pmem(struct cxl_pmem *pmem)
> @@ -240,6 +243,38 @@ CXL_EXPORT void *cxl_get_private_data(struct cxl_ctx *ctx)
>  	return ctx->private_data;
>  }
>  
> +static char* get_cxl_debugfs_dir(void)
> +{
> +	char *debugfs_dir = NULL;
> +	struct mntent *ent;
> +	FILE *mntf;
> +
> +	mntf = setmntent("/proc/mounts", "r");
> +	if (!mntf)
> +		return NULL;
> +
> +	while ((ent = getmntent(mntf)) != NULL) {
> +		if (!strcmp(ent->mnt_type, "debugfs")) {
> +			/* Magic '5' here is length of "/cxl" + NULL terminator */
> +			debugfs_dir = calloc(strlen(ent->mnt_dir) + 5, 1);
> +			if (!debugfs_dir)
> +				return NULL;
> +
> +			strcpy(debugfs_dir, ent->mnt_dir);
> +			strcat(debugfs_dir, "/cxl");
> +			if (access(debugfs_dir, F_OK) != 0) {
> +				free(debugfs_dir);
> +				debugfs_dir = NULL;
> +			}
> +
> +			break;
> +		}
> +	}
> +
> +	endmntent(mntf);
> +	return debugfs_dir;
> +}
> +
>  /**
>   * cxl_new - instantiate a new library context
>   * @ctx: context to establish
> @@ -295,6 +330,7 @@ CXL_EXPORT int cxl_new(struct cxl_ctx **ctx)
>  	c->udev = udev;
>  	c->udev_queue = udev_queue;
>  	c->timeout = 5000;
> +	c->cxl_debugfs = get_cxl_debugfs_dir();
>  
>  	return 0;
>  
> @@ -350,6 +386,7 @@ CXL_EXPORT void cxl_unref(struct cxl_ctx *ctx)
>  	kmod_unref(ctx->kmod_ctx);
>  	daxctl_unref(ctx->daxctl_ctx);
>  	info(ctx, "context %p released\n", ctx);
> +	free((void *)ctx->cxl_debugfs);
>  	free(ctx);
>  }
>  

