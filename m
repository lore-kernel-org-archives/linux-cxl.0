Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D6E3876DF;
	Tue, 10 Feb 2026 16:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770740845; cv=none; b=edS/F8F8zrn2YOM/RWkgPigXNE5P3l1jZ3z2OJQHYm+IOEc//sHATm5wICLPB46lOSUfZsGbsu8Yz6AhpnlbK1fLfhIib3c348MNbx6MV1SLzORwb6Vq2YYik6nxHBOjZkwPKOlFOlm0FtA8YDLfxMTuu+Sgvrb30NUMTQuia5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770740845; c=relaxed/simple;
	bh=XRgeHyK629WE47ZV6ZVHfe6oIQB5dHULZAKE3+sP3wQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mDiBQb+kt2JMydHzhUGN0si14+6iLQCoTUBViiKHbLPq19CLZIcvIhp81rI0XFoB7KfMy7FuLIXVr/FEXd0zSAlcEPEJYt+/Iz5zeSAyqDtPxE9aYyEhxPkghOOemj3wg5qU+rx2Y8yXpSA6Swda4oMKRzUVUqsqXEWtlN9uHaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i2S6yeBi; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i2S6yeBi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770740844; x=1802276844;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XRgeHyK629WE47ZV6ZVHfe6oIQB5dHULZAKE3+sP3wQ=;
  b=i2S6yeBiEfBuTs4gSlbqfqW5FjMkjvOVYUfIXGV0YNP0CnUQZ3VAAlPb
   HKdDLB2rmejKZBtNIKfZj21hPSv60ylUxVDFUA4lUy/GkWxOXeHuyWn0t
   JGWJpoey50ykwpD2NWSTn5ItNYAcSm2vsi8YDjrvWjUoElNxr13bVg8E8
   xYX6TFI1PAyTC8FKO/4JuMNGc8zuujWigZRaC3dBINeZpZz8v3r00+6CZ
   Hu2VvWmma+eqnjQTdy6TNcCBAthTsyDeK31kL2F4Aomf+HELtzlt/OuOa
   tgjl7cAsj2cDuNNSJCKUVYHjW/OtJWFVuKTqk5P4lCzeHUuo7x69kSFcX
   g==;
X-CSE-ConnectionGUID: 0MMdnXCjRMqTaUfj9tL6Yg==
X-CSE-MsgGUID: m1bbEtbdQoqH1LAaF4BxrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="82604143"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="82604143"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2026 08:27:24 -0800
X-CSE-ConnectionGUID: H5o9ECAnQM+Idz+EWfV9sA==
X-CSE-MsgGUID: gvFCQywsR7yp6+zIdXVs7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="212047863"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO [10.125.108.49]) ([10.125.108.49])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2026 08:27:24 -0800
Message-ID: <bb3e385c-89cd-48e4-9db8-edd04b7736e7@intel.com>
Date: Tue, 10 Feb 2026 09:27:22 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/memdev: fix deadlock in cxl_memdev_autoremove() on
 attach failure
To: Gregory Price <gourry@gourry.net>, linux-cxl@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com
References: <20260210154320.1748223-1-gourry@gourry.net>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260210154320.1748223-1-gourry@gourry.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/10/26 8:43 AM, Gregory Price wrote:
> cxl_memdev_autoremove() takes device_lock(&cxlmd->dev) via guard(device)
> and then calls cxl_memdev_unregister() when the attach callback was
> provided but cxl_mem_probe() failed to bind.
> 
> cxl_memdev_unregister() calls
>   cdev_device_del()
>     device_del()
>       bus_remove_device()
>         device_release_driver()
> 
> which also takes device_lock(), deadlocking the calling thread.
> 
> This path is reached when a driver uses the @attach parameter to
> devm_cxl_add_memdev() and the CXL topology fails to enumerate (e.g.
> DVSEC range registers decode outside platform-defined CXL ranges,
> causing the endpoint port probe to fail).
> 
> Fix by using scoped_guard() and breaking out of the guard scope before
> calling cxl_memdev_unregister(), so device_lock() is released first.
> 
> Fixes: 29317f8dc6ed ("cxl/mem: Introduce cxl_memdev_attach for CXL-dependent operation")
> Signed-off-by: Gregory Price <gourry@gourry.net>

Reivewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/core/memdev.c | 25 ++++++++++++++-----------
>  1 file changed, 14 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index af3d0cc65138..c0de767b24fb 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -1098,19 +1098,22 @@ static struct cxl_memdev *cxl_memdev_autoremove(struct cxl_memdev *cxlmd)
>  	 * return. Note that failure here could be the result of a race to
>  	 * teardown the CXL port topology. I.e. cxl_mem_probe() could have
>  	 * succeeded and then cxl_mem unbound before the lock is acquired.
> +	 *
> +	 * Check under device_lock but unregister outside of it, as
> +	 * cxl_memdev_unregister() will also take the device lock.
>  	 */
> -	guard(device)(&cxlmd->dev);
> -	if (cxlmd->attach && !cxlmd->dev.driver) {
> -		cxl_memdev_unregister(cxlmd);
> -		return ERR_PTR(-ENXIO);
> +	scoped_guard(device, &cxlmd->dev) {
> +		if (cxlmd->attach && !cxlmd->dev.driver)
> +			break;
> +
> +		rc = devm_add_action_or_reset(cxlmd->cxlds->dev,
> +					      cxl_memdev_unregister, cxlmd);
> +		if (rc)
> +			return ERR_PTR(rc);
> +		return cxlmd;
>  	}
> -
> -	rc = devm_add_action_or_reset(cxlmd->cxlds->dev, cxl_memdev_unregister,
> -				      cxlmd);
> -	if (rc)
> -		return ERR_PTR(rc);
> -
> -	return cxlmd;
> +	cxl_memdev_unregister(cxlmd);
> +	return ERR_PTR(-ENXIO);
>  }
>  
>  /*

