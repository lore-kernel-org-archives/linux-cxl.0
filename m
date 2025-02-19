Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A84E1E47A5;
	Wed, 19 Feb 2025 17:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739986608; cv=none; b=FXgeHZRUpW+NQ7aIrJqAtum0gwNXLJU8gnXYb7ZxzrY9fzVVV/2syD9Nt0K7+171VOGqNutnOOSjoOL9bb7rcF+tajr4Jm7juNb1uHTZFv9pYL38Eynp+SzMRWHds338ouRaa8ePfvSIFa46C4YzD1v9tJ+R8mN3I388C8ok5y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739986608; c=relaxed/simple;
	bh=krMXhzrilpIH8JBe8mr0/n3uMnvNSF879fTsoKfFN6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nrhNOCtAQKBgZGDdEv48R8OY5Y5uXhKNhN95vM2Z7MRn6JF0XMACntBHMu6cdu619MP5hTxpvl0/xS3veWO2nqp4/RpS4E1I6/fQ217rtGrwYyFVbMtq/QKPUVium4GgXpayi5/JesQiqaFDLKfYRZOf96/dSndIt+K/BFNdecM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lkYyJLad; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lkYyJLad"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739986606; x=1771522606;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=krMXhzrilpIH8JBe8mr0/n3uMnvNSF879fTsoKfFN6M=;
  b=lkYyJLadqzvtlgsQI3ECHj0lTTbiIlt+a0kgCEnk3pjQ7YANN9b949iy
   Rr5N5EayHhniCELLbXi83gz3GKtQBzOypt5GjS+PWfUABfUKWdOjkwwcO
   wEJxkIfMeG1Z3DH0fJPxj+v3nUIJOaS0QjabTfQy9GHmgmc2OhW5c4FaW
   t09Qlg0HK61+pHeoH7V4qFIUcD7SGXUHMGnB6Zm09McJetOgQnvsg/U2q
   aULs4Tb4jfOFEbczmUMksCKMzrbvMZmppegootUiv5YhnJbmBobGdR52w
   sLsh00NazxNhDo1nH+k/yfwxq9sjhVjg2IJGcJyimCscI5vr/J20w6lyW
   g==;
X-CSE-ConnectionGUID: 79sINky/SGqEJ1irXY+mzw==
X-CSE-MsgGUID: saLdeCX8RS+LtWtB9nKUug==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="39923590"
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="39923590"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 09:36:45 -0800
X-CSE-ConnectionGUID: B+tz3kKwR+mmnR7n4qxuJQ==
X-CSE-MsgGUID: /IQPyXbWTtCw8wel59G1bQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="115683470"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.110.15])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 09:36:45 -0800
Date: Wed, 19 Feb 2025 09:36:43 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Li Ming <ming.li@zohomail.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/7] cxl/core: Use guard() to drop goto pattern of
 cxl_dpa_alloc()
Message-ID: <Z7YWqxCNbqw94fYj@aschofie-mobl2.lan>
References: <20250217144828.30651-1-ming.li@zohomail.com>
 <20250217144828.30651-6-ming.li@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217144828.30651-6-ming.li@zohomail.com>

On Mon, Feb 17, 2025 at 10:48:26PM +0800, Li Ming wrote:
> In cxl_dpa_alloc(), some checking and operations need to be protected by
> a rwsem called cxl_dpa_rwsem, so there is a goto pattern in
> cxl_dpa_alloc() to release the rwsem. The goto pattern can be optimized
> by using guard() to hold the rwsem.
> 
> Creating a new function called __cxl_dpa_alloc() to include all checking
> and operations needed to be procted by cxl_dpa_rwsem. Using
> guard(rwsem_write()) to hold cxl_dpa_rwsem at the beginning of the new
> function.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Li Ming <ming.li@zohomail.com>

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

snip
