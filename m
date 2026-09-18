Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A599C51C33D;
	Fri, 18 Sep 2026 17:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789752770; cv=none; b=WnK6T2rlAG9dcngu+ahCzTnKlnyyAK1k+CIL2Qs4Yh0q0Bhfv6kV5RlCS6yyiDsCM8TrZbpg0LbKX8LlsgymsweP6pHejVfeMlHuRo+PaRNJT6a3NDpuxJiPqttItbL2v83bq6WMtJmOJI5+3LsF56L/MIUiEeq3Kaw0IwLf6BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789752770; c=relaxed/simple;
	bh=+MipdwgB9d8LhkU7pI5Fn9ExzsC+2EygZrsOkOi4Gvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nhTn2txLjEVPQ7OTVfBORbWcrD1Zx7GAhSiQAe7zXF7YwgfkSng/6Qr1jkvs5JQ1+CpAGVdESWj7t/MVOB2OT22jIRYRdflr4vSOs56a1cQHLie59OUjdKxAj7Gyy72l66jWVmzc8LzrAGSeFhmsT8hVZ8blQFzC3te5LRfycyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0aQiQJ9d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0aQiQJ9d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A6F31F00898;
	Fri, 18 Sep 2026 17:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789752765;
	bh=BuanVriHcbqPQQUX4nBe3Unkk+xi8JLt3kizAHx+IBo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=0aQiQJ9d5eoc2Rb8gAjNDbnU3FpbauR/JR6FyNbuTEWhJ46MztAJ8sf2FZj6mjPIi
	 vKFjWNxFdk7gagEEktZOERwqu81UFrQriLKCLF/wnbWAFbhTQEMCVQuzjAHxELt+3z
	 FPRJc09qZ2P6+fWM1SD6G/waL7EdMWzG4rAe2MgY=
Date: Fri, 18 Sep 2026 18:30:49 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Guixin Liu <kanie@linux.alibaba.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Shaikh Kamaluddin <shaikhkamal2012@gmail.com>,
	linux-cxl@vger.kernel.org, driver-core@lists.linux.dev
Subject: Re: [PATCH v4 0/2] cxl/memdev: Fix poison debugfs vs unbind deadlock
Message-ID: <2026091839-pennant-imperfect-0e46@gregkh>
References: <20260916025453.3532614-1-kanie@linux.alibaba.com>
 <be97d805-94e7-48a0-9812-446d08dab7ce@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be97d805-94e7-48a0-9812-446d08dab7ce@intel.com>

On Fri, Sep 18, 2026 at 08:26:28AM -0700, Dave Jiang wrote:
> 
> 
> On 9/15/26 7:54 PM, Guixin Liu wrote:
> > Writing a memdev poison debugfs file while cxl_mem is being unbound
> > deadlocks. Patch 2 fixes it by not waiting for the device lock in those
> > handlers. Patch 1 adds the trylock guard it uses.
> > 
> > Patch 2 does not build without patch 1, so the two need to travel
> > together.
> > 
> > Testing:
> > 
> > Reproduced on a QEMU CXL topology whose type3 devices advertise poison
> > inject support:
> > 
> >   while :; do echo 0 > /sys/kernel/debug/cxl/mem0/inject_poison; done &
> >   while :; do
> >       echo mem0 > /sys/bus/cxl/drivers/cxl_mem/unbind
> >       echo mem0 > /sys/bus/cxl/drivers/cxl_mem/bind
> >   done
> > 
> > Without the fix the unbind wedges within seconds. The three tasks
> > involved, from /proc/<pid>/stack:
> > 
> >   writer, state S, holds the debugfs reference and waits for the lock
> >     cxl_debugfs_poison_inject+0x25/0xa0 [cxl_mem]
> >     debugfs_attr_write+0x61/0xb0
> >     full_proxy_write+0xfc/0x1c0
> >     vfs_write+0x1d4/0xe60
> > 
> >   unbind, state D, holds the lock and waits for the reference to drain
> >     remove_one+0x27f/0x3d0
> >     debugfs_remove+0x44/0x60
> >     release_nodes+0xfa/0x2c0
> >     devres_release_all+0x113/0x1a0
> >     device_unbind_cleanup+0x76/0x260
> >     device_release_driver_internal+0x3eb/0x540
> >     unbind_store+0xde/0x100
> > 
> >   cxl_port workqueue, state D, blocked on the same lock
> >     device_release_driver_internal+0x96/0x540
> >     detach_memdev+0x79/0xb0 [cxl_core]
> >     process_one_work+0x6b0/0xfb0
> > 
> > The writer is in interruptible sleep and can be killed; the unbind
> > cannot, and because cxl_bus_wq is an ordered workqueue the wedged
> > detach_memdev() blocks every other CXL bus work item behind it.
> > 
> > The same deadlock shows up with a pciehp hot-remove racing the writer
> > loop: the pciehp thread hits the same debugfs_remove() drain holding
> > the memdev lock, and the hot-remove wedges the same way. With both
> > patches applied the hot-remove flow completes normally.
> > 
> > With both patches applied, 46 unbind/bind cycles against the same writer
> > loop all completed, no task was left in D state, and the writer collected
> > 10920 EBUSY returns from the contended trylock. Note that lockdep stays
> > quiet either way: one leg of the cycle is the debugfs active_users
> > completion rather than a lock it tracks.
> > 
> > v3 -> v4:
> > - reword the patch 2 commit message per Alison: enumerate the teardown
> >   paths that race a poison write into an unbind, and state that mixing
> >   poison writes with cxl_mem teardown is not a supported use of this
> >   debug ABI, though the fix keeps the cost of doing so to a failed write
> > - add the pciehp hot-remove reproduction, reported during v3 review,
> >   to the patch 2 commit message
> > - collect Jonathan's Reviewed-by on both patches (no code change)
> > 
> > v1 -> v2:
> > - add the device_trylock() guard and use ACQUIRE(device_try, ...) instead
> >   of open-coding device_trylock()/device_unlock(), keeping the style the
> >   Fixes: commit established (Shaikh Kamaluddin)
> > - cut the changelog down to the failing condition, the consequence and
> >   the fix; the call graph and the reproducer live here instead
> > - say how the issue was found and how it was tested
> > 
> > v2 -> v3:
> > - rebase onto v7.3-rc2 (master), per Dave's request to send the series
> >   against Linus's tags rather than cxl/next
> > 
> > v1:
> > https://lore.kernel.org/linux-cxl/20260826125248.4003792-1-kanie@linux.alibaba.com/
> > 
> > v2:
> > https://lore.kernel.org/linux-cxl/20260831124809.889829-1-kanie@linux.alibaba.com/
> > 
> > v3:
> > https://lore.kernel.org/linux-cxl/20260910094017.4032170-1-kanie@linux.alibaba.com/
> > 
> > Guixin Liu (2):
> >   driver core: Add conditional guard support for device_trylock()
> >   cxl/memdev: Fix deadlock between poison debugfs and cxl_mem unbind
> > 
> >  drivers/cxl/mem.c      | 14 ++++++++++----
> >  include/linux/device.h |  1 +
> >  2 files changed, 11 insertions(+), 4 deletions(-)
> > 
> 
> For the series
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> 
> Greg,
> I can take the patches through the CXL tree if you ack the first patch. Thanks!

Please do!

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
