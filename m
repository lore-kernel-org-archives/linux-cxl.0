Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80350126F11
	for <linux-cxl@vger.kernel.org>; Thu,  4 Apr 2024 15:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712243293; cv=none; b=f8xWMtu6XM77LK5LNbtk06Om/o/h0uLepxu99uJXh+xl+UTWvE1iUehxBzDVQXaAA8/kfZMQtuW+c1I7gpG14LUNfFtlT2gPyE2C6nnX2AfYeGF2uN0AqZYDYo/KnLoZK278Z+w8dG0m9b2mHWgblgX89B4+y8JqGDKi+ZJt5X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712243293; c=relaxed/simple;
	bh=SReSKnlJvLU7tMYpdQx3qlj42foLnbXLpPvzpJcdWBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BDhb2aB4JTlbja2M71H/ET7L8gCjcoWx0mq2ggYBUv5a61iGwun8hbu51bVnFdJvrIAAwWldwaFv7uvvy1aWiz2RpJqhdNTzEb9avdoGp64egeB9ml6XBU2c8phdho7jRHwsXFlEhAag9KzXJ6pNnl4eDmjT5vHDwn2fIr64TEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jrNBKpO+; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jrNBKpO+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712243291; x=1743779291;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SReSKnlJvLU7tMYpdQx3qlj42foLnbXLpPvzpJcdWBY=;
  b=jrNBKpO+wmSWv10L5+jTTXSRUrjt2QC5FXGgonduIxj2J994Guatqr4w
   xgYtZiWot/XaB7qMGPwtutMw5NFT2g8Ns7qfsN1OzqboPOYPYsqo3RWRt
   cVlOi2NmW+SrGqBWmgbr25yXHmg9V9trmDAdUg8x8gBNwt4N8QHcxJkQU
   yDdcZyYLVCxA4QhgBfCY3sznQ55zpANOw1Z6Hu9jznzHHZ5A9KbXw80KE
   eD3JEoseeplWhKhJN4aCgDVRp4yamaF9H8TVBj0mWjqtQVFVZ0AfYR4Br
   3JLva2xw2ZixilWP49xGKVZnut9NwKmvkhAti1oc9Owfxu7yD3sBAu62M
   A==;
X-CSE-ConnectionGUID: 9m+uzuWEQ1CGwjlxskfxsQ==
X-CSE-MsgGUID: +G+I7V62RU6nseHXCRlK3w==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="7397612"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="7397612"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 08:08:10 -0700
X-CSE-ConnectionGUID: xbjRwOqNS02PbOG9xhkaNw==
X-CSE-MsgGUID: PTwqDmlWQU+/mopFHCSXzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="18781978"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.19.15])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 08:08:11 -0700
Date: Thu, 4 Apr 2024 08:08:08 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 1/4] cxl/region: Move cxl_dpa_to_region() work to the
 region driver
Message-ID: <Zg7CWDe6F1uW+3cN@aschofie-mobl2>
References: <cover.1711598777.git.alison.schofield@intel.com>
 <e62889d00f883b804e46a1840454b0c06323fedf.1711598777.git.alison.schofield@intel.com>
 <20240403182448.00003c79@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403182448.00003c79@Huawei.com>

On Wed, Apr 03, 2024 at 06:24:48PM +0100, Jonathan Cameron wrote:
> On Wed, 27 Mar 2024 21:36:30 -0700
> alison.schofield@intel.com wrote:
> 
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > This helper belongs in the region driver as it is only useful
> > with CONFIG_CXL_REGION. Add stubs in core.h for when the region
> stub
> 
> > driver is not built.
> > 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Otherwise, does what is says on the tin.
s/is/it

And TIL:
"It does exactly what it says on the tin" was originally an advertising
slogan in the United Kingdom, which then became a common idiomatic phrase
in that country. It colloquially means that the name of something is an
accurate description of its qualities." Wikipedia

Watch for reuse in my reviews.

Thanks Jonathan!
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
