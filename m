Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A50C3A8D0
	for <linux-cxl@vger.kernel.org>; Fri,  5 Apr 2024 23:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712361380; cv=none; b=iBp9L+IYiJj2u/g7gPbIUUlW7jdHdrxnz6/4U/f0/c3UWX7TsdNv6Yc3QTvZ02mAh7xp2+fbpsWihldNoDHs3XXhf8WcKYk4GqHPcOvFhwZgbKIFygPaEOK/emcPhW6sAEb4Pv+13DdSImNBTYObpK2P3XMcmCIY9uI/3V/W4Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712361380; c=relaxed/simple;
	bh=bf2wDRB9R4uOhglxK84WAmlj9Iei6X0IMdj/647puvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hmo8XslUJo6fP0N7woeVpFyf6VsjVjuROnxYho0X7lxNEJx8YZq/W/OhUS6SNWQIM7sdgMhuTk0x6/UhNHgXCQ9MC+NqSRmRJTQLbSwXzG9esO2h72/g2+Ix80ikEZS2ik4PF0j26xe3sRfhIi1D1zGP9chjPRMzuSeZmQ/ygxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ESoWMwT9; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ESoWMwT9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712361378; x=1743897378;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bf2wDRB9R4uOhglxK84WAmlj9Iei6X0IMdj/647puvg=;
  b=ESoWMwT9Yv8nfdRQWWi0t3d4olDHQZiAtNVksRSu3bditqYc/T32MkpT
   lI6y502WfFkDnh4kynwysJzk1bwJBd5SgEuzKTjqvxGYuA/cKl4Jm6fBe
   7R20AsoFevxjHLQKbn+8dA+4LKtfIQBggW12gvNZ95OTwr7wYfGzuwbHv
   IjOTPir+cTLa0fM5br6EPJDzq4nTEBmfBmITE+ocUHS2cUIm9rxBeEYx6
   H+GGNLocAqIOKHCpCkFIAEJkgIZl37HCnLYB0t4X/Q2++kyyc2xNV31XJ
   L5DaKDt3+JbzOAWSiA9iYQ1KmkKoskKsImyKODPQhLuLnFiC5IIVfmHZ4
   g==;
X-CSE-ConnectionGUID: iPJ5Ou9pT22ewHVztRvPbA==
X-CSE-MsgGUID: 9S9XZWRnQQ2JbBouPUb2LA==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="7590423"
X-IronPort-AV: E=Sophos;i="6.07,182,1708416000"; 
   d="scan'208";a="7590423"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 16:56:18 -0700
X-CSE-ConnectionGUID: 3JOlbuM7Si23pALaR6cd7g==
X-CSE-MsgGUID: 0RLZVTlnRPeZrhqMWs49RA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,182,1708416000"; 
   d="scan'208";a="19756569"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.142.219])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 16:56:17 -0700
Date: Fri, 5 Apr 2024 16:56:15 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: dave.jiang@intel.com, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Vishal Verma <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v3] cxl/acpi: Cleanup __cxl_parse_cfmws()
Message-ID: <ZhCPn9nnJq1xaCze@aschofie-mobl2>
References: <170915213220.2419769.6117155173006983208.stgit@dwillia2-xfh.jf.intel.com>
 <171235474028.2718248.14109646123143505522.stgit@dwillia2-xfh.jf.intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171235474028.2718248.14109646123143505522.stgit@dwillia2-xfh.jf.intel.com>

On Fri, Apr 05, 2024 at 03:05:50PM -0700, Dan Williams wrote:
> As a follow on to the recent rework of __cxl_parse_cfmws() to always
> return errors [1], use cleanup.h helpers to remove goto and other cleanups
> now that logging is moved to the cxl_parse_cfmws() wrapper.
> 
> This ends up adding more code than it deletes, but __cxl_parse_cfmws()
> itself does get smaller. The takeaway from the cond_no_free_ptr()
> discussion [2] was to not add new macros to handle the cases where
> no_free_ptr() is awkward, instead rework the code to have helpers and
> clearer delineation of responsibility.
> 
> Now one might say that  __free(del_cxl_resource) is excessive given it
> is immediately registered with add_or_reset_cxl_resource(). The
> rationale for keeping it is that it forces use of "no_free_ptr()" on the
> argument passed to add_or_reset_cxl_resource(). That in turn makes it
> clear that @res is NULL for the rest of the function which is part of
> the point of the cleanup helpers, to turn subtle use after free errors
> [3] into loud NULL pointer de-references.
> 
> Link: http://lore.kernel.org/r/170820177238.631006.1012639681618409284.stgit@dwillia2-xfh.jf.intel.com [1]
> Link: http://lore.kernel.org/r/CAHk-=whBVhnh=KSeBBRet=E7qJAwnPR_aj5em187Q3FiD+LXnA@mail.gmail.com [2]
> Link: http://lore.kernel.org/r/20230714093146.2253438-1-leitao@debian.org [3]
> Reported-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Closes: http://lore.kernel.org/r/20240219124041.00002bda@Huawei.com
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>


Doubling down ;)

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

> ---
> Changes since v2:
> - Drop kvasprintf() usage in alloc_cxl_resource (Alison)
> 
>  drivers/cxl/acpi.c |   93 +++++++++++++++++++++++++++++-----------------------
>  drivers/cxl/cxl.h  |    5 +++
>  2 files changed, 56 insertions(+), 42 deletions(-)

snip

