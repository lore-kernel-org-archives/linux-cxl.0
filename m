Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BCF3B7B84
	for <linux-cxl@vger.kernel.org>; Wed,  1 Jul 2026 07:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782891110; cv=pass; b=Nj9I+02RbYnpBCwy6hiHQhDAhCcHA6zKnFjPhR5pWy1xEEsEz9iygeQVr/ANH9qMVChxJ78r4JqMC2Jp0PizRz3EjfqGtrVcoqkrMrEoKdxD/AC/0y6sGv1HV9Iio51X9eghguanK8Qsl6P7IktOMCM230skQDgPHzi4nEnFysE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782891110; c=relaxed/simple;
	bh=a4dMXjwSQ0zKb8jt5Hx5kg3SFFcJmUIvsfaXwGREE0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qmwdsCnifsjEjyewsE929Zua6ALJs9nm/xikn68TepCpAKHG/sE5FVoFHY1J7P1g8llENJEsPc78DmjsnD9utOnCoJFcgErNMg2b7pWlB26UT4bDa3vBe0d2UDSOkVOoV9dPy+nxUE2RejXsFcel5ylayy4w2W+ktwbw/SSNLU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=C/MfTKXj; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="C/MfTKXj"
ARC-Seal: i=1; a=rsa-sha256; t=1782891101; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=UrczUpkzFuBrk/JtvtJqknH4ZPHFbBK0b1+beHfTR33iDZyjHFnnHApmhAndJ6ui3JYdeyWrCRAb5Z2dLwCQHv403FDDUFppDhQgZvwwIYR90MlxQYZKivAJ8bPlIa/dj5Q85qol4LxnFXtV0jxWckQmym7zU3EwPVZwfu38ILY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1782891101; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=y5NKAPlTHRf3qUe1/padh5jxe0G8PbiWqmCfbQqqzpc=; 
	b=Rd1+ieigldewS6BBx3fQQ2Er/sx8Oq5q71ciptUCnfhRdZ4R0ho4HCIM1GUQSA/MZUrZe9+GpmYb1SRwo53uEP8ObxVstWx20IGQW/TDikGXbKtsSchmSlV9NHON88o4dTiXkiTiSaiiLKmumtCHHO0DHteKCgfP1zAjSdYbVRI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1782891101;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=y5NKAPlTHRf3qUe1/padh5jxe0G8PbiWqmCfbQqqzpc=;
	b=C/MfTKXjq0hXsn+/XjffD2Exz3hPjUfxaakbG5ifmmo2SeDIZN0NOXq51CfKEtN5
	k8iGKIsclNNlp5hcm85DSpOPIY8bzANx5YTnp0cRqJ2w9oD7W3fbqVuxZnZrJLaNPpp
	e0zslLhva02fNNhiywZhoKUSolnlxPcad6bvh1Ko=
Received: by mx.zohomail.com with SMTPS id 1782891098545557.6862467021632;
	Wed, 1 Jul 2026 00:31:38 -0700 (PDT)
Message-ID: <e0ef1308-f26a-4869-b5d4-5d14db539973@zohomail.com>
Date: Wed, 1 Jul 2026 15:31:34 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/7] cxl/test: Add hierarchy enumeration support for
 type2 device
To: Dave Jiang <dave.jiang@intel.com>
Cc: djbw@kernel.org, dave@stgolabs.net, jic23@kernel.org,
 alison.schofield@intel.com, vishal.l.verma@intel.com,
 linux-cxl@vger.kernel.org
References: <20260629221104.3891733-1-dave.jiang@intel.com>
 <20260629221104.3891733-5-dave.jiang@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20260629221104.3891733-5-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: zu0801122752ad6574dfeede51f69fe4e30000dca268a6963fdc55d66a6600d85d2d6d75a321590bda4d5e47:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External

