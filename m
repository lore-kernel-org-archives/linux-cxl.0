Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F190A18A6CF;
	Tue, 17 Feb 2026 23:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771372518; cv=none; b=KWuHiMYi4/wMIDj6qD1QtJbcYxS6m0e5tswPgiy0MKIzT0AQBw4K7th1vpjn9X1CihcZ4qB6qY5bvT0iGYUJ/X4Z+IFxKqjUrvf6TRx26RC7xA/vQRQTR6DfZIsuz+i4id2E+qSK387fn7Vx1rsTesDdGHIXYGYU+oYPJKBzMrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771372518; c=relaxed/simple;
	bh=qVr7Lgf/QMeO5NyqsXSmtq8W6gPpy4WGbJ5JL2Ob7Kg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DSbFvwzW1iECgaughokV8r+JflWQr2yZNqjT2Gyo2DxkDJ4dqRUGzeUWDkHexuiga/5HWFnibq6xQ/GPuYGKHl7ZY09Cw/xpzFn3SCU2tK4sawnIicMq9pJSpF7GdYmzv98/6W8ECOSh3nu9vBY8UDzUGbzJTpKnLb8tjLsxbX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j0qwNZ96; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j0qwNZ96"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771372517; x=1802908517;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qVr7Lgf/QMeO5NyqsXSmtq8W6gPpy4WGbJ5JL2Ob7Kg=;
  b=j0qwNZ96DaL/NQHeVEKhaS0snknBf4GVGulLwZag6J3IBOIOhbVi5G6o
   3cs4S7c9h7KaTII8n9ZCH/D/1LZLSlDZB76wlnVu9R1yEm4zlkSyMX/ry
   wfFe8G2TbBdIkr9gOwvFoZ4715CYtDG+Q+e/4qOfVaN3qdfFWX4ucvq8A
   z13RcxVm2w+Couyl7ZHC86uot+MGnIWi+kPlO21f37We9r346CCFiTZ26
   XGRM0YyEhYkyZTypLXGESm9+wJmoAUZKvMd1BrhVDZCVJapKnjIFJPk3A
   2kdaEVWlVOXxBaVhPL6To7zmTjWljKqj9FxK2Pvd21jbJ66Ez/sy60jns
   w==;
X-CSE-ConnectionGUID: hVYYZMsySlmFuPeaDbVYDQ==
X-CSE-MsgGUID: 7SG3d6sYSxmUwj2tJ0LA/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11704"; a="72164525"
X-IronPort-AV: E=Sophos;i="6.21,297,1763452800"; 
   d="scan'208";a="72164525"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 15:55:16 -0800
X-CSE-ConnectionGUID: B8pQ8v2ISaSAusr8adkDUQ==
X-CSE-MsgGUID: 5XOW4gWPQ5mH7Sv6W1kOxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,297,1763452800"; 
   d="scan'208";a="212448079"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO [10.125.109.138]) ([10.125.109.138])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 15:55:15 -0800
Message-ID: <68d44fc4-55fe-42df-85ea-cffc60454325@intel.com>
Date: Tue, 17 Feb 2026 16:55:13 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] cxl/core: use cleanup.h for
 devm_cxl_add_dax_region
To: Gregory Price <gourry@gourry.net>, linux-cxl@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com
References: <20260211204206.2171525-1-gourry@gourry.net>
 <20260211204206.2171525-4-gourry@gourry.net>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260211204206.2171525-4-gourry@gourry.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/11/26 1:42 PM, Gregory Price wrote:
> Cleanup the gotos in the function.
> 
> No functional change intended.
> 
> Signed-off-by: Gregory Price <gourry@gourry.net>
> ---
>  drivers/cxl/core/region_dax.c | 21 ++++++++-------------
>  drivers/cxl/cxl.h             |  1 +
>  2 files changed, 9 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/cxl/core/region_dax.c b/drivers/cxl/core/region_dax.c
> index c8dd2bd1d9b9..49907c6c7620 100644
> --- a/drivers/cxl/core/region_dax.c
> +++ b/drivers/cxl/core/region_dax.c
> @@ -81,29 +81,24 @@ static void cxlr_dax_unregister(void *_cxlr_dax)
>  
>  int devm_cxl_add_dax_region(struct cxl_region *cxlr)
>  {
> -	struct cxl_dax_region *cxlr_dax;
> -	struct device *dev;
> +	struct cxl_dax_region *cxlr_dax __free(put_cxl_dax_region) = NULL;
>  	int rc;
>  
>  	cxlr_dax = cxl_dax_region_alloc(cxlr);

The typical __cleanup() pattern is to move the variable declaration here in order to minimize unintended issues between declare and check.

>  	if (IS_ERR(cxlr_dax))
>  		return PTR_ERR(cxlr_dax);
>  
> -	dev = &cxlr_dax->dev;

Given that this local var is used multiple times, maybe we should keep it?

DJ

> -	rc = dev_set_name(dev, "dax_region%d", cxlr->id);
> +	rc = dev_set_name(&cxlr_dax->dev, "dax_region%d", cxlr->id);
>  	if (rc)
> -		goto err;
> +		return rc;
>  
> -	rc = device_add(dev);
> +	rc = device_add(&cxlr_dax->dev);
>  	if (rc)
> -		goto err;
> +		return rc;
>  
> -	dev_dbg(&cxlr->dev, "%s: register %s\n", dev_name(dev->parent),
> -		dev_name(dev));
> +	dev_dbg(&cxlr->dev, "%s: register %s\n", dev_name(cxlr_dax->dev.parent),
> +		dev_name(&cxlr_dax->dev));
>  
>  	return devm_add_action_or_reset(&cxlr->dev, cxlr_dax_unregister,
> -					cxlr_dax);
> -err:
> -	put_device(dev);
> -	return rc;
> +					no_free_ptr(cxlr_dax));
>  }
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 04c673e7cdb0..0b59008ea45a 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -803,6 +803,7 @@ DEFINE_FREE(put_cxl_root, struct cxl_root *, if (_T) put_device(&_T->port.dev))
>  DEFINE_FREE(put_cxl_port, struct cxl_port *, if (!IS_ERR_OR_NULL(_T)) put_device(&_T->dev))
>  DEFINE_FREE(put_cxl_root_decoder, struct cxl_root_decoder *, if (!IS_ERR_OR_NULL(_T)) put_device(&_T->cxlsd.cxld.dev))
>  DEFINE_FREE(put_cxl_region, struct cxl_region *, if (!IS_ERR_OR_NULL(_T)) put_device(&_T->dev))
> +DEFINE_FREE(put_cxl_dax_region, struct cxl_dax_region *, if (!IS_ERR_OR_NULL(_T)) put_device(&_T->dev))
>  
>  int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd);
>  void cxl_bus_rescan(void);

