Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D2A21A424;
	Tue, 11 Feb 2025 16:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739291912; cv=none; b=kBAqUjMkXyq6LluP2BMGHII61M+mGL0R9HBi0pHsO8WRir7XnWAfNJWbdE7NFHfTnkkwvr6IOIxg53Xosnw06tmeSNl9zgAWMeDqkpw/ipMviKvXyQ5epNy6uSpEPH/0aJDiqkkHVoA3WwGBn7C307ACSRPjkOFh6JaaQ2Nnfhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739291912; c=relaxed/simple;
	bh=NuCAsRBh4DvBmjiQFOTpFDz2o7WyWhoN/XH3+lxuELo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lIH7VJzNHUa64VNCSqkZXU/U2/BoT+K94Dg253hFtUoQVywFHastmvnYOkMHak8C/daU8nrv7e9tvDSOD8Gqk5TNbk/p79LfBadfaB0LNMw9DNRyW4bQ0Xey6DLcUNnPnn6cDcgtKro29f2jdfM2LPm3mS9S1ZicpDg/5pg56Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AAJDAP+i; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AAJDAP+i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739291911; x=1770827911;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NuCAsRBh4DvBmjiQFOTpFDz2o7WyWhoN/XH3+lxuELo=;
  b=AAJDAP+izXi3YAyWWlxJCCk/9FhvopqFgmUJ0G4QMZgvMLtHDFtvfjFz
   pMgMZ6bRIE6vj+wB7ip3E86/+BdkN5GTrw6Da3dNCBqQIF1Wq3V5Ci+Ih
   3en7P8NVVWYUJ7WAaw1r+Hg42Uz+IWexPmI+pTT+HDkaKs1BLeIzsbWMS
   RZTTRw91VCK1qBLi69U1gL8oF4QCJFCIONvAymdIsEGL3LEaCNt5F2U6B
   gGTAUTfhLpayk0D5qj42Cdx5ouosmq6oNTKbm5JTFBAx/1tBV3C49XORS
   f3VVPsQFAilPnIS64vRwtpdC71YtgFHt309qhXY18Vrt0HMqYeAo7Regc
   Q==;
X-CSE-ConnectionGUID: THVPT2ixTRWwxJHZWy+rNw==
X-CSE-MsgGUID: SGn7dIPSQXqcjZPXgVlD9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="51313901"
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="51313901"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 08:38:30 -0800
X-CSE-ConnectionGUID: 9FRCUSJkRmuDOCOTjebaww==
X-CSE-MsgGUID: HAmm8tkaRBC/YhzWwwwz0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="113454082"
Received: from ldmartin-desk2.corp.intel.com (HELO [10.125.108.26]) ([10.125.108.26])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 08:38:29 -0800
Message-ID: <52996207-3021-47ad-935e-f3884fde6688@intel.com>
Date: Tue, 11 Feb 2025 09:38:28 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] cxl/cdat: Remove redundant gp_port initialization
To: Li Ming <ming.li@zohomail.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250211062054.300108-1-ming.li@zohomail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250211062054.300108-1-ming.li@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/10/25 11:20 PM, Li Ming wrote:
> gp_port is already pointed to the grandparent port during its definition,
> remove a redundant code to let gp_port point to the grandparent port
> again.
> 
> Signed-off-by: Li Ming <ming.li@zohomail.com>

Thanks! Applied to cxl/next

> ---
>  drivers/cxl/core/cdat.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index 8153f8d83a16..c656c1346aa0 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -651,7 +651,6 @@ static int cxl_endpoint_gather_bandwidth(struct cxl_region *cxlr,
>  	if (IS_ERR(perf))
>  		return PTR_ERR(perf);
>  
> -	gp_port = to_cxl_port(parent_port->dev.parent);
>  	*gp_is_root = is_cxl_root(gp_port);
>  
>  	/*

