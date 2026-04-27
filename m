Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E5833121F;
	Mon, 27 Apr 2026 17:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777311755; cv=none; b=KZl8m9uDWYALOHnlwa+swgzX3qPrp6Ne1WRvjItS7/AHfArl4gcZ3+KKPmnOdfmAa2XMeqBfkBgm4vR0ZghIgH21obbLkElAB6uBCyorrMY95dnrDHnaHMxGYoMHq97js2qTi+B/OUniRLY0AE2zXXYxAVM12UA5xrl2pHjpTHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777311755; c=relaxed/simple;
	bh=SjVsHL75Z6JwELAgtNOYAI95UhbI/AJCq/JHO983QWY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hIcGqAER8C2oM5EOS/mB3YT0r/g2nj9X0K7tDsC0gvvy3YALOLbJ3j8ArRmRERUuMk+8z0IDacWz1YKsc7KXFijZWalA2CSfDV/lSmhiuphCjGIF6Tg6UzsNvI6dPxl1KhpXdj7S+pM30OooNrT5k3BiPAfPJ8egQsDMEMEM5rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JGfH3kZ1; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JGfH3kZ1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777311751; x=1808847751;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SjVsHL75Z6JwELAgtNOYAI95UhbI/AJCq/JHO983QWY=;
  b=JGfH3kZ18L2XaUXaDCUQBgAc5Kbzgq0BNe93olBh4bUsfiwyqUDoDouX
   dqLC/nAze7yWQ/Io+jpwZQtqWaAbUr/VdLSJMQMdJwsvAhsX6OyFctQW6
   HV8D3EF8/Dh3xghgvU1msxmJ0UDjkmNjpW07ZFzsg+tJLGxD7bk+AA/rh
   Ts07rl4s/CKP7rE7dAXMCBUznSfAgdi28yFGikkgeQY5B86nRWBEoIFkh
   KtsPgZla6vUV7nw1FOlEaVOqOnzD2t7kmK0FG5bil+BNUpkI0A8GwILl6
   dIUky10GnAa68yBC6fW5mXCFZdYIkDseeu/zzcaeBy96V0B+IT6cpJVVX
   Q==;
X-CSE-ConnectionGUID: tq4+XvaEQaqbCgJ7c85aPA==
X-CSE-MsgGUID: YLG44UIgTf6l25BsVBrKaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="81818022"
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="81818022"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 10:42:31 -0700
X-CSE-ConnectionGUID: 1CGi6/pVSOG0kf11xRC94g==
X-CSE-MsgGUID: nxzEl9LyTfWhSvPV7sd7RA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="232820123"
Received: from msatwood-mobl.amr.corp.intel.com (HELO [10.125.108.172]) ([10.125.108.172])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 10:42:29 -0700
Message-ID: <5b46d2ca-7821-4245-92fc-7169ea7435ae@intel.com>
Date: Mon, 27 Apr 2026 10:42:28 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] cxl/region: Fix race conditions in cxl region
 unregistration.
To: Sungwoo Kim <iam@sung-woo.kim>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jic23@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <djbw@kernel.org>, Robert Richter <rrichter@amd.com>,
 Li Ming <ming.li@zohomail.com>, Gregory Price <gourry@gourry.net>,
 Ben Widawsky <bwidawsk@kernel.org>
Cc: Dave Tian <daveti@purdue.edu>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260427032010.916681-2-iam@sung-woo.kim>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260427032010.916681-2-iam@sung-woo.kim>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/26/26 8:20 PM, Sungwoo Kim wrote:
> This version mainly addresses Dave's comments and meaningful issues reported by Sashiko AI[1].
> 
> Overview
> ========
> This patch series fixes race conditions in cxl region unregistration.
> 
> devm_release_action() should be called once, otherwise, it warns about
> the second call. However, the current implementation has a race condition
> that allows multiple calls to devm_release_action(). The details are in
> each patch.
> 
> To fix these, the first patch adds a new function that guarantees that
> devm_release_action() is called only once.
> Using this function, the second patch subsitutes the current use of 
> devm_release_action() in cxl region with the new function.
> 
> Change in v3
> ============
> Addressed Dave's comments:
> - Split and made this in a patch series.
> - Enhanced a commit log explaining why a workqueue is used in the first patch.
> - Added a context on how these issues were found and what impact was observed and how that effects a user in the second patch.
> Sashiko AI review fixes:
> - Fixed construct_region() as it also can race.
> - Used a driver's wq instead of system wq so unbinding can drain a work.

A few issues Sashiko raised with the v3.
https://sashiko.dev/#/patchset/20260427032010.916681-2-iam%40sung-woo.kim

DJ


> 
> [1] https://sashiko.dev/#/patchset/20260422045637.3048249-2-iam%40sung-woo.kim
> 
> Earlier approach:
> v2: https://lore.kernel.org/linux-cxl/20260422045637.3048249-2-iam@sung-woo.kim/
> v1: https://lore.kernel.org/linux-cxl/20260308185958.2453707-2-iam@sung-woo.kim/
> 
> Sungwoo Kim (2):
>   cxl/region: serialize devm action removal via scheduled work
>   cxl/region: Fix a race bug in delete_region_store()
> 
>  drivers/cxl/core/port.c   |  6 +++++
>  drivers/cxl/core/region.c | 47 ++++++++++++++++++++++++++++++++++-----
>  drivers/cxl/cxl.h         |  9 ++++++++
>  3 files changed, 57 insertions(+), 5 deletions(-)
> 

