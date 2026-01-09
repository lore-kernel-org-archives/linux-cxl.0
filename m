Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D85364EB0
	for <linux-cxl@vger.kernel.org>; Fri,  9 Jan 2026 18:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767981803; cv=none; b=WObhIK/hD62nTRP1RSIKPf7gJxncl9nBl1vpMlwHux/+5jIbcOkUwwI2FL+CoWTfgKCBHtdc0FrmKP+jN0+XdkmDGFn//C0t8+PYYGRuhpRIssbEAlneFchJyjo+wjbeYDPI9iYpjAHZsyVE6t3wz9MyZfD33dJJx82frC7/xvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767981803; c=relaxed/simple;
	bh=H+zYgfV1e7pI/il6aZSz7Mc+SUDJzM0dqMlgXcODIHc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GaT+YjjRrVipfPqkQqjLDJzVC9JVn+GzzJYOk420xwA+JyckPm1gpO2TrkAHgvmQ3aPWG/2YIiT9u/NQGKL2Ca++r7kYb4hqU0V1li86KEATKFy2Rs9sSHCZCUtu01yUdXdaJL37HF1qy0la3JP6wRdVimYfmgKQxhrwwtBiW2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g5CU+rYa; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g5CU+rYa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767981801; x=1799517801;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=H+zYgfV1e7pI/il6aZSz7Mc+SUDJzM0dqMlgXcODIHc=;
  b=g5CU+rYaczw8axXBc3UVOjHIbTbTd0I1AMVOmljx9rgFtZT3cL9Q5M8V
   5zAM5Vue7SlWa0HfBfKSS/Pddc7qVbUDQkmRZ8UZ+cA9z04GNmHRLn1hH
   6Scz3fLS19VfmDw0dYJlYzV0Zb41BKb/OpIFiTmdBcWUIyygJme6icFK6
   GvzYzSaMQo3CXIi1esScEJjlTSxisIGG/n33fYC3+P+qMTqSt6I6iAPGs
   LVr2RZYZ7mg5sjOGmhrGmL54oft1KOP5GTkJ3/7atF3J2TxeZxQqXlTLy
   r+SXVAzthk9krsdXaiz4xq0mK932fdGVfQ0ZbcZu/PzDcxTPSGgvWdc1V
   Q==;
X-CSE-ConnectionGUID: Pcn2ubnQTAy44q9COPc6wg==
X-CSE-MsgGUID: yTBxGqN4RW+F97Ov6DLJdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11666"; a="92028613"
X-IronPort-AV: E=Sophos;i="6.21,214,1763452800"; 
   d="scan'208";a="92028613"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2026 10:03:21 -0800
X-CSE-ConnectionGUID: mY3CuwDaRk+rnZ/5+97G7A==
X-CSE-MsgGUID: EW0VFq65RfWhAoDAaePhyg==
X-ExtLoop1: 1
Received: from agladkov-desk.ger.corp.intel.com (HELO [10.125.110.37]) ([10.125.110.37])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2026 10:03:20 -0800
Message-ID: <187c3ad1-4fa0-4573-9848-484629d06217@intel.com>
Date: Fri, 9 Jan 2026 11:03:19 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] libcxl: Add poison injection support
To: Ben Cheatham <Benjamin.Cheatham@amd.com>, nvdimm@lists.linux.dev,
 alison.schofield@intel.com
Cc: linux-cxl@vger.kernel.org
References: <20260109160720.1823-1-Benjamin.Cheatham@amd.com>
 <20260109160720.1823-4-Benjamin.Cheatham@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260109160720.1823-4-Benjamin.Cheatham@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/9/26 9:07 AM, Ben Cheatham wrote:
