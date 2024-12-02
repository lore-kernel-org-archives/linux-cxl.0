Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB77208986;
	Mon,  2 Dec 2024 15:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733153669; cv=none; b=I5IEIeddF+Tnh4Bp1iW6lxp+yJdO7Is0mkf/EjTFWANywEdGMnyZImPw6GfVAtjl51pfNZ8o/yr3E230dpfGNBJEi9sjGe8+q/5cA9qj0v4KiEKb17iT7vkThYJ2oTG+NS6lXgCIxpInz5N1EF2VPynoo5g7SmY1c8v57fnK3w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733153669; c=relaxed/simple;
	bh=0aiCO6irx3KjpiEsB3bMtihBZzkRX+giqdpY7eyHggw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dH8cPD72siwkWZSj0bI74UQmJOsbubwpy3MuKlJEb8IPNr1ddso6bsajrUYCe3dtulcK64CqlCTQ4wc3x+ExVJXn84W1pxT5cKnNpBoCJ35uqAnaeld7wAD9sO03oKzBEKidjjnWanuIYblsacURHqZWuOkrrBXgnaZhXroogJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gZwElVFG; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gZwElVFG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733153667; x=1764689667;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0aiCO6irx3KjpiEsB3bMtihBZzkRX+giqdpY7eyHggw=;
  b=gZwElVFG02QsRTkPuZaXi1Q6ASaCvY23AbHtTIWCiBZawU2oIAecVzZR
   BOSUEYH/TyRsH3YFU07g+n514TCsK8VTvb52VGXBWI8opgB/3FvGKCGZv
   ajWRs+fIGmucSLuJs3DuW84v4lRovPfz8oW2Qo/Sr80sR5aXxCCdtAZgA
   tn77uq5ZO9n1THR3+x4gxj5iN5xZ8lIuIVxJ8mUIu7YxEqEF2/5bUz2tj
   MaiE3SyT6I00byTpnp+P6ivrRDOIxaz/Jn8Bb1EjboZlyJWvv9KBI4zGL
   zGbds0RpSt6NMQiIuSMpiPDkuF99LE16sja+8DJv6t4vMn0UYLB2Dr8m9
   A==;
X-CSE-ConnectionGUID: cFVne9mSRbyGtehbHOp+8A==
X-CSE-MsgGUID: PQks5q8+RKmspFBSeATS/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="20918669"
X-IronPort-AV: E=Sophos;i="6.12,202,1728975600"; 
   d="scan'208";a="20918669"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 07:34:26 -0800
X-CSE-ConnectionGUID: BBV3fdIoRricTQUUZTjVMQ==
X-CSE-MsgGUID: cyEI96nyQKK9gUkxcru1+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,202,1728975600"; 
   d="scan'208";a="93528245"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 07:34:22 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tI8RG-00000003BDo-0brw;
	Mon, 02 Dec 2024 17:34:18 +0200
Date: Mon, 2 Dec 2024 17:34:17 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Raghavendra K T <raghavendra.kt@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	bharata@amd.com, Huang Ying <ying.huang@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	David Hildenbrand <david@redhat.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Alistair Popple <apopple@nvidia.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Baoquan He <bhe@redhat.com>,
	ilpo.jarvinen@linux.intel.com,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Fontenot Nathan <Nathan.Fontenot@amd.com>,
	Wei Huang <wei.huang2@amd.com>
Subject: Re: [RFC PATCH] resource: Fix CXL node not populated issue
Message-ID: <Z03TeSrlI_8y4j89@smile.fi.intel.com>
References: <20241202111941.2636613-1-raghavendra.kt@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202111941.2636613-1-raghavendra.kt@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Dec 02, 2024 at 11:19:41AM +0000, Raghavendra K T wrote:
> Before:
> ~]$ numastat -m
> ...
>                           Node 0          Node 1           Total
>                  --------------- --------------- ---------------
> MemTotal               128096.18       128838.48       256934.65
> 
> After:
> $ numastat -m
> .....
>                           Node 0          Node 1          Node 2           Total
>                  --------------- --------------- --------------- ---------------
> MemTotal               128054.16       128880.51       129024.00       385958.67
> 
> Current patch reverts the effect of first commit where the issue is seen.
> 
> git bisect had led to below commit

Missed blank line here.

> Fixes: b4afe4183ec7 ("resource: fix region_intersects() vs add_memory_driver_managed()")

> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Alistair Popple <apopple@nvidia.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: <ilpo.jarvinen@linux.intel.com>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: Fontenot Nathan <Nathan.Fontenot@amd.com>
> Cc: Wei Huang <wei.huang2@amd.com>

Isn't it too many to be included in the commit message? Note you may use the
same list with --cc in the command line with almost the same effect (almost --
no noise in the commit message).

> Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>
> ---

...

> +		bool is_type = (((p->flags & flags) == flags) &&
> +				((desc == IORES_DESC_NONE) ||
> +				 (desc == p->desc)));
> +
> +		if (resource_overlaps(p, &res))
> +			is_type ? type++ : other++;

Instead (if you will end up with this approach) please still use is_type_match().

-- 
With Best Regards,
Andy Shevchenko


