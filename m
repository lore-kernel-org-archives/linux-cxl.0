Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9958E3AAF4D
	for <linux-cxl@vger.kernel.org>; Wed, 16 Sep 2026 02:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789527307; cv=none; b=DABimBUeXTEImnBJsD9yygLds9U6GpAYG6SA2aLAj7uyzpXKtpbizeEqW4Sxyck9kUd8D8wQydkKpf/VG/dGGdf3772CVSxjBwOXq/kf15X7ZadkiBF4/D9abdMDNJvCk8Ml08Bs7RaymbUBMVbwXnj9z1xODYWJfLLL8sMTK7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789527307; c=relaxed/simple;
	bh=XoyW/LqrHyY96ZKhhusUTDPQzvSPWv9Pwq9/zGRx6kc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LpmgzCqCkU+aFFcp6IrzKIKLMaEOsj+48opalspko4M/UFu82PHFxfNVZ1MBcrSzaKj2FUqNOt1u3eV/ruIiG3IbdBbbyRUWcu1L+EK+UyjJ9qaEBPPwMUNeW3cEkRrDJW6/73ClmJK+7xnvl/n/XX7iXn9ne2+WwxOHeXFJlY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=QkXXOFmo; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="QkXXOFmo"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1789527302; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Fkjz7gi2nwbPl6/DxAeMgmmXt6CPx/IGyGzZ9JlNlh8=;
	b=QkXXOFmo/ybQzv4HMjS22R9pHI+KyxuuSUVJvi6zQRsu03iJewDD8hUaSL3Csy0SaqXNHzBN2MZzbI828/eNy3Rhlu9CwjlOhE4M283FWTvqPAuzp5pUBo4P9WU453EmtwO7SfJNQS1sd7eVwYgsPYaUhXCCQ/ZEWX143XXACpY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0XB3US2U_1789527300;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XB3US2U_1789527300 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 16 Sep 2026 10:55:01 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
Cc: linux-cxl@vger.kernel.org,
	driver-core@lists.linux.dev
Subject: [PATCH v4 0/2] cxl/memdev: Fix poison debugfs vs unbind deadlock
Date: Wed, 16 Sep 2026 10:54:51 +0800
Message-ID: <20260916025453.3532614-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Writing a memdev poison debugfs file while cxl_mem is being unbound
deadlocks. Patch 2 fixes it by not waiting for the device lock in those
handlers. Patch 1 adds the trylock guard it uses.

Patch 2 does not build without patch 1, so the two need to travel
together.

Testing:

Reproduced on a QEMU CXL topology whose type3 devices advertise poison
inject support:

  while :; do echo 0 > /sys/kernel/debug/cxl/mem0/inject_poison; done &
  while :; do
      echo mem0 > /sys/bus/cxl/drivers/cxl_mem/unbind
      echo mem0 > /sys/bus/cxl/drivers/cxl_mem/bind
  done

Without the fix the unbind wedges within seconds. The three tasks
involved, from /proc/<pid>/stack:

  writer, state S, holds the debugfs reference and waits for the lock
    cxl_debugfs_poison_inject+0x25/0xa0 [cxl_mem]
    debugfs_attr_write+0x61/0xb0
    full_proxy_write+0xfc/0x1c0
    vfs_write+0x1d4/0xe60

  unbind, state D, holds the lock and waits for the reference to drain
    remove_one+0x27f/0x3d0
    debugfs_remove+0x44/0x60
    release_nodes+0xfa/0x2c0
    devres_release_all+0x113/0x1a0
    device_unbind_cleanup+0x76/0x260
    device_release_driver_internal+0x3eb/0x540
    unbind_store+0xde/0x100

  cxl_port workqueue, state D, blocked on the same lock
    device_release_driver_internal+0x96/0x540
    detach_memdev+0x79/0xb0 [cxl_core]
    process_one_work+0x6b0/0xfb0

The writer is in interruptible sleep and can be killed; the unbind
cannot, and because cxl_bus_wq is an ordered workqueue the wedged
detach_memdev() blocks every other CXL bus work item behind it.

The same deadlock shows up with a pciehp hot-remove racing the writer
loop: the pciehp thread hits the same debugfs_remove() drain holding
the memdev lock, and the hot-remove wedges the same way. With both
patches applied the hot-remove flow completes normally.

With both patches applied, 46 unbind/bind cycles against the same writer
loop all completed, no task was left in D state, and the writer collected
10920 EBUSY returns from the contended trylock. Note that lockdep stays
quiet either way: one leg of the cycle is the debugfs active_users
completion rather than a lock it tracks.

v3 -> v4:
- reword the patch 2 commit message per Alison: enumerate the teardown
  paths that race a poison write into an unbind, and state that mixing
  poison writes with cxl_mem teardown is not a supported use of this
  debug ABI, though the fix keeps the cost of doing so to a failed write
- add the pciehp hot-remove reproduction, reported during v3 review,
  to the patch 2 commit message
- collect Jonathan's Reviewed-by on both patches (no code change)

v1 -> v2:
- add the device_trylock() guard and use ACQUIRE(device_try, ...) instead
  of open-coding device_trylock()/device_unlock(), keeping the style the
  Fixes: commit established (Shaikh Kamaluddin)
- cut the changelog down to the failing condition, the consequence and
  the fix; the call graph and the reproducer live here instead
- say how the issue was found and how it was tested

v2 -> v3:
- rebase onto v7.3-rc2 (master), per Dave's request to send the series
  against Linus's tags rather than cxl/next

v1:
https://lore.kernel.org/linux-cxl/20260826125248.4003792-1-kanie@linux.alibaba.com/

v2:
https://lore.kernel.org/linux-cxl/20260831124809.889829-1-kanie@linux.alibaba.com/

v3:
https://lore.kernel.org/linux-cxl/20260910094017.4032170-1-kanie@linux.alibaba.com/

Guixin Liu (2):
  driver core: Add conditional guard support for device_trylock()
  cxl/memdev: Fix deadlock between poison debugfs and cxl_mem unbind

 drivers/cxl/mem.c      | 14 ++++++++++----
 include/linux/device.h |  1 +
 2 files changed, 11 insertions(+), 4 deletions(-)

-- 
2.43.7

