Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A47813F435;
	Thu,  8 Aug 2024 18:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723143331; cv=none; b=K8jZ4L4od3V2aE2x7vroxxBtPmhQyZxvnObkpILTpIF3ikTf1uVWEGPC0xIjqRkbmtwkPmA7u+p9+nhkkc3Kyx2k0V8MC6Xo0J+MUOfC5ySJ0WFJ9MPnMKjsNR5rXFtCqiobE7A8J2hUJbZYW3fE0Dk/Ms2rTCtEZ0Vo6YhC5lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723143331; c=relaxed/simple;
	bh=G32pgusq1KzhckqZqehp2esIUUvD3rdQptDyWQ9E8ms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z1d9kJ6koa4tO9B4Cs3klo3Um4g8yLBZbHZPoRh2gH26zX3Mxm8szUQlw0p4u058GIK5T+/bSgSN2dmk33FabxwFIo68Eb0xRHuPvxr8syn0vJBwgA4GB+07xswv4LKz8eNBk7X7WYlEJnVk6IWIPLqQwkM7qeKf7qzRJBqXMQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dLHhue2X; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dLHhue2X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723143329; x=1754679329;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=G32pgusq1KzhckqZqehp2esIUUvD3rdQptDyWQ9E8ms=;
  b=dLHhue2Xy/JyJgAJZDTE92alAfaI+ZwluuMwyXlrAubjHzolK+SbAKoO
   A50Ua46WOvckJHR66OcZ69jw0rFn+kz0qdGAlb6Ra+FP7YZLD+weBUX9R
   /SxzfsH2U+SlOL776kKKgLIcC8fL6A1hqcBSZX82GO6FVq46pjXCW8wdX
   0vf0lzAh2WaXbfxffUS0I1zCpQzPhoAiNJFaaqxU0ZTFlvWUhezjiw8BL
   7PacEhZquRjYP1YTVGGy17mD1qT1AxztuGaCrh8aFyb5rcbeNAkBbpP/K
   vZu3bmf6NQkPdWyE3bFfTqrcjcvQ2jx5fM2O44pvNII9+scXC2VDvWiOV
   w==;
X-CSE-ConnectionGUID: f7o11Um3TUCR1/ny3nC7UQ==
X-CSE-MsgGUID: rXvhgK1ORuGOtFiu7iu6Ng==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="32699441"
X-IronPort-AV: E=Sophos;i="6.09,273,1716274800"; 
   d="scan'208";a="32699441"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 11:55:28 -0700
X-CSE-ConnectionGUID: sGyYPv3aTLaRDrK47+3Owg==
X-CSE-MsgGUID: 989w6FVzSNG3acFu9LuX4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,273,1716274800"; 
   d="scan'208";a="94850394"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.12.215])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 11:55:28 -0700
Date: Thu, 8 Aug 2024 11:55:26 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-cxl@vger.kernel.org,
	cerasuolodomenico@gmail.com, hannes@cmpxchg.org,
	j.granados@samsung.com, lizhijian@fujitsu.com,
	muchun.song@linux.dev, nphamcs@gmail.com, rientjes@google.com,
	rppt@kernel.org, souravpanda@google.com, vbabka@suse.cz,
	willy@infradead.org, dan.j.williams@intel.com, yi.zhang@redhat.com,
	david@redhat.com, yosryahmed@google.com
Subject: Re: [PATCH v3 4/4] mm: don't account memmap per-node
Message-ID: <ZrUUnm/pEpPS9ltC@aschofie-mobl2>
References: <20240808154237.220029-1-pasha.tatashin@soleen.com>
 <20240808154237.220029-5-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808154237.220029-5-pasha.tatashin@soleen.com>

On Thu, Aug 08, 2024 at 03:42:37PM +0000, Pasha Tatashin wrote:
> Currently, when memory is hot-plugged or hot-removed the accounting is
> done based on the assumption that memmap is allocated from the same node
> as the hot-plugged/hot-removed memory, which is not always the case.
> 
> In addition, there are challenges with keeping the node id of the memory
> that is being remove to the time when memmap accounting is actually
> performed: since this is done after remove_pfn_range_from_zone(), and
> also after remove_memory_block_devices(). Meaning that we cannot use
> pgdat nor walking though memblocks to get the nid.
> 

How about directly include the failing cases and user visible impacts as
reported in the Tags appended below.

--Alison

> Given all of that, account the memmap overhead system wide instead.
> 
> For this we are going to be using global atomic counters, but given that
> memmap size is rarely modified, and normally is only modified either
> during early boot when there is only one CPU, or under a hotplug global
> mutex lock, therefore there is no need for per-cpu optimizations.
> 
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Closes: https://lore.kernel.org/linux-cxl/CAHj4cs9Ax1=CoJkgBGP_+sNu6-6=6v=_L-ZBZY0bVLD3wUWZQg@mail.gmail.com
> Reported-by: Alison Schofield <alison.schofield@intel.com>
> Closes: https://lore.kernel.org/linux-mm/Zq0tPd2h6alFz8XF@aschofie-mobl2/#t
> 
> Fixes: 15995a352474 ("mm: report per-page metadata information")
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---

snip

>

