Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59952E401
	for <linux-cxl@vger.kernel.org>; Tue, 24 Feb 2026 00:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771892375; cv=none; b=JZXFNFMGbOZ2vG+083i4PmISspTiqq7PtgXXqKZ5U6VeRTSAjHR716uls/k26mn82WIHFvj4bpuIDBmRzZ2mUQcTeQHjy2/KAs0EQODW5xNLVnl37GsfunjbOm0XVoPRxyZIuk5rdTh51vovnh7ByBWYvV/xctvBoKTldm5tWJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771892375; c=relaxed/simple;
	bh=m6g0p6qk42y2YsCN0Ooy/rTREiU/bmFjY3sHIU/SfDA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Io7OKGqq1zEMveCNmSxA+D1wT2v5rhhWmwr5t1pvZZJKx9TFLWnHNE0Iq/kY6eEV35dz7yfhHeRZqs1hAKMhvU2eyClq8VRkL5HrqVMv82z4da12+dd2GWxcNyEKedGiGB7grvtD0OHzqNAujxyNpLNyvkiSJhbsHb/lYemQWGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QrmT4THp; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QrmT4THp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771892372; x=1803428372;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=m6g0p6qk42y2YsCN0Ooy/rTREiU/bmFjY3sHIU/SfDA=;
  b=QrmT4THpzb8/fXEQt42QUu2OgZD5J2h6Nfga0JKPPguyx7f3NoNodqOb
   KeuWEavhQuKvklvt9YyGHQPWDSO+2kDY0yUt0bRPyIzh/k6Bsqazu5tQU
   ILKIZGMZBOnim+3Ho8RE9PA3FRtmUE4FvC6YJUdFFWf6OfihvQ4EfJQVy
   Q7b+A31cSdhrIu52pFG3ahPGZL4ogxQZXdTB/qT1sFX+jzN/S32zZwN+/
   T/yWjTXbjEZhlzbIAptIYdZZP2xeaCB48zn+c3JhOEyHFpNbEoYLdKQ5j
   jACG+pTTG2mGZBteVkKv/4wGvG4DGhCE7EsOrlL3d0fKLxZcuxdA8p1dl
   Q==;
X-CSE-ConnectionGUID: CvOuhXW9RMyNJImXwvfNpg==
X-CSE-MsgGUID: ioM0ZnToSuiunbItn19qgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="84355777"
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="84355777"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 16:19:32 -0800
X-CSE-ConnectionGUID: LM5OZbonSLegUtHZmyxneA==
X-CSE-MsgGUID: 6Pbz0JZBRPe8Dn3FBV5fPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="219831110"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.110.227]) ([10.125.110.227])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 16:19:32 -0800
Message-ID: <caa7a20b-4731-4df3-a93b-e49193f67994@intel.com>
Date: Mon, 23 Feb 2026 17:19:31 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] cxl: support Type2 when initializing cxl_dev_state
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 dan.j.williams@intel.com
Cc: Alejandro Lucero <alucerop@amd.com>
References: <20260223142633.2994082-1-alejandro.lucero-palau@amd.com>
 <20260223142633.2994082-2-alejandro.lucero-palau@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260223142633.2994082-2-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/23/26 7:26 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> In preparation for type2 drivers add function and macro for
