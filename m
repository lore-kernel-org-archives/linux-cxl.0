Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F74E25F7A0;
	Fri,  9 May 2025 21:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746824921; cv=none; b=mZQam8Rf5ZxnQgdchgqK220W7m7PJslxCNLZ0AvqER0Cvr0TFspASq5YyJTcrcLLqsRgYjocpXkATZ41fu8lZ00gGt1w/SmNiNrCEMHmp9qT20gs8FzMxhAdU05YkZMPOt6akGgeJgdvyVSQ3c1G8/qlWFxMb06b4MmKbmkp7vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746824921; c=relaxed/simple;
	bh=GmqAD2aFQfYXBWL82oaoqnr2YM075jgG2kOLumgiHfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a6EPDs+8uE4j1wc2e0Afs86ZdW6S80VqdUHGCTeQaz2zb6FDeYeUxy8wiimLCPiNK3k4P/W+VQH8wLD/phDz4kjAHMXWI0lj2o1RCmsizfTmZ6LvZYwFIJqHQsS6J1hg7g7/EkKJtls+CK6ey3gRBumyq7+cWAHmbG1qmAV2dhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bvk46BrP; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bvk46BrP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746824920; x=1778360920;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GmqAD2aFQfYXBWL82oaoqnr2YM075jgG2kOLumgiHfU=;
  b=bvk46BrPLCBh/0KtevvBJMMD1Q6BTboJkmvvuTe5uk71/aohhThBYiPW
   r05imQafXZmUpJefGlN6sN/o5ER+Ekmqt8tONUCQoELYf6eFuiJGUINQq
   A1KbbpK5+V5PATOXqVDIXYjvB3KW+GKHxyPq+Uum2mKy+vw3CT2htWXCp
   0TWStwkDWoMfI+MYe1Buf2pQ0J2wdRHrlMly7taaOraEcA6akWwDPTjjD
   EGgzUgLNapOXnM3vNQSf7XyFJjk+xF8ntCxWv9jDP+hpnfRpHmpwjPI8S
   FIgGAgFPbpcliDHbbuj7JeQQzyxtAWNhPLJuWiXmSUlSQCTyCq9W42JwA
   Q==;
X-CSE-ConnectionGUID: iFjFO8NuR+uOiuBfT3x7fw==
X-CSE-MsgGUID: FDTkUSyzRaC2Zm3G7TLwIw==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="48819587"
X-IronPort-AV: E=Sophos;i="6.15,276,1739865600"; 
   d="scan'208";a="48819587"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 14:08:39 -0700
X-CSE-ConnectionGUID: 3m+zL70JQYq2kBv20UfOZw==
X-CSE-MsgGUID: /7VgAW/gRYyqn7Ef5ePyPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,276,1739865600"; 
   d="scan'208";a="137239744"
Received: from mgoodin-mobl2.amr.corp.intel.com (HELO [10.125.108.220]) ([10.125.108.220])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 14:08:39 -0700
Message-ID: <00e3c386-27ed-418a-8af6-e1e7eddc8284@intel.com>
Date: Fri, 9 May 2025 14:08:35 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/hdm: Clean up a debug printk
To: Ira Weiny <ira.weiny@intel.com>, Dan Carpenter
 <dan.carpenter@linaro.org>, Davidlohr Bueso <dave@stgolabs.net>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Robert Richter <rrichter@amd.com>,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <3d3d969d-651d-4e9d-a892-900876a60ab5@moroto.mountain>
 <681e6d2da4fc8_2e76d2294a7@iweiny-mobl.notmuch>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <681e6d2da4fc8_2e76d2294a7@iweiny-mobl.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/9/25 2:01 PM, Ira Weiny wrote:
> Dan Carpenter wrote:
>> Smatch complains that %pa is for phys_addr_t types and "size" is a u64.
>>
>>     drivers/cxl/core/hdm.c:521 cxl_dpa_alloc() error: '%pa' expects
>>     argument of type 'phys_addr_t*', argument 4 has type 'ullong*
>>
>> Looking at this, to me it seems more useful to print the sizes as
>> decimal instead of hex.  Let's do that.
>>
>> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> 
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>

Applied to cxl/next

> 
> [snip]

