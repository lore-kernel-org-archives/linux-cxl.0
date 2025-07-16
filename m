Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4F41CD2C;
	Wed, 16 Jul 2025 20:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752699130; cv=none; b=gGsznLAhUp8TZLEiQMi5RSwsgYN3n8LgFQZ8y0zLGArdl2J8IF+9/ehxeII+yIt7ifefHwN503Lav4i7LE4GuUepAc0agoGZ4xVekPJZLzCuNczuOzWMEZ4v+jEHHmuykYbEJBl7Mk30CZ8SsH7tpnPq9eK5emwbv+xZ0AgomD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752699130; c=relaxed/simple;
	bh=zZ5+IpidhpHjRlgbxgkkSdgbQ4hUjW9s6DcsAAoZ5bk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iY6R+9QA9OI4ePDsSCmCzhxlLeI7vo4dli5VY9p1gxWYrEp62UlmReXu2aolqJakWXP7sA9B0W0R3WjmtumqbgYQbBsJWP15XVvTz1GfOT3c/JOwrG9UlNPx8hGLUJJ0rLApFL/dG+uNEZsZD3SIrsyLDbEi0ntOxGua1MbquVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nWXrALL4; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nWXrALL4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752699128; x=1784235128;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zZ5+IpidhpHjRlgbxgkkSdgbQ4hUjW9s6DcsAAoZ5bk=;
  b=nWXrALL4yVVjSQKqBpnp6prfTYC26WYwtGVATEhUwme0vbpKzOPq3SHy
   wWnH7Fisi0IWQbNmIgMqkXf1hRg1jeaqyzejXEukCmuvRP4apPMyflOrh
   2+kVUHf4Lh1Uv4IOjC6X1HM+3DPm6YxUMcEixG90jA3k4EuFfCR6pzPG+
   0gkUsMyZjFelj8VekFoNGw3dbPB+drkCYTi5CW+5i8bTEQolRSEePGkJL
   fzj8/Qky25CB5i3euMsMNXcn7LZ4gwulYssPN+SSIsvtqV9dD8r0jsRCS
   gsGUMjZvJjo4R5ONJm2543pph0h8w4ap4tiNQygzhGkgpOFoMeO22ip/t
   g==;
X-CSE-ConnectionGUID: vCstN/AxQMCEz+nsPnYCWw==
X-CSE-MsgGUID: DgpLJ33BSsG3lOVQ6JhTbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="72415399"
X-IronPort-AV: E=Sophos;i="6.16,316,1744095600"; 
   d="scan'208";a="72415399"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 13:52:08 -0700
X-CSE-ConnectionGUID: jMLG/VOaQh+5yPd7yHhEsQ==
X-CSE-MsgGUID: zxOQAGkwQlmvSeNypqRjQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,316,1744095600"; 
   d="scan'208";a="157010694"
Received: from puneetse-mobl.amr.corp.intel.com (HELO [10.125.111.193]) ([10.125.111.193])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 13:52:08 -0700
Message-ID: <1e52ede4-6256-432c-b5a2-45c3342eca84@intel.com>
Date: Wed, 16 Jul 2025 13:52:04 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/8] cleanup: Introduce ACQUIRE(), a guard() for
 conditional locks
To: Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
 Alison Schofield <alison.schofield@intel.com>,
 David Lechner <dlechner@baylibre.com>, Davidlohr Bueso <dave@stgolabs.net>,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Ingo Molnar <mingo@kernel.org>, Ira Weiny <ira.weiny@intel.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Shiju Jose <shiju.jose@huawei.com>, Vishal Verma <vishal.l.verma@intel.com>
References: <20250711234932.671292-1-dan.j.williams@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250711234932.671292-1-dan.j.williams@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/11/25 4:49 PM, Dan Williams wrote:
> Changes since v2 [1]:
> - Pick up Acks and Reviews
> - Whitespace fixups for cleanup.h changes (Jonathan)
> - Use consistent local variable style for ACQUIRE_ERR() (Jonathan)
>   - Not addressed: switch to less compact style ACQUIRE_ERR()
> - Not addressed: pickup checkpatch change for ACQUIRE_ERR() style in
>   this series (Alison)
> - Drop the cxl_decoder_detach() CLASS() and convert to a helper function (Jonathan)
> - Refactor attach_target() to make it easier to read (Jonathan)

Applied to cxl/next
b873adfddeeb337fa8e9f381fd35eb94f7887f2f


> 
> [1]: http://lore.kernel.org/20250619050416.782871-1-dan.j.williams@intel.com
> 
> For those new to this set, the motivation for this work is that the CXL
> subsystem adopted scope-based-cleanup helpers and achieved some decent
> cleanups. However, that work stalled with conditional locks. It stalled
> due to the pain points of scoped_cond_guard(). See patch1.
> 
> In the interim, approaches like rwsem_read_intr_acquire() attempted to
> workaround the pain points, but started a "parallel universe" of helpers
> that is not sustainable.
> 
>     0c6e6f1357cb cxl/edac: Add CXL memory device patrol scrub control feature
> 
> Peter fixed all of this up in a manner consistent with existing guards.
> Take that proposal and run with it to unblock further cleanups of "goto"
> in unwind paths in the CXL subsystem.
> 
> Potential follow-on work identified by this effort:
> 
> - __GUARD_IS_ERR() asm helper [2]
> - Checkpatch fixups for proposed ACQUIRE_ERR() style [3]
> 
> [2]: http://lore.kernel.org/20250514064624.GA24938@noisy.programming.kicks-ass.net
> [3]: http://lore.kernel.org/aGXDMZB6omShJpoj@aschofie-mobl2.lan
> 
> Dan Williams (7):
>   cxl/mbox: Convert poison list mutex to ACQUIRE()
>   cxl/decoder: Move decoder register programming to a helper
>   cxl/decoder: Drop pointless locking
>   cxl/region: Split commit_store() into __commit() and queue_reset()
>     helpers
>   cxl/region: Move ready-to-probe state check to a helper
>   cxl/region: Consolidate cxl_decoder_kill_region() and
>     cxl_region_detach()
>   cxl: Convert to ACQUIRE() for conditional rwsem locking
> 
> Peter Zijlstra (1):
>   cleanup: Introduce ACQUIRE() and ACQUIRE_ERR() for conditional locks
> 
>  drivers/cxl/core/cdat.c   |   6 +-
>  drivers/cxl/core/core.h   |  32 ++-
>  drivers/cxl/core/edac.c   |  44 ++--
>  drivers/cxl/core/hdm.c    | 118 +++++-----
>  drivers/cxl/core/mbox.c   |  13 +-
>  drivers/cxl/core/memdev.c |  50 ++--
>  drivers/cxl/core/port.c   |  27 +--
>  drivers/cxl/core/region.c | 473 ++++++++++++++++++++------------------
>  drivers/cxl/cxl.h         |  13 +-
>  drivers/cxl/cxlmem.h      |   4 +-
>  include/linux/cleanup.h   |  95 ++++++--
>  include/linux/mutex.h     |   2 +-
>  include/linux/rwsem.h     |   3 +-
>  13 files changed, 480 insertions(+), 400 deletions(-)
> 
> 
> base-commit: e04c78d86a9699d136910cfc0bdcf01087e3267e

