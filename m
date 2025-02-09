Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B53F4C7C
	for <linux-cxl@vger.kernel.org>; Sun,  9 Feb 2025 01:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739064319; cv=none; b=r+LXClMGovkwNuPU+T57eJVuWPk4E5G2P6fjgHRW+luIVGzbIdOeypIML1vsS/lEDIK8v30MLNwAPdef9E546tAo8hqgrALlj0JfU1NySDCPEwUSZidSKzZsuKYHob+18kmxJ7u6I3q5bqK5GW48UeyH+qWsYCPdiMA8N0hFjoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739064319; c=relaxed/simple;
	bh=8HvZjh/OZne0Rd9Pem7SJyNnKzy/3sBkmbrItwM4omU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e68mO962jnAKBFdEJMr1k0+XeFIBzUD7qsxMVnYjx1bRB4gf/m1kKQjLaKqIQ0sqgVcT41s6jaNVXplxvLsSqjwADJsFwJwaeXuUBJRKSenP0Wk2NR9DXHhOYdyEaPlDXd/n6v0Nftt3THGGQPZVNyQb2vOYKu6Gz8s9h397DP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W/rTu2uz; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W/rTu2uz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739064318; x=1770600318;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8HvZjh/OZne0Rd9Pem7SJyNnKzy/3sBkmbrItwM4omU=;
  b=W/rTu2uz1RP/fogwaYdmH9QTeY0QvNbwu/epc3qjdT9s/VIeTlpjBPg7
   kxLdHvboq8gQaNv0GGSpVErpL4xmOUCADYRZfBt9Yw5q9teipCPXPkmY2
   lBV84w/OMzM66TsTF4iLIYzpY5amjC8Ye3NtW3LvZfwafjkmlGqxmJ64o
   pbhM9EQsutllffMMl24qSE0HImBGZ1aUIjfu8xVqrkL5OGpGM+yj1vBv6
   B7RhasM6FsaKt4ekB+b/fF4qvxj5gV63H82d1MlBLc2xJzDLLevahXKUT
   WrPklmLdFfy25o1tpc2QMtfphERSnQEot/xQ9k7jC0w6v181FLw2nR15v
   A==;
X-CSE-ConnectionGUID: sSwPShhKSYmC609QV3eq/A==
X-CSE-MsgGUID: fYaMX/ZZQ7+w/H0ytc6hVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11339"; a="42516355"
X-IronPort-AV: E=Sophos;i="6.13,271,1732608000"; 
   d="scan'208";a="42516355"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2025 17:25:14 -0800
X-CSE-ConnectionGUID: Hc2TVKBsRfCK5nGK73LWHg==
X-CSE-MsgGUID: 09Fcdi1TQiu6BWMba+yHFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,271,1732608000"; 
   d="scan'208";a="116907798"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.111.139])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2025 17:25:14 -0800
Date: Sat, 8 Feb 2025 17:25:12 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Ira Weiny <ira.weiny@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Fan Ni <fan.ni@samsung.com>,
	Navneet Singh <navneet.singh@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
	nvdimm@lists.linux.dev
Subject: Re: [ndctl PATCH v2 1/6] ndctl/cxl-events: Don't fail test until
 event counts are reported
Message-ID: <Z6gD-Lq1rWLveZWN@aschofie-mobl2.lan>
References: <20241104-dcd-region2-v2-0-be057b479eeb@intel.com>
 <20241104-dcd-region2-v2-1-be057b479eeb@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104-dcd-region2-v2-1-be057b479eeb@intel.com>

On Mon, Nov 04, 2024 at 08:10:45PM -0600, Ira Weiny wrote:
> In testing DCD event modifications a failed cxl-event test lacked
> details on the event counts.  This was because the greps were failing
> the test rather than the check against the counts.
> 
> Suppress the grep failure and rely on event count checks for pass/fail
> of the test.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---

Thanks!  Applied to https://github.com/pmem/ndctl/commits/pending/
with [ alison: rm unnecessary reference to DCD in commit log ]

snip

