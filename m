Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F152837E308
	for <linux-cxl@vger.kernel.org>; Tue, 19 May 2026 22:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779231048; cv=none; b=UodMqswuxDGMfWfYd+r0BIpou7wPqwSp8LQoy7jEYSIgEKLpNRFg/3LjIiS5BnB4bwNcnwd9KWhmG1eQ6b2RHl+sxmbtRMI+Dld56X9LW8ahKE/YZVePgNXUlZ1blqgoAN1qYkOc62M1+LtUX+z9D4B7o5FZ5ehCTl/w48xRiaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779231048; c=relaxed/simple;
	bh=qLZTk1xjyfx//YablrpfUJmKW2Yk9/5LuZm/459+G7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZhzJ61gZ7GVHurt0jFKVuv3irt2P6Qnzq/06DWQ6BSIbMTAGYtXCFGItbMbfaFIBQap3ytDec+OUFS8PEwJmVkOIMnuimlbds3fwgNv3yaxNsjWwEt2Znp0l2fC/sh5oR/si4l1gTI8Ogl51rNUANAXOFdleLCnyM7Hbikx+NmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PJahIN8U; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PJahIN8U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779231043; x=1810767043;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qLZTk1xjyfx//YablrpfUJmKW2Yk9/5LuZm/459+G7Q=;
  b=PJahIN8UOj3U3S+RhbPn0KASSRU0zuvvWqmLKDeV39QdZvA4qyLnsMZM
   Zk1M4NSBVUq4Ab8XzAdxR76K+xsTDRKDpp9PMnbmqTrL+1peQZv1Zdf9A
   WBKOQ328GvY7qEeFtOkan5GXfxXYHxdx2pyE4uTBVud4xCPsMz7iF3VaQ
   i3gwDXxA0+xc2ixVZrPrdwuUhyCAEIo53r+oBoM7WKQGi4Xi/7Z7QL1xE
   HBoI23bVYbY5GVxcH2dAWfJucS0YkMl1dyS2S+QnKhU5CKJlKlWEtqmLW
   D8L0dnOeRLfVJU/sbwTUsS0SNdonOk6Q6qBNiq/k+Ur9ek4vm3+DlGFGc
   w==;
X-CSE-ConnectionGUID: oKWU7oI3RYul5hbFoydhGQ==
X-CSE-MsgGUID: dPyKwIN7TUykYxSCWSw7RQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="105582025"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="105582025"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 15:50:40 -0700
X-CSE-ConnectionGUID: G7gIgtZbTJ65b/NXAneP/g==
X-CSE-MsgGUID: ZvaKmi0fRlKJDnPVgzqswA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="243929547"
Received: from aduenasd-mobl5.amr.corp.intel.com (HELO [10.125.109.143]) ([10.125.109.143])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 15:50:41 -0700
Message-ID: <9c291611-7f7e-473f-8a11-9376d98610fa@intel.com>
Date: Tue, 19 May 2026 15:50:39 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] cxl/memdev: Introduce cxl_class_memdev_type
To: Dan Williams <djbw@kernel.org>, linux-cxl@vger.kernel.org
Cc: alejandro.lucero-palau@amd.com, jic23@kernel.org,
 Alejandro Lucero <alucerop@amd.com>
References: <20260519210158.1499795-1-djbw@kernel.org>
 <20260519210158.1499795-5-djbw@kernel.org>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260519210158.1499795-5-djbw@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/19/26 2:01 PM, Dan Williams wrote:
> In preparation for memdev's without mailbox related infrastructure,
> introduce cxl_class_memdev_type as a superset of a cxl_memdev_type.
> Effectively the only difference is that cxl_class_memdev_type exports
> common sysfs attributes where cxl_memdev_type has none.
> 
> Related to this is all the cxl_mem_probe() paths that assume the presence
> of a class device mailbox are updated to skip that requirement.
> 
> Co-developed-by: Alejandro Lucero <alucerop@amd.com>
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Signed-off-by: Dan Williams <djbw@kernel.org>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>


