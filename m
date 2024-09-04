Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B811CEE89
	for <linux-cxl@vger.kernel.org>; Wed,  4 Sep 2024 16:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725467461; cv=none; b=Niaa5Cl0kgyyh3X//ttkIJYhJrRK5onwY5BYr3xe+ie/0fffrEKw9gZL6TcVOxa3LS9EXPg9eRSqRMn8v9d0F3B76LVW02brwWbCKUcPtwjl+8xdfKLBIt/iXyRwYtEoX6IPIolJTbnQ87EFrkDQd1UlcGMED7+qpuVKl0TXgbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725467461; c=relaxed/simple;
	bh=svK9KHFisBCvkHOYJkSb2ii1g4ukUPwm1hA0jwuPf+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R17uYGUWSLgzaAfYiFCrMiJaN8HRL0/vPCL/qZUeYEIE9lmOMOgzH8thR+aWHt/OPYO7ZYuYZ4SL0OYiw1zpuHCt2QP3h+loMOAuK5rBPney3biij5F7tZRgWZ+/WLxRSx0xHzNoqcC0+76z+MoHN4jUuQrZnnXgCaQQYvDpRLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kZTykB8T; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kZTykB8T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725467460; x=1757003460;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=svK9KHFisBCvkHOYJkSb2ii1g4ukUPwm1hA0jwuPf+s=;
  b=kZTykB8TRaqoyc9B8dhtMaeadnzRjmkmmQNj+7tMMZmlF6+5sGOpVQWc
   8kquWJXKD2yseHHTutqNuJSDTL+QOQFtJLtvdbe3sTnxVGpZwGhNxY4kQ
   ZwZ3FY2SPxQPXjvr0SuAmNB24mRDRM9GrKtTQHntmspNqxsjS4KWe+eWM
   Bn8ohjNuffapV210WB50kkQ6meTwDbJr5q6hBbI9XEHS0zOd4CchggxcR
   OK2XJyiA2DYWKR5VsSYIkfZO4jxN4QUo0qwbv4MlVkOzVFvrCVHTu030O
   pqcOP5KNKVPOe0PqMBe4ZXRwnslDglSUrwznuu331kI1NdswerhtN0SoH
   g==;
X-CSE-ConnectionGUID: kHoQgwpJT1WtjFV2ylR++A==
X-CSE-MsgGUID: S7KXU+StTfKhptkaNspaUg==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="46672159"
X-IronPort-AV: E=Sophos;i="6.10,202,1719903600"; 
   d="scan'208";a="46672159"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 09:31:00 -0700
X-CSE-ConnectionGUID: MglBm4L5Qam+tDtL23D41A==
X-CSE-MsgGUID: zUxW2n1GQ7qG8Mq+9TAXuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,202,1719903600"; 
   d="scan'208";a="70142558"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.109.152])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 09:30:59 -0700
Date: Wed, 4 Sep 2024 09:30:57 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, alejandro.lucero-palau@amd.com,
	dan.j.williams@intel.com, ira.weiny@intel.com,
	vishal.l.verma@intel.com, Jonathan.Cameron@huawei.com,
	dave@stgolabs.net, fan.ni@samsung.com,
	Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v3 1/3] cxl: Move mailbox related bits to the same context
Message-ID: <ZtiLQblMnSAoHfu3@aschofie-mobl2.lan>
References: <20240904000020.1686611-1-dave.jiang@intel.com>
 <20240904000020.1686611-2-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904000020.1686611-2-dave.jiang@intel.com>

On Tue, Sep 03, 2024 at 04:59:08PM -0700, Dave Jiang wrote:
> Create a new 'struct cxl_mailbox' and move all mailbox related bits to
> it. This allows isolation of all CXL mailbox data in order to export
> some of the calls to external kernel callers and avoid exporting of CXL
> driver specific bits such has device states. The allocation of
> 'struct cxl_mailbox' is also split out with cxl_mailbox_create() so the
> mailbox can be created independently.
> 
> Reviewed-by: Fan Ni <fan.ni@samsung.com>
> Reviewed-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> Link: https://patch.msgid.link/20240724185649.2574627-2-dave.jiang@intel.com
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 

snip


> @@ -1408,6 +1421,19 @@ int cxl_poison_state_init(struct cxl_memdev_state *mds)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_poison_state_init, CXL);
>  
> +int cxl_mailbox_init(struct cxl_mailbox *cxl_mbox, struct device *host)
> +{
> +	if (!cxl_mbox && !host)
> +		return -EINVAL;
> +
> +	cxl_mbox->host = host;

drivers/cxl/core/mbox.c:1431 cxl_mailbox_init() error: we previously assumed 'cxl_mbox' could be null (see line 1428)

caught by smatch_scripts/kchecker



> +	mutex_init(&cxl_mbox->mbox_mutex);
> +	rcuwait_init(&cxl_mbox->mbox_wait);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_mailbox_init, CXL);
> +
> 
> 
