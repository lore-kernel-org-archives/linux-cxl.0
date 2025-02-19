Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCAA21481B;
	Wed, 19 Feb 2025 18:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739989616; cv=none; b=tqCvWcixQzeQwJkShdb8WcD1cBiP2WSuIpvil4G/3SldR1HsyeRWWurOjEIYmV4Uc1j6CUmdWFypVjObMvV5Lbyx1QyPyPKbVkWPG1kGpjBqClLEwoFS5ihUwRwcNyMtdIlriw+ETlr1pZIuaE1TQG9hSZCC8y5703kknNDN19U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739989616; c=relaxed/simple;
	bh=BynjFU2Ir4LMIytzR/2ljyenub6oAViTBqIdgJJdD3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jG688b5/oxSQGuyAJ0PN68B/v83UzSOSkYHu+sokkKMaAfEtfysjF8FSrYm+8uLxHbkrmpw5O8iu+Si8XqJ6lRHmcAQaOjQThKFLm/L31E+NPelnaLGIpscHWTnGqm0J9eyWMyU3y+q6DGBQzy4wxKjiYmkZ9CplIlV9XqJEi08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VvxF8XA3; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VvxF8XA3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739989615; x=1771525615;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BynjFU2Ir4LMIytzR/2ljyenub6oAViTBqIdgJJdD3I=;
  b=VvxF8XA3EUSeAir9u90jXQ5S6leTbu0F4UQnk8xqTmLnpHSi48p8F3Zc
   jOxsP2XLKosedU/L5/ExXu6aa3Xe+UAQs/TC9R635EpEex2O/QyESMgUu
   eEE4TJ9xMSDhKrwPqZfKu9YKtFhDtcFsvQ3KPgPT8r1xOxw3hiEwiweYe
   MrVDZOB+BucC1RZUv2QEwAyULfWYmgg16p27hbf3MRqLuGvXODBFv2laq
   lLuxxW/BYK9swrdLGtib/L9uFypIh5i/ByPcGjf11maJ1OY35JZ/MATxk
   XmzpSbh6pD9HcE57OSqRv8drjCyUs5s7Gp8VQyDA62WSWl/8476xpMu1G
   A==;
X-CSE-ConnectionGUID: cXJoqJz4T1KjeetE7YATgw==
X-CSE-MsgGUID: A3nHNWyeRlydTXJpqqn4sQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="40756606"
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="40756606"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 10:26:53 -0800
X-CSE-ConnectionGUID: 0ikWnpgcRh++9TjK5rV0bA==
X-CSE-MsgGUID: uor3T1kPTruOnoQnsDIn0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118923359"
Received: from inaky-mobl1.amr.corp.intel.com (HELO [10.125.110.11]) ([10.125.110.11])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 09:16:35 -0800
Message-ID: <ec04b92f-e916-4769-be82-93f369c9c593@intel.com>
Date: Wed, 19 Feb 2025 10:16:22 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] cxl/memdev: cxl_memdev_ioctl() cleanup
To: Li Ming <ming.li@zohomail.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250217144828.30651-1-ming.li@zohomail.com>
 <20250217144828.30651-4-ming.li@zohomail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250217144828.30651-4-ming.li@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/17/25 7:48 AM, Li Ming wrote:
> In cxl_memdev_ioctl(), the down_read(&cxl_memdev_rwsem) and
> up_read(&cxl_memdev_rwsem) can be replaced by a
> guard(rwsem_read)(&cxl_memdev_rwsem), it helps to remove the open-coded
> up_read(&cxl_memdev_rwsem). Besides, the local var 'rc' can be also
> removed to make the code more cleaner.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Li Ming <ming.li@zohomail.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/core/memdev.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 98c05426aa4a..6f90dcd626f9 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -668,15 +668,13 @@ static long cxl_memdev_ioctl(struct file *file, unsigned int cmd,
>  {
>  	struct cxl_memdev *cxlmd = file->private_data;
>  	struct cxl_dev_state *cxlds;
> -	int rc = -ENXIO;
>  
> -	down_read(&cxl_memdev_rwsem);
> +	guard(rwsem_read)(&cxl_memdev_rwsem);
>  	cxlds = cxlmd->cxlds;
>  	if (cxlds && cxlds->type == CXL_DEVTYPE_CLASSMEM)
> -		rc = __cxl_memdev_ioctl(cxlmd, cmd, arg);
> -	up_read(&cxl_memdev_rwsem);
> +		return __cxl_memdev_ioctl(cxlmd, cmd, arg);
>  
> -	return rc;
> +	return -ENXIO;
>  }
>  
>  static int cxl_memdev_open(struct inode *inode, struct file *file)

