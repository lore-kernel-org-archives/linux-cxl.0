Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EDF1922E3;
	Wed, 10 Jul 2024 18:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720636030; cv=none; b=VU5Yw+bOzwbb1vIzCPT/HCidwrjorPDUc9Dfo7Sz+xJDeYN6UXBdO+vtLlAIp7srKcrSvmJ8dVPfbpeAqKHERvnqdWdlabvAByh7s2Z4SwRS0+64yEeP9d9tuciVVOtHMS6ql3V0y0ff9tT45Z3OxtmbDE0NyxK9n+ovBtJemb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720636030; c=relaxed/simple;
	bh=vE4YwZqVSyf+g3MpvOLWDYqAVnZMm6ZdBSNJBrlYexg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sMScOCuBWKGFiI2l50YvOxi1NIR0HQx3fDVuScBFeUsbTBwGNMA251FKOAm7sO2/QSVEdQeafqJiXddHhRVmjMApzNeda2otdZabeZV3NBYZUlJqUDl6PN2T/rgDzDMUNmvulKcaDx7X9UN1s5CnX6UqYaE4YIpQq4d6/KPrgZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iqZbUlJy; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iqZbUlJy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720636027; x=1752172027;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vE4YwZqVSyf+g3MpvOLWDYqAVnZMm6ZdBSNJBrlYexg=;
  b=iqZbUlJyVHzBFubW/zfQ/WSVFu3q9GVWVg0lxtEKBw0bSLhs3lzO/1Hb
   gKzAi5Txv87Rpn+kNGDncxDgyzEUQ2XF2lpfKEZKBDqEUNeCVpY6qmaRn
   jmeadrW3YaP8f4ZzKk215oSaZBVVQYDUP0XqAAI56l4YG0gXuo8eUch43
   sAP0nsVwZ0pP6mrCTBBdGFpBlUVUWHubx5z3qnlcy1k/EfwSOrGxGualx
   NFH4iyIiiuTtobXdu2B2f7T3VZ/qHRV0tMXIjMdqyFLE84rb+ogoGApxP
   JwVljxAwRRsnKV5hXBLF1i79ez8zpSHmialF2Wd1hfXqTk2e4lAE9fvY0
   w==;
X-CSE-ConnectionGUID: njQxMGGpQYiMbt+CARYQYA==
X-CSE-MsgGUID: mRz4/FC1Q4yREdATvfgZ4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="18116550"
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="18116550"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 11:26:58 -0700
X-CSE-ConnectionGUID: 57EtbHqaTjieQffc5EaEOg==
X-CSE-MsgGUID: c+uv0ukqQkmGTgV3zK17xQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="48313002"
Received: from janchell-mobl1.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.72.164])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 11:26:58 -0700
Date: Wed, 10 Jul 2024 11:26:56 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: peng guo <engguopeng@buaa.edu.cn>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, wyguopeng@163.com
Subject: Re: [PATCH v3] cxl/core: Support mbox op clear log of vendor debug
 logs
Message-ID: <Zo7ScFy2B4jFSGtb@aschofie-mobl2>
References: <20240710023112.8063-1-engguopeng@buaa.edu.cn>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710023112.8063-1-engguopeng@buaa.edu.cn>

On Wed, Jul 10, 2024 at 10:31:12AM +0800, peng guo wrote:
> When user send a mbox cmd whose opcode is CXL_MBOX_OP_CLEAR_LOG and
> the in_payload is normal vendor debug log UUID according to
> the CXL specification
> cxl_payload_from_user_allowed() will return false unexpectedly,
> Sending mobox cmd operation failed and the kernel log will print:
> Clear Log: input payload not allowed.
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
> Fix the definition value of DEFINE_CXL_VENDOR_DEBUG_UUID to match the
> CXL r3.1 specification.
> 
> Fixes: 472b1ce6e9d6 ("cxl/mem: Enable commands via CEL")
> Signed-off-by: peng guo <engguopeng@buaa.edu.cn>


Peng: Thanks for the patch!

DaveJ: Please fixup paragraph one split and s/mobox/mbox when applying.

Reviewed-by: Alison Schofield <alison.schofield@intel.com>


> ---
> v2 -> v3: Add a description of the impact of this issue on user usage
>           Modify the fixes tag
> v1 -> v2: update commit message  and addressed review comments
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
