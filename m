Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707BD1F3FF1
	for <linux-cxl@vger.kernel.org>; Fri, 21 Feb 2025 16:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740155439; cv=none; b=ViPq0uT5VmRCmmlNa6BtShFO5dM/xkvdtm07Ke/0KA2s8YHxIghhNnh8kPh0OgaxBG6iJo6/4A8d50x+Auxb3lh+iR/vivdw4JVZ8iNCor6hUEty+wdA0NzDdyMGxzw6Idw2i4utg8rxIAjF/UGZxuKsMizYovvNKhKhJ3O0P+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740155439; c=relaxed/simple;
	bh=SXbfVkbYKjW26Melo7Kgf+usKJESeSYbgoW/Z7Danb8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jn5gy1luGuHypiZzSxlbwtmwrNSa7VhY009HTAi01OaMOyAqjjP8bkIWF54EWoq2zDePWTFoF8ZuR6eHz3EJUABKLia7eYlBtg6sv602c25uv69rK2urEnhr2VQJosjZsQpL9rqdBWAxhdjQq1gRrklPh7XHWpT/f9mXr1SSwZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=laUyGgXb; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="laUyGgXb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740155438; x=1771691438;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SXbfVkbYKjW26Melo7Kgf+usKJESeSYbgoW/Z7Danb8=;
  b=laUyGgXbYh8iTX+KGu6HNwB0yZXkZJKALskCwqUVdthcJAjTT91Dfz6a
   lj1EPZzpI570qZg1+TDMPeSCHln+qGXehUTtBOxeoxrChRWZlo21BpW9e
   /pr75PGD/KbgsO8hucolHRfiyt3tkj3WFG8j4tarsP2FqEGaaivNygoHt
   2lgW+rXaQpXEvfxKk+RhJ1SZviyMxmtAgBC2n7OJxMQsMyZvMc8S0XT8q
   BuVNS++kghl6QONJxEqqY/OPXF5P9SGiHeFENxG4h3LXBJ00mytxv0Jgy
   67TyEy5nNg42TLV12aQxrl8EQcUrjV15O7Do+xpaeXVIXEtgyGVwuqa11
   A==;
X-CSE-ConnectionGUID: urq4UEZ2QKCAEmB/DefIUA==
X-CSE-MsgGUID: 9490TW2+QmGJRJiHF58uBg==
X-IronPort-AV: E=McAfee;i="6700,10204,11352"; a="44625803"
X-IronPort-AV: E=Sophos;i="6.13,305,1732608000"; 
   d="scan'208";a="44625803"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 08:30:37 -0800
X-CSE-ConnectionGUID: 3amcDm0ATXWdysK9nNwavw==
X-CSE-MsgGUID: jBQxef3pRyyfAsyBqbNlNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,305,1732608000"; 
   d="scan'208";a="120513372"
Received: from inaky-mobl1.amr.corp.intel.com (HELO [10.125.110.189]) ([10.125.110.189])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 08:30:35 -0800
Message-ID: <33ed0b20-fdbc-460c-af72-adb3c948f99d@intel.com>
Date: Fri, 21 Feb 2025 09:30:34 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/4] cxl: Dirty shutdown followups
To: Davidlohr Bueso <dave@stgolabs.net>, dan.j.williams@intel.com
Cc: jonathan.cameron@huawei.com, alison.schofield@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, seven.yi.lee@gmail.com,
 ming.li@zohomail.com, a.manzanares@samsung.com, fan.ni@samsung.com,
 anisa.su@samsung.com, linux-cxl@vger.kernel.org
References: <20250220220235.276831-1-dave@stgolabs.net>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250220220235.276831-1-dave@stgolabs.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/20/25 3:02 PM, Davidlohr Bueso wrote:
> Changes from v4:
>   - use %llu on the correct sysfs file in patch 3 (Jonathan)
>   - s/cxl_nvdimm_setup_dirty_tracking()/cxl_nvdimm_arm_dirty_shutdown_tracking()
>     in patch 3 which was feedback from v1.

Applied to cxl/next

> 
> Hi,
> 
> Some followup patches to the GPF work. First two patches are from feedback
> provided by DaveJ. The third patch adds a $platform/dirty_shutdown sysfs
> attribute to expose the count to userspace. Fourth patch adds support
> emulating the set shutdown state command for the mock device.
> 
> Applies against the -next branch of cxl.git.
> 
> Thanks!
> 
> Davidlohr Bueso (4):
>   cxl/pci: Introduce cxl_gpf_get_dvsec()
>   cxl/pmem: Rename cxl_dirty_shutdown_state()
>   cxl/pmem: Export dirty shutdown count via sysfs
>   tools/testing/cxl: Set Shutdown State support
> 
>  Documentation/ABI/testing/sysfs-bus-cxl       | 12 +++
>  Documentation/driver-api/cxl/maturity-map.rst |  2 +-
>  drivers/cxl/core/mbox.c                       | 25 +++++-
>  drivers/cxl/core/pci.c                        | 30 +++++---
>  drivers/cxl/cxl.h                             |  3 +
>  drivers/cxl/cxlmem.h                          | 15 +++-
>  drivers/cxl/pmem.c                            | 77 +++++++++++++++++--
>  tools/testing/cxl/test/mem.c                  | 23 ++++++
>  8 files changed, 165 insertions(+), 22 deletions(-)
> 

