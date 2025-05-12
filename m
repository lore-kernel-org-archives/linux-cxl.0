Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C32186A
	for <linux-cxl@vger.kernel.org>; Mon, 12 May 2025 22:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747089479; cv=none; b=oTh5mgHJ2PVfex+aO2JzsOxy8VC1g9jEGEQjyCnNEZGBM5SSKglQLLYjlmH00usguIuc4MD2k7ec1AJdLc2lb1oDrRoBcyVNgFMIb6BtJhD2PDcNiB9MVQEeltoJteAlyQ/6FxMWXwqbg9eH0Wj4ptm+D2hI7L2tXuR9KO0vvko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747089479; c=relaxed/simple;
	bh=legSyMkGmjbYeoRKBUXqGWzs3xB9PmjT8Vlb4PQep1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uGXMaSzjIWOXgflBfk8Q/+e9tA0kO+bkqmvckjWcLO3HROy6QoOkUBOeA+NWBn65sbXWFa9DR7I2ZXobA4J2dJrnxWgVUcgVaLV3ToRzIMpg/RKki78VahOgW6Yk6DAjIZ2JZj2+bj7TIj/a0jWZsWCNo3IsikFi7zrhM6XqPhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jaVDnJab; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jaVDnJab"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747089477; x=1778625477;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=legSyMkGmjbYeoRKBUXqGWzs3xB9PmjT8Vlb4PQep1Q=;
  b=jaVDnJabXNhLOgBnZ1NRNltzv7mY6JKDxvk75LkdGs2xE9pPO07GZkOA
   0tusgbeGr4JuYbXeiyaMtlUHGnrlPZKDSP5ry02uCqZ9CfmHaSsI/SmW8
   OAhnnaCwCJDv7rbgb8tbnv4C6854dOEQ+RowyWlh8Ih6nBSLm59C2QCoa
   C1RvMfDTrjR90EI80Sh8dU0sl8Iqu6oH+HMcxHILx3cheNTnYKITb749e
   f7Ngs3dFMdIIoT6odTG4Wo3Iv5Hmv8dqkzMmrB7YxDCe2xt53vu7VF97t
   xGf9HJMdc58xPSgzJ5O44kOfGFgCL67qtdS6B+xnvGyMxE7MwLUHRFsSo
   g==;
X-CSE-ConnectionGUID: 6A3nAKDyQpaYXmYLBqFG2g==
X-CSE-MsgGUID: +rlVExoiR8WyW0Im8f3j1w==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="66451657"
X-IronPort-AV: E=Sophos;i="6.15,283,1739865600"; 
   d="scan'208";a="66451657"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 15:37:56 -0700
X-CSE-ConnectionGUID: LfBcxpZpRqyYB1wvlbCsAA==
X-CSE-MsgGUID: M6WAvHoRQZmeJjjU28mXvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,283,1739865600"; 
   d="scan'208";a="168597753"
Received: from bjrankin-mobl3.amr.corp.intel.com (HELO [10.124.220.233]) ([10.124.220.233])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 15:37:56 -0700
Message-ID: <dc697ea8-20e8-453d-a22d-d5451b2cba21@intel.com>
Date: Mon, 12 May 2025 15:37:53 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Documentation: Update the CXL Maturity Map
To: alison.schofield@intel.com, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
References: <20250512214225.1389484-1-alison.schofield@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250512214225.1389484-1-alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/12/25 2:42 PM, alison.schofield@intel.com wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> Changes for extended-linear cache, hetero-interleave, and HPA->DPA
> address translation.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
> Change in v2:
> - Make ELC a '2' (DaveJ)
> 
>  Documentation/driver-api/cxl/maturity-map.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/driver-api/cxl/maturity-map.rst b/Documentation/driver-api/cxl/maturity-map.rst
> index a2288f9df658..1330f3f52129 100644
> --- a/Documentation/driver-api/cxl/maturity-map.rst
> +++ b/Documentation/driver-api/cxl/maturity-map.rst
> @@ -51,9 +51,9 @@ in place, but there are several corner cases that are pending closure.
>  
>  * [2] CXL Window Enumeration
>  
> -  * [0] :ref:`Extended-linear memory-side cache <extended-linear>`
> +  * [2] :ref:`Extended-linear memory-side cache <extended-linear>`
>    * [0] Low Memory-hole
> -  * [0] Hetero-interleave
> +  * [X] Hetero-interleave
>  
>  * [2] Switch Enumeration
>  
> @@ -173,7 +173,7 @@ Accelerator
>  User Flow Support
>  -----------------
>  
> -* [0] HPA->DPA Address translation (need xormaps export solution)
> +* [0] Inject & clear poison by HPA
>  
>  Details
>  =======

