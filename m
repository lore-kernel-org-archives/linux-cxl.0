Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666F41E009F;
	Tue,  3 Dec 2024 13:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733233299; cv=none; b=Qye4O0WtHXj2rnyOx6p26+0qeaI1e1M0T8oGBpS0uzxQ4+vu0gFAeJnca3OMC0mWaUBoADiM4EwnoBLbj3jG+gDUGpnOqLg5jTGBBKm90Zau//17VOEzGpokOmO7FfXowwZuAN0l2Vy+e+vCmvMBJyu/Do+Er0URG2kce/0m4fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733233299; c=relaxed/simple;
	bh=BFUTGSKYwpmQrNItOM3iPUHLJXb0xZtcnGzNjRiZ9xA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FhOOj/wLwwKb06/2lbpkIWGBabSeymjyBy5R6VFOdQrn17/wBIG3MJ5LQhcKpzw/0UYZjsQP4rgsIdy0h0+RmwNMBNpEYSjJHKrxL6D7ts+az3s0b8ASTnD/oBumx5T0vslSUZ0ThfOXgecOKy5TegrTf1+6xL9344Mp42lxiKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SuPNq+Mt; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SuPNq+Mt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733233297; x=1764769297;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BFUTGSKYwpmQrNItOM3iPUHLJXb0xZtcnGzNjRiZ9xA=;
  b=SuPNq+Mt9n2Ut0ZmbjKtWv2555CYfgjJh0So7lxT/mKa5tKhJh2tAZHg
   l0fHgeHqDB3mMnkHyIUAOmrCSx3LpB05pj0b9/UqobVTvkS8O3XI+Cb90
   voiBAfVrQELtDtKtYjx4oosfHy01/ZQ8qJTTvIwOhPVkAIP+Mh1A6qq/q
   XrSqVRNsdI/6gnmSwMHlCuhD6dCjMdrjWWuIkWdb5ZICG6kJa8XNYaMmo
   wfFkoHRZlAlwpCdnCp+S7JS59bNuVQiovKXUrGxJHqZkOrWHHIyRkuoMW
   I7Diy8E83iDw0dhoEHEAnj34EZzBSM6bhlSpKtf57+RqomtYWPh9Pntjs
   w==;
X-CSE-ConnectionGUID: DRQ17aJdT0ucypZIoFYorw==
X-CSE-MsgGUID: Rrw51WZnRCqzQNVA6vlY2A==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="33191241"
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="33191241"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 05:41:37 -0800
X-CSE-ConnectionGUID: Xt3N8INIQTangqT1Z3zb0w==
X-CSE-MsgGUID: GBHzDLcxQxml9A+qka5abA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="93345181"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 05:41:33 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tIT9c-00000003S1o-3KHu;
	Tue, 03 Dec 2024 15:41:28 +0200
Date: Tue, 3 Dec 2024 15:41:28 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Huang, Ying" <ying.huang@linux.alibaba.com>
Cc: Raghavendra K T <raghavendra.kt@amd.com>, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, bharata@amd.com,
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
Message-ID: <Z08KiPwwiw72Vo9R@smile.fi.intel.com>
References: <20241202111941.2636613-1-raghavendra.kt@amd.com>
 <87frn5wac3.fsf@DESKTOP-5N7EMDA>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87frn5wac3.fsf@DESKTOP-5N7EMDA>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Dec 03, 2024 at 02:26:52PM +0800, Huang, Ying wrote:
> Raghavendra K T <raghavendra.kt@amd.com> writes:

...

> > git bisect had led to below commit
> > Fixes: b4afe4183ec7 ("resource: fix region_intersects() vs add_memory_driver_managed()")
> 
> This breaks you case, sorry about that.  But this also fixed a real bug
> too.  So, it's not appropriate just to revert it blindly.

Linus was clear about this recently. Even if it fixes a bug, regression is
still regression and might (*) lead to a revert.
https://lwn.net/Articles/990599/

(*) in general fixes are better than reverts, but depends on the timing in
    the release cycle the revert may be the only option.

-- 
With Best Regards,
Andy Shevchenko


