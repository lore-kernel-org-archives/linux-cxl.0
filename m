Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA97121019C;
	Tue, 10 Jun 2025 17:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749577302; cv=none; b=n5G7p8qT92KASGZPwM89tfpsgHaHtqJcmKmBRbELXfCb3QOt1ICozfOEpTkjHxVVsV1Zaf7KEkk9DVjIEW9z0Epr3oqwufmpmIZU6yO4aNub5t/oTm2iDwxd7ek4G9+LXmIslp5qUyoSniZEw6dEhozZ+wReNAeFUSxx938slvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749577302; c=relaxed/simple;
	bh=Ognpew/E4byiPajspQy8PqqmvFMzBgvNmXyz1wCBkUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SwvEH5X9+1Bn6LetqwtIGo21cEaqamQM84WKl7uKrpF0qpnwR5+K2KoFnIaRoNbviha50SDE67J435spktbnYxWxty7iZa/0em5XNwaYzD1BUf/iG2AsGGEiXGJAXJ+SH2Hz1PPVzmuB1GKcKqL5DURDzqkkQZirjRH1WdOcAdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jZtgyZWa; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jZtgyZWa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749577300; x=1781113300;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ognpew/E4byiPajspQy8PqqmvFMzBgvNmXyz1wCBkUY=;
  b=jZtgyZWaQK+zVPVdDPnUcdjFibo1Oc/6uvo9mzipEDYzhJ5HIPN+u3Uu
   83PR74HwE7YQQHH1F+MdQI+yJ82MGusSfp+/dHxTtEvLTGBtshDxt/5T+
   Q/x5nrLdqps5agDBQchmP1suXHHbh2LNHM8EaysGCJK9YWjjlVWS2aWof
   pFWOALUVW7mGe5pl5mDHLYtDhtck6neyunD1M7DC5p0rGgyM16vcjDj45
   XeIUL5TtmnvSc2tesgRj3BidKPpa6zOHK7JUP+NmKCCcdVkRlpR6DUDar
   oVMtcS9L0vTBYg578J5w4ArlhKvhebFARt0MI/LHkBtDYDmB1ysF/2pwI
   g==;
X-CSE-ConnectionGUID: pXjBjnKNSoWcaqN14vwqrg==
X-CSE-MsgGUID: ZodE+6WwSqCwMXzRiSxhoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="55494999"
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; 
   d="scan'208";a="55494999"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 10:41:39 -0700
X-CSE-ConnectionGUID: 1HVtPtUSR1Wo9D0FVfXRdQ==
X-CSE-MsgGUID: Y5ObahOAS2C6uZRKzI36/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; 
   d="scan'208";a="147843909"
Received: from lstrano-mobl6.amr.corp.intel.com (HELO [10.125.111.135]) ([10.125.111.135])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 10:41:38 -0700
Message-ID: <36978c5d-9473-43f4-af7d-7a1b2927e36d@intel.com>
Date: Tue, 10 Jun 2025 10:41:36 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: fix typo in CXL driver documentation
To: Nai-Chen Cheng <bleach1827@gmail.com>, Davidlohr Bueso
 <dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-cxl@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev, Shuah Khan <skhan@linuxfoundation.org>
References: <20250610173152.33566-1-bleach1827@gmail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250610173152.33566-1-bleach1827@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/10/25 10:31 AM, Nai-Chen Cheng wrote:
> Fix typo 'enumates' to 'enumerate' in CXL driver operation
> documentation to improve readability.
> 
> Signed-off-by: Nai-Chen Cheng <bleach1827@gmail.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  Documentation/driver-api/cxl/linux/cxl-driver.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/driver-api/cxl/linux/cxl-driver.rst b/Documentation/driver-api/cxl/linux/cxl-driver.rst
> index 9759e90c3cf1..dd6dd17dc536 100644
> --- a/Documentation/driver-api/cxl/linux/cxl-driver.rst
> +++ b/Documentation/driver-api/cxl/linux/cxl-driver.rst
> @@ -20,7 +20,7 @@ The CXL driver is split into a number of drivers.
>  * cxl_port  - initializes root and provides port enumeration interface.
>  * cxl_acpi  - initializes root decoders and interacts with ACPI data.
>  * cxl_p/mem - initializes memory devices
> -* cxl_pci   - uses cxl_port to enumates the actual fabric hierarchy.
> +* cxl_pci   - uses cxl_port to enumerate the actual fabric hierarchy.
>  
>  Driver Devices
>  ==============

