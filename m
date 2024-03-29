Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BB33B78E
	for <linux-cxl@vger.kernel.org>; Fri, 29 Mar 2024 19:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711741089; cv=none; b=cVQfSlD6DeMOrjap57cGLwEkYDsHb9u58mTXGwNvLq943jfnxc4GLKn/90DxO/PB1rAuoeFGWhZSZm7YG1QX7N2IWs1vDMXLXsRmM0n4vWqU+lVKMvMPInsdzONgLj+4iKZTH0zBXFp2I4PcR2qZZGCra6MejNkGvDjz2pO9s/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711741089; c=relaxed/simple;
	bh=+vKbkzFZ4eZd1MQh5+5s+z854meqlngn22v4O+87I90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MyGSaqCenMRlQebZHfPZdS8vGaJ2ro6YA93XvNw5xyui4ys5+8vD+AgX0UwBKHnLk6yep8e7J1nFNoVrcQLiZVGnjxhu1OrtGQGPotos1ZxblbtrfvvqQmnbNUzwDsXGC9N8pLDmkrMmnGlNOGN3Ltfo/JebM8qQLXB53a7zsFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NmRpDsqG; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NmRpDsqG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711741087; x=1743277087;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+vKbkzFZ4eZd1MQh5+5s+z854meqlngn22v4O+87I90=;
  b=NmRpDsqGmmCMHXkb7sqx9i1dKOhwDio63407Kz8OzkroFAvLoBMLbWtI
   BtQUk+J0WjlY4gp/aMkFdN9GC1mHsIq0ITRSFaz1UYXXZWsUubtMR3P+c
   m0J7IoKMONrPB+ziQMaUl2WH+44gvkdFXtVtWdB9T6jDlVf7wuGdcawb6
   3R9JfL4aLFdiaeOgljnLYQH7czpMt7+Oec2Iz1ET7ZvIOpFlnAfnuTOaa
   wumzTi7neBTrWJlXoJ2u1RWjPOqjaoMm5aXKfhCHwRQ5Rp8zRLLsnLNLd
   S1twRNM1slI2wTrGT8Fxu6sZPyahJLHf9R2ajpC/8PW9n9CXQw2kb7lHH
   Q==;
X-CSE-ConnectionGUID: 3xGzn8ETRnecvtoByvWPpg==
X-CSE-MsgGUID: DJdnDg6oSh64jU8uAf4Q/w==
X-IronPort-AV: E=McAfee;i="6600,9927,11028"; a="29422399"
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; 
   d="scan'208";a="29422399"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 12:38:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; 
   d="scan'208";a="17042956"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.86.126])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 12:38:06 -0700
Date: Fri, 29 Mar 2024 12:38:04 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Shiyang Ruan <ruansy.fnst@fujitsu.com>, qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org, Jonathan.Cameron@huawei.com,
	dave@stgolabs.net, ira.weiny@intel.com
Subject: Re: [RFC PATCH v2 0/6] cxl: add poison event handler
Message-ID: <ZgcYnCr19aVhCO93@aschofie-mobl2>
References: <20240329063614.362763-1-ruansy.fnst@fujitsu.com>
 <Zgb9wjTIu1CE4S5r@aschofie-mobl2>
 <660706e8a66c_4a98a294e@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <660706e8a66c_4a98a294e@dwillia2-mobl3.amr.corp.intel.com.notmuch>

On Fri, Mar 29, 2024 at 11:22:32AM -0700, Dan Williams wrote:
> Alison Schofield wrote:
> [..]
> > Upon receipt of that new poison list, call memory_failture_queue()
> > on *any* poison in a mapped space. Is that OK?  Can we call
> > memory_failure_queue() on any and every poison report that is in
> > HPA space regardless of whether it first came to us through a GMER?
> > I'm actually wondering if that is going to be the next ask anyway -
> > ie report all poison.
> 
> memory_failure_queue() should be called on poison creation events. Leave
> the MF_ACTION_REQUIRED flag not set so that memory_failure() performs
> "action optional" handling.  So I would expect memory_failure_queue()
> notification for GMER events, but not on poison list events.

Seems I totally missed the point of this patch set.
Is it's only purpose to make sure that poison that is injected gets
reported to memory_failure?

So this single patch only:
1. Poison inject leads to this GMER/CXL_EVENT_TRANSACTION_INJECT_POISON 
2. Driver sees GMER/CXL_EVENT_TRANSACTION_INJECT_POISON and reads poison
list to get accurate length.
3. Driver reports that to memory_failure_queue()

Still expect there's some code sharing opportunities and I still wonder
about what is next in this area.

--Alison