On 6/30/2026 6:11 AM, Dave Jiang wrote:
> Add enumeration of type2 device hierarchy in cxl-test. The type2 device
> is setup to be directly attached to a root port instead of rp -> switch
> -> device that type3 hierarchy is setup..
>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v7:
> - Replace platform_device_put() with platform_device_unregister(). (sashiko)
> ---
>  tools/testing/cxl/test/cxl.c | 238 ++++++++++++++++++++++++++++-------
>  1 file changed, 192 insertions(+), 46 deletions(-)
>
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 8abe066080bc..801d42ac1bad 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -28,6 +28,7 @@ static bool type2_test;
>  #define NR_CXL_SWITCH_PORTS 2
>  #define NR_CXL_PORT_DECODERS 8
>  #define NR_BRIDGES (NR_CXL_HOST_BRIDGES + NR_CXL_SINGLE_HOST + NR_CXL_RCH)
> +#define NR_CXL_TYPE2_ACCEL 1
>  
>  #define MOCK_AUTO_REGION_SIZE_DEFAULT SZ_512M
>  static int mock_auto_region_size = MOCK_AUTO_REGION_SIZE_DEFAULT;
> @@ -1747,19 +1748,93 @@ static void cxl_single_topo_exit(void)
>  	}
>  }
>  
> +static void cxl_type3_mem_exit(void)
> +{
> +	struct platform_device *pdev;
> +	int i;
> +
> +	for (i = ARRAY_SIZE(cxl_rcd) - 1; i >= 0; i--) {
> +		pdev = cxl_rcd[i];
> +		if (!pdev)
> +			continue;
> +		platform_device_unregister(cxl_rcd[i]);
> +	}
> +
> +	for (i = ARRAY_SIZE(cxl_mem_single) - 1; i >= 0; i--) {
> +		pdev = cxl_mem_single[i];
> +		if (!pdev)
> +			continue;
> +		platform_device_unregister(cxl_mem_single[i]);
> +	}
> +
> +	for (i = ARRAY_SIZE(cxl_mem) - 1; i >= 0; i--) {
> +		pdev = cxl_mem[i];
> +		if (!pdev)
> +			continue;
> +		platform_device_unregister(pdev);
> +	}
> +}
> +
> +static void cxl_type2_mem_exit(void)
> +{
> +	for (int i = NR_CXL_TYPE2_ACCEL - 1; i >= 0; i--) {
> +		struct platform_device *pdev = cxl_mem[i];
> +
> +		if (!pdev)
> +			continue;
> +		platform_device_unregister(pdev);
> +	}
> +}
> +
>  static void cxl_mem_exit(void)
>  {
> -	int i;
> -
> -	for (i = ARRAY_SIZE(cxl_rcd) - 1; i >= 0; i--)
> -		platform_device_unregister(cxl_rcd[i]);
> -	for (i = ARRAY_SIZE(cxl_mem_single) - 1; i >= 0; i--)
> -		platform_device_unregister(cxl_mem_single[i]);
> -	for (i = ARRAY_SIZE(cxl_mem) - 1; i >= 0; i--)
> -		platform_device_unregister(cxl_mem[i]);
> +	if (type2_test) {
> +		cxl_type2_mem_exit();
> +		return;
> +	}
> +
> +	cxl_type3_mem_exit();
> +}
> +
> +static int cxl_type2_mem_init(void)
> +{
> +	int i, rc;
> +
> +	for (i = 0; i < NR_CXL_TYPE2_ACCEL; i++) {
> +		struct platform_device *dport = cxl_root_port[i];
> +		struct platform_device *pdev;
> +
> +		pdev = platform_device_alloc("cxl_type2_accel", i);
> +		if (!pdev) {
> +			rc = -ENOMEM;
> +			goto err_mem;
> +		}
> +		pdev->dev.parent = &dport->dev;
> +		set_dev_node(&pdev->dev, i % 2);
> +
> +		rc = platform_device_add(pdev);
> +		if (rc) {
> +			rc = -ENOMEM;
> +			platform_device_put(pdev);
> +			goto err_mem;
> +		}
> +		cxl_mem[i] = pdev;

Hi Dave,

Sorry for the delayed review.

I think that we should use cxl_mock_platform_device_add() helper here when adding the device, otherwise it may hit the issue resolved by the patch[1].

If we confirm that we need to use the helper here, I can send out a fixup patch for this, or you can make the change directly.


Ming

[1]: https://lore.kernel.org/all/20260520121457.234404-1-ming.li@zohomail.com/


