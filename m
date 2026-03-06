Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC892848B2;
	Fri,  6 Mar 2026 15:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772809303; cv=none; b=X9gGh83CYWHs6CrFSUdbOdqMvC6dccMp6QWVTyigXuM7Y2hji/DX4kn1/beVjnI7t2a7+J4pQiNVRbwGKzyb1+cUlENvwuEvJdMgKeEggW5sNcCr+zHhg8oUlmAz6f/f0gueG3eLU6tJkYDDDlaZqOgBwQKCDVNcJtcholI7oDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772809303; c=relaxed/simple;
	bh=kmWB+wZwH2GD7iZMwjtj27Bt1Wp4PEc5my8dBaahCFY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h84BTv4FUsz9dBSZiTz1xts/IeBLN4bxLLggMSnZkuURaI+Y+yRDXT+czypQaBOVb3dXltUNk+O5NJKI09FoHXRiHFJRfZsACqAXyz3tUH7zNvmJWhlYGS5wgWwS0wxmEciJIVNSlnre8KDWP4fM/1FPm5Nf9OYGqhU8t0rgtZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tymirq9q; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tymirq9q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772809301; x=1804345301;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kmWB+wZwH2GD7iZMwjtj27Bt1Wp4PEc5my8dBaahCFY=;
  b=Tymirq9qVaU2e0WKoeZKXK0dqmGOB4ob/DQBXozfmPoSO90wVWAyDtfC
   oTDoZlJIuP5IupNF/qbg9uCCLhVp/X85iPA6NvkY8YGrtAKCgochk/GlQ
   H3I2UCuRMgwnmloOMrd0XhfVlloC3hGccyNSKHtImv1LBBHKq6FsUxMdE
   Du/NJ+wp8pQYksVaP8if0foLbbdp1LtKDcBtMLVkWc+j0bY6dc38vS+OX
   LU/i53NKyg11ea5GGYI4VCrrnueNGwORsqAYoTNUiicqtcNTVcm4uUtvl
   tqTJDgAiPCyM5308XKHDzo8Ng4WLpArKTvGi04CKVYi3xN3TWBt6KMqdr
   w==;
X-CSE-ConnectionGUID: BnipaRL7Rj6k6Yz4MqgtSQ==
X-CSE-MsgGUID: sHDKABOkSdK5lzoMgViBVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11721"; a="91304647"
X-IronPort-AV: E=Sophos;i="6.23,105,1770624000"; 
   d="scan'208";a="91304647"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 07:01:41 -0800
X-CSE-ConnectionGUID: AhnY6UjxToG3zf5KGcfwfA==
X-CSE-MsgGUID: OBPrRjqLR5aTi+iw3+WuZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,105,1770624000"; 
   d="scan'208";a="214934421"
Received: from jdoman-mobl3.amr.corp.intel.com (HELO [10.125.109.87]) ([10.125.109.87])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 07:01:40 -0800
Message-ID: <34f85830-5fc2-4568-afe8-3172d587d318@intel.com>
Date: Fri, 6 Mar 2026 08:01:38 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/test: Update mock memdev array before calling
 platform_device_add()
To: Li Ming <ming.li@zohomail.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260306-update_array_before_adding_mock_memdev-v1-1-a1a6af0952f1@zohomail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260306-update_array_before_adding_mock_memdev-v1-1-a1a6af0952f1@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/6/26 7:28 AM, Li Ming wrote:
> CXL test environment hits the following error sometimes.
> 
>  cxl_mem mem9: endpoint7 failed probe
> 
> All mock memdevs are platform firmware devices added by cxl_test module,
> and cxl_test module also provides a platform device driver for them to
> create a memdev device to CXL subsystem. cxl_test module uses
> cxl_rcd/mem_single/mem arrays to store different types of mock memdevs.
> CXL drivers calls registered mock functions for a mock memdev by
> checking if a given memdev is in these arrays.
> 
> When cxl_test module adds these mock memdevs, it always calls
> platform_device_add() before adding them to a suitable mock memdev
> array. However, there is a small window where CXL drivers calls mock
> function for a added memdev before it added to a mock memdev array. In
> above case, cxl endpoint driver considers a added memdev was not a mock
> memdev, then calling devm_cxl_endpoint_decoders_setup() for it rather
> than mock_endpoint_decoders_setup().
> 
> An appropriate solution is that adding a new mock memdev to a mock
> memdev array before calling platform_device_add() for it. It can
> guarantee the new mock memdev is visible to CXL subsystem.
> 
> Fixes: 3a2b97b3210b ("cxl/test: Improve init-order fidelity relative to real-world systems")
> Signed-off-by: Li Ming <ming.li@zohomail.com>

Makes sense.
Reviewed-by: Dave Jiang <dave.jiang@intel.com>


> ---
>  tools/testing/cxl/test/cxl.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 81e2aef3627a..2664c9de8dd6 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -1356,12 +1356,13 @@ static int cxl_mem_init(void)
>  		pdev->dev.parent = &dport->dev;
>  		set_dev_node(&pdev->dev, i % 2);
>  
> +		cxl_mem[i] = pdev;
>  		rc = platform_device_add(pdev);
>  		if (rc) {
>  			platform_device_put(pdev);
> +			cxl_mem[i] = NULL;
>  			goto err_mem;
>  		}
> -		cxl_mem[i] = pdev;
>  	}
>  
>  	for (i = 0; i < ARRAY_SIZE(cxl_mem_single); i++) {
> @@ -1374,12 +1375,13 @@ static int cxl_mem_init(void)
>  		pdev->dev.parent = &dport->dev;
>  		set_dev_node(&pdev->dev, i % 2);
>  
> +		cxl_mem_single[i] = pdev;
>  		rc = platform_device_add(pdev);
>  		if (rc) {
>  			platform_device_put(pdev);
> +			cxl_mem_single[i] = NULL;
>  			goto err_single;
>  		}
> -		cxl_mem_single[i] = pdev;
>  	}
>  
>  	for (i = 0; i < ARRAY_SIZE(cxl_rcd); i++) {
> @@ -1393,12 +1395,13 @@ static int cxl_mem_init(void)
>  		pdev->dev.parent = &rch->dev;
>  		set_dev_node(&pdev->dev, i % 2);
>  
> +		cxl_rcd[i] = pdev;
>  		rc = platform_device_add(pdev);
>  		if (rc) {
>  			platform_device_put(pdev);
> +			cxl_rcd[i] = NULL;
>  			goto err_rcd;
>  		}
> -		cxl_rcd[i] = pdev;
>  	}
>  
>  	return 0;
> 
> ---
> base-commit: 19d2f0b97a131198efc2c4ca3eb7f980bba8c2b4
> change-id: 20260306-update_array_before_adding_mock_memdev-89673b4d9118
> 
> Best regards,

