Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BD3130E2D
	for <linux-cxl@vger.kernel.org>; Fri, 29 Mar 2024 17:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711734216; cv=none; b=ufT10tcWLgxfOYNAF9QZFvq6RVlzHCg/FPwba8n9rYOLvRpDGfY5vyjgLuSRL5Qw1h7LXq+s3SeVeDf0SsKdi9YlskbZlNJU9J5Yofed+WRt9C6ZExkc9QQsw9n/ei0aTAtpZD8nHD+HNpR6btQvgn2IVeAPxBxEIz8RbboyeLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711734216; c=relaxed/simple;
	bh=8+m0+9kTXHDmzApqownqXccYvxDRzk9RZtXpnSr/xMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DrFvE5t7QLSTnWsrJJEyh+260HGkIHrq4pM36/QAG/L2kY3JhvG6LKov8NjYNQBg9jZuXvdl3kCMWTl/DVhqqRzGvbMIJ+fsQ6DfeZkzSDZovlDCcz4J7vllde3+DwIG0WsRAbln3JgfD+La8v/sfcY4F0/ivLWoBYf/cjKdlR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RCHuCVFr; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RCHuCVFr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711734215; x=1743270215;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8+m0+9kTXHDmzApqownqXccYvxDRzk9RZtXpnSr/xMs=;
  b=RCHuCVFrT44p5kA4FbNtSljbW479KTch8qSnCC6i7UenLHox/D+6638/
   U6mgKxN7qbySN2VSG+y8sI527GWmPpggjsAh7YDPRbocEOsqJkTBdpPrg
   wS5v693DMv9qp1SzKicqM46G6xD+E6/M73KjxEKf7/htucExwr+yRO4TQ
   LYftX76JLgjwyNkbZFexzZGm44gcDKuyt7nvFwfoZHNc4o/H8ndUBd3cj
   UgGD+lvId7Y1C26ss1DNgiHBsk6+r4rV25UhcIEyXkL6YMhWDgB8Sqjdl
   nRsXdmVu1aYbRrNz+DpFcLynFKNaWa+X0RpFIH5xO3FSFBv/s1RxVANWP
   A==;
X-CSE-ConnectionGUID: PNCSYKa9SueMhV3RVLoasQ==
X-CSE-MsgGUID: mWVQO3IERiuA9vxJZX1REw==
X-IronPort-AV: E=McAfee;i="6600,9927,11028"; a="6824706"
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; 
   d="scan'208";a="6824706"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 10:43:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; 
   d="scan'208";a="48239761"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.86.126])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 10:43:32 -0700
Date: Fri, 29 Mar 2024 10:43:30 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
	Jonathan.Cameron@huawei.com, dan.j.williams@intel.com,
	dave@stgolabs.net, ira.weiny@intel.com
Subject: Re: [RFC PATCH v2 0/6] cxl: add poison event handler
Message-ID: <Zgb9wjTIu1CE4S5r@aschofie-mobl2>
References: <20240329063614.362763-1-ruansy.fnst@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329063614.362763-1-ruansy.fnst@fujitsu.com>

On Fri, Mar 29, 2024 at 02:36:08PM +0800, Shiyang Ruan wrote:
> Changes:
> RFCv1 -> RFCv2:
> 1. update commit message of PATCH 1
> 2. use memory_failure_queue() instead of MCE
> 3. also report poison in debugfs when injecting poison
> 4. correct DPA->HPA logic:
>      find memdev's endpoint decoder to find the region it belongs to
> 5. distinguish transaction_type of GMER, only handle POISON related
>      event for now
> 
> 
> Currently driver only traces cxl events, poison injection (for both vmem
> and pmem type) on cxl memdev is silent.  OS needs to be notified then it
> could handle poison range in time.  Per CXL spec, the device error event
> could be signaled through FW-First and OS-First methods.
> 
> So, add poison event handler in OS-First method:
>   - qemu:
>     - CXL device report POISON event to OS by MSI by sending GMER after
>       injecting a poison record
>   - CXL driver                                  <-- this patchset
>     a. parse the POISON event from GMER;
>     b. retrieve POISON list from memdev;
>     c. translate poisoned DPA to HPA;
>     d. enqueue poisoned PFN to memory_failure's work queue;

Hi,

Yesterday I posted code adding the HPAs to cxl_general_media & dram
events[1], so as I review this patchset today it's fresh in my mind.

Can we integrate this into the trace_ path directly:

1) On any GMER/poison, trigger a new poison list read

BTW - I'm not sure where to trigger that because we want to keep all
the locking in place and read by endpoints like is done now. It may
not be safe to sneak in a direct call to cxl_mem_get_poison()
as is done in this patch set.

2) Teach the poison list read trace event handler to call
memory_failure_queue().

Upon receipt of that new poison list, call memory_failture_queue()
on *any* poison in a mapped space. Is that OK?  Can we call
memory_failure_queue() on any and every poison report that is in
HPA space regardless of whether it first came to us through a GMER?
I'm actually wondering if that is going to be the next ask anyway -
ie report all poison.

I'll comment a bit more on individual patches.

--Alison

[1] https://lore.kernel.org/linux-cxl/cover.1711598777.git.alison.schofield@intel.com/

> 
> 
> Shiyang Ruan (6):
>   cxl/core: correct length of DPA field masks
>   cxl/core: introduce cxl_mem_report_poison()
>   cxl/core: add report option for cxl_mem_get_poison()
>   cxl/core: report poison when injecting from debugfs
>   cxl: add definition for transaction_type
>   cxl/core: add poison injection event handler
> 
>  drivers/cxl/core/mbox.c   | 126 +++++++++++++++++++++++++++++++++-----
>  drivers/cxl/core/memdev.c |   5 +-
>  drivers/cxl/core/region.c |   8 +--
>  drivers/cxl/core/trace.h  |   6 +-
>  drivers/cxl/cxlmem.h      |  13 ++--
>  include/linux/cxl-event.h |  17 ++++-
>  6 files changed, 144 insertions(+), 31 deletions(-)
> 
> -- 
> 2.34.1
> > 
