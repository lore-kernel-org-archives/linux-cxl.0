Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793747208;
	b=4qHQRMT+rc1WzMkFCj1AKIaKqmqmF7oTp/rGLHkDpg+Kd+FOLK3GlhGpb9gvYhcL0rXM
	 yQU2A9/yaxelw99aJlXbFWoO8kXpb92VPJyqEueW8C6WCsssb3BcL8qgr9rM7unOasv9n
	 nDwfjeGiITP2GHRCAhHYwyEQakKZgTEnU9w8SojgwzpGUCkXliSp3bGyS1TXBcLkMfJ+8
	 ADCSKPyiCGruCU8Qux5boSMSJu6+WE32fiWXdwp9bTh0mIch7BBJX0VloWm0IquaygqT1
	 q8c9IvqsZ9l/ZC7THQNgD3lPsKf8KiVg99h2pNGpQ489XbHog9fmdQi3WeThX0LzxtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793747208;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=GHIpcBjMnAcZFN/GNEP5OYssSMpgfJrk2LI0yzC9sJI=;
	b=L1zixeNprh2vh6cg1OR4184Svb9kC6lgIyG45WWVfJ/5JtViVjCCV+f3CKzEoNZoTAB4
	 //7QmyNdHu4wf12HeJJqI0LqUXdE6MdJ5p2VTgoYL4BGvy++LDR0BVp3eS63yYqJZ/wbC
	 flqa4LYjlTXaoHu23aRcRwv5qL0MyT4ljIZ392+8Pvy+8Pqe8kDwR7WQcfjusSic1/816
	 nkbE6tsm/i2uKuMNIZLtqmp3uNzuAlW7vT7t6N6C36S8nTceF616Y7QkDf8xfBmhKcHRw
	 jfa6U8x4G2XyPbv0cKColuUMweCb5BPFWT2Th+KsqEvEjb4yPiubpw5Z8RBbG2idP4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XJ4GdCZm;
	arc=none smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94AE0606A31B
	for <linux-cxl@vger.kernel.org>; Tue,  3 Nov 2026 23:06:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94AE0606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XJ4GdCZm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793747203; x=1825283203;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8SLYf00QzUQlgnDsKgwvC/VkUN7DCT1xJKqvdC+Qq4E=;
  b=XJ4GdCZmuUr6FwKkrsyFkH7SWRwMaeMyE9loE2Ficz/nJoEXrgDCokx6
   sNRg0SrEo67RlczUQM0WwsM5ScZYkYIPbAFUqoiyCjIoU7JnUC4yv/N85
   xxtvslgt3AsQW9ePqlEPCufEL/Far5Vv3dfvocYCDeqA8bJ6ryXgxV/Yw
   iXrNVVGdDOIHRy0Igf8UOmkAJVz2VxM5thbvEs/lqMybbd4WGG/rgZqWM
   ouEKlHDZyshURYjfRZ+ir0kYnfM6xVFBBNiY7MVhKmZWtk3ULyGFIBPSX
   fskxXBnKycjxkpXl7R8a7wXj94zMcGFt5aKarSgnUx9jA754YngOpAue6
   A==;
X-CSE-ConnectionGUID: cmLe7ubaT1uyrMoRSW0XAw==
X-CSE-MsgGUID: QkPBgQSQQgyOzSG3OrMQmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2518108"
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="2518108"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 15:06:41 -0800
X-CSE-ConnectionGUID: 1DUdsu/6TyWMXAw14rTbcw==
X-CSE-MsgGUID: vilGeeIzQ1CH3h1kIkK+Ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="6939745"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.109.235]) ([10.125.109.235])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 15:06:39 -0800
Message-ID: <3dded9e7-4a0e-48bf-ade6-24953e99af90@intel.com>
Date: Tue, 3 Nov 2026 16:06:39 -0700
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

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

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

