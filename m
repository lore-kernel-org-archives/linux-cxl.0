Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA49D2F5
	for <linux-cxl@vger.kernel.org>; Thu, 29 Feb 2024 00:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709166966; cv=none; b=T5K4m0sZBOZuHGtHKpUo5GOePo4MnMPkBo2pHUf6yAJtGN7DR0UYfNGdLQgeLh2OiItbryOUDiHAA9PZmbou49gBL9d4mdJZtCHdq3xm2UgjpOp4W0a7fYlFpx23Rn+yzHhM1LlkvoF+Ls4/dYdimk+ie13Wuxn2g0/p4obCj4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709166966; c=relaxed/simple;
	bh=pXAJ146JUob6QHzGL+9ZT4Yw1r0gOsykr0+fItFVPsI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aWmz+2nK7VnuJTpf/CxjFZQy2cY6sMdnPYGCysIbonnB1sFyN+FLXcUVlAqnnFXFXJi5w4EHGiyf0KWs7HOqwHyr2vjHV/cUWxXfMcH8xL/Pl+Qn/60EPsUfTy4hl8a2QrWrGV4nwrZB7cl+cpzJaX8YxkT/q9B3I2gmvulF5UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SK7lVIHu; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SK7lVIHu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709166964; x=1740702964;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pXAJ146JUob6QHzGL+9ZT4Yw1r0gOsykr0+fItFVPsI=;
  b=SK7lVIHuYlejj7cBBlETT8ZWpEF+xFafpybhPpX8mLOf4O96hUbva+bt
   BJu/awGP5p3FUKl7cSk4YSiqfEBVcDFZfBJS3BJIZZSUYnZYe6AkgQItL
   rA2QZUnh0+JMvN3zogGtKJIUmxJvoZ7ARUpluzf6JF9yjxHiqxHY6xMBE
   mtY3NUnJn0rlJQ771JlV6xtgVzOYEYyLhemZY3V3zvrXd7WdxygaZ5zr6
   fV/6HIlV9Sk3MwLGzuSl10zh+seoFwfiwS+0AyEzXlXJIVPSbPdvFjr6N
   y59f2SsP+pGwD9ELOB9H7PhgW2NTraIZyX9QO4whF0OSzwPWrOXIw1xBJ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="29041868"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="29041868"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 16:36:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="7544966"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.246.112.174]) ([10.246.112.174])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 16:36:02 -0800
Message-ID: <647dbe4c-e1cf-456a-8b15-1132dce7d37a@intel.com>
Date: Wed, 28 Feb 2024 17:36:01 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] cxl: Remove checking of iter in
 cxl_endpoint_get_perf_coordinates()
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Cc: ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, Jonathan.Cameron@huawei.com, dave@stgolabs.net
References: <20240229002542.634982-1-dave.jiang@intel.com>
 <65dfd0b697797_1138c729458@dwillia2-xfh.jf.intel.com.notmuch>
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <65dfd0b697797_1138c729458@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/28/24 5:32 PM, Dan Williams wrote:
> Dave Jiang wrote:
>> The while() loop in cxl_endpoint_get_perf_coordinates() checks to see if
>> 'iter' is valid as part of the condition breaking out of the loop. However,
>> iter is being used before the check at the end of the while loop before
>> the next iteration starts. Given that the loop doesn't expect the iter to
>> be NULL because it stops before the root port, remove the iter check.
> 
> This smells like a fix, but no "Fix" in the title or "Fixes" tag. So, is
> this a cleanup or a fix, and if it a fix what are the user visible
> effects of the bug?

I debated on this and in the end decided that it doesn't need to be a fix because there is no impact whether we check the iter or not in the loop since iter should not ever be NULL. 
