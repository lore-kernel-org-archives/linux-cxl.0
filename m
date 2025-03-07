Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30CE23FC68
	for <linux-cxl@vger.kernel.org>; Fri,  7 Mar 2025 22:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741386371; cv=none; b=MuDIrPPyZjYkh9ImzHhqGPgMrgVZ/s0lX4AmT7JGYhDe5ytEsDsjjQtRW+00FbkVzALSMLqpYq+T3VsdXZzBqeT6Iv3hKb0FXzQi/2GeIci/GCQ3FzHsyj9kFZpBV8mEG7mLy+JxWf6PRO9p9dx1fNtQM+mPt8u3ArqGRRZzRIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741386371; c=relaxed/simple;
	bh=VM/QCzGfryGXFpEOGWDn5BATBFxykuZ7TCXhwuplHIc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RpArwI3HmEQvz8ZMUceZ38d8y7EGcjiKDC3qNcG3CnnHITEThj6EgPKVUp9NMLr3nRwRaM46N/aVOOM9Fun5+A88ONSz4C2oehqEQn3h2DWCQNQOf8PkDlc7k6IpwblP0nuhqcoH9nOwjYu7ztKUY3ilW7sNHnJkSxCWddy2WFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iNj4f+8J; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iNj4f+8J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741386368; x=1772922368;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VM/QCzGfryGXFpEOGWDn5BATBFxykuZ7TCXhwuplHIc=;
  b=iNj4f+8JFN3l8n143tzQcu5lpmPcEjVXq96NwxDsWeMJLyaNYsP44/Pl
   kCoIJ+78gYYPnGdti4SrkDo/RTwY0+f0uMfty18H8BPe3pyBjkkVQSCd1
   sxFTFUwYjPQjuyTTYpYDRLFDqA3CO+q+LdTp8QGp/Z68TfzWbHPj5hqrx
   +lWNAEbjq550B7rf7g3pmwsJIDyly2lzQQdPReshMWCTxil8XLcKZwngF
   yu+eZVMriS0Y5yik904DaI15W5Keh8nmCKHUuCdmH282NISpUsE5q0kPC
   zuD5VYDD2fpD6WBvYzEh+K+vlxLS4ExygJy9leOBDCdh0nvhv64o9SbjT
   A==;
X-CSE-ConnectionGUID: 46lmRiKyQ/eamMo+XDxzJw==
X-CSE-MsgGUID: vjsy1cIZTtKBAtExLyOgkg==
X-IronPort-AV: E=McAfee;i="6700,10204,11366"; a="52659005"
X-IronPort-AV: E=Sophos;i="6.14,230,1736841600"; 
   d="scan'208";a="52659005"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 14:26:07 -0800
X-CSE-ConnectionGUID: 8zMokG+XQLKHBekJLM3c4w==
X-CSE-MsgGUID: Xghl6qjdTBe61YkmLcxr6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="120348456"
Received: from jdoman-mobl3.amr.corp.intel.com (HELO [10.125.110.142]) ([10.125.110.142])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 14:26:06 -0800
Message-ID: <1d180475-54ae-4095-bb36-f7ec8ee17f7c@intel.com>
Date: Fri, 7 Mar 2025 15:26:02 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/fwctl: Cleanup unused fwctl_dev from
 cxl_features_state
To: Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Cc: Li Ming <ming.li@zohomail.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Jason Gunthorpe <jgg@nvidia.com>
References: <174138547078.1626291.2681320775917569071.stgit@dwillia2-xfh.jf.intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <174138547078.1626291.2681320775917569071.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/7/25 3:11 PM, Dan Williams wrote:
> A review of devm_cxl_setup_fwctl() indicates a potential a use after
> free condition for the ->fwctl_dev pointer given it is not cleared after
> devm_add_action_or_reset() might have released it. However, nothing uses
> it, so just delete it.
> 
> If it ever comes back it should be returned by devm_cxl_setup_fwctl() so
> that users can always assume the pointer is either valid or NULL.
> 
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Li Ming <ming.li@zohomail.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
> 
> base-commit: da0dd17604d4c70080497091c762a790b0871eff
> 
>  drivers/cxl/core/features.c |    2 --
>  include/cxl/features.h      |    2 --
>  2 files changed, 4 deletions(-)
> 
> diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
> index caf92e9cea21..f4daefe3180e 100644
> --- a/drivers/cxl/core/features.c
> +++ b/drivers/cxl/core/features.c
> @@ -700,8 +700,6 @@ int devm_cxl_setup_fwctl(struct cxl_memdev *cxlmd)
>  	if (rc)
>  		return rc;
>  
> -	cxlfs->fwctl_dev = fwctl_dev;
> -
>  	return devm_add_action_or_reset(&cxlmd->dev, free_memdev_fwctl,
>  					no_free_ptr(fwctl_dev));
>  }
> diff --git a/include/cxl/features.h b/include/cxl/features.h
> index ead63573b0b4..fbfdc601bd85 100644
> --- a/include/cxl/features.h
> +++ b/include/cxl/features.h
> @@ -53,7 +53,6 @@ enum cxl_features_capability {
>   * @entries: CXl feature entry context
>   *	@num_features: total Features supported by the device
>   *	@ent: Flex array of Feature detail entries from the device
> - * @fwctl_dev: Firmware Control device
>   */
>  struct cxl_features_state {
>  	struct cxl_dev_state *cxlds;
> @@ -62,7 +61,6 @@ struct cxl_features_state {
>  		int num_user_features;
>  		struct cxl_feat_entry ent[] __counted_by(num_features);
>  	} *entries;
> -	struct fwctl_device *fwctl_dev;
>  };
>  
>  struct cxl_mailbox;
> 

