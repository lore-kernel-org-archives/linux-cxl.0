Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6535726A0B9;
	Thu, 27 Feb 2025 15:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740669420; cv=none; b=aLIZJ7RgK2uyQR0tjRsdYvBwrv7NkyULcBd7obH9LbjSvtlGFwliHNf0yygLDYscEL/v2y6K5Tilbp8FQlM92siL6Nwt5E/Y9do+QK+ZaXWs30rZG/wGLCt1lTLl7Q8skxjXrRVSUWLwYgGu4Wl35kWvbCKDMOp3Qaie92ftwH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740669420; c=relaxed/simple;
	bh=xpitV625HIqwx7eYcgXZnDV02z63z9DmbM4MzyVJtxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G4o65xOgrkvU0hs4rJOYcyiTdmFc6FCaErFdIlBpcZSXaPmVC/Py19kh4lP0S5Jw/ipqRogyAMoa86cKNNt3Rl4cQlr7Pt215AgiHAm6W9QVdk0mM7HRFxNlU0o0QzB+4R5Ju0PwztY5fu3TxuPnXHxWsmbfvVec0X7gOKEOYog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UDj3IAiS; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UDj3IAiS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740669419; x=1772205419;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xpitV625HIqwx7eYcgXZnDV02z63z9DmbM4MzyVJtxk=;
  b=UDj3IAiSMxQUSWa9vpe7IY3ZZffg76cQl1+7yvUE8MYLaHJ2YP3hetmq
   vKG7yf9d+3Cho4F/bwCP085KfU/QoY2sLQv0ZcyyeOK3bFYBhsU4ThSzL
   WsiYzOmnuXYrFirLdES+w+Soumc8JYvEi3YM9akuaxA+Uoyr7giEQmlby
   TroxQTjG877hE841Nmvm6VZYPI87QKxO3m6UHr60slvHtkxd7+dJ3DBvv
   wiYwHobZXBCs/ak+mRAMJbPItA9DKe/34YMrfee17vMGkfnbtgOLhUgqF
   CVo498AiQmMT6GPNkwNHFFN2KG1yAqcP0szW3wwI/8y2K5AIbMtRdk6Vq
   Q==;
X-CSE-ConnectionGUID: CZP4swWJQU6+0z+XJU8+rQ==
X-CSE-MsgGUID: 7wn/7ikGRUyE0zdiy2Btaw==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="41688964"
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="41688964"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 07:16:58 -0800
X-CSE-ConnectionGUID: K4R4qhFgQ2WEBZVJyuvK8Q==
X-CSE-MsgGUID: qtA4MuLTRUi+OSUgJdkI7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="117549868"
Received: from msatwood-mobl.amr.corp.intel.com (HELO [10.125.108.89]) ([10.125.108.89])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 07:16:58 -0800
Message-ID: <e272e791-3ada-4630-b3c5-ee8113248eec@intel.com>
Date: Thu, 27 Feb 2025 08:16:56 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] cxl/mem: Do not return error if CONFIG_CXL_MCE
 unset
To: Li Ming <ming.li@zohomail.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250227101848.388595-1-ming.li@zohomail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250227101848.388595-1-ming.li@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/27/25 3:18 AM, Li Ming wrote:
> CONFIG_CXL_MCE depends on CONFIG_MEMORY_FAILURE, if
> CONFIG_CXL_MCE is not set, devm_cxl_register_mce_notifier() will return
> an -EOPNOTSUPP, it will cause cxl_mem_state_create() failure , and then
> cxl pci device probing failed. In this case, it should not break cxl pci
> device probing.
> 
> Add a checking in cxl_mem_state_create() to check if the returned value
> of devm_cxl_register_mce_notifier() is -EOPNOTSUPP, if yes, just output
> a warning log, do not let cxl_mem_state_create() return an error.
> 
> Signed-off-by: Li Ming <ming.li@zohomail.com>

Thanks!

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
> I hit this issue on my cxl_test environment with latest cxl-next. If
> CONFIG_MEMORY_FAILURE is unset, all cxl pci devices will fail to probe.
> 
> ...
> [    6.337952] cxl_mock_mem cxl_mem.6: probe with driver cxl_mock_mem failed with error -95
> [    6.338880] cxl_mock_mem cxl_mem.4: probe with driver cxl_mock_mem failed with error -95
> [    6.339593] cxl_mock_mem cxl_mem.9: probe with driver cxl_mock_mem failed with error -95
> [    6.340588] cxl_mock_mem cxl_mem.2: probe with driver cxl_mock_mem failed with error -95
> [    6.340914] cxl_mock_mem cxl_mem.0: probe with driver cxl_mock_mem failed with error -95
> [    6.345762] cxl_mock_mem cxl_rcd.10: probe with driver cxl_mock_mem failed with error -95
> [    6.345793] cxl_mock_mem cxl_mem.7: probe with driver cxl_mock_mem failed with error -95
> ...
> [    6.519824] cxl_pci 0000:c4:00.0: probe with driver cxl_pci failed with error -95
> [    6.520178] cxl_pci 0000:38:00.0: probe with driver cxl_pci failed with error -95
> ...
> 
> base-commit: 22eea823f69ae39dc060c4027e8d1470803d2e49 cxl/next
> ---
>  drivers/cxl/core/mbox.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 13cac98846bc..d72764056ce6 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1503,7 +1503,9 @@ struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
>  	mds->cxlds.type = CXL_DEVTYPE_CLASSMEM;
>  
>  	rc = devm_cxl_register_mce_notifier(dev, &mds->mce_notifier);
> -	if (rc)
> +	if (rc == -EOPNOTSUPP)
> +		dev_warn(dev, "CXL MCE unsupported\n");
> +	else if (rc)
>  		return ERR_PTR(rc);
>  
>  	return mds;

