Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1154E5227
	for <linux-cxl@vger.kernel.org>; Thu, 12 Sep 2024 01:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726103284; cv=none; b=jdeHzdxLzoW7KOnvfLNO42DyFDtTl2Ux6ua8KCmO3zYFcpbVJ3ysgtVYcHtzc40gClj5DZkH4IgIDKirfycDTvqDQA4DM4R0Vyo5WpdQuYIrCyozLpiEnUjmHyulbjxRKftSk6ayvleeT9wI6Y/GRcr8ItqXiv5ke/uKTUv5Q24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726103284; c=relaxed/simple;
	bh=xm49SXPnjg+YMJlsZI4b5+tGfDps6DzJPQ6IZX5aYwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jSojOgUJ4+QhE7HObUWa2e39EQacPWbow0oP8UY5zI58fWBJsC8jW5dGwqVQJTw7JcBWRAJRahBVE/ceidqiRImGkZ5HZGP5WhcbyGHOjg87WHLSMu/wiZ0mMpfaz09xXdCQ2hSHneiuCVE0x5gdF15r017IuYzcUTnT0uvkm0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B6eEPut5; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B6eEPut5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726103282; x=1757639282;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xm49SXPnjg+YMJlsZI4b5+tGfDps6DzJPQ6IZX5aYwY=;
  b=B6eEPut51/cwNgbXH4wxpoZAlaS+8Nip61rJLFc1MVcN8uIiYjuopQY7
   B+ujQQnXED7VO86K6h+MJ1nn1JwpJSBVcwJPwWkLxoo/Ru9vPobRqjse2
   3mDgD6PSgnJvEEBqZqT6qhan8bIyxYxFcQDFZaw4nRwQ+EZuMqkhyZ6Pb
   4XpVNgizomRa/Htl9I11fQWyAcfFr2s5c5XBWCbUhy2C65It4IIaeWDAM
   9mu6U1leVDLKqlpvaiikmnZvchJK1CDNNidza0JdvVhKXhyhPda4TmU++
   JVF0A1a8gsFaK9WkGpXbLJpQQEqU4dU8b10fynm17MALiygGF6i5LfEFR
   g==;
X-CSE-ConnectionGUID: E6FJl6D5TAiwX6uftqDxwg==
X-CSE-MsgGUID: Ikj88k2fRg2AyFCknA5Jhg==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="25066829"
X-IronPort-AV: E=Sophos;i="6.10,221,1719903600"; 
   d="scan'208";a="25066829"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 18:07:46 -0700
X-CSE-ConnectionGUID: q2fgYsMpRpujWMeQXK8eRg==
X-CSE-MsgGUID: LQCGzu7xRNujkoaoO2hIvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,221,1719903600"; 
   d="scan'208";a="68333106"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.108.5])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 18:07:46 -0700
Date: Wed, 11 Sep 2024 18:07:43 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
	ira.weiny@intel.com, vishal.l.verma@intel.com,
	Jonathan.Cameron@huawei.com, dave@stgolabs.net
Subject: Re: [PATCH v8 3/3] cxl: Add documentation to explain the shared link
 bandwidth calculation
Message-ID: <ZuI-32VltQUYWjhg@aschofie-mobl2.lan>
References: <20240904001316.1688225-1-dave.jiang@intel.com>
 <20240904001316.1688225-4-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904001316.1688225-4-dave.jiang@intel.com>

On Tue, Sep 03, 2024 at 05:11:52PM -0700, Dave Jiang wrote:
> Create a kernel documentation to describe how the CXL shared upstream
> link bandwidth is calculated.
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
> ---
> v8:
> - spelling fixups (Jonathan)
> - remove duplications (Jonathan)
> - clarify definition of symmetry (Jonathan)
> ---

Reviewed-by: Alison Schofield <alison.schofield@intel.com>


snip
