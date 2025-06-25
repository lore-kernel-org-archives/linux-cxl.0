Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE10529B8D2;
	Wed, 25 Jun 2025 18:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750875481; cv=none; b=VO/kL9M8Tu6VdO26Geq87h74rqFm9crGvBRV624uVqswY4eJwDdN5EvvAOTG3A2l5xKTd+7AXNp+UnT/VUShfZgI8BIkG22C0zE1Sw6lE7m6K9UU2NvHGLxgIrcOudGzMLNWPYHAZFfC+ob8KeU64x81TWoWmZz1kSbyVfzBJZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750875481; c=relaxed/simple;
	bh=Z2g5O50Y21w6pBaHNBX03PftrEVQ/d/Koyj5SdU8Gok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NSpDtfz19IRrQtMNgCE2eGrnceFr6faHwCiAbhi2cFfWWbPEV8wV99LBCCH3tkmXKpTl5eVv/xbvu3JV3la57LZneINi+JA1KkmFV4bBsTAaGKsAnXAJh2K4iaZMwvUba1KJDd+ACvwAt/hkg9ZiUH9KwVsYxfcU0N07RLjnIGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d6qBV629; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d6qBV629"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750875480; x=1782411480;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Z2g5O50Y21w6pBaHNBX03PftrEVQ/d/Koyj5SdU8Gok=;
  b=d6qBV629kL8dhOdO4qlPN322xxP1avewkptyqANzBIOFYZZcvjdoi8Vi
   A35q3IFAODUz2hfrFXdgM0cKT3zeYW2ZOtKgYnxJx+vmn8YrOfxQY4hfu
   JfGwjXbwQ6dE23NouIMl7Cgcj7Q7LVn/EkvDgCILts/k0KZSOJcT1WGaB
   i/LGgYg9x8ur0lSM8rPunU9Y7hzqlAfZaQysiaJod1o8/7EtEvKVG6q5X
   tTIV23WWogqjyIwYOBwZ2SbXnlsx46WenPMzvUEq7tS6Hi+dI14M5E/J/
   mqaMBaHAAK9sg7BUbJv5kEYKu6Mgxib07TnuzwT1i41se8mCseEzrZdUp
   w==;
X-CSE-ConnectionGUID: 20fCUEVXTFm8JO+EsoiDIA==
X-CSE-MsgGUID: ytwx1x8FQAKdjJbUHkKgsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="53123795"
X-IronPort-AV: E=Sophos;i="6.16,265,1744095600"; 
   d="scan'208";a="53123795"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 11:17:59 -0700
X-CSE-ConnectionGUID: QxE0x9YDTaKPmbTkGWbjSA==
X-CSE-MsgGUID: dqak/Cp0TRisWpYhoZoucg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,265,1744095600"; 
   d="scan'208";a="183184858"
Received: from puneetse-mobl.amr.corp.intel.com (HELO [10.125.109.5]) ([10.125.109.5])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 11:17:59 -0700
Message-ID: <c1432ad8-a6fb-4635-bc00-14d64db89194@intel.com>
Date: Wed, 25 Jun 2025 11:17:57 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] cxl/edac: Fix using wrong repair type to check dram
 event record
To: Li Ming <ming.li@zohomail.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 shiju.jose@huawei.com
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250620052924.138892-1-ming.li@zohomail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250620052924.138892-1-ming.li@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/19/25 10:29 PM, Li Ming wrote:
> cxl_find_rec_dram() is used to find a DRAM event record based on the
> inputted attributes. Different repair_type of the inputted attributes
> will check the DRAM event record in different ways.
> When EDAC driver is performing a memory rank sparing, it should use
> CXL_RANK_SPARING rather than CXL_BANK_SPARING as repair_type for DRAM
> event record checking.
> 
> Fixes: 588ca944c277 ("cxl/edac: Add CXL memory device memory sparing control feature")
> Signed-off-by: Li Ming <ming.li@zohomail.com>

Applied to cxl/fixes. Thanks Ming!

> ---
> base-commit: 3c70ec71abdaf4e4fa48cd8fdfbbd864d78235a8 cxl/fixes
> ---
>  drivers/cxl/core/edac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
> index d725ee954199..623aaa4439c4 100644
> --- a/drivers/cxl/core/edac.c
> +++ b/drivers/cxl/core/edac.c
> @@ -1323,7 +1323,7 @@ cxl_mem_get_rec_dram(struct cxl_memdev *cxlmd,
>  		attrbs.bank = ctx->bank;
>  	break;
>  	case EDAC_REPAIR_RANK_SPARING:
> -		attrbs.repair_type = CXL_BANK_SPARING;
> +		attrbs.repair_type = CXL_RANK_SPARING;
>  		break;
>  	default:
>  		return NULL;

