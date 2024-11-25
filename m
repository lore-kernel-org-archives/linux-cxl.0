Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CDC17557C;
	Mon, 25 Nov 2024 21:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732569044; cv=none; b=mBEBtjGTdSh1lvXHGscnqPNk6DzmLn/KLrznDGn9oBG3upjUFeQZOo+zNDb/LA6KgXXDMKlNkFqk/TD2JVJKiNMbUJBJtav+X1s0YqLHQ9hmXi0z7twqA+1SinuqLw3VVIuhWnycjbrVikX7XCZvueMi+3lamQhnvi2tLjezz1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732569044; c=relaxed/simple;
	bh=U+Qsi7cWJv2e5EGby/fr1Mg1ssqDOJaPBL8zmp+PBGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jRN+wRhOc5nEMd5oGj6hEQG7IPtdS4aDnW0u+cVmIwTRpkT/SaRNcqaGYcYU7scduS2H9L3z3e8glg9Xn02VwO5sbEXWumluCmUPm1qigBVdXkDQbw+QSKph6GvWQfwNT78S5/iUQM8c11PHqJACWTqkEVT/Y9zLlIEchI2etAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ifscGWLE; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ifscGWLE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732569042; x=1764105042;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=U+Qsi7cWJv2e5EGby/fr1Mg1ssqDOJaPBL8zmp+PBGI=;
  b=ifscGWLEkQnytfx0+krtGvAyw5NsF98jy/oIHCXakoCVRXNk68MjaBnU
   kXlQsJYD/0EoBbC7tvpSZHOBjOCGU+zTKARqCZbjCBd3xk/QzEe8s3XaO
   mbOcBoN7lZwAb7gqGgyTaoEIai28taGNJtnWhWo1WOMY/5dWl3xMGqMdi
   ZjLG4WhN+/T/B04Xon8iGESzUXX29G/UFumT7yQNJ94sHnuCzWiULIs/n
   8ajxZCJw32gkWESIIpFX+1wfp45PxKOWU7/AGPfLvKvK1I+V/ozZZjnvb
   ue88DSDaSyMJDhB3OFuEBN2qJKLIwNaA2aajxb9AOV8n6I9ocazGM31/W
   A==;
X-CSE-ConnectionGUID: XKndI+zJR8azrd3JQ6Qbzg==
X-CSE-MsgGUID: FBW+2jDbQLeUfGiuNBG3WA==
X-IronPort-AV: E=McAfee;i="6700,10204,11267"; a="43767151"
X-IronPort-AV: E=Sophos;i="6.12,183,1728975600"; 
   d="scan'208";a="43767151"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 13:10:41 -0800
X-CSE-ConnectionGUID: CPxtnh7URGmoGWYTsVyfXA==
X-CSE-MsgGUID: rXBlmlIvReujEIk74uF9zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,183,1728975600"; 
   d="scan'208";a="91570578"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.110.188])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 13:10:40 -0800
Date: Mon, 25 Nov 2024 13:10:38 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Huang Ying <ying.huang@intel.com>,
	Yao Xingtao <yaoxt.fnst@fujitsu.com>, Li Ming <ming4.li@intel.com>,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 1/3] cxl/core: Change match_*_by_range() calling
 convention
Message-ID: <Z0Tnzl7fPmZkj7zp@aschofie-mobl2.lan>
References: <20241122155226.2068287-1-fabio.m.de.francesco@linux.intel.com>
 <20241122155226.2068287-2-fabio.m.de.francesco@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241122155226.2068287-2-fabio.m.de.francesco@linux.intel.com>

On Fri, Nov 22, 2024 at 04:51:52PM +0100, Fabio M. De Francesco wrote:
> In preparation for a patch that supports matching between Decoders that may
> have larger HPA ranges than their corresponding Root Decoders or Regions,
> change the calling convention of three match_*_by_range() to take CXL
> Endpoint Decoders as their second arguments which later will be reused by
> two new functions (arch_match_spa() and arch_match_region()).

Suggest not telling the future, esp future func names.
Here's a suggestion:

Replace struct range parameter with struct cxl_endpoint_decoder of
which range is a member in the match_*_by_range() functions.

This is in preparation for expanding these helpers to perform arch
specific region matching that requires a cxl_endpoint_decoder.

No functional change. (right ?)


Code looks good!

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

snip to end
> 