> differentiating CXL memory expanders (type 3) from CXL device
> accelerators (type 2) helping accel drivers to embed cxl_dev_state
> inside a private struct.
> 
> Update type3 driver for using this same initialization.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/core/mbox.c      | 12 +++++-------
>  drivers/cxl/core/memdev.c    | 24 ++++++++++++++++++++++++
>  drivers/cxl/cxlmem.h         | 34 +++++++++++++++++++++++++++++++++-
>  drivers/cxl/pci.c            | 14 +++++++-------
>  tools/testing/cxl/test/mem.c |  3 +--
>  5 files changed, 70 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index fa6dd0c94656..bee84d0101d1 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1514,23 +1514,21 @@ int cxl_mailbox_init(struct cxl_mailbox *cxl_mbox, struct device *host)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_mailbox_init, "CXL");
>  
> -struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
> +struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev, u64 serial,
> +						 u16 dvsec)
>  {
>  	struct cxl_memdev_state *mds;
>  	int rc;
>  
> -	mds = devm_kzalloc(dev, sizeof(*mds), GFP_KERNEL);
> +	mds = devm_cxl_dev_state_create(dev, CXL_DEVTYPE_CLASSMEM, serial,
> +					dvsec, struct cxl_memdev_state, cxlds,
> +					true);
>  	if (!mds) {
>  		dev_err(dev, "No memory available\n");
>  		return ERR_PTR(-ENOMEM);
>  	}
>  
>  	mutex_init(&mds->event.log_lock);
> -	mds->cxlds.dev = dev;
> -	mds->cxlds.reg_map.host = dev;
> -	mds->cxlds.cxl_mbox.host = dev;
> -	mds->cxlds.reg_map.resource = CXL_RESOURCE_NONE;
> -	mds->cxlds.type = CXL_DEVTYPE_CLASSMEM;
>  
>  	rc = devm_cxl_register_mce_notifier(dev, &mds->mce_notifier);
>  	if (rc == -EOPNOTSUPP)
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index f547d8ac34c7..ad131f053bf5 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -656,6 +656,30 @@ static void detach_memdev(struct work_struct *work)
>  
>  static struct lock_class_key cxl_memdev_key;
>  
> +struct cxl_dev_state *_devm_cxl_dev_state_create(struct device *dev,
> +						 enum cxl_devtype type,
> +						 u64 serial, u16 dvsec,
> +						 size_t size, bool has_mbox)
> +{
> +	struct cxl_dev_state *cxlds = devm_kzalloc(dev, size, GFP_KERNEL);
> +
> +	if (!cxlds)
> +		return NULL;
> +
> +	cxlds->dev = dev;
> +	cxlds->type = type;
> +	cxlds->serial = serial;
> +	cxlds->cxl_dvsec =dvsec;
> +	cxlds->reg_map.host = dev;
> +	cxlds->reg_map.resource = CXL_RESOURCE_NONE;
> +
> +	if (has_mbox)
> +		cxlds->cxl_mbox.host = dev;
> +
> +	return cxlds;
> +}
> +EXPORT_SYMBOL_NS_GPL(_devm_cxl_dev_state_create, "CXL");
> +
>  static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
>  					   const struct file_operations *fops,
>  					   const struct cxl_memdev_attach *attach)
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index e21d744d639b..9daf4bc42692 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -523,6 +523,37 @@ to_cxl_memdev_state(struct cxl_dev_state *cxlds)
>  	return container_of(cxlds, struct cxl_memdev_state, cxlds);
>  }
>  
> +struct cxl_dev_state *_devm_cxl_dev_state_create(struct device *dev,
> +						 enum cxl_devtype type,
> +						 u64 serial, u16 dvsec,
> +						 size_t size, bool has_mbox);
> +
> +/**
> + * cxl_dev_state_create - safely create and cast a cxl dev state embedded in a
> + * driver specific struct.
> + *
> + * @parent: device behind the request
> + * @type: CXL device type
> + * @serial: device identification
> + * @dvsec: dvsec capability offset
> + * @drv_struct: driver struct embedding a cxl_dev_state struct
> + * @member: drv_struct member as cxl_dev_state
> + * @mbox: true if mailbox supported
> + *
> + * Returns a pointer to the drv_struct allocated and embedding a cxl_dev_state
> + * struct initialized.
> + *
> + * Introduced for Type2 driver support.
> + */
> +#define devm_cxl_dev_state_create(parent, type, serial, dvsec, drv_struct, member, mbox)	\
> +	({										\
> +		static_assert(__same_type(struct cxl_dev_state,				\
> +			      ((drv_struct *)NULL)->member));				\
> +		static_assert(offsetof(drv_struct, member) == 0);			\
> +		(drv_struct *)_devm_cxl_dev_state_create(parent, type, serial, dvsec,	\
> +						      sizeof(drv_struct), mbox);	\
> +	})
> +
>  enum cxl_opcode {
>  	CXL_MBOX_OP_INVALID		= 0x0000,
>  	CXL_MBOX_OP_RAW			= CXL_MBOX_OP_INVALID,
> @@ -858,7 +889,8 @@ int cxl_dev_state_identify(struct cxl_memdev_state *mds);
>  int cxl_await_media_ready(struct cxl_dev_state *cxlds);
>  int cxl_enumerate_cmds(struct cxl_memdev_state *mds);
>  int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info);
> -struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev);
> +struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev, u64 serial,
> +						 u16 dvsec);
>  void set_exclusive_cxl_commands(struct cxl_memdev_state *mds,
>  				unsigned long *cmds);
>  void clear_exclusive_cxl_commands(struct cxl_memdev_state *mds,
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index fbb300a01830..a42f273ff72b 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -865,25 +865,25 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	int rc, pmu_count;
>  	unsigned int i;
>  	bool irq_avail;
> +	u16 dvsec;
>  
>  	rc = pcim_enable_device(pdev);
>  	if (rc)
>  		return rc;
>  	pci_set_master(pdev);
>  
> -	mds = cxl_memdev_state_create(&pdev->dev);
> +	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> +					  PCI_DVSEC_CXL_DEVICE);
> +	if (!dvsec)
> +		pci_warn(pdev, "Device DVSEC not present, skip CXL.mem init\n");
> +
> +	mds = cxl_memdev_state_create(&pdev->dev, pci_get_dsn(pdev), dvsec);
>  	if (IS_ERR(mds))
>  		return PTR_ERR(mds);
>  	cxlds = &mds->cxlds;
>  	pci_set_drvdata(pdev, cxlds);
>  
>  	cxlds->rcd = is_cxl_restricted(pdev);
> -	cxlds->serial = pci_get_dsn(pdev);
> -	cxlds->cxl_dvsec = pci_find_dvsec_capability(
> -		pdev, PCI_VENDOR_ID_CXL, PCI_DVSEC_CXL_DEVICE);
> -	if (!cxlds->cxl_dvsec)
> -		dev_warn(&pdev->dev,
> -			 "Device DVSEC not present, skip CXL.mem init\n");
>  
>  	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
>  	if (rc)
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index cb87e8c0e63c..79f42f4474d4 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -1716,7 +1716,7 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
>  	if (rc)
>  		return rc;
>  
> -	mds = cxl_memdev_state_create(dev);
> +	mds = cxl_memdev_state_create(dev, pdev->id + 1, 0);
>  	if (IS_ERR(mds))
>  		return PTR_ERR(mds);
>  
> @@ -1732,7 +1732,6 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
>  	mds->event.buf = (struct cxl_get_event_payload *) mdata->event_buf;
>  	INIT_DELAYED_WORK(&mds->security.poll_dwork, cxl_mockmem_sanitize_work);
>  
> -	cxlds->serial = pdev->id + 1;
>  	if (is_rcd(pdev))
>  		cxlds->rcd = true;
>  

