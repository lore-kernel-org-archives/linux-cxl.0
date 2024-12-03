Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFB11DF27E;
	Tue,  3 Dec 2024 22:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733263678; cv=none; b=J/X0HF7RDDVplk0hK9FdfI4M3gVBCQdS+5daPzZVsxWiY0XNjRef4QeRPoAD4CWBmeyhNzogAlJ+11PtJ/QZq7yNb85VgNyqtwoz0jsckt2mE6oVTSnrwVvZfNFU85g8PIF1cwnt1J3vL4HqVan2Z+I6MzQkPcj92aTppmyc93c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733263678; c=relaxed/simple;
	bh=cWABRbRQSTNoxmBHCIL/kN00v2PronTcxiPovf7NaeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CpvSWneaLok2Ft15jdUmDf1TkLVLBwxVH4Y1A4RidH0len8AWMYrv2j9sZ3OaCTN9V+6nsI6WI2FDro512E3mhweDaW67Vkp7QCQTdDIDMRVXijR7bFBXVRYo05XTm2a78m0A4P8qQ/QL4OL+Jdc72w8cMuyyWvLuYZBc+CEgT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZXkgnWoT; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZXkgnWoT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733263677; x=1764799677;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=cWABRbRQSTNoxmBHCIL/kN00v2PronTcxiPovf7NaeU=;
  b=ZXkgnWoT3kNqB5xbCbcEtfbGKLfEGl9X6yrBfXvqcoPbw3bX47MdEWkU
   +8XUozAzy8P8d0GcAUh3XjMGGFI/xOOH+YM552bg31m/8v4mIHetLJ9I1
   cYdw8lHMcZa6k3LTGSoq82RtXq5kMC6q1vSZh+K//RvcDZUIl1jVFhAxy
   +AzJ1WLsssAMVAJM+cJZ5Cb0c3p9ltAVYsw+1pYUFengqHQKFaUzQ0P4g
   Ft+0ZzglhCrCIVq7Y4mJdD5FRiSzCbqwusTKoGV49ZK1JLpfTyzt+0QG1
   Jbrk4oXvDqEbQKiQaAK05BwGQ+cZR/l8onQZvjPq+BA5vQDkaOmMB3sd0
   A==;
X-CSE-ConnectionGUID: paH+9+b+QmOXnnFUVGORlg==
X-CSE-MsgGUID: gicE8YHyRBSg6ZDJLAtihg==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="33251832"
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="33251832"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 14:07:56 -0800
X-CSE-ConnectionGUID: AXxz1y0iQMK94dgoYoc3/w==
X-CSE-MsgGUID: p2dcZNoTShS9j6wvmAXuzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="98649053"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 14:07:51 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tIb3b-00000003Z0g-2xww;
	Wed, 04 Dec 2024 00:07:47 +0200
Date: Wed, 4 Dec 2024 00:07:47 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Gregory Price <gourry@gourry.net>
Cc: "Huang, Ying" <ying.huang@linux.alibaba.com>,
	Raghavendra K T <raghavendra.kt@amd.com>,
	linux-kernel@vger.kernel.org, linux-cxl <linux-cxl@vger.kernel.org>,
	Bharata B Rao <bharata@amd.com>,
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
Message-ID: <Z0-BM5KcS9PQcycg@smile.fi.intel.com>
References: <20241202111941.2636613-1-raghavendra.kt@amd.com>
 <87frn5wac3.fsf@DESKTOP-5N7EMDA>
 <Z08KiPwwiw72Vo9R@smile.fi.intel.com>
 <CAAt7c_piFt2UY_OSzdhhr3yFfgMZPgcw2ogtAoVRjgDFGaG_8Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAt7c_piFt2UY_OSzdhhr3yFfgMZPgcw2ogtAoVRjgDFGaG_8Q@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Dec 03, 2024 at 11:56:35AM -0800, Gregory Price wrote:
> On Tue, Dec 3, 2024, 6:09 AM Andy Shevchenko <
> andriy.shevchenko@linux.intel.com> wrote:
> > On Tue, Dec 03, 2024 at 02:26:52PM +0800, Huang, Ying wrote:
> > > Raghavendra K T <raghavendra.kt@amd.com> writes:

...

> > > > git bisect had led to below commit
> > > > Fixes: b4afe4183ec7 ("resource: fix region_intersects() vs
> > add_memory_driver_managed()")
> > >
> > > This breaks you case, sorry about that.  But this also fixed a real bug
> > > too.  So, it's not appropriate just to revert it blindly.
> >
> > Linus was clear about this recently. Even if it fixes a bug, regression is
> > still regression
> 
> In my experience, region intersection issues often stem from bad CEDT
> entries.

Yeah, sometimes fixes may reveal the hidden issues.

> Have you dumped the ACPI tables on your system and validated the content?

I believe this is the Q to the original reporter.

> It would be a shame to revert a patch because the ACPI tables were wrong.

I agree with you and as I said in my reply "fixes are better than reverts".
I.o.w. I'm on the same page with Linus on this.

-- 
With Best Regards,
Andy Shevchenko


