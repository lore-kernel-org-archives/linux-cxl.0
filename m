Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DCF14BFA8;
	Mon,  8 Jul 2024 18:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720464392; cv=none; b=Pv64waKKN4tDd/yRyNAE3/DWEPKFyHFX61ToIKjfb8GfN+Vzza4fy4VrZWZriwmVox2L0tm2NVG3biq0EL5YAXRTdgI1rWuCyIM6b1Uzs8Au6wzFf4wsHdVrPJS9mCdzfsbBBiFmipmG0yKUgGSGDwDk6klXrHsql19huMpPrhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720464392; c=relaxed/simple;
	bh=nWsKkWowCIBu+p5sjvVUVjNIp23bl9SMKEPKGmLp4tc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rsD08Ls0r1mJV4hgX1NslexkUq+mUWsgbejYGP4o30urF+mK6NT0//ZOEizU646D6Ky9rAuTMHkCl+XA47wFV5hA+dRO+4lm0Tx8BDCu9Z4EI/QkCpAM/g4mjwRKZ3BEGoGJDs/04oYF9S1cwoKX0iRMpmbaiD0JseSMw4uNFDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=axskcSQs; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="axskcSQs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720464390; x=1752000390;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nWsKkWowCIBu+p5sjvVUVjNIp23bl9SMKEPKGmLp4tc=;
  b=axskcSQszyy9taC6iLt7nKXnhU7imk7ovy84sB3UFRYPWriWLOTsVLJ5
   LcJNBi83fu6cwGCV+WVsD3UGaiW7J0afN/z8gENfO2hcbjv2A6hKpbbRg
   7n+rEqWnyHWAkX3PW8NrCx1SlcgdENGUsNMC53HqLhtKqpyBCM2dbxW2c
   FEL3A91er620EHWZGQjXpJjcy5CkhWal5zGHu6uEvGzvoKwg0y49/jWg8
   +IO3BoIwRI8Pi+qmnPOXRk+/PtwUaWd72dlJ77+P6EJb90VOu16RSafHN
   2JFXtiSHFL1EyKCMjQ90Fm5wmzS8j/xoTjpJNcQMePBnNrBaybk1uhEdy
   g==;
X-CSE-ConnectionGUID: /4mzYbb8RvedRjCFGFlGtA==
X-CSE-MsgGUID: luO3H9uWT42Pd7Cn1bZuRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="40194942"
X-IronPort-AV: E=Sophos;i="6.09,192,1716274800"; 
   d="scan'208";a="40194942"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 11:46:29 -0700
X-CSE-ConnectionGUID: 6zaTBzB8TcKx8bpQm7yTCg==
X-CSE-MsgGUID: mUB86ChdRU6fPZ2trmZSvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,192,1716274800"; 
   d="scan'208";a="48327202"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.105.241])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 11:46:29 -0700
Date: Mon, 8 Jul 2024 11:46:27 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: peng guo <engguopeng@buaa.edu.cn>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, wyguopeng@163.com
Subject: Re: [PATCH] cxl core:wrong value of macro definition
Message-ID: <Zow0Aw+vrXShXv+n@aschofie-mobl2>
References: <20240708152902.5853-1-engguopeng@buaa.edu.cn>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240708152902.5853-1-engguopeng@buaa.edu.cn>

On Mon, Jul 08, 2024 at 11:29:02PM +0800, peng guo wrote:
> The first value of the macro definition DEFINE_CXL_VENDOR_DEBUG_UUID
> does not match the definition in the CXL 2.0 specification table 170.

Please update commit message format and make it specific, like:
cxl/core: Support mbox op clear log of vendor debug logs

Isn't that what this is actually doing? It's correcting a typo to enable
the clearing of those logs. If that's true, let's not bury the impact
in a typo headline.

See cxl_payload_from_user_allowed(). I'm guessing that's how you
found this.

--Alison

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
> -- 
> 2.43.0
> 
