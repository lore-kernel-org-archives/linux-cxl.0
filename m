Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7B337CD39;
	Fri, 27 Mar 2026 18:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774637859; cv=none; b=jgqSJqAqdgCMC4MW5lA4pD4EGcdEQjwM6vnhtzAqANcBUU3tnyiJsl/RG9Xa/y0lWtJPn9vFsmTWy/RqsLR208mIwMdpdhUyNma4Mi2MXmMcYQi8QzcQN+JHi7fJJv7d92Vtc57+l50m9WTzZ+vQBji4S/pxaoY5cYCauAwwpUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774637859; c=relaxed/simple;
	bh=m91QQvK1G4jbS9J0w4znUxmZvkW7psURJTgifpYBJbA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OpqHJvxWRbiEaL2etoPe/0qKnvQwUMw0O9EfbmH54RTA12xieiii4I3Dc5U8SdXkI/PRTazkv94RkkH0R+DblbYsnQXIDqG7hxfjWvVrz4uj4ko8E5zYT22Bq6UVSPC7msSPjsiPgKgqC3Kh8hkKPn5XH1HDLf/DgRbCjFYwBug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lB7AdwXD; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lB7AdwXD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774637858; x=1806173858;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=m91QQvK1G4jbS9J0w4znUxmZvkW7psURJTgifpYBJbA=;
  b=lB7AdwXDJMS+B26biTCu5kzTigE4P70otIPjDxt0JfijNvBnIp3Q495P
   ihbgyWKiLTlW0y5I0ZbqIJ8VkZWsaJgZ5S+sS4Cz7NHz2Ut2YkxlI9yhZ
   YPwbnmbLQR0Iin43QM6VL0uLv0YNC69btt2t/TbiID9KMxWEbeaILI30E
   Ssk7EPaWGnjhuiUQF7HsUpjpWXqaS6I1O3lAYwJIO3pyvoieqaNfytwU2
   d13JAXtXNfkW+GSyEnomFiO8HyPkn93KOkPJERvquNBfo7oO4FOqGFOcQ
   XaekEL/CqMcPrGEpr7aLYSwGIqUiL5eC6//WDYJaCu3C/CoSXFo6PogSh
   w==;
X-CSE-ConnectionGUID: CgVR9DB1StqVsZxX0O/O3g==
X-CSE-MsgGUID: 1d0qVeJSSgeQWxVij2GBOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11742"; a="87190566"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="87190566"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 11:57:37 -0700
X-CSE-ConnectionGUID: IlgxTF0XS2u60H2J4hBccQ==
X-CSE-MsgGUID: zEF+3ki6Q/Kc81jvIpo1Pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="248675251"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.110.180]) ([10.125.110.180])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 11:57:34 -0700
Message-ID: <e0192e62-0891-4d18-b194-9dab5596e1b9@intel.com>
Date: Fri, 27 Mar 2026 11:57:33 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/3] pull region-specific logic into new files
To: Gregory Price <gourry@gourry.net>, linux-cxl@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com
References: <20260327020203.876122-1-gourry@gourry.net>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260327020203.876122-1-gourry@gourry.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/26/26 7:02 PM, Gregory Price wrote:
> cxl/core/region.c presently contains logic to handle cxl_region,
> cxl_pmem_region, and cxl_dax_region.  The cxl_pmem_region and
> cxl_dax_region management code deserves new files to make it clear
> that this logic applies to a specific types of regions.
> 
> This also breaks up development space so fewer conflicts can occur, and
> it becomes clear where changes are actually happening.
> 
> I snuck in a cleanup.h fixup for devm_cxl_add_dax_region to tidy up some
> of the existing functions.
> 
> v4 -> v5:  Ira test fixes
>            Jonathan nit fixes
> 
> v3 -> v4:  address DJ's feedback on cleanup.h patch:
>            move __free() declaration to assignment point
>            restore local dev variable
> 
> v2 -> v3:  renamed from x_region to region_x because it's prettier
>            added cleanup.h
>            small nits asked for by Jonathan (commas)
> 
> Gregory Price (3):
>   cxl/core/region: move pmem region driver logic into region_pmem.c
>   cxl/core/region: move dax region device logic into region_dax.c
>   cxl/core: use cleanup.h for devm_cxl_add_dax_region
> 
>  drivers/cxl/core/Makefile      |   2 +-
>  drivers/cxl/core/core.h        |   2 +
>  drivers/cxl/core/region.c      | 283 ---------------------------------
>  drivers/cxl/core/region_dax.c  | 106 ++++++++++++
>  drivers/cxl/core/region_pmem.c | 191 ++++++++++++++++++++++
>  drivers/cxl/cxl.h              |   1 +
>  tools/testing/cxl/Kbuild       |   2 +-
>  7 files changed, 302 insertions(+), 285 deletions(-)
>  create mode 100644 drivers/cxl/core/region_dax.c
>  create mode 100644 drivers/cxl/core/region_pmem.c
> 

I applied to for-7.1/cxl-region-refactor branch and pushed to the cxl.git so it gets 0-day coverage. But I'm going hold off until the end to merge this in case of merge conflicts.

29990ab5cb40 cxl/core: use cleanup.h for devm_cxl_add_dax_region
d747cf98f091 cxl/core/region: move dax region device logic into region_dax.c
8a1ec5fb2360 cxl/core/region: move pmem region driver logic into region_pmem.c
 
