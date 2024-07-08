Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E301E876;
	Mon,  8 Jul 2024 16:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720456312; cv=none; b=ECB7P7dXsGeXZ1XakNO3JoC9vuLlehFgSdR8u0vWjRBVe/HRDvxy7f433V/YLCuaDkqOQQfcgUej/Uku0LwcXp96nVl0wJJf4bSTLEi/4A2OMvitDHCO1ka28NYrVwij4NFboyGTZpVOXkWUDoy5LIioUMLZf96UuydxM87F9z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720456312; c=relaxed/simple;
	bh=OIY7mAKliXOrSwkWIU8gDcsma9imTxj14l4XNTy5SdI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n28YTjFViPriMACbnp+B8oDzA2c+RWuKy7SehKHSlc51qoNsntpMSbFBTaLphMPrPnxxcP8fIUbfNhF1KXMEcndQWe2Dhl8ae1tCcvTu+yZFUmgJm+/MuLESWIUgcZpbT9uV9mz+XgxBezOhTg9PFuvbMlgMHqk8nsbESaNh59M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M/aaHGSE; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M/aaHGSE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720456311; x=1751992311;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OIY7mAKliXOrSwkWIU8gDcsma9imTxj14l4XNTy5SdI=;
  b=M/aaHGSE/Ne41bS0j0GYxKGhThR6buGOx1AhXNVRGI/yJuyD50ccvczl
   GI7dYQNuM9/Ip6qiWG5amJ5gEjhSZEeA6QmEAvgVFlnO2dZHRQgbRGpD5
   74kR59sgDirxGPH0qc07yjKOwlVbbs5qfoH0ZFZZabY7cn1qtjJmf6dwo
   JBVxRy2ExFGQABFRiW7m3xaxQcuLs2n3GA8wh1ot1xhb3WVqC8mSXoD8B
   UlJ0P6hgV9Aexr0oL6lb64zVeuAl4BvX/I5LXv9QuSgOo8KSK6x6BABKl
   c6TafGGS3sloKgxjFDKhXopDDvnhitGzgH8AMPcS3IkEV8sCNl0V62H7k
   Q==;
X-CSE-ConnectionGUID: /HS5tWg0TFewRRuiKJTSBg==
X-CSE-MsgGUID: RYp3gOkLTkC9gUm09oC/wQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="28275805"
X-IronPort-AV: E=Sophos;i="6.09,192,1716274800"; 
   d="scan'208";a="28275805"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 09:31:50 -0700
X-CSE-ConnectionGUID: MJNGz0qSTHakYub2nmsH9A==
X-CSE-MsgGUID: UKtqXDqdS1OtluFW6HoMag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,192,1716274800"; 
   d="scan'208";a="52498124"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.125.108.203]) ([10.125.108.203])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 09:31:49 -0700
Message-ID: <045fb08e-6d18-4558-b7b2-b83c412307da@intel.com>
Date: Mon, 8 Jul 2024 09:31:48 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl core:wrong value of macro definition
To: peng guo <engguopeng@buaa.edu.cn>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, wyguopeng@163.com
References: <20240708152902.5853-1-engguopeng@buaa.edu.cn>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240708152902.5853-1-engguopeng@buaa.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/8/24 8:29 AM, peng guo wrote:
> The first value of the macro definition DEFINE_CXL_VENDOR_DEBUG_UUID
> does not match the definition in the CXL 2.0 specification table 170.

Thank you for the fix. Please use latest spec to identify. CXL spec r3.1 Table 8-71 I think?

Also, can you please provide a Fixes tag for this issue? Thanks!
> 
> Signed-off-by: peng guo <engguopeng@buaa.edu.cn>
> ---
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
