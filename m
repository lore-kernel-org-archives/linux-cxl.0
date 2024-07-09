Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E951B1DFCF;
	Tue,  9 Jul 2024 15:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720540107; cv=none; b=Orzr7GSpuA+a3xuGPX7GdBStE2ye6qt8g18yznj3Vju+glqtPvcI1TrRRh8F9H7CidAA1U/CLT3JK9AdLduX99oQdLNVFzn5mmCcHdzYZzLInAl6diyT7WjIL3gzFJuDPlRJBGEucSvSVKLY8zcNH7oHgVpqORECFGt1/r8sfKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720540107; c=relaxed/simple;
	bh=NWutiFclNUFOv1GhJD7R5w/nPuQtkGtoacxlO3cj5Zk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vi7hHodcjxByA+S/DRwYtnlqnQh0/An4Bk3n+lZzi3vP3wFxE1C4mmq/EgIhhnvgNpZuY5nZovD5P8XXekiilKzA6v8ual+YeXpj6PkloPtkPmo4M1f8RwGAIfqNmD3ECgVmnFqRKOyZiGb9cYCNo7uHobgpdZTKw9mgjCnKqaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z8Bl6clI; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z8Bl6clI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720540105; x=1752076105;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NWutiFclNUFOv1GhJD7R5w/nPuQtkGtoacxlO3cj5Zk=;
  b=Z8Bl6clIX/iFBKU1tOMXuguhBrBT28hGLCBAaUCtHmY4NFGG5wJz42GK
   VxcRHoG8c8IurylwjRd6UmrvcedbypP4kkGcKOfrEj6YEV5Xb7kDOH6Gz
   8UGY1QB4ePMPOCvgnap7EfAIisrnxdOdhI9echf2DBTcjFxQuNwcT6rkW
   hWaKoFufy9yAQlvexz7BNxYTdHhgMf9N1WerjEyHMfFaSQML4212gch+/
   2V4N87t4up83JJItWUH3MWoRGSzajh+iXBuZz3gaCmKztRvYphrBmNjqK
   9Erb5ZliaDoLDBzvkedSFPmWCHpYhHKScYG5hKz37yJ89ssGJoejHfVhF
   Q==;
X-CSE-ConnectionGUID: Sx7lBJybScm31op88mlSsA==
X-CSE-MsgGUID: +2PCRkoDSQWGLLOfPCHZDQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="40323526"
X-IronPort-AV: E=Sophos;i="6.09,195,1716274800"; 
   d="scan'208";a="40323526"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2024 08:48:24 -0700
X-CSE-ConnectionGUID: cbWgAitAS5upY1AAPsesdQ==
X-CSE-MsgGUID: pZldvnNXQV2/S33lzhf4lQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,195,1716274800"; 
   d="scan'208";a="48624786"
Received: from kinlongk-desk.amr.corp.intel.com (HELO [10.125.109.72]) ([10.125.109.72])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2024 08:48:24 -0700
Message-ID: <2ce919d1-9c2d-44be-a58f-56b91eac7b48@intel.com>
Date: Tue, 9 Jul 2024 08:48:22 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cxl/core: Fix the UUID of CXL vendor debug Log
 identifier
To: peng guo <engguopeng@buaa.edu.cn>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, wyguopeng@163.com
References: <045fb08e-6d18-4558-b7b2-b83c412307da@intel.com>
 <20240709141239.10737-1-engguopeng@buaa.edu.cn>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240709141239.10737-1-engguopeng@buaa.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/9/24 7:12 AM, peng guo wrote:
> Fix the definition value of DEFINE_CXL_VENDOR_DEBUG_UUID to match the
> CXL r3.1 specification, although this value is not currently used.
> 
> All CXL devices that support a debug log shall support the Vendor Debug
> Log to allow the log to be accessed through a common host driver, for any
> device, all versions of the CXL specification define the same value with
> Log Identifier of: 5e1819d9-11a9-400c-811f-d60719403d86
> 
> refer to:
> CXL spec r2.0 Table 169
> CXL spec r3.0 Table 8-62
> CXL spec r3.1 Table 8-71
> 
> Fixes: 49be6dd80751 ("cxl/mbox: Move command definitions to common location")

Thanks for the update Peng. 

This one is tricky as the definition has been moved twice, but the original commit that introduced the error was here:
472b1ce6e9d6 ("cxl/mem: Enable commands via CEL")

I will update that when I apply the patch.

Next time for follow on patch revisions, please post as independent email rather than threaded behind the previous submission. Thanks! 

> Signed-off-by: peng guo <engguopeng@buaa.edu.cn>
> ---
>  v1 -> v2: update commit message  and addressed review comments
> 
>  drivers/cxl/cxlmem.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index af8169ccdbc0..feb1106559d2 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -563,7 +563,7 @@ enum cxl_opcode {
>  		  0x3b, 0x3f, 0x17)
>  
>  #define DEFINE_CXL_VENDOR_DEBUG_UUID                                           \
> -	UUID_INIT(0xe1819d9, 0x11a9, 0x400c, 0x81, 0x1f, 0xd6, 0x07, 0x19,     \
> +	UUID_INIT(0x5e1819d9, 0x11a9, 0x400c, 0x81, 0x1f, 0xd6, 0x07, 0x19,     \
>  		  0x40, 0x3d, 0x86)
>  
>  struct cxl_mbox_get_supported_logs {
