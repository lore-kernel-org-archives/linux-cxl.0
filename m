Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D990285C8C;
	Tue,  6 Jan 2026 01:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767661996; cv=none; b=mMtCqiwPmLjsKJKZGbVAUoXuxqsiw5yk59RcVMCyHRgH1Pqmva1TF115xPVOdga0BWViN+KrwhT6tWi/e4vlqC8u81WstWub99ODuCpqgqsi61hCTdrTot6xgZcBEX6D4WMo3FFCTBVWkJGg+6oUKR/snyqY3+Jtq8CHtwsPz9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767661996; c=relaxed/simple;
	bh=EqvhVdf8RNaVo5XMUPZNivjjtsMkCglrvWVqqLdKPTU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E79KKWR1q8HWZI68QZABJFJ9AHilUnZumWaQRstQguL79uk7nyD+vZRkESaU+i0Z0Z37UCcUQvAWgx5CCGIHSpeU92XP4Buh4L3rDGCxFutPju1dvRVsBXXlE3AxnKUyFeSliALb0OWV17Gqr/uTGbwvWLjReuio3UUVSaq5f+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ds8BgGJE; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ds8BgGJE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767661995; x=1799197995;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EqvhVdf8RNaVo5XMUPZNivjjtsMkCglrvWVqqLdKPTU=;
  b=Ds8BgGJEalfjtxWfus0KpW7KEM1oB38CVuKVUdsQMcLDNDEArStGotbS
   dSh3v8wHlUUcWF0w7GLa4XpCxk9/kbfxzDKu6fWYlxzxLV0v+MvcIutbz
   FgUWliEnLyn7bzcrZpZzPl3sh+gXp0K/CXouEn1TDXV2RX+qLhHQP1fQ9
   UMaNkrm66mXzlv/t52FKX4SlDi3bMN8PFZo27Ivsn/5b9eanbdr71w/Ix
   xyYp0v7gJt6qYYyMPOKyiDHPSwU6Q03Qi3YYQIzsuUpnbMDdljkCjb20P
   Octc/UIl5Ze1qBjN0CgrH6tsbXdHBZc3+wsjoPVa2rWA2KbjjhXEtfy/f
   g==;
X-CSE-ConnectionGUID: Shey7tydT82qrgIRUP7DEw==
X-CSE-MsgGUID: B6Ien1Q2RsCbTP/oaTOFyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11662"; a="69011437"
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; 
   d="scan'208";a="69011437"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2026 17:13:14 -0800
X-CSE-ConnectionGUID: WryN2CYzTqWyY5IzcB5M7w==
X-CSE-MsgGUID: zcQ78Ol2QimwuZltk6LElw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; 
   d="scan'208";a="202772162"
Received: from vverma7-desk1.amr.corp.intel.com (HELO [10.125.109.45]) ([10.125.109.45])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2026 17:13:12 -0800
Message-ID: <c6637e76-5363-4ebd-9997-ae2b379915e5@intel.com>
Date: Mon, 5 Jan 2026 18:13:11 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/region: fix format string for resource_size_t
To: Arnd Bergmann <arnd@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Ben Cheatham <benjamin.cheatham@amd.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Gregory Price <gourry@gourry.net>,
 Robert Richter <rrichter@amd.com>, Li Ming <ming.li@zohomail.com>,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251204095237.1032528-1-arnd@kernel.org>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20251204095237.1032528-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/4/25 2:52 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The size of this type is architecture specific, and the recommended
> way to print it portably is through the custom %pap format string.
> 
> Fixes: d6602e25819d ("cxl/region: Add support to indicate region has extended linear cache")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied to cxl/fixes
88c72bab77aaf389beccf762e112828253ca0564

DJ

> ---
>  drivers/cxl/core/region.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index ae899f68551f..fc36a5413d3f 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -759,7 +759,7 @@ static ssize_t extended_linear_cache_size_show(struct device *dev,
>  	ACQUIRE(rwsem_read_intr, rwsem)(&cxl_rwsem.region);
>  	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &rwsem)))
>  		return rc;
> -	return sysfs_emit(buf, "%#llx\n", p->cache_size);
> +	return sysfs_emit(buf, "%pap\n", &p->cache_size);
>  }
>  static DEVICE_ATTR_RO(extended_linear_cache_size);
>  

