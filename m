Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862CD313E2C;
	Thu, 15 Jan 2026 16:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768493563; cv=none; b=WUHsGWdN+0WF63pOjkmRzHxIUKvcrtv4AMH6NYhHcKflNEK/QY3f1ZTHzGAW7kID4vDIJIOACe5DQ0Awpc9+nOCEoA9peYPY9XqskBUDKGAO8scYfeUNJgN4n1iTyeLdGyB/Orfk4FRvkmo0jg6FDNExTJmy2aPjyp4LxZtojac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768493563; c=relaxed/simple;
	bh=k1vo75jVuw3W/CvVqErXlrD9M4YyYaMrI8MAoGB/z9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aVb+HzSrVBm7/4XoeIKFQjU/fg7iOOSa7BcIz6Z+uB8NaqKVhqN2P0z86TOEf6OavRG5ITd1I9dlmzNOGzevVR0fDcJbJNFh3ewnKej5pTO0kdFmiDnkUpuQKO5ZNzIMcimVwS4RDNpKLfNH0ldlpl2NLnqkrg2Rp+ZUnJGqNmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JX0IKVxf; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JX0IKVxf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768493563; x=1800029563;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=k1vo75jVuw3W/CvVqErXlrD9M4YyYaMrI8MAoGB/z9A=;
  b=JX0IKVxfuYfeWnzspEBFkgKSOIY6q1Qbt63yKjbOGwoZ8JueWmL68c22
   n36Hzn8HAVOMSc98I+gV9wYfh3YSujsRxC3JjtdEMTqQBcOZ9zp0AADET
   setrgP4l0Cza9K4o+k7k6539NZfCDjJafcuvOTiAIgtH41Dep1LvtSC1N
   C/bU0arNY25WJk1ftZo8fP8vcOe4csYUQgH+NdVBEqMdN6V9EW+gopDYb
   nXK132HRw1dYuyHp5ek1Gz1R/eAwt+xLHCoUM56WGGVQVJ099JgLbJrC/
   8U8z2I8xYhTGoCSdqCvL7QTxhPHEdPzaa9QZMVGHi+pjF7LC9y1rnr3Xx
   w==;
X-CSE-ConnectionGUID: M9Vgz4i3SJuf+zW4DfrI1Q==
X-CSE-MsgGUID: nJWr2RiJSt6GJA95xM0+UA==
X-IronPort-AV: E=McAfee;i="6800,10657,11672"; a="69782910"
X-IronPort-AV: E=Sophos;i="6.21,228,1763452800"; 
   d="scan'208";a="69782910"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 08:12:42 -0800
X-CSE-ConnectionGUID: w1JcEND9T0avEvF0TMc2sQ==
X-CSE-MsgGUID: DGAiYxToQkKO0uTcXKZUwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,228,1763452800"; 
   d="scan'208";a="205269711"
Received: from gabaabhi-mobl2.amr.corp.intel.com (HELO [10.125.111.80]) ([10.125.111.80])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 08:12:41 -0800
Message-ID: <8bda319a-967a-4f90-906c-438ac3719346@intel.com>
Date: Thu, 15 Jan 2026 09:12:39 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] cxl/acpi: Fix using extra xormaps for address
 translation
To: Li Ming <ming.li@zohomail.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260115131648.620177-1-ming.li@zohomail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260115131648.620177-1-ming.li@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/15/26 6:16 AM, Li Ming wrote:
> CXL r3.1 Table 9-22 defines a fixed number of XOR maps for interleave
> arithmetic based on the number of interleave ways, as reflected by
> hbiw_to_nr_maps[].
> 
> The current implementation applies all XOR maps during address
> translation, but it should use the spec-defined number of XOR maps
> derived from the number of interleave ways.

Can you add what is the current impact without applying the fix pls?

DJ

> 
> Fixes: 3b2fedcd75e3 ("cxl: Restore XOR'd position bits during address translation")
> Signed-off-by: Li Ming <ming.li@zohomail.com>
> ---
>  drivers/cxl/acpi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 77ac940e3013..5f84d01e7d39 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -61,7 +61,7 @@ u64 cxl_do_xormap_calc(struct cxl_cxims_data *cximsd, u64 addr, int hbiw)
>  	 * bits results in val==0, if odd the XOR result is val==1.
>  	 */
>  
> -	for (int i = 0; i < cximsd->nr_maps; i++) {
> +	for (int i = 0; i < nr_maps_to_apply; i++) {
>  		if (!cximsd->xormaps[i])
>  			continue;
>  		pos = __ffs(cximsd->xormaps[i]);

