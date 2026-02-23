Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EEA344DAA;
	Mon, 23 Feb 2026 22:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771886075; cv=none; b=kLI9kXTgOU6iN0hGhUsx6zCW9znfdMiy6ygmUeAxq8Lp4M/mI1HCIXly/H/WNbdFxXpCq4rnbWbm6+jTNSnm9TPvBfnWFoj95EuZLi04msh+ktgTGGGuCmxwiRQeuRaW0nLBdZ+HnvJwZKw2ktr5Q3L3C6UBZKBITf+lR9ZXTR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771886075; c=relaxed/simple;
	bh=ItU3uHRNEl65UtC3uLyPu3l2IJDkwGvLsRznBKCMxTU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ix+jBsxsKGIvnu6AZqlvRytjE9NQe3aPgkdvpWE1g0K2TG0sWxb184UyTjLv6geSlhIeX45Utb95j+pavHFXI29PM0CVKZc7ubtdfUhLGWWkQiRbwNL2Xq07IOcOfXw8wP/674RA6XbzlUHrY+snavB6mCnihPO4TchuuXWnKPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nnlxHU2u; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nnlxHU2u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771886073; x=1803422073;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ItU3uHRNEl65UtC3uLyPu3l2IJDkwGvLsRznBKCMxTU=;
  b=nnlxHU2u5qlukPjLWvi3u2r2z/n/vfGplgx02s+AtW5nSxJbIT4VMUss
   IFsMX+Hx0aY1a3lEaS+E6tqZh0vWXfY10zmAWMNmXuY6bMGdlpr1pRaN4
   bHxqVVXuFhkkXgEBooBS9HO6xfJEGq03uvD45wOZBlAuKGDixW+dtLvWM
   RTzCuHvkfHQuUvfclOsj6vXfl1zzmjcD3C/KTWLRppYwSkYhktWbA8Umf
   iXupMyd0H9XcThpg047ejcvyTlvq+Ng0ia29PMkR4bCftlDwI1MFCUo6P
   dYjuxPXYq10YRCJeDKSfb6u9PF0a1uZTtPeG7HzkEB7rfQ27vdv4GwQpN
   g==;
X-CSE-ConnectionGUID: LwkQ6ZPPQ0ODL7GV++U4xQ==
X-CSE-MsgGUID: JYmwERsWRvma3Z1HR+pddw==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="71922166"
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="71922166"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 14:34:32 -0800
X-CSE-ConnectionGUID: +aF79AMsQCCVY3lgb1kXXg==
X-CSE-MsgGUID: Z7/TtHH/TwGLlH2YtljqeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="215555866"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.110.227]) ([10.125.110.227])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 14:33:12 -0800
Message-ID: <424666d2-b04b-4ea8-a47c-1bdcf86f23df@intel.com>
Date: Mon, 23 Feb 2026 15:33:11 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] cxl/memdev: fix deadlock in cxl_memdev_autoremove() on
 attach failure
To: Gregory Price <gourry@gourry.net>, linux-cxl@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com
References: <20260211192228.2148713-1-gourry@gourry.net>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260211192228.2148713-1-gourry@gourry.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/11/26 12:22 PM, Gregory Price wrote:
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
> This path is reached when a driver uses the @attach parameter to
> devm_cxl_add_memdev() and the CXL topology fails to enumerate (e.g.
> DVSEC range registers decode outside platform-defined CXL ranges,
> causing the endpoint port probe to fail).
> 
> Add cxl_memdev_attach_failed() to set the scope of the check correctly.
> 
> Fixes: 29317f8dc6ed ("cxl/mem: Introduce cxl_memdev_attach for CXL-dependent operation")
> Signed-off-by: Gregory Price <gourry@gourry.net>

Applied to cxl/fixes
318c58852e68

> ---
>  drivers/cxl/core/memdev.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index af3d0cc65138..25ca4443e4f7 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -1089,10 +1089,8 @@ static int cxlmd_add(struct cxl_memdev *cxlmd, struct cxl_dev_state *cxlds)
>  DEFINE_FREE(put_cxlmd, struct cxl_memdev *,
>  	    if (!IS_ERR_OR_NULL(_T)) put_device(&_T->dev))
>  
> -static struct cxl_memdev *cxl_memdev_autoremove(struct cxl_memdev *cxlmd)
> +static bool cxl_memdev_attach_failed(struct cxl_memdev *cxlmd)
>  {
> -	int rc;
> -
>  	/*
>  	 * If @attach is provided fail if the driver is not attached upon
>  	 * return. Note that failure here could be the result of a race to
> @@ -1100,7 +1098,14 @@ static struct cxl_memdev *cxl_memdev_autoremove(struct cxl_memdev *cxlmd)
>  	 * succeeded and then cxl_mem unbound before the lock is acquired.
>  	 */
>  	guard(device)(&cxlmd->dev);
> -	if (cxlmd->attach && !cxlmd->dev.driver) {
> +	return (cxlmd->attach && !cxlmd->dev.driver);
> +}
> +
> +static struct cxl_memdev *cxl_memdev_autoremove(struct cxl_memdev *cxlmd)
> +{
> +	int rc;
> +
> +	if (cxl_memdev_attach_failed(cxlmd)) {
>  		cxl_memdev_unregister(cxlmd);
>  		return ERR_PTR(-ENXIO);
>  	}

