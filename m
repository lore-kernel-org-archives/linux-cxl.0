Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0545B1B86E4;
	Tue,  9 Jul 2024 18:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720550034; cv=none; b=fzH7s3Gd/lfoRVhYg079qEp9Pb46ow0D8urTXJ1yo7nrdUMJ4lZitbGUfbLajB6FsHFztbg8A1kI/PlMzjxa97Ct3R8d5qUZXoh0Hiw9Jp8KrF3Tn/yIcashp6rNXRbZe7X7uJ4QcCsQEit3fy0n9MWyKZaww7OTKMMKzCKO7es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720550034; c=relaxed/simple;
	bh=tmVX/C4yIEx1ethLXgaPRHHJAs0JD4bW3hQ7K8czov0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=djrvYJ89v5IocSBjemZ8aKW5TGTXxxjhFiYE42VgqrzwQlLaxmV5pfxh4nBfMuipdNHMhXb6974Jz9XVQpul97dkL71z/jftU/lhbOFipR0Yc1BWHp8kfI4qeqKRtohBzz2qmZ7XsyE9qR841e3x1SuPGaVYl6UniEDWSJ9bwS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bd2zQhz8; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bd2zQhz8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720550032; x=1752086032;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tmVX/C4yIEx1ethLXgaPRHHJAs0JD4bW3hQ7K8czov0=;
  b=Bd2zQhz8ntfPPtbKP/23n/31QXcVDVmK+2FtplcH5XgFFMbZYyVqmDH2
   aR35sQA7JmZiU7p1Kgvx9fCmgQn4CqRUdY0nhwlxMNoYpugYcBhi2bg4t
   OYSpcD6W3GubYncMVCDszsXhR3RNpCb1iueZaRWbDHTfcj6/W4LPCYYkT
   NKQM73MyT386tPkWTFQnMhlGBAP+gplXtqQEslyPPyBm4aB6FUTo71lqk
   zoQ8lgk6wOilKWR1HQGGsIbWbBbgFYyP4rsYdF1co3274/cl9II6p2Tjx
   DojxoNttWnXQ3ErZUEAx5Q0bYMiPp0SPuGO91H4wncQ5yV/m0r5tDtvaS
   Q==;
X-CSE-ConnectionGUID: uputb14AQwyp9SEZl9TQSg==
X-CSE-MsgGUID: x2jJAH1/SiSt5ADV9igsFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="21593993"
X-IronPort-AV: E=Sophos;i="6.09,195,1716274800"; 
   d="scan'208";a="21593993"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2024 11:33:52 -0700
X-CSE-ConnectionGUID: qszBf9+aR+635AihjfUasA==
X-CSE-MsgGUID: 3uJ0Z4XMSq2Val5ybod/zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,195,1716274800"; 
   d="scan'208";a="52746275"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.105.195])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2024 11:33:52 -0700
Date: Tue, 9 Jul 2024 11:33:49 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: peng guo <engguopeng@buaa.edu.cn>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, wyguopeng@163.com
Subject: Re: [PATCH v2] cxl/core: Fix the UUID of CXL vendor debug Log
 identifier
Message-ID: <Zo2CjTCSnPmn6t8R@aschofie-mobl2>
References: <045fb08e-6d18-4558-b7b2-b83c412307da@intel.com>
 <20240709141239.10737-1-engguopeng@buaa.edu.cn>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709141239.10737-1-engguopeng@buaa.edu.cn>

On Tue, Jul 09, 2024 at 10:12:39PM +0800, peng guo wrote:
> Fix the definition value of DEFINE_CXL_VENDOR_DEBUG_UUID to match the
> CXL r3.1 specification, although this value is not currently used.

I thought the value was actually used.
Please help me understand by responding to v1 review:
https://lore.kernel.org/Zow0Aw+vrXShXv+n@aschofie-mobl2/

--Alison


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
> -- 
> 2.43.0
> 
