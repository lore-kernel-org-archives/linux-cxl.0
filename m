Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702B7353A8A
	for <linux-cxl@vger.kernel.org>; Fri, 28 Aug 2026 07:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787903288; cv=none; b=jWMFQFeWaOOcvTanVN0g6gv8D0gDV/1OIYOV72+XJC7cqCT78s5WWZVXZca60X7bmwbcOgsbAmNvOaNaEzEH+1hSDEL0X4nVHuL8w0zEvNqwZpcMxena+1q7UgJmRl0S9YhgAdG3+GzbC0aOvzi9g6FBQe6wzxbjPgl8YdOX4Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787903288; c=relaxed/simple;
	bh=8l78m1Np1VEONbO7dy/+fu1e3hNGTp5xy6XV4xXcC/4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jNTFIT4S1WkkNMJeGYGBxHtGuqbpRy93pWmybXqEH2H2vlMTjPcEPkviLURtOXWYZmyp74GMHYbUVCJocvKMyv8mVwLOVtTjW5qbnMZHZTeBqRJxcH5dXzBlnRLhf9rPM3H8AX+e/SQvzc8X+h2WyV52/VmThajBZ5yAr5qp6jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=WZ1wI2JK; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="WZ1wI2JK"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1787903277; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=/xC4/IadbyQqUo7+Nl3Pg1WvCdBVa4hgZ4fruO1iXVQ=;
	b=WZ1wI2JKVQTOqZ4DLHoqJ5SXY8/HlLIodm9VEIYYrovoTxSek++/XjBv0LoF8EmcIzz5jedj3v6O7aV0t8tradw+jHJMEIwNb9xM/6oGUmgxLc3tevoRETS3CnEMvjSFhJVzgnZDr9RKfze9Y2sj7u84tfSOq36Ogak0AD1eneI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0X9lrKe._1787903276;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X9lrKe._1787903276 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 28 Aug 2026 15:47:56 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v3] cxl/core: Fix dport use-after-free via the einj_inject debugfs file
Date: Fri, 28 Aug 2026 15:47:52 +0800
Message-ID: <20260828074752.3336779-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The per-dport einj_inject debugfs file retains a pointer to the
'struct cxl_dport', but its lifetime is not tied to the dport. Unbinding
the dport host frees the dport and leaves einj_inject behind, so writing
the file dereferences freed memory:

  BUG: KASAN: slab-use-after-free in cxl_einj_inject+0xa1/0xf0 [cxl_core]
  Read of size 1 at addr ffff88810880ac90 by task bash/1690
   cxl_einj_inject+0xa1/0xf0 [cxl_core]
   debugfs_attr_write+0x61/0xb0
   full_proxy_write+0xfc/0x1c0
   vfs_write+0x1d4/0xe60
  Allocated by task 213:
   __devm_cxl_add_dport+0x1e1/0x14d0 [cxl_core]
   cxl_port_add_dport+0xd6/0x200 [cxl_port]
  Freed by task 1622:
   release_nodes+0xfa/0x2c0
   devres_release_all+0x113/0x1a0
   device_unbind_cleanup+0x76/0x260
   unbind_store+0xde/0x100

The stale directory also prevents recreation on rebind.

Remove the per-dport debugfs directory when the dport host is released.

Found by code inspection, then reproduced on a QEMU CXL topology with
KASAN (the einj_cxl_is_initialized() guard had to be forced open, as
QEMU emits no EINJ table). Unpatched, writing the leftover file after
unbind gives the splat above, and rebind hits "already exists in
'cxl'". Patched, the directory goes away with the dport and rebind
recreates a working einj_inject.

Fixes: 8039804cfa73 ("cxl/core: Add CXL EINJ debugfs files")
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
Reviewed-by: Richard Cheng <icheng@nvidia.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
---
This was patch 3/8 of the "cxl: Assorted fixes" series [1]. Per review
feedback that series is not being reworked as a whole; the fixes are resent
individually instead.

Exact steps behind the testing paragraph above, on a QEMU topology with two
root ports under a host bridge port plus a switch, KASAN enabled:

  # find the per-dport dir and the cxl_port that hosts the dport
  find /sys/kernel/debug/cxl -name einj_inject
  ls -d /sys/bus/cxl/devices/port1/dport*

  echo port1 > /sys/bus/cxl/drivers/cxl_port/unbind
  # unpatched: /sys/bus/cxl/devices/port1/dport0 is gone but
  #            /sys/kernel/debug/cxl/0000:34:00.0/einj_inject remains
  # patched:   /sys/kernel/debug/cxl/0000:34:00.0 is gone too

  echo 0x1 > /sys/kernel/debug/cxl/0000:34:00.0/einj_inject
  # unpatched: the KASAN splat quoted in the commit message
  # patched:   no such file; no KASAN report for the whole boot
  # 0x1 is deliberately not a CXL error type, so both inject paths return
  # -EINVAL from einj_is_cxl_error_type() after the dport read

  echo port1 > /sys/bus/cxl/drivers/cxl_port/bind
  for m in mem0 mem1 mem2; do echo $m > /sys/bus/cxl/drivers/cxl_mem/bind; done
  # unpatched: debugfs: '0000:34:00.0' already exists in 'cxl'
  #            and a write to the surviving file still faults, at a different
  #            address than the new dport, i.e. still the old freed one
  # patched:   both einj_inject files recreated, write returns -EINVAL

v2 -> v3:
- no code change; drivers/cxl/core/port.c is byte-identical to v2, so
  Richard's and Li Ming's Reviewed-by from v2 are carried forward. Only the
  commit message differs, please shout if you would rather re-review.
- cut the commit message down to the problem, its impact and the fix, and
  quote the KASAN splat rather than narrating the code (Alison Schofield)
- say how the issue was found and what was actually tested
  (Alison Schofield)

v1 -> v2:
- do not propagate the devm_add_action_or_reset() failure out of
  cxl_debugfs_create_dport_dir(); a missing debugfs directory must not fail
  the dport addition (Li Ming)
- rebase onto cxl/next
- rewrite the commit message to describe the behaviour rather than narrate
  the code change (Alison Schofield)

[1] https://lore.kernel.org/linux-cxl/20260811113608.2815625-1-kanie@linux.alibaba.com/

 drivers/cxl/core/port.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 625e4aa427db..62a9c2038d1f 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -814,6 +814,11 @@ static int cxl_einj_inject(void *data, u64 type)
 DEFINE_DEBUGFS_ATTRIBUTE(cxl_einj_inject_fops, NULL, cxl_einj_inject,
 			 "0x%llx\n");
 
+static void remove_debugfs(void *dentry)
+{
+	debugfs_remove_recursive(dentry);
+}
+
 static void cxl_debugfs_create_dport_dir(struct cxl_dport *dport)
 {
 	struct cxl_port *parent = parent_port_of(dport->port);
@@ -834,6 +839,8 @@ static void cxl_debugfs_create_dport_dir(struct cxl_dport *dport)
 
 	debugfs_create_file("einj_inject", 0200, dir, dport,
 			    &cxl_einj_inject_fops);
+
+	devm_add_action_or_reset(dport_to_host(dport), remove_debugfs, dir);
 }
 
 static int cxl_port_add(struct cxl_port *port,

base-commit: 7098e9cd98a05c0c5de2fae0c2465f9d966fdd07
-- 
2.43.7

