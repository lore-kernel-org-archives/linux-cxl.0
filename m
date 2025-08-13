Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E351369B4;
	Wed, 13 Aug 2025 00:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755043379; cv=none; b=C7DltqI1H/uwr6yr85fiL3VkbovWC1uhdQ1C9KzUHJNzrsHuI+6SKDNV/2t5wU521Js/ORaLI0Rt89mMUNHuAto8BoY+hcDTTCrKtgzSUtuQ4scoybFkdFLZrzjXpERLjySoPYyIeoDe3wL0YlhnnCNZw9rU8XlR9Qz5CqY1BA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755043379; c=relaxed/simple;
	bh=zykA6qfry9bt4gf1nt2c1l5Y3AMskg+ea5JhzydUnWo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gAdpYI/tZzLHy+WE657w84jDjlFbN0ThHBxz9/HBlZkNraLm/JIaPlw7At14nomoUtvmyMBVYcILEWUQj7EPD4hXC+Tsk62WQlf8wo09tKHxVd/nr6/ZE7/5u0CHSEZ0gOfFnpzVcRvHzM7eCgeyxWzqx8d5/XoZfWjiMsR5iO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I8h79MLo; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I8h79MLo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755043377; x=1786579377;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zykA6qfry9bt4gf1nt2c1l5Y3AMskg+ea5JhzydUnWo=;
  b=I8h79MLoUxTko+k6/mY5k7DzPyTTNpmFlxIhqY+zjf1ilokKJDqaHeMu
   QneL43RWztkWcU6E7HKwSDFH6lSsjyBU1P9ceLP8KxytHhZl+ldazd0eL
   CgoW6pRaykXbw0RhF26VhUAvkihNF9RzHdRdIxDEwUOCuztTSgiE+8C31
   77CNJiqvaLwNJ7ZkUQbB+ol6vPZWIp6aedHR6B9DvLVONr0ixRwuljN9T
   4NpuwLpCKIRT+iO+o2cZ2GEcM3jlZuihSsbIfluBohfb9ieSmrIGWa0HV
   d1rGaAzqdxejMsV9E2OhgwyxApE3Aayh6DTCftHhPxMC9dDx9pBRuoVZV
   A==;
X-CSE-ConnectionGUID: X3gTB2ogThi9wWDNc1yO0w==
X-CSE-MsgGUID: L0OpIQXiRaWzobh61B1nPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="56538147"
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="56538147"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 17:02:55 -0700
X-CSE-ConnectionGUID: 8z9uwQqKQo2vr/TAm4u4Jg==
X-CSE-MsgGUID: 4qIjPp2VQWSq+ALy/BPT0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="165952315"
Received: from anmitta2-mobl4.gar.corp.intel.com (HELO [10.247.119.149]) ([10.247.119.149])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 17:02:50 -0700
Message-ID: <143f328f-52fb-41b2-9e46-08a390c3e47a@intel.com>
Date: Tue, 12 Aug 2025 17:02:45 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/region: use str_enabled_disabled() instead of tenary
 operator
To: Nai-Chen Cheng <bleach1827@gmail.com>, Davidlohr Bueso
 <dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev
References: <20250812-cxl-region-string-choices-v1-1-50200b0bc782@gmail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250812-cxl-region-string-choices-v1-1-50200b0bc782@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/11/25 9:49 AM, Nai-Chen Cheng wrote:
> Replace tenary operator with str_enabled_disabled() helper to enhance
> code readability and consistency.
> 
> Signed-off-by: Nai-Chen Cheng <bleach1827@gmail.com>

Applied to cxl/next. Spelling mistakes noted by Alison fixed.
733c4e9bcec9

> ---
>  drivers/cxl/core/region.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 71cc42d05248..83d58787b5af 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -10,6 +10,7 @@
>  #include <linux/sort.h>
>  #include <linux/idr.h>
>  #include <linux/memory-tiers.h>
> +#include <linux/string_choices.h>
>  #include <cxlmem.h>
>  #include <cxl.h>
>  #include "core.h"
> @@ -1468,9 +1469,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  				dev_name(port->uport_dev), dev_name(&port->dev),
>  				__func__, cxld->interleave_ways,
>  				cxld->interleave_granularity,
> -				(cxld->flags & CXL_DECODER_F_ENABLE) ?
> -					"enabled" :
> -					"disabled",
> +				str_enabled_disabled(cxld->flags & CXL_DECODER_F_ENABLE),
>  				cxld->hpa_range.start, cxld->hpa_range.end);
>  			return -ENXIO;
>  		}
> 
> ---
> base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
> change-id: 20250812-cxl-region-string-choices-f5aa9832346e
> 
> Best regards,

