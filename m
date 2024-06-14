Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597E538C
	for <linux-cxl@vger.kernel.org>; Fri, 14 Jun 2024 04:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718340446; cv=none; b=km4Af7Rd41UDx10iLwidnF49oIHMz3Jn16Jshg8uO1wOgsgQ7Y88KF2xWUNFQ7o74NSNNxQjEloYFQzHn0a91NFRXD9r4TLtnbc6jKWdlQewqW6hzxHK6U4dH8F18gpUyesiTFKgB61KjAHUoK/0kq8rvqCZUxpuARKEtJbfpWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718340446; c=relaxed/simple;
	bh=rMCUsMV/oaWynVqPdX2Ec8vP/Qajmf3HCt6YX7u5KwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tUFW4FRODTgUKqpO7izIILTFrhNBVsJ/L715DBBuIhhNHA53QtfD338Oyo86voQ7c3sG/4FqUyGJDyUd/TPQLc63urlzmYa/bY67jV9vpNb2vP6UpMdYK/H61TXRrUIDiy0Sa9e9XCh0WRGcfL878CWdZlgqao0VJP1A55Mq514=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ao9Fl27H; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ao9Fl27H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718340444; x=1749876444;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rMCUsMV/oaWynVqPdX2Ec8vP/Qajmf3HCt6YX7u5KwA=;
  b=ao9Fl27HTITkbKNwrIUiQAmBJyOFoEA4Dd+6KbInB3cjo3QclfEhHMdI
   AAyX9bnuMn8jcSFyucVmuuo4/I2i6YTBJ3/+4DJr71aLrgfn2dE6vZgW1
   hDHFwyGgosW1huSndfzDJVAe7S5HM+lxNLMO26VTT44XmepaueXQXXJIg
   6i1vRVEqONHlOlwVU0tE+BlyoXFnNQjHwNNWo4MHlqgYBdMhqs7UlgGhQ
   M9IcI8E50FKby/7bHa+0Ch674Bm0u6cJO5Q7Y9Ug9L0acFSDX3F4NYkTx
   vUbrzBSmDKMZL7jIe4+HVPhEUSZjwd0ulX6jcVpjICpTokw8Sq90zbd5c
   Q==;
X-CSE-ConnectionGUID: xvt/XdgMTACGH4c1Bz0cdw==
X-CSE-MsgGUID: 3DtKiK1UTDKHS80kB9phQQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="15370237"
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="15370237"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 21:47:24 -0700
X-CSE-ConnectionGUID: d/aL6w3ZQ8e78VAwVXksSg==
X-CSE-MsgGUID: qzcuMaDTQze+7wP+O/nTyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="71158090"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.251.22.236])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 21:47:23 -0700
Date: Thu, 13 Jun 2024 21:47:21 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Yao Xingtao <yaoxt.fnst@fujitsu.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, jim.harris@samsung.com,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v8 2/3] cxl: documentation: add cxlmem.h to cxl driver-api
Message-ID: <ZmvLWWR6WnClsQH2@aschofie-mobl2>
References: <20240614032133.45365-1-yaoxt.fnst@fujitsu.com>
 <20240614032133.45365-3-yaoxt.fnst@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240614032133.45365-3-yaoxt.fnst@fujitsu.com>

On Thu, Jun 13, 2024 at 11:21:32PM -0400, Yao Xingtao wrote:
> Since the interleave capability check is supported, and this feature
> depends on cxl_hdm, add cxl_hdm structure to the cxl driver API
> documentation.
> 

Hi Yao,

I was hoping you were going to add the other missing files here,
core/cdat.c and core/hdm.c

If you don't we can pick them up another time.

However, the new struct in Patch 1 doesn't have the kernel doc
notation so this isn't picking up the cxl_hdm structure for the
docs.

-- Alison


> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
> ---
>  Documentation/driver-api/cxl/memory-devices.rst | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/driver-api/cxl/memory-devices.rst b/Documentation/driver-api/cxl/memory-devices.rst
> index 5149ecdc53c7..e33ee67ac1a2 100644
> --- a/Documentation/driver-api/cxl/memory-devices.rst
> +++ b/Documentation/driver-api/cxl/memory-devices.rst
> @@ -325,6 +325,9 @@ CXL Memory Device
>  .. kernel-doc:: drivers/cxl/pci.c
>     :internal:
>  
> +.. kernel-doc:: drivers/cxl/cxlmem.h
> +   :internal:
> +
>  .. kernel-doc:: drivers/cxl/mem.c
>     :doc: cxl mem
>  
> -- 
> 2.37.3
> 
