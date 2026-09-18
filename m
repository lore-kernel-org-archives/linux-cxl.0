Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEC34E01E4
	for <linux-cxl@vger.kernel.org>; Fri, 18 Sep 2026 15:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789745193; cv=none; b=rs4qu/0/miE2a4QMaPY934HBjPZTXEzIATgZKTg/HoVhAwOBrSojmbxDUmsLH2ScgKI0tYrHuU+v79gW89vOpKbPSxfd67mlNxgpZ4u9ZpOJErsQtOlbIkEgTFeF5VArQQ7fIzIE7zq+QEJ7zsXqBnRUfj3hXFFHyLgGfmLfFSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789745193; c=relaxed/simple;
	bh=jYoQB8ncidccv5WHb4DvC8rbwdX7nH12lcxba9ugm1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gKCBIseQoM/slqnjfWnTgytmjIfFyF7F822K/eae5fytCEsxgjtwzhKdE3O3gz0bbMEuEUGzVRVC+YSRCePyFYjLhzjbFmKSp8/MOd5sR2Ayywe19M8F1m3o8MXh66QslzDPjoXJ9MrnT0griI4YaqFCcepFTmmjtxVeYYT3bwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AT7w7UAP; arc=none smtp.client-ip=192.198.163.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AT7w7UAP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789745191; x=1821281191;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jYoQB8ncidccv5WHb4DvC8rbwdX7nH12lcxba9ugm1E=;
  b=AT7w7UAPgH3OuL3MO36/iXfGM8mzbCGIfGrvQJpBzpPZ8XHC5jUQRx8c
   8IM08sqdXXiGNC8NhXt7aiWBvOakpNkwWsIzwUlWUq/fVUSoV18ZinbSs
   giQNO7TiH9BJsZ4HDJqAgr9vfXOKfA6+eUtjjWNICjCz0hIxW/QpsQPT0
   dIHKRWAVAkAXumesBVcJtGkcO222pem9W+CgojR2wggF+UXpMAZSdcq6F
   t0FwsHx1ZNxSr0ebKZIOa/rAUpzZEji3evppZ3Ewq8cYAMOuyvwaq1mmM
   VSnFY9SaBPmgRBW5ppE0cC9AXV7LX1pAnKy/1XDQONV64FuDP+OXlWo7X
   A==;
X-CSE-ConnectionGUID: vY+mJeY0R4mWdnFFNqk4fw==
X-CSE-MsgGUID: pHHswf2/RECwaYFvIDC8fA==
X-IronPort-AV: E=McAfee;i="6800,10657,11909"; a="766368"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="766368"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa114.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 08:26:31 -0700
X-CSE-ConnectionGUID: lnsFS2ODTP6Ro1TKS5eCkQ==
X-CSE-MsgGUID: 8V4nfstaRpW3BkXp0yq/vQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="2682184"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.109.117]) ([10.125.109.117])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 08:26:30 -0700
Message-ID: <be97d805-94e7-48a0-9812-446d08dab7ce@intel.com>
Date: Fri, 18 Sep 2026 08:26:28 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] cxl/memdev: Fix poison debugfs vs unbind deadlock
To: Guixin Liu <kanie@linux.alibaba.com>, Davidlohr Bueso
 <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>,
 Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich
 <dakr@kernel.org>, Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
Cc: linux-cxl@vger.kernel.org, driver-core@lists.linux.dev
References: <20260916025453.3532614-1-kanie@linux.alibaba.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260916025453.3532614-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/15/26 7:54 PM, Guixin Liu wrote:
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
> The same deadlock shows up with a pciehp hot-remove racing the writer
> loop: the pciehp thread hits the same debugfs_remove() drain holding
> the memdev lock, and the hot-remove wedges the same way. With both
> patches applied the hot-remove flow completes normally.
> 
> With both patches applied, 46 unbind/bind cycles against the same writer
> loop all completed, no task was left in D state, and the writer collected
> 10920 EBUSY returns from the contended trylock. Note that lockdep stays
> quiet either way: one leg of the cycle is the debugfs active_users
> completion rather than a lock it tracks.
> 
> v3 -> v4:
> - reword the patch 2 commit message per Alison: enumerate the teardown
>   paths that race a poison write into an unbind, and state that mixing
>   poison writes with cxl_mem teardown is not a supported use of this
>   debug ABI, though the fix keeps the cost of doing so to a failed write
> - add the pciehp hot-remove reproduction, reported during v3 review,
>   to the patch 2 commit message
> - collect Jonathan's Reviewed-by on both patches (no code change)
> 
> v1 -> v2:
> - add the device_trylock() guard and use ACQUIRE(device_try, ...) instead
>   of open-coding device_trylock()/device_unlock(), keeping the style the
>   Fixes: commit established (Shaikh Kamaluddin)
> - cut the changelog down to the failing condition, the consequence and
>   the fix; the call graph and the reproducer live here instead
> - say how the issue was found and how it was tested
> 
> v2 -> v3:
> - rebase onto v7.3-rc2 (master), per Dave's request to send the series
>   against Linus's tags rather than cxl/next
> 
> v1:
> https://lore.kernel.org/linux-cxl/20260826125248.4003792-1-kanie@linux.alibaba.com/
> 
> v2:
> https://lore.kernel.org/linux-cxl/20260831124809.889829-1-kanie@linux.alibaba.com/
> 
> v3:
> https://lore.kernel.org/linux-cxl/20260910094017.4032170-1-kanie@linux.alibaba.com/
> 
> Guixin Liu (2):
>   driver core: Add conditional guard support for device_trylock()
>   cxl/memdev: Fix deadlock between poison debugfs and cxl_mem unbind
> 
>  drivers/cxl/mem.c      | 14 ++++++++++----
>  include/linux/device.h |  1 +
>  2 files changed, 11 insertions(+), 4 deletions(-)
> 

For the series
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Greg,
I can take the patches through the CXL tree if you ack the first patch. Thanks!
