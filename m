Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D883491C4;
	Tue, 26 May 2026 21:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779831390; cv=none; b=i/shB5endVg0MrXlHi9nDHSPutzgsiFzGuTT5jVdw9TKUeHjbQuLGT4RGtLcP4MkoWecQxe+nlU2Kb3ymHmTwBIPprhwYlhrP4prJnZl0146e52phj5694gq4rsDZRT90Tv4Yr+VYV40ct5HmUg8jODav7WKU1TTecDfK1VvHGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779831390; c=relaxed/simple;
	bh=VFQQztAego6Nckr76pbTrgwkscIm2lpxDFQ8MQkI4Dk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ldpwBfA/+hJx4aG6yeJ1svxK2ZJpgFBJqYvT9k3QAp7yqYHC5/Zkd5QQSCutxF1cpW0nJVBEo4cBWXbpiaiBig+SYi8SknCzUkskLkuw1ByBMNAW6PQzTXyf/mRf8/kkBzFs2IRwaDBxDH1xLZ2DiENKxkFLNoqi3GlL9L0v8NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hbv/HOMt; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hbv/HOMt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779831389; x=1811367389;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VFQQztAego6Nckr76pbTrgwkscIm2lpxDFQ8MQkI4Dk=;
  b=hbv/HOMty9MaWDyrChBLynVuCpNMqK1wre8hgTFz9vQFCiRkBnryeL0+
   Fv4oaEfv9Z9C2RH6HgIUF6cCRedXuqeuQ9F9W/yKF8KN4KOkt4Gp3QGrc
   eUrdUWkGImDgMfcLWzrSr0Uj1YXWXa2JGllRV/w6FXvBl7dknFZ/J883m
   A3cDKAc0BnSbzL81CwRgifZ1d1f2Vcsrg8B9iAeALzzfcGAeomHdDZmMD
   64OENJ3vgPXznuy+n90N1TILOW17LMumw8skHYcJqvHG1y2+nDDBDiB/T
   KQkjeNwnguz2a22J23GH2HWei9um0L/C4NKiua0l8M3Kn1eud4/H1Ue/z
   g==;
X-CSE-ConnectionGUID: UetA6m+dQ8mCgOFIV/ctoA==
X-CSE-MsgGUID: 3VCmATkLRL6biyX65prpDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11798"; a="98081622"
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; 
   d="scan'208";a="98081622"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 14:36:28 -0700
X-CSE-ConnectionGUID: AyfaELVHSd+iLMbLO66BnA==
X-CSE-MsgGUID: LOku8YdFTcGzIGxt8gVGRw==
X-ExtLoop1: 1
Received: from aduenasd-mobl5.amr.corp.intel.com (HELO [10.125.110.201]) ([10.125.110.201])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 14:36:27 -0700
Message-ID: <fb5de769-34c0-479b-a246-ab658ef6996e@intel.com>
Date: Tue, 26 May 2026 14:36:26 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] cxl/test: Update mock dev array before calling
 platform_device_add()
To: Li Ming <ming.li@zohomail.com>, dave@stgolabs.net, jic23@kernel.org,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 djbw@kernel.org
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260520121457.234404-1-ming.li@zohomail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260520121457.234404-1-ming.li@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/20/26 5:14 AM, Li Ming wrote:
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
> An appropriate solution is that adding a new mock device to a mock
> device array before calling platform_device_add() for it. It can
> guarantee the new mock device is visible to CXL subsystem.
> 
> This patch introduces a new helped called cxl_mock_platform_device_add()
> to handle the issue, and uses the function for all mock devices addition.
> 
> Fixes: 3a2b97b3210b ("cxl/test: Improve init-order fidelity relative to real-world systems")
> Signed-off-by: Li Ming <ming.li@zohomail.com>

Applied to cxl/fixes
d90f236f8b9e354848bd226f581db27755ab901d

