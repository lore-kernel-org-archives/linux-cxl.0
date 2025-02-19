Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BFC2144C8;
	Wed, 19 Feb 2025 17:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739986643; cv=none; b=bXCxst39Z2tVvTovK59WbKJI3pGo+q3jXA1a2fAXw74vyetl2ENq1h9YD9F9IriX92xRtfZQT9sZbIx+X6q7XWNaTKjqqOtf5D6mlo4TRvtC9j0LrT+qWU6aYHxWyHlV/BxDKdkyKflL8cd0xHeguE6LY0JvogyEyCUwUyPqSvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739986643; c=relaxed/simple;
	bh=gL7RoAkXhs4YzAdD62lr4XGzaoyOwsAvRd+cHaJaaWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XIvOKRPQfUS9qIQtPnOF+qvLbgVi9yxT26/lweGlFC6KT355BBznFykkjmBlbi3Jtv23B+e7kRS5oSLTeQKW9AHTPpeFgNO6C1j8hAZYfDpzd5n/46E2JsDq8crPRDaTShvtV0l73/qvD00/ilQ46SRYnBb4ghSCrIrgLAcnFbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l7CzcmIl; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l7CzcmIl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739986642; x=1771522642;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gL7RoAkXhs4YzAdD62lr4XGzaoyOwsAvRd+cHaJaaWQ=;
  b=l7CzcmIlJxVMh3e6F82lJNteFKT82h1Cd2rRjf+EcxCgdTL+/L4qb+w8
   SIKxMJYf/2tlPwxuHesToblc1X7/PxWrtp/fsiywfhyv16gJD45+NBNyZ
   1k0ZMu/lGTOxr9AVGXDG16s2VMOmjBO9NEJG4ZCvQz7C63lwrszv6QWms
   yDhX8JJ1RhyYW6cEdiqGQ1ezoCbwvwwciHNE6umVbBaE/a0FDDXpPnTV2
   LdN0scVPbiVCU7e8vWluWTRiaIWO4t081Uo3guWckDd0S233TxscBg4RY
   cvpdC8/G28jzXp0HYTxe/r3H98GC68ABpZo6rBvkSsIHD3ln4EEs0ZPSz
   A==;
X-CSE-ConnectionGUID: /kMN+EeHQpq2NqMWFMjHng==
X-CSE-MsgGUID: oSVuwBNiTgSGAwjOl2Xrpg==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="40944365"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="40944365"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 09:37:21 -0800
X-CSE-ConnectionGUID: RhbUW0gFSPyVhfQw7OzeoQ==
X-CSE-MsgGUID: k0QD9xi7Sl6Jv3ncgusBwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="114717554"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.110.15])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 09:37:20 -0800
Date: Wed, 19 Feb 2025 09:37:17 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Li Ming <ming.li@zohomail.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/7] cxl/region: Drop goto pattern in
 cxl_dax_region_alloc()
Message-ID: <Z7YWzeTlQFG3zZZ6@aschofie-mobl2.lan>
References: <20250217144828.30651-1-ming.li@zohomail.com>
 <20250217144828.30651-7-ming.li@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217144828.30651-7-ming.li@zohomail.com>

On Mon, Feb 17, 2025 at 10:48:27PM +0800, Li Ming wrote:
> In cxl_dax_region_alloc(), there is a goto pattern to release the rwsem
> cxl_region_rwsem when the function returns, the down_read() and up_read
> can be replaced by a guard(rwsem_read) then the goto pattern can be
> removed.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Li Ming <ming.li@zohomail.com>

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

snip
