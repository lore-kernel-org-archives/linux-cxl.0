Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88B3581250
	for <linux-cxl@vger.kernel.org>; Wed,  9 Sep 2026 16:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788971285; cv=none; b=MBJSPJRu2GBnf3Wi2qX5E3cxzL5T8gfASyyPyuF4cL94KXPHqoaNvrtsGaQTZVHKxQflRqmpniieKft2/XkvJvxzg8XBOKRV/3OTifNx07aeX+9laFchW7/WKAVcGoI5W89Lqw34ft1241yYFgzu6jxrv2DWnQDAUbQDUTD0PHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788971285; c=relaxed/simple;
	bh=Aw6ienXb8ek2QzVpJ5eT2Ml76EkHtd0wLw+gsBWxjZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YSnSyO0opwbJZuuGfoTuW2BA5Mf8WD5OlsQCzhch+/VENZkUoqg2D6ehzJs6XI7KwyJabDdfklAO1JFyfi6an5mWZGiPOt3g8UubmTJ2Vs3Q7CQDRYUS77NcBS+P1IF8nquHuzsPSWHuaJ8hZi5EbpTjAH+yVLilKl8SmyXqUSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TctVwUE6; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TctVwUE6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788971282; x=1820507282;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Aw6ienXb8ek2QzVpJ5eT2Ml76EkHtd0wLw+gsBWxjZc=;
  b=TctVwUE6oahpu593wZ6G51LDjcHRCwrXggoGY99pCd+ujeDTNgDuXVAR
   uUZau97pDjIvVLVQ2+bmuBN6VXudY86/6BQjyfXJ6xOZspBesaDha3QHE
   j3jTatG1faiBz/l11wpovXHy6dX2UH3Ci2CTpB2pxqgbr/ocLAci1B+5g
   0YDRGamYq4HobeJtveG6Pks+5UUg59bPALyJjC+lfsoBgnRiUZ3KwaoCe
   Vc0hvNhoOxaD3BxqpOatNSL1F5V72NF2YQTAy0kIGeDgGvBLsP2Hu08EC
   ZFHRFiqzjeb0DkAds7a5SKBNkXrIaizqZkJylKBBIx/IqhyLNGscTHOGa
   w==;
X-CSE-ConnectionGUID: ii/dSxZLSz2995l5XG0sUA==
X-CSE-MsgGUID: z3Le0+7mRIWi+doXDE9TMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="100065441"
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="100065441"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 09:28:02 -0700
X-CSE-ConnectionGUID: Orf7ofH4TS6Swa5Lc3jYjg==
X-CSE-MsgGUID: 2TEhRwPmRfSDpHTRopUjfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="275506954"
Received: from aschende-mobl.amr.corp.intel.com (HELO [10.125.111.155]) ([10.125.111.155])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 09:28:00 -0700
Message-ID: <124abd10-a6df-4256-b994-37c92218bac9@intel.com>
Date: Wed, 9 Sep 2026 09:28:00 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] cxl/memdev: Fix poison debugfs vs unbind deadlock
To: Guixin Liu <kanie@linux.alibaba.com>, Davidlohr Bueso
 <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>,
 Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich
 <dakr@kernel.org>, Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
Cc: linux-cxl@vger.kernel.org, driver-core@lists.linux.dev
References: <20260831124809.889829-1-kanie@linux.alibaba.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260831124809.889829-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/31/26 5:48 AM, Guixin Liu wrote:
> Writing a memdev poison debugfs file while cxl_mem is being unbound
> deadlocks. Patch 2 fixes it by not waiting for the device lock in those
> handlers. Patch 1 adds the trylock guard it uses.
> 
> Patch 2 does not build without patch 1, so the two need to travel
> together.
> 
> Testing:
> 
> Reproduced on a QEMU CXL topology whose type3 devices advertise poison
> inject support:
> 
>   while :; do echo 0 > /sys/kernel/debug/cxl/mem0/inject_poison; done &
>   while :; do
>       echo mem0 > /sys/bus/cxl/drivers/cxl_mem/unbind
>       echo mem0 > /sys/bus/cxl/drivers/cxl_mem/bind
>   done
> 
> Without the fix the unbind wedges within seconds. The three tasks
> involved, from /proc/<pid>/stack:
> 
>   writer, state S, holds the debugfs reference and waits for the lock
>     cxl_debugfs_poison_inject+0x25/0xa0 [cxl_mem]
>     debugfs_attr_write+0x61/0xb0
>     full_proxy_write+0xfc/0x1c0
>     vfs_write+0x1d4/0xe60
> 
>   unbind, state D, holds the lock and waits for the reference to drain
>     remove_one+0x27f/0x3d0
>     debugfs_remove+0x44/0x60
>     release_nodes+0xfa/0x2c0
>     devres_release_all+0x113/0x1a0
>     device_unbind_cleanup+0x76/0x260
>     device_release_driver_internal+0x3eb/0x540
>     unbind_store+0xde/0x100
> 
>   cxl_port workqueue, state D, blocked on the same lock
>     device_release_driver_internal+0x96/0x540
>     detach_memdev+0x79/0xb0 [cxl_core]
>     process_one_work+0x6b0/0xfb0
> 
> The writer is in interruptible sleep and can be killed; the unbind
> cannot, and because cxl_bus_wq is an ordered workqueue the wedged
> detach_memdev() blocks every other CXL bus work item behind it.
> 
> With both patches applied, 46 unbind/bind cycles against the same writer
> loop all completed, no task was left in D state, and the writer collected
> 10920 EBUSY returns from the contended trylock. Note that lockdep stays
> quiet either way: one leg of the cycle is the debugfs active_users
> completion rather than a lock it tracks.
> 
> v1 -> v2:
> - add the device_trylock() guard and use ACQUIRE(device_try, ...) instead
>   of open-coding device_trylock()/device_unlock(), keeping the style the
>   Fixes: commit established (Shaikh Kamaluddin)
> - cut the changelog down to the failing condition, the consequence and
>   the fix; the call graph and the reproducer live here instead
> - say how the issue was found and how it was tested
> 
> v1:
> https://lore.kernel.org/linux-cxl/\
> 20260826125248.4003792-1-kanie@linux.alibaba.com/
> 
> Guixin Liu (2):
>   driver core: Add conditional guard support for device_trylock()
>   cxl/memdev: Fix deadlock between poison debugfs and cxl_mem unbind
> 
>  drivers/cxl/mem.c      | 14 ++++++++++----
>  include/linux/device.h |  1 +
>  2 files changed, 11 insertions(+), 4 deletions(-)
> 
> 
> base-commit: 7098e9cd98a05c0c5de2fae0c2465f9d966fdd07

Please rebase the patch series on Linus tags rather than cxl/next. Currently v7.3-rc2. It would be nice to get sashiko coverage. 

