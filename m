Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEA42FF667;
	Mon,  3 Nov 2025 23:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762213279; cv=none; b=a1JTMjnhHpFN8Tom0RYLRgP344rfujM8gq0FnULsHWQWBqVCM02f/7/AQ92xGGxL44mmhhJ9O6CZsk/U04UyRoJmaUurpqUR07i370w5WC6TaG+gX5CUpfmqH3pF4bt1rESQCZwyM03socMHfgKV4WJ5rQwA0O2lTZq6gD6mmVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762213279; c=relaxed/simple;
	bh=VKiITf9+qS6tyVB2MiLwEqlp/hx+AJoBSKEVJ8HXt4o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ijQHl1MYw5RAVgxHIdCZTVE9V8UssVae9Gvw/S2ZCWLTrZgQHoC4W/uWa5l75GqRwChdQRrsmpXzJvGtRC/6rAtBd7SzCy3sk5bunJCbRPsvT97eCdEBKe1AhwgoX2W65BZ0krT6EKhnuON3mByKYy5ELrDw4P10nRsyWhSgMLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ROl9OrnP; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ROl9OrnP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762213278; x=1793749278;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VKiITf9+qS6tyVB2MiLwEqlp/hx+AJoBSKEVJ8HXt4o=;
  b=ROl9OrnPkEJrjAYHcn6V55IvGVDQW58bzEfbS9bkQhDSYoZ215YYC6cu
   R0IDt9W9/dbYrq017pYj1sLMzwo1nk0Fwrqnc8ezFFO98IaJ5cSPD+qws
   DoYXNS/h8GCxB+NMHKZmFuIYhwIywfXgG73tvFAUGqcYBZcQzpQU0hctr
   j41aWt9ps/UXUg3j/YAx4lYfP0GJT7RD31X7dr+iZJC2vd0mOPXibMZwt
   ljRZRV55VxC8l7GZBC05cHh8np+DfXQ+N/Nh2Hv5uVlzAm1CQSNo03Rny
   jYUfmZXMzMqXbE1TSNHxE+y43503Dyl6zAaSkR5fLuDf+pwh9NiZVapdQ
   g==;
X-CSE-ConnectionGUID: hDumcN8+SnmHbdr1RBzM5g==
X-CSE-MsgGUID: 36CUx6qMQsmzykkgjQx59g==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="74591597"
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="scan'208";a="74591597"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 15:41:18 -0800
X-CSE-ConnectionGUID: MMZ6YupdQHOjc5ly7jlPcw==
X-CSE-MsgGUID: ZQg/glfQQb2JwYZQbaF4NA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="scan'208";a="186678175"
Received: from dwesterg-mobl1.amr.corp.intel.com (HELO [10.125.110.133]) ([10.125.110.133])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 15:41:16 -0800
Message-ID: <39ddd86e-f635-40f9-b3b7-0d1583b6bb6e@intel.com>
Date: Mon, 3 Nov 2025 16:41:15 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation/driver-api/cxl: remove page-allocator quirk
 section
To: Jonathan Corbet <corbet@lwn.net>, Gregory Price <gourry@gourry.net>,
 linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251003143233.1985150-1-gourry@gourry.net>
 <87bjlibsdi.fsf@trenco.lwn.net>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <87bjlibsdi.fsf@trenco.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/3/25 4:36 PM, Jonathan Corbet wrote:
> Gregory Price <gourry@gourry.net> writes:
> 
>> The node/zone quirk section of the cxl documentation is incorrect.
>> The actual reason for fallback allocation misbehavior in the
>> described configuration is due to a kswapd/reclaim thrashing scenario
>> fixed by the linked patch.  Remove this section.
>>
>> Link: https://lore.kernel.org/linux-mm/20250919162134.1098208-1-hannes@cmpxchg.org/
>> Signed-off-by: Gregory Price <gourry@gourry.net>
>> ---
>>  .../cxl/allocation/page-allocator.rst         | 31 -------------------
>>  1 file changed, 31 deletions(-)
> 
> This patch is still outstanding...should I take it through docs?

I just pushed it to cxl/next this morning. Thanks. 

> 
> Thanks,
> 
> jon

