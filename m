Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0339B415B71
	for <linux-cxl@vger.kernel.org>; Mon, 14 Sep 2026 21:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789420013; cv=none; b=GwPd5Ax7qLdYYo5jH4o8EClz5ykNfJ5hqjhOL5kxons0ytfOah+uc0SogHvkLqNVdCK2ST9oTxxMC4clC5rqpbyooOqCUmzd3kwzSpIWLdYf0dgNn3YY6ffCpkR+0tmFPR5KHdb/gIIYtMgtFTqEuMtttuvzvP4DrUtxiyK9BYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789420013; c=relaxed/simple;
	bh=FsPl/Kpo2PVhMOsMP1jxHZmHqVDpsy23i1lkfqj7lOc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZoJKG4/U7jwce6JVZxPaYHoWkeBmDigoRcIFQEdCq00Cno8mzW/CqjA7o/fRXB80WgkalxmZAW6dIlBanVGc+fRfbii85WJwfhoDODitsxgFbE2zvR6Tl3yuidwa77ThemRCHFcCXQ0puFBucJFKo4NHTzqS+X1sle+hd5jiWFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E0fooJEd; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E0fooJEd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789420012; x=1820956012;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FsPl/Kpo2PVhMOsMP1jxHZmHqVDpsy23i1lkfqj7lOc=;
  b=E0fooJEdjZCV1Uw4xAoV78MMnpGQjKE+jjJjtwaePd4vZMyV1lEK9IJ/
   +modUWx88M0UtJIQqKOC7JI/Vme+D+m4YM67YDRQvbcGkGV/SvOFOV7Kt
   oFVp0cJasnZJ8qI+757g8nmiUpuvI5XJ9s5cj5DHKfYthje20ds0enQIi
   ZFaj2ThlXOguWwhdU8qDjuwCxIsDLhmKjDRvHLGFnPLTtEg+7Dx30YKbs
   TnCyV/XVHBC1WXSZOatoL5FUNJysC9LgcDUmDZEABEJni1YQCWd9On/q8
   +ZvPnJ49bnPneZKSkIZcGVLd3GyM8wVudLdXWxSflCUMHYIkcaJQ1504/
   Q==;
X-CSE-ConnectionGUID: riL6ZPvITH+MGjx4+R9KuQ==
X-CSE-MsgGUID: PS9xmkGeThaxl6gBqti8Pw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="77339044"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="77339044"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 14:06:51 -0700
X-CSE-ConnectionGUID: 24T4JoF8RHOPD3whMgCz/A==
X-CSE-MsgGUID: QTVMRhR8TGe8oW4tAehk1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="296237889"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO [10.125.108.142]) ([10.125.108.142])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 14:06:46 -0700
Message-ID: <11bf2aee-166c-4601-8865-f239cac240ac@intel.com>
Date: Mon, 14 Sep 2026 14:06:45 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] cxl/core: Fix dport use-after-free via the einj_inject
 debugfs file
To: Guixin Liu <kanie@linux.alibaba.com>, Davidlohr Bueso
 <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>,
 Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>
Cc: linux-cxl@vger.kernel.org
References: <20260914121843.718493-1-kanie@linux.alibaba.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260914121843.718493-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/14/26 5:18 AM, Guixin Liu wrote:
> The per-dport einj_inject debugfs file retains a pointer to the
> 'struct cxl_dport', but its lifetime is not tied to the dport. Unbinding
> the dport host frees the dport and leaves einj_inject behind, so writing
> the file dereferences freed memory.
> 
> The stale directory also prevents recreation on rebind.
> 
> Remove the per-dport debugfs directory when the dport host is released.
> 
> Found by code inspection, then reproduced on a QEMU CXL topology with
> KASAN (the einj_cxl_is_initialized() guard had to be forced open, as
> QEMU emits no EINJ table). Unpatched, writing the leftover file after
> unbind gives a KASAN slab-use-after-free report in cxl_einj_inject(),
> and rebind hits "already exists in 'cxl'". Patched, the directory goes
> away with the dport and rebind recreates a working einj_inject.
> 
> Fixes: 8039804cfa73 ("cxl/core: Add CXL EINJ debugfs files")
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> Reviewed-by: Richard Cheng <icheng@nvidia.com>
> Reviewed-by: Li Ming <ming.li@zohomail.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>

Applied to cxl/next
9185b1a3043c

Can you send a follow up to address the sashiko complaint if needed? Thanks!

> ---
> v3: https://lore.kernel.org/linux-cxl/20260828074752.3336779-1-kanie@linux.alibaba.com/
> 
> v3->v4:
> - move the devm_add_action_or_reset() call next to the directory creation
>   (Jonathan Cameron)
> - drop the KASAN stack from the commit message (Alison Schofield)
> - rebase onto master (v7.3-rc2), per Dave's request for patches against
>   Linus's tags rather than cxl/next
> 
>  drivers/cxl/core/port.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 625e4aa427db..82513b46f634 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -814,6 +814,11 @@ static int cxl_einj_inject(void *data, u64 type)
>  DEFINE_DEBUGFS_ATTRIBUTE(cxl_einj_inject_fops, NULL, cxl_einj_inject,
>  			 "0x%llx\n");
>  
> +static void remove_debugfs(void *dentry)
> +{
> +	debugfs_remove_recursive(dentry);
> +}
> +
>  static void cxl_debugfs_create_dport_dir(struct cxl_dport *dport)
>  {
>  	struct cxl_port *parent = parent_port_of(dport->port);
> @@ -832,6 +837,8 @@ static void cxl_debugfs_create_dport_dir(struct cxl_dport *dport)
>  
>  	dir = cxl_debugfs_create_dir(dev_name(dport->dport_dev));
>  
> +	devm_add_action_or_reset(dport_to_host(dport), remove_debugfs, dir);
> +
>  	debugfs_create_file("einj_inject", 0200, dir, dport,
>  			    &cxl_einj_inject_fops);
>  }
> 
> base-commit: 50d05c7c76c96b90462f24debacca971d2e86713

