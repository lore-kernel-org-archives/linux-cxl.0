Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8602330B0E
	for <linux-cxl@vger.kernel.org>; Wed, 12 Aug 2026 06:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786514993; cv=none; b=gvAaXRUSlZk/8GXyTzIftxazlYBLXxf6+ECkvRg0wgL/borAPNK/puAWqDBgBSshGy23rFYrISv12VsL7RAMABGJTXNARtEV6ZRoi+GzdobK6K/cHZh0E5gO9UANu1QvVL6i+yY8r/pWFmpZfaM6a0UTT8jWMsQrpvNxbcP7gZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786514993; c=relaxed/simple;
	bh=cgX/NLvWu4ijo7rfdqCZ4OJKSWim4LEpqh4SgVsasLA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PnpVp6qJ81TY4tx9gHZc0GOAOvETV9bnA+IFYyP8r6+VZ5hxKk1uBneNPl8yF4AMva6RtV/v8t4Fpam2jYs6Cb0V73qWCoLAplPdesEWSNsKMROqR/lcU4O/ODg3lx7Jy7j4eSgjMUqv8j4mAh+35YFQ88JuoMsQ21KnO10PpB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=RjrtRA81; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="RjrtRA81"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1786514984; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=vfGggJWJDwGjh+rDlLE3u+NfMGE/y9eOjB2iTJnoMfs=;
	b=RjrtRA81KCN2hHEqAXPMTjTwky7BheXgkkCp91WqXTTJIS2QxoHHKrPe8CMrLyEwES/8yLWAeMmqXJ1Rho8NwBtMYU5SgTq7XCzuXGbPo7O0jipN80Xp+qVu27+RfLIozLyUaoEiT0PxqQoj2swdvOMKfSpQawgUzfNfo3E2/QE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0X8qj294_1786514983;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X8qj294_1786514983 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 12 Aug 2026 14:09:44 +0800
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
Subject: [PATCH v2] cxl/core: Fix dport use-after-free via the einj_inject debugfs file
Date: Wed, 12 Aug 2026 14:09:43 +0800
Message-ID: <20260812060943.56246-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cxl_debugfs_create_dport_dir() publishes a debugfs directory containing an
"einj_inject" file whose i_private is the 'struct cxl_dport', then discards
the returned dentry and registers nothing to remove it. The other per-dport
facility set up next to it in __devm_cxl_add_dport(),
devm_cxl_dport_ras_setup(), binds its resources to dport_to_host(dport) so
that they go away with the dport. The debugfs directory has no such owner:
it lives until cxl_core is unloaded and cxl_core_exit() tears down the
whole cxl/ tree.

The dport itself is freed much earlier. free_dport() is registered in the
dport's devres group, so the dport is freed when the host device is
unbound, which is an ordinary sysfs operation on the host bridge port or
the ACPI0017 root, not a module-teardown-only path. After that unbind the
einj_inject file is still there, and a write to it calls cxl_einj_inject()
on freed memory, reading dport->rch and dport->dport_dev and passing them
to the EINJ code.

Re-binding the topology does not recover either. The stale directory keeps
the dport device's name, so the second creation finds the name in use,
debugfs setup fails, and error injection is silently unavailable for that
dport for the remaining lifetime of the module.

Keep the dentry and remove the directory from a devm action on the dport's
host device. The action is registered after free_dport() within the same
devres group, so release ordering runs it before the dport is freed. Its
registration failure is deliberately not propagated, following
devm_cxl_dport_ras_setup(): a missing debugfs directory is not a
functional failure of the dport, and on that path
devm_add_action_or_reset() has already removed the directory itself, so
there is no dangling node left and nothing to gain from failing the dport
addition.

Fixes: 8039804cfa73 ("cxl/core: Add CXL EINJ debugfs files")
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
This was patch 3/8 of the "cxl: Assorted fixes" series [1]. Per review
feedback that series is not being reworked as a whole; the fixes are resent
individually instead. Patches 1, 2 and 7 of the series are dropped, as those
issues are already fixed in cxl/next.

v1->v2:
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