> ---
>  drivers/cxl/core/memdev.c | 16 +++++++++++---
>  drivers/cxl/mem.c         | 45 +++++++++++++++++++++++++++++----------
>  2 files changed, 47 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 91c99eeea92c..33a3d2e7b13a 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -574,16 +574,23 @@ void cxl_memdev_update_perf(struct cxl_memdev *cxlmd)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_memdev_update_perf, "CXL");
>  
> -static const struct device_type cxl_memdev_type = {
> +static const struct device_type cxl_class_memdev_type = {
>  	.name = "cxl_memdev",
>  	.release = cxl_memdev_release,
>  	.devnode = cxl_memdev_devnode,
>  	.groups = cxl_memdev_attribute_groups,
>  };
>  
> +static const struct device_type cxl_memdev_type = {
> +	.name = "cxl_memdev",
> +	.release = cxl_memdev_release,
> +	.devnode = cxl_memdev_devnode,
> +};
> +
>  bool is_cxl_memdev(const struct device *dev)
>  {
> -	return dev->type == &cxl_memdev_type;
> +	return (dev->type == &cxl_class_memdev_type ||
> +		dev->type == &cxl_memdev_type);
>  }
>  EXPORT_SYMBOL_NS_GPL(is_cxl_memdev, "CXL");
>  
> @@ -712,7 +719,10 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
>  	dev->parent = get_device(cxlds->dev);
>  	dev->bus = &cxl_bus_type;
>  	dev->devt = MKDEV(cxl_mem_major, cxlmd->id);
> -	dev->type = &cxl_memdev_type;
> +	if (cxlds->type == CXL_DEVTYPE_DEVMEM)
> +		dev->type = &cxl_memdev_type;
> +	else
> +		dev->type = &cxl_class_memdev_type;
>  	device_set_pm_not_required(dev);
>  	INIT_WORK(&cxlmd->detach_work, detach_memdev);
>  
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index fcffe24dcb42..ff858318091f 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -65,6 +65,26 @@ static int cxl_debugfs_poison_clear(void *data, u64 dpa)
>  DEFINE_DEBUGFS_ATTRIBUTE(cxl_poison_clear_fops, NULL,
>  			 cxl_debugfs_poison_clear, "%llx\n");
>  
> +static void cxl_memdev_poison_enable(struct cxl_memdev_state *mds,
> +				     struct cxl_memdev *cxlmd,
> +				     struct dentry *dentry)
> +{
> +	/*
> +	 * Avoid poison debugfs for DEVMEM aka accelerators as they rely on
> +	 * cxl_memdev_state.
> +	 */
> +	if (!mds)
> +		return;
> +
> +	if (test_bit(CXL_POISON_ENABLED_INJECT, mds->poison.enabled_cmds))
> +		debugfs_create_file("inject_poison", 0200, dentry, cxlmd,
> +				    &cxl_poison_inject_fops);
> +
> +	if (test_bit(CXL_POISON_ENABLED_CLEAR, mds->poison.enabled_cmds))
> +		debugfs_create_file("clear_poison", 0200, dentry, cxlmd,
> +				    &cxl_poison_clear_fops);
> +}
> +
>  static int cxl_mem_probe(struct device *dev)
>  {
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> @@ -92,12 +112,7 @@ static int cxl_mem_probe(struct device *dev)
>  	dentry = cxl_debugfs_create_dir(dev_name(dev));
>  	debugfs_create_devm_seqfile(dev, "dpamem", dentry, cxl_mem_dpa_show);
>  
> -	if (test_bit(CXL_POISON_ENABLED_INJECT, mds->poison.enabled_cmds))
> -		debugfs_create_file("inject_poison", 0200, dentry, cxlmd,
> -				    &cxl_poison_inject_fops);
> -	if (test_bit(CXL_POISON_ENABLED_CLEAR, mds->poison.enabled_cmds))
> -		debugfs_create_file("clear_poison", 0200, dentry, cxlmd,
> -				    &cxl_poison_clear_fops);
> +	cxl_memdev_poison_enable(mds, cxlmd, dentry);
>  
>  	rc = devm_add_action_or_reset(dev, remove_debugfs, dentry);
>  	if (rc)
> @@ -206,16 +221,24 @@ static ssize_t trigger_poison_list_store(struct device *dev,
>  }
>  static DEVICE_ATTR_WO(trigger_poison_list);
>  
> -static umode_t cxl_mem_visible(struct kobject *kobj, struct attribute *a, int n)
> +static bool cxl_poison_attr_visible(struct kobject *kobj, struct attribute *a)
>  {
>  	struct device *dev = kobj_to_dev(kobj);
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>  	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
>  
> -	if (a == &dev_attr_trigger_poison_list.attr)
> -		if (!test_bit(CXL_POISON_ENABLED_LIST,
> -			      mds->poison.enabled_cmds))
> -			return 0;
> +	if (!mds ||
> +	    !test_bit(CXL_POISON_ENABLED_LIST, mds->poison.enabled_cmds))
> +		return false;
> +
> +	return true;
> +}
> +
> +static umode_t cxl_mem_visible(struct kobject *kobj, struct attribute *a, int n)
> +{
> +	if (a == &dev_attr_trigger_poison_list.attr &&
> +	    !cxl_poison_attr_visible(kobj, a))
> +		return 0;
>  
>  	return a->mode;
>  }