> Add a library API for clearing and injecting poison into a CXL memory
> device through the CXL debugfs.
> 
> This API will be used by the 'cxl-inject-error' and 'cxl-clear-error'
> commands in later commits.
> 
> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
> ---
>  cxl/lib/libcxl.c   | 83 ++++++++++++++++++++++++++++++++++++++++++++++
>  cxl/lib/libcxl.sym |  3 ++
>  cxl/libcxl.h       |  3 ++
>  3 files changed, 89 insertions(+)
> 
> diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
> index 27ff037..deebf7f 100644
> --- a/cxl/lib/libcxl.c
> +++ b/cxl/lib/libcxl.c
> @@ -5046,3 +5046,86 @@ CXL_EXPORT struct cxl_cmd *cxl_cmd_new_set_alert_config(struct cxl_memdev *memde
>  {
>  	return cxl_cmd_new_generic(memdev, CXL_MEM_COMMAND_ID_SET_ALERT_CONFIG);
>  }
> +
> +CXL_EXPORT bool cxl_memdev_has_poison_injection(struct cxl_memdev *memdev)
> +{
> +	struct cxl_ctx *ctx = memdev->ctx;
> +	size_t path_len, len;
> +	bool exists = true;
> +	char *path;
> +	int rc;
> +
> +	if (!ctx->cxl_debugfs)
> +		return false;
> +
> +	path_len = strlen(ctx->cxl_debugfs) + 100;

Same comment about PATH_MAX.

> +	path = calloc(path_len, sizeof(char));
> +	if (!path)
> +		return false;
> +
> +	len = snprintf(path, path_len, "%s/%s/inject_poison", ctx->cxl_debugfs,
> +		       cxl_memdev_get_devname(memdev));
> +	if (len >= path_len) {
> +		err(ctx, "%s: buffer too small\n",
> +		    cxl_memdev_get_devname(memdev));
> +		free(path);
> +		return false;

I think I saw in an earlier patch that you were using goto to filter error exit point. So may as well make it consistent and do it here as well.

> +	}
> +
> +	rc = access(path, F_OK);
> +	if (rc)
> +		exists = false;
> +
> +	free(path);
> +	return exists;
> +}
> +
> +static int cxl_memdev_poison_action(struct cxl_memdev *memdev, size_t dpa,
> +				    bool clear)
> +{
> +	struct cxl_ctx *ctx = memdev->ctx;
> +	size_t path_len, len;
> +	char addr[32];
> +	char *path;
> +	int rc;
> +
> +	if (!ctx->cxl_debugfs)
> +		return -ENOENT;
> +
> +	path_len = strlen(ctx->cxl_debugfs) + 100;

same comment about path len

> +	path = calloc(path_len, sizeof(char));
> +	if (!path)
> +		return -ENOMEM;
> +
> +	len = snprintf(path, path_len, "%s/%s/%s", ctx->cxl_debugfs,
> +		       cxl_memdev_get_devname(memdev),
> +		       clear ? "clear_poison" : "inject_poison");
> +	if (len >= path_len) {
> +		err(ctx, "%s: buffer too small\n",
> +		    cxl_memdev_get_devname(memdev));
> +		free(path);
> +		return -ENOMEM;

same comment about error paths

DJ

> +	}
> +
> +	len = snprintf(addr, sizeof(addr), "0x%lx\n", dpa);
> +	if (len >= sizeof(addr)) {
> +		err(ctx, "%s: buffer too small\n",
> +		    cxl_memdev_get_devname(memdev));
> +		free(path);
> +		return -ENOMEM;
> +	}
> +
> +	rc = sysfs_write_attr(ctx, path, addr);
> +	free(path);
> +	return rc;
> +}
> +
> +CXL_EXPORT int cxl_memdev_inject_poison(struct cxl_memdev *memdev, size_t addr)
> +{
> +	return cxl_memdev_poison_action(memdev, addr, false);
> +}
> +
> +CXL_EXPORT int cxl_memdev_clear_poison(struct cxl_memdev *memdev, size_t addr)
> +{
> +	return cxl_memdev_poison_action(memdev, addr, true);
> +}
> diff --git a/cxl/lib/libcxl.sym b/cxl/lib/libcxl.sym
> index c683b83..c636edb 100644
> --- a/cxl/lib/libcxl.sym
> +++ b/cxl/lib/libcxl.sym
> @@ -309,4 +309,7 @@ global:
>  	cxl_protocol_error_get_num;
>  	cxl_protocol_error_get_str;
>  	cxl_dport_protocol_error_inject;
> +	cxl_memdev_has_poison_injection;
> +	cxl_memdev_inject_poison;
> +	cxl_memdev_clear_poison;
>  } LIBCXL_10;
> diff --git a/cxl/libcxl.h b/cxl/libcxl.h
> index faef62e..4d035f0 100644
> --- a/cxl/libcxl.h
> +++ b/cxl/libcxl.h
> @@ -105,6 +105,9 @@ int cxl_memdev_read_label(struct cxl_memdev *memdev, void *buf, size_t length,
>  		size_t offset);
>  int cxl_memdev_write_label(struct cxl_memdev *memdev, void *buf, size_t length,
>  		size_t offset);
> +bool cxl_memdev_has_poison_injection(struct cxl_memdev *memdev);
> +int cxl_memdev_inject_poison(struct cxl_memdev *memdev, size_t dpa);
> +int cxl_memdev_clear_poison(struct cxl_memdev *memdev, size_t dpa);
>  struct cxl_cmd *cxl_cmd_new_get_fw_info(struct cxl_memdev *memdev);
>  unsigned int cxl_cmd_fw_info_get_num_slots(struct cxl_cmd *cmd);
>  unsigned int cxl_cmd_fw_info_get_active_slot(struct cxl_cmd *cmd);

