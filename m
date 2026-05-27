Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743BF208D0
	for <linux-cxl@vger.kernel.org>; Wed, 27 May 2026 00:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779841995; cv=none; b=j1h4ugUezDEvLXNSf9m8kFP2OQcVokQE6vM0Ca0ARIn2bWkgB9wgqu2smD6FQXCkL1E7ovKcEmp9yGtXd/1WMbvVaUTeuHuSX0CcatqBuDfqrDSbER6Ofstl9u0dwF651CGjbfAxECQvt6BwVwLEsxOGDmvDEF6MxXNkuqFA/VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779841995; c=relaxed/simple;
	bh=s87ssDpyU7OihqB/ZFezY4eMjWDhAG8lU7ER6RiLQxE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UYBwt6NCQozgetzo0alcZePOmucDbrhWxEuoxw+96kIGdgueHZEQZzB10A/27xBVf/2wInCqyPkYLoNHPbRQ4i3Z/vto+K6E+ptQk3HW6laLpLiouAPubXEMonJNNkfQ1prAUzaU68I+EB3Hea4b74ugPxIbiEbfhDt68ZWBWJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jdIYuPqS; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jdIYuPqS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779841994; x=1811377994;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=s87ssDpyU7OihqB/ZFezY4eMjWDhAG8lU7ER6RiLQxE=;
  b=jdIYuPqS+e7ckqhzEon1aqcNHtb7WLbX1nLNvOcduWDcQPCuny1JPowY
   fNVXscV3X6A4j9Tp8SeGeBrHdK88gVuWZxouI9Rbqc9Tpc8c9qs/aByDo
   hrOH6CNMqJDuVizjoITbs5lr3cVTYryZtLJF2KzAZuag2nW0/67R3DwTO
   NFl8DkyMWvfJyfva0rg99oDdmTFEuIZFcPxtGT9UdFEi3fYoAxN4fyNX1
   4VZ+xfRieGcEsxqRtH7w4KUDrD8aFvo3d1tGWKObJV+gBlr5dK6VeKqbz
   //QCDYblYHHK9KWpgMn3ABHzf74Cwnieu+9yTUm5LbOq9y1FuqtvAfyyi
   g==;
X-CSE-ConnectionGUID: lq20qxUyTkW5jCuYnkwldA==
X-CSE-MsgGUID: YqkYnos2SNe/Y9TAdUBMPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11798"; a="83247115"
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; 
   d="scan'208";a="83247115"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 17:33:14 -0700
X-CSE-ConnectionGUID: v1/5UYL4SXqk0CJ76qkfTw==
X-CSE-MsgGUID: rPpnc3/LQByeqRGt+gHBSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; 
   d="scan'208";a="243900366"
Received: from aduenasd-mobl5.amr.corp.intel.com (HELO [10.125.110.201]) ([10.125.110.201])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 17:33:13 -0700
Message-ID: <27e15fda-2994-4fd4-9822-d0006b01a26e@intel.com>
Date: Tue, 26 May 2026 17:33:12 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Add CXL reviewer
To: Alison Schofield <alison.schofield@intel.com>,
 Li Ming <ming.li@zohomail.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>
Cc: linux-cxl@vger.kernel.org
References: <20260527001305.533170-1-alison.schofield@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260527001305.533170-1-alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/26/26 5:13 PM, Alison Schofield wrote:
> Add Li Ming as CXL subsystem reviewer.
> 
> Thanks to Li Ming for all the CXL bugs they've found and fixed,
> and looking forward to many more prevented!
> 
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Acked-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2fb1c75afd16..992e1fa57b72 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6428,6 +6428,7 @@ M:	Alison Schofield <alison.schofield@intel.com>
>  M:	Vishal Verma <vishal.l.verma@intel.com>
>  M:	Ira Weiny <ira.weiny@intel.com>
>  M:	Dan Williams <djbw@kernel.org>
> +R:	Li Ming <ming.li@zohomail.com>
>  L:	linux-cxl@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/driver-api/cxl