> ---
> Changes from v1:
> - Rebase to v7.1-rc4.
> - Introduce a new helper to handle the issue. (Alison)
> - Use new helper for all mock device addition.
> ---
>  tools/testing/cxl/test/cxl.c | 105 ++++++++++++++---------------------
>  1 file changed, 43 insertions(+), 62 deletions(-)
> 
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 418669927fb0..296516eecfd6 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -1523,6 +1523,23 @@ static void mock_companion(struct acpi_device *adev, struct device *dev)
>  #define SZ_64G (SZ_32G * 2)
>  #endif
>  
> +static int cxl_mock_platform_device_add(struct platform_device *pdev,
> +					struct platform_device **ppdev)
> +{
> +	int rc;
> +
> +	if (ppdev)
> +		*ppdev = pdev;
> +	rc = platform_device_add(pdev);
> +	if (rc) {
> +		platform_device_put(pdev);
> +		if (ppdev)
> +			*ppdev = NULL;
> +	}
> +
> +	return rc;
> +}
> +
>  static __init int cxl_rch_topo_init(void)
>  {
>  	int rc, i;
> @@ -1537,13 +1554,10 @@ static __init int cxl_rch_topo_init(void)
>  			goto err_bridge;
>  
>  		mock_companion(adev, &pdev->dev);
> -		rc = platform_device_add(pdev);
> -		if (rc) {
> -			platform_device_put(pdev);
> +		rc = cxl_mock_platform_device_add(pdev, &cxl_rch[i]);
> +		if (rc)
>  			goto err_bridge;
> -		}
>  
> -		cxl_rch[i] = pdev;
>  		mock_pci_bus[idx].bridge = &pdev->dev;
>  		rc = sysfs_create_link(&pdev->dev.kobj, &pdev->dev.kobj,
>  				       "firmware_node");
> @@ -1595,13 +1609,10 @@ static __init int cxl_single_topo_init(void)
>  			goto err_bridge;
>  
>  		mock_companion(adev, &pdev->dev);
> -		rc = platform_device_add(pdev);
> -		if (rc) {
> -			platform_device_put(pdev);
> +		rc = cxl_mock_platform_device_add(pdev, &cxl_hb_single[i]);
> +		if (rc)
>  			goto err_bridge;
> -		}
>  
> -		cxl_hb_single[i] = pdev;
>  		mock_pci_bus[i + NR_CXL_HOST_BRIDGES].bridge = &pdev->dev;
>  		rc = sysfs_create_link(&pdev->dev.kobj, &pdev->dev.kobj,
>  				       "physical_node");
> @@ -1620,12 +1631,9 @@ static __init int cxl_single_topo_init(void)
>  			goto err_port;
>  		pdev->dev.parent = &bridge->dev;
>  
> -		rc = platform_device_add(pdev);
> -		if (rc) {
> -			platform_device_put(pdev);
> +		rc = cxl_mock_platform_device_add(pdev, &cxl_root_single[i]);
> +		if (rc)
>  			goto err_port;
> -		}
> -		cxl_root_single[i] = pdev;
>  	}
>  
>  	for (i = 0; i < ARRAY_SIZE(cxl_swu_single); i++) {
> @@ -1638,12 +1646,9 @@ static __init int cxl_single_topo_init(void)
>  			goto err_uport;
>  		pdev->dev.parent = &root_port->dev;
>  
> -		rc = platform_device_add(pdev);
> -		if (rc) {
> -			platform_device_put(pdev);
> +		rc = cxl_mock_platform_device_add(pdev, &cxl_swu_single[i]);
> +		if (rc)
>  			goto err_uport;
> -		}
> -		cxl_swu_single[i] = pdev;
>  	}
>  
>  	for (i = 0; i < ARRAY_SIZE(cxl_swd_single); i++) {
> @@ -1657,12 +1662,9 @@ static __init int cxl_single_topo_init(void)
>  			goto err_dport;
>  		pdev->dev.parent = &uport->dev;
>  
> -		rc = platform_device_add(pdev);
> -		if (rc) {
> -			platform_device_put(pdev);
> +		rc = cxl_mock_platform_device_add(pdev, &cxl_swd_single[i]);
> +		if (rc)
>  			goto err_dport;
> -		}
> -		cxl_swd_single[i] = pdev;
>  	}
>  
>  	return 0;
> @@ -1735,12 +1737,9 @@ static int cxl_mem_init(void)
>  		pdev->dev.parent = &dport->dev;
>  		set_dev_node(&pdev->dev, i % 2);
>  
> -		rc = platform_device_add(pdev);
> -		if (rc) {
> -			platform_device_put(pdev);
> +		rc = cxl_mock_platform_device_add(pdev, &cxl_mem[i]);
> +		if (rc)
>  			goto err_mem;
> -		}
> -		cxl_mem[i] = pdev;
>  	}
>  
>  	for (i = 0; i < ARRAY_SIZE(cxl_mem_single); i++) {
> @@ -1753,12 +1752,9 @@ static int cxl_mem_init(void)
>  		pdev->dev.parent = &dport->dev;
>  		set_dev_node(&pdev->dev, i % 2);
>  
> -		rc = platform_device_add(pdev);
> -		if (rc) {
> -			platform_device_put(pdev);
> +		rc = cxl_mock_platform_device_add(pdev, &cxl_mem_single[i]);
> +		if (rc)
>  			goto err_single;
> -		}
> -		cxl_mem_single[i] = pdev;
>  	}
>  
>  	for (i = 0; i < ARRAY_SIZE(cxl_rcd); i++) {
> @@ -1772,12 +1768,9 @@ static int cxl_mem_init(void)
>  		pdev->dev.parent = &rch->dev;
>  		set_dev_node(&pdev->dev, i % 2);
>  
> -		rc = platform_device_add(pdev);
> -		if (rc) {
> -			platform_device_put(pdev);
> +		rc = cxl_mock_platform_device_add(pdev, &cxl_rcd[i]);
> +		if (rc)
>  			goto err_rcd;
> -		}
> -		cxl_rcd[i] = pdev;
>  	}
>  
>  	return 0;
> @@ -1869,13 +1862,10 @@ static __init int cxl_test_init(void)
>  			goto err_bridge;
>  
>  		mock_companion(adev, &pdev->dev);
> -		rc = platform_device_add(pdev);
> -		if (rc) {
> -			platform_device_put(pdev);
> +		rc = cxl_mock_platform_device_add(pdev, &cxl_host_bridge[i]);
> +		if (rc)
>  			goto err_bridge;
> -		}
>  
> -		cxl_host_bridge[i] = pdev;
>  		mock_pci_bus[i].bridge = &pdev->dev;
>  		rc = sysfs_create_link(&pdev->dev.kobj, &pdev->dev.kobj,
>  				       "physical_node");
> @@ -1893,12 +1883,9 @@ static __init int cxl_test_init(void)
>  			goto err_port;
>  		pdev->dev.parent = &bridge->dev;
>  
> -		rc = platform_device_add(pdev);
> -		if (rc) {
> -			platform_device_put(pdev);
> +		rc = cxl_mock_platform_device_add(pdev, &cxl_root_port[i]);
> +		if (rc)
>  			goto err_port;
> -		}
> -		cxl_root_port[i] = pdev;
>  	}
>  
>  	BUILD_BUG_ON(ARRAY_SIZE(cxl_switch_uport) != ARRAY_SIZE(cxl_root_port));
> @@ -1911,12 +1898,9 @@ static __init int cxl_test_init(void)
>  			goto err_uport;
>  		pdev->dev.parent = &root_port->dev;
>  
> -		rc = platform_device_add(pdev);
> -		if (rc) {
> -			platform_device_put(pdev);
> +		rc = cxl_mock_platform_device_add(pdev, &cxl_switch_uport[i]);
> +		if (rc)
>  			goto err_uport;
> -		}
> -		cxl_switch_uport[i] = pdev;
>  	}
>  
>  	for (i = 0; i < ARRAY_SIZE(cxl_switch_dport); i++) {
> @@ -1929,12 +1913,9 @@ static __init int cxl_test_init(void)
>  			goto err_dport;
>  		pdev->dev.parent = &uport->dev;
>  
> -		rc = platform_device_add(pdev);
> -		if (rc) {
> -			platform_device_put(pdev);
> +		rc = cxl_mock_platform_device_add(pdev, &cxl_switch_dport[i]);
> +		if (rc)
>  			goto err_dport;
> -		}
> -		cxl_switch_dport[i] = pdev;
>  	}
>  
>  	rc = cxl_single_topo_init();
> @@ -1953,9 +1934,9 @@ static __init int cxl_test_init(void)
>  	acpi0017_mock.dev.bus = &platform_bus_type;
>  	cxl_acpi->dev.groups = cxl_acpi_groups;
>  
> -	rc = platform_device_add(cxl_acpi);
> +	rc = cxl_mock_platform_device_add(cxl_acpi, NULL);
>  	if (rc)
> -		goto err_root;
> +		goto err_rch;
>  
>  	rc = cxl_mem_init();
>  	if (rc)

