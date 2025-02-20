Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EB82638AD;
	Thu, 20 Feb 2025 18:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740077864; cv=none; b=OshWQ4TE9EO9FQlDtmPhTte6GHwiOoFy5RMi89CfHBJWtLWGE368Snx3rbgyUhkW+qxudqZMXsedV7C5t2q4yvjh0jL/QqAS33JXMv3RMKBDBa4hakiWAxXbjYnHeKTPPp5maKMKYBj/k9A4saHWoWOlEwLTAaeXQxzMGM73cZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740077864; c=relaxed/simple;
	bh=zSrG59aoaEow+aaKtErqEiXfB8XXK57u995KZveihkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XFS2O0pjBPeFApgldqeBuV29pykShvtHWYCGnpCiLkWZgySIv08dcdrKd7c2wcLBM0AQPi6b+apWGEwVvbfjqYWLTsFROBeW/FhB4DrGlLPIYsw6RAdBHXkd91DnXzHl1pq5eFIFR21lKqPlSlMg49eAcWkgZrZW1eZuStPjh+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gvqFbohf; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gvqFbohf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740077863; x=1771613863;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zSrG59aoaEow+aaKtErqEiXfB8XXK57u995KZveihkc=;
  b=gvqFbohfu/WfF1WEIHovlSdX1hGWBtHdXMV7Xs131j9c03JEjUhAC4Sh
   Qx/bJWvG6Ht/uOQGH7FM+fhUKDQuLfhPGFXzt7MyDUyuS1Qrr2essrT9D
   ZeA5tk3ZdQcoci47XJqZnn05nyv8Bz5IBVMII+9BKc33Fg2DQLeHRZomd
   FmwY37aZGIrqAA9wqcGnJJd8O8KG1Pn1RCr6q0w2SFrshJae8KOEcKze8
   6nSMDAfS3DZjndoVmwAAdIn/Rdlj3J2VcgKm8NXq8GkTMWVqUibn/FVze
   uE6M4Vk6rPWEGGtEgTWLGBn5do7ieQc4AhXaJiH1tFrFcKcs/lWgbjAJ1
   w==;
X-CSE-ConnectionGUID: mEHnw4t0TzK6l5GUaGEFqg==
X-CSE-MsgGUID: KlmhYznqSCKZYOe3nO48sw==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="44658007"
X-IronPort-AV: E=Sophos;i="6.13,302,1732608000"; 
   d="scan'208";a="44658007"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 10:57:42 -0800
X-CSE-ConnectionGUID: ZJ30zw5iSx28IyrfslwqYA==
X-CSE-MsgGUID: QwPKbgULQnONMDh0TpEyWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,302,1732608000"; 
   d="scan'208";a="120110313"
Received: from puneetse-mobl.amr.corp.intel.com (HELO [10.125.110.112]) ([10.125.110.112])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 10:57:41 -0800
Message-ID: <7ab84fc9-2a1f-4737-a272-51adf4904d0a@intel.com>
Date: Thu, 20 Feb 2025 11:57:40 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/1] cxl/pmem: debug invalid serial number data
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 chenbaozi@phytium.com.cn
References: <20250219040029.515451-1-wangyuquan1236@phytium.com.cn>
 <20250219040029.515451-2-wangyuquan1236@phytium.com.cn>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250219040029.515451-2-wangyuquan1236@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/18/25 9:00 PM, Yuquan Wang wrote:
> In a nvdimm interleave-set each device with an invalid or zero
> serial number may cause pmem region initialization to fail, but in
> cxl case such device could still set cookies of nd_interleave_set
> and create a nvdimm pmem region.
> 
> This adds the validation of serial number in cxl pmem region creation.
> The event of no serial number would cause to fail to set the cookie
> and pmem region.
> 
> For cxl-test to work properly, always +1 on mock device's serial
> number.
> 
> Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>

Applied to cxl/next

> ---
>  drivers/cxl/pmem.c           | 12 ++++++++++--
>  tools/testing/cxl/test/mem.c |  2 +-
>  2 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
> index f9c95996e937..11c5a65acacf 100644
> --- a/drivers/cxl/pmem.c
> +++ b/drivers/cxl/pmem.c
> @@ -375,6 +375,16 @@ static int cxl_pmem_region_probe(struct device *dev)
>  			goto out_nvd;
>  		}
>  
> +		if (cxlds->serial == 0) {
> +			/* include missing alongside invalid in this error message. */
> +			dev_err(dev, "%s: invalid or missing serial number\n",
> +				dev_name(&cxlmd->dev));
> +			rc = -ENXIO;
> +			goto out_nvd;
> +		}
> +		info[i].serial = cxlds->serial;
> +		info[i].offset = m->start;
> +
>  		m->cxl_nvd = cxl_nvd;
>  		mappings[i] = (struct nd_mapping_desc) {
>  			.nvdimm = nvdimm,
> @@ -382,8 +392,6 @@ static int cxl_pmem_region_probe(struct device *dev)
>  			.size = m->size,
>  			.position = i,
>  		};
> -		info[i].offset = m->start;
> -		info[i].serial = cxlds->serial;
>  	}
>  	ndr_desc.num_mappings = cxlr_pmem->nr_mappings;
>  	ndr_desc.mapping = mappings;
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index 8d731bd63988..9e098cf06603 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -1533,7 +1533,7 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
>  	mds->event.buf = (struct cxl_get_event_payload *) mdata->event_buf;
>  	INIT_DELAYED_WORK(&mds->security.poll_dwork, cxl_mockmem_sanitize_work);
>  
> -	cxlds->serial = pdev->id;
> +	cxlds->serial = pdev->id + 1;
>  	if (is_rcd(pdev))
>  		cxlds->rcd = true;
>  

