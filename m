Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352A81AC45F
	for <linux-cxl@vger.kernel.org>; Mon, 14 Oct 2024 18:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728930996; cv=none; b=I1TRiuNji+dqTelAVD1W+3QNCpFIYzKHg1RakJPnVzXU5IA3lW+pdI0VfniMRgcAccmijZxNFNGW6AqNJO0NVVnAp07t+PiB0gjMu951sbKfe7Xqcu/qOfP0JCbJ0xpUqW59f/TCNUzIZ1uk+EyT48YHnKygFPiBep1+Y9v5BdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728930996; c=relaxed/simple;
	bh=dPF+kwQKNn3m0uOkv4gAcy6l1b1OOSGlgKGY1TjRPLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XM+ChaInlWvokXWc5W8ZA/UfkJwdIhl0wakDw914Et91lyWI5bp/93XttxxEK8j4TrjbnYElOHM+IvwJXsV3dZ3PjsykAWsDhbzuhleAx6wKjp1x0KrBbEJVifZyY2t/LtQF+G9nYWPvaT2oKavV8Dy6gQ3etMtmDp8DDE37IWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ASVUt4ew; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ASVUt4ew"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728930995; x=1760466995;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dPF+kwQKNn3m0uOkv4gAcy6l1b1OOSGlgKGY1TjRPLY=;
  b=ASVUt4ewdseCY2add6CCfVSla4TnbbPmqmpMtOc/Ky3Q6jn7ASvBars1
   TxUerc5tlljHm7tkKeYoYNL8VQmGVRc+sridmrz9E14HxHqrQ8jEn+Pi8
   zlMCoxsSskWWt67TIRzWS2pb7SYaAPTZY6OwOMey+Kq7NXqhqERqVXPiU
   Wlc0LAoPx5EZUybnFziuTXSaIUEZz5LXHcapri1XxjMazv5hZFeqj7XgV
   fCf80MwKtiVX8tyi3n54aqwE1sCyQd6m1QhUfgYzjg5eg52dZx2on/E/u
   NoSF/YxD0U2kT+uUN4kdPQ+ZVNptzws+QhJuGwFPGzLa1qSb4Yg3dXOtp
   w==;
X-CSE-ConnectionGUID: KKTOSpZPRx+jsXcO1/q/HQ==
X-CSE-MsgGUID: s74oMydVSlupgdzD3gh0wg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="31995118"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="31995118"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 11:36:35 -0700
X-CSE-ConnectionGUID: hMAR0YBjTXqwyhCu8I3A/Q==
X-CSE-MsgGUID: Jc4dsrY3ROSKz4LFTFAdew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,203,1725346800"; 
   d="scan'208";a="82687603"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.108.40])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 11:36:33 -0700
Date: Mon, 14 Oct 2024 11:36:31 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
	alejandro.lucero-palau@amd.com, dan.j.williams@intel.com,
	ira.weiny@intel.com, vishal.l.verma@intel.com, dave@stgolabs.net,
	fan.ni@samsung.com, Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v4 2/3] cxl: Move mailbox related bits to the same context
Message-ID: <Zw1kr5-99J_nKPyl@aschofie-mobl2.lan>
References: <20240905223711.1990186-1-dave.jiang@intel.com>
 <20240905223711.1990186-3-dave.jiang@intel.com>
 <20241014155154.00001d5a@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014155154.00001d5a@Huawei.com>

On Mon, Oct 14, 2024 at 03:51:54PM +0100, Jonathan Cameron wrote:
> On Thu, 5 Sep 2024 15:35:46 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
> > Create a new 'struct cxl_mailbox' and move all mailbox related bits to
> > it. This allows isolation of all CXL mailbox data in order to export
> > some of the calls to external kernel callers and avoid exporting of CXL
> > driver specific bits such has device states. The allocation of
> > 'struct cxl_mailbox' is also split out with cxl_mailbox_create() so the
> > mailbox can be created independently.
> > 
> > Reviewed-by: Fan Ni <fan.ni@samsung.com>
> > Reviewed-by: Alejandro Lucero <alucerop@amd.com>
> > Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> > Link: https://patch.msgid.link/20240724185649.2574627-2-dave.jiang@intel.com
> > Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
> LGTM.
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Note this is currently being carried in Shiju's RAS features set
> as well.  What is the merge plan?  My preference is an immutable branch
> that Borislav could pull into the EDAC tree and on which we can base
> other stuff in CXL 
> That is a branch based on 6.12-rc1 directly with an appropriate tag
> that Shiju's patch set can refer to.


This set was merged in 6.12.

> 
> Thanks,
> 
> Jonathan
