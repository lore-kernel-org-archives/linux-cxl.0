Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FF131196B;
	Wed,  1 Oct 2025 21:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759354124; cv=none; b=QWUMpT0EB3UhPvOeivrXduKVcMP5IXWvn8yf8WmQZrD/pGoEQreozXgGtNdm/ABv4K34inoIAvxb/k8aZtxgPzSpqyUfXwVcd2pWG/IkXL/7m1PClM2oolaLqPeGFywBPJC6H5Mm6tVzCUMYIiLZkg0YyGWdGlBHi2TvGg4lsHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759354124; c=relaxed/simple;
	bh=n4LF0JbF8KL2ASozmucI9reeOGqYm+jFVV7kHoj9sqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AQd5BqsJ6mAM0fUGhRCuka4i8ltMVN33MRDq1Dk5CDIy3Ql1JxZhjLK3l4qAYxVRaAVDCMMPnmzAc5JQrgActDDCPJb+Gq146FImsX+WlUCUQsfdPxvgXH5pXeytodlVVkBv5mqavLkbrVE+iglI2ZS1iyUP78pSrKpDGSOPs3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hb0CyUEP; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hb0CyUEP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759354122; x=1790890122;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=n4LF0JbF8KL2ASozmucI9reeOGqYm+jFVV7kHoj9sqs=;
  b=Hb0CyUEPtmD3C3AaECeLcjTJYeBeVUjNY3Kc2Hf8oWRDW6CJrHQeEcGL
   ivmxt6zTTkhPnTTY8G0A3rMI+ru2Z+TVR5b2S4uVUVrKfjirc9Lun9Y07
   V6u0di8zaatvFEya1H4+PhdOfPTevZULe7Hx/iD1SbM5kJ35ZCmQaQxQp
   3SvQjlAqL6JqMpnwB8RiawhkhInlQD08w6yBFXMy32Gs/X6UtxcAwaw1P
   1QMa/lvHdClkp6BhO+W3iiR5zSDsgpI3LJ9haxfrkyHagyxCRRDieCAzJ
   ZczSxUwGhFgRlrbIEIEoWcmex0w594MsGrQgW3IbtSazceKkSL+Ph1FrT
   w==;
X-CSE-ConnectionGUID: eje2vKWWQB2HydwLqPo1fA==
X-CSE-MsgGUID: tTfYoX16S4KUPsjSKSyJIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="61529272"
X-IronPort-AV: E=Sophos;i="6.18,307,1751266800"; 
   d="scan'208";a="61529272"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2025 14:28:41 -0700
X-CSE-ConnectionGUID: G11fCUXyQn+EKb8XSG7nKg==
X-CSE-MsgGUID: RYjAI3edRRyhUQAkp3KQNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,307,1751266800"; 
   d="scan'208";a="178923010"
Received: from tfalcon-desk.amr.corp.intel.com (HELO [10.125.109.218]) ([10.125.109.218])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2025 14:28:40 -0700
Message-ID: <cb300580-1297-4d4b-9a3a-2cf7445b739b@intel.com>
Date: Wed, 1 Oct 2025 14:28:39 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/hdm: allow zero sized committed decoders
To: Vishal Aslot <vaslot@nvidia.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Li Ming <ming.li@zohomail.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Zijun Hu <zijun.hu@oss.qualcomm.com>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <SN7PR12MB81316C958DF0F4B10369B928BBE6A@SN7PR12MB8131.namprd12.prod.outlook.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <SN7PR12MB81316C958DF0F4B10369B928BBE6A@SN7PR12MB8131.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/1/25 1:37 PM, Vishal Aslot wrote:
> Signed-off-by: Vishal Aslot <vaslot@nvidia.com>

Missing commit log?

> ---
>  drivers/cxl/core/hdm.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index e9e1d555cec6..97a5f27f5b72 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> -/* Copyright(c) 2022 Intel Corporation. All rights reserved. */
> +/* Copyright(c) 2022-2025 Intel Corporation. All rights reserved. */

Stray change?

>  #include <linux/seq_file.h>
>  #include <linux/device.h>
>  #include <linux/delay.h>
> @@ -1050,7 +1050,7 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>                         dev_warn(&port->dev,
>                                  "decoder%d.%d: Committed with zero size\n",
>                                  port->id, cxld->id);

I wonder if we should make this dev_dbg() now that it's a valid case.

> -                       return -ENXIO;
> +                       return -ENOSPC;
>                 }
>                 port->commit_end = cxld->id;
>         } else {
> @@ -1210,6 +1210,11 @@ int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
>                 rc = init_hdm_decoder(port, cxld, target_map, hdm, i,
>                                       &dpa_base, info);
>                 if (rc) {
> +                       if (rc == -ENOSPC) {
> +                               put_device(&cxld->dev);

Why put_device()? Should we enumerate this decoder instead of pretend it doesn't exist? essentially only a dev_set_name() and device_add()?

> +                               rc = 0;

Don't think this is needed since the continue will put it at start of the loop where rc gets written by init_hdm_decoder() return value.

> +                               continue;
> +                       }
>                         dev_warn(&port->dev,
>                                  "Failed to initialize decoder%d.%d\n",
>                                  port->id, i);
> --
> 2.34.1

