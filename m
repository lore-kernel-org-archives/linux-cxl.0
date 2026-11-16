Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794867177;
	b=36PJKPAJPyhHpCQyS1xc+D69KpPs4OuE8s/V9NoS95+azaOkmoz+3tZXheOPHqJWe1Qr
	 sWpML5iTrikHqjOTAYNjPpl+nBWNz1xbUbNP32AkYP18nOVN0pK2TcFG3gFgr/rPSBz8x
	 7TbQVSInCCv8jW7MwKywmtQjTN8VTUC3Ef/iiK0RYZ6E7xrPkM89TZ23Ug+26omqKJIV4
	 VVGjIVsyhllp2bdQnF162gjIWs1UJbUasPLTbmxNZL2kM5Q8iUttgV7Fml4JzpOfxRums
	 H5GO7P5+Z3/c8RfPDMkpuzFPf8Y7zPNFrtZ/Y6MekW7mOIkLc1LeeIqvsqvMKj2RPEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794867177;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=dSuwk8KSGmX+iouxJ1Hhu3LtWrIADO5P02FHss8JOm4=;
	b=kftdfEsHXhL96SeKjJsw3K73ue5L4+TFVfGBgVaJFfaE08idUnsTfqy7b8VUeszc1bC3
	 mIu1k0ykW5+rpY2rWaTUdql6+Y3zPQ/Qdj1JeK1ULxmNkanw8IZjv7cJdHsHkOCzIFNQw
	 OQVeFIw8UXyFlGXhZlxRnmiLHhbEzZQzdfJQMCTCve0shQ939Bf/0y5n79pKRgBgEG6FF
	 MW98Ml5XW3XaOoEt0yU6kV19APmk8qErX354jnyFhk/TsQ1Af00cbAkIhwE9uOaiDaJZZ
	 PbI/xjEQFCo9aOgD632dT8Wh06CIn2jxUijTyAbwYdhVvXy/VxwXz70c0Hu8qbO0cBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=feS59DAK;
	arc=none smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46703606A31C
	for <linux-cxl@vger.kernel.org>; Mon, 16 Nov 2026 22:12:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46703606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=feS59DAK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794867177; x=1826403177;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=21oGg5VhhAz1RqqyeVcOLc/Pys3jbLofzeHswNxL4KQ=;
  b=feS59DAKgUNXSvJycoSHgB+jVF87I1CI6iPkdf+r0sjZq9kszhMc57fl
   crbzq5RVs2OjgZtt8uGKXIYEggoSdmtNJmkb5x+hBgJEowbePuJPIwwCE
   x0dQX/mFF5/WSAasN1AD285yUAqMLfpHLRt5GujBwzAdVeQar070Zc4km
   hTCr8i2M3vA/VoF1vBWTdEch5tZwPX6gSMFK035mqXOn6eK1tRbKJnzG1
   d1SLaSC5a5lu2rO4gEZfo//MQ/nRvNaHFHU3pVMZMr6EvyXfusYh+pnLV
   +MYVnqNuey1sTCa7PVvXta1pVF4T0VCqNX5LyvrFOxnikE7R3Xf+K9bwL
   Q==;
X-CSE-ConnectionGUID: dbE6kEnmSkS8ay3q8K99vg==
X-CSE-MsgGUID: SVmuAQ1FSR+GAX/9BvjKBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3637110"
X-IronPort-AV: E=Sophos;i="6.27,217,1787036400"; 
   d="scan'208";a="3637110"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 14:12:57 -0800
X-CSE-ConnectionGUID: f1hGh9tfSM+2PEqXRJp7ng==
X-CSE-MsgGUID: UBExoHUPSmi1oGa4yZiLNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,217,1787036400"; 
   d="scan'208";a="9641710"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.108.118]) ([10.125.108.118])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 14:12:56 -0800
Message-ID: <bb4de306-58e1-4e37-96bb-d211dae984e9@intel.com>
Date: Mon, 16 Nov 2026 15:12:55 -0700
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] cxl/region: Reject a repeat write of an endpoint
 decoder to targetN
To: Alison Schofield <alison.schofield@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>,
 Li Ming <ming.li@zohomail.com>, Richard Cheng <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
References: <e8235faea3d75dbfd45f197fe657c467b6259705.1793724885.git.alison.schofield@intel.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <e8235faea3d75dbfd45f197fe657c467b6259705.1793724885.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/3/26 10:07 AM, Alison Schofield wrote:
> Writing an endpoint decoder to a region targetN attribute that already
> holds it returns -EBUSY, but leaves the partially populated region in an
> inconsistent state. The targetN attribute still names the decoder, so the
> failed write gives no indication that the region was damaged.
> 
> Filling the remaining target positions can then trigger a NULL pointer
> dereference in cxl_region_setup_targets(). This can be reproduced through
> sysfs:
> 
>     echo $decoder > /sys/bus/cxl/devices/region0/target0
>     echo $decoder > /sys/bus/cxl/devices/region0/target0
>     echo $other_decoder > /sys/bus/cxl/devices/region0/target1
> 
> An existing check recognizes the repeated assignment but incorrectly allows
> the attachment to proceed, damaging region state. Remove that check so the
> repeated write is rejected without disturbing the existing attachment,
> consistent with the documented targetN ABI.
> 
> Fixes: 9995576cef48 ("cxl/region: Move region-position validation to a helper")
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Applied to cxl/fixes (only this patch, not 2/2)
b8183f9259b5

> ---
> 
> Note: cxl_region_perf_data_calculate() currently updates region performance
> data before attachment validation completes. This is a pre-existing issue
> that will be addressed separately.
> 
> Changes in v4:
> - Drop the added useless check in cxl_region_attach() (Sashiko)
>   The pre-existing occupied position check already returns -EBUSY.
> v3: https://lore.kernel.org/linux-cxl/3e5af9d6d59f8df52b9d21bcf1c7e78f06918f80.1793653629.git.alison.schofield@intel.com/
> 
> Changes in v3:
> - Reject repeat writes with -EBUSY, consistent with the documented ABI
> - Rebase on 7.4-rc1
> v2: https://lore.kernel.org/linux-cxl/920d80735a449f93a1f17a8bca4c25e4b302cb42.1792989098.git.alison.schofield@intel.com/
> 
> Changes in v2:
> - Preserve the successful no-op behavior for repeated writes (Jonathan)
> - Correct the Fixes tag
> v1: https://lore.kernel.org/linux-cxl/94e9157aac2e99df1251d733769d539b914fdefc.1790829690.git.alison.schofield@intel.com/
> ---
>  drivers/cxl/core/region.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index a048bd5c06cb..f42c6b6e3213 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1764,9 +1764,6 @@ static int cxl_region_validate_position(struct cxl_region *cxlr,
>  		return -ENXIO;
>  	}
>  
> -	if (p->targets[pos] == cxled)
> -		return 0;
> -
>  	if (p->targets[pos]) {
>  		struct cxl_endpoint_decoder *cxled_target = p->targets[pos];
>  		struct cxl_memdev *cxlmd_target = cxled_to_memdev(cxled_target);
> 
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4

