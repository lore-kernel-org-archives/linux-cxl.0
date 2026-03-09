Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242DC29405
	for <linux-cxl@vger.kernel.org>; Mon,  9 Mar 2026 00:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773015056; cv=none; b=dMlyS3cCYRyBXZ+/SJSBnAaaiPws0CNB8EZ5osUM5KU7u/rpBT2nmGEZebS7cWbUDFfXzeeaRlNAhm2XZonsDr6BWrJdCyvbTUYxYqv0SCKQycFpNxB/6jOHVJ1Xn9dgX4q7P9pBUXDEOYg8kz2rEhZ5UoVgCkhGwTrFeMSB1uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773015056; c=relaxed/simple;
	bh=pXEEhVHwuVgT/fu21TaSjJ5tO5mqGtan/ccC2ML+GCU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t7AhxXfZyqvfaB1J/98UFSN0EDXXHxY/YiGGjBswvYNnkQ5jVa2kdV8k0jS+EdyM20SMP5YTeZS1InIa1m285j9ZK4xjue0H+gQUqWPJIawXWRbC5Prcmg+sLJLKuyTdT9ZHRUxlTvefkPaEu5JJFFTZs5UHczpGl/rtlI9pKZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7986d231b3cso138137657b3.1
        for <linux-cxl@vger.kernel.org>; Sun, 08 Mar 2026 17:10:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773015053; x=1773619853;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bGAMFu2DWaW1aHTsL/PoCzheLXQYvpCKBh0Ov44tQ/U=;
        b=ZqcSjy5JI7XWJRH9z7z8SrU3SkgnSpGD+EF4fCvnK+9UdErRCpMmJ4unH7p5myHk0R
         EeEPyT3r7x+EPw1pZhaIQbUWUtGgV5ibp2tAPywrWV2H7ScKkOpuOaVqmEFksvLtcN79
         yWrQh4Oh4WWG4eS9bMCHqFdqxI9lI6AQQVBqIK3+vYAOqLCWIqbTtMCUkto82pvYuMIB
         sMLbrJ4PTqL8O8q/emnZo+tuYlxeAa1ultu0nasGFcO/cbFuHZUeqKoDRwLESHpF+Ipl
         fGii0wNAQ574c8Q1uk7W5HkhqNbPX4Eck4vIwNAJR0cmF3sKAIxy0QceHYPM41Kfy5Ph
         LZDQ==
X-Forwarded-Encrypted: i=1; AJvYcCU17qZahfbtqujz4ny6fUGWKNDjdK/p5G9hmv+IergazAmi+4S+QRlOqOjL3bduij4+I8qakyXCPJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK+niCK13Jc5ZNkHKP4mi3iaJmEHu/ZJk88TxVzaPkf4J6dGbJ
	pUOxmuRoq0MgM2PYlftuFMV3Cu3ufOIIMr0L2YR1fXxPp+D9TD/+9SqS
X-Gm-Gg: ATEYQzz83bmccSVqyaJ7h22FmyWQEHHPo81XOn94Xn3AZawTKxx6d73IoZqtl46U9Cl
	c2x5LcJ4p1/KgFF1W1O9ER3ghdG/rs6444gsVAb5aKb+ACCGfYIeUu6FPosLjwBu3/sfyyOLohk
	R2a2VtKkESCMqN5jlEKF5KW/kNauqXSWmYfav9h6Ll//2SZEh+sB1VbJu4q+COAw8O5D3CvC/5J
	YLE4uqtiSnCjL6zR4Ev+XYn17zRkwXzwF/AX3+Eox7axDUQbGbg89nId1HtJaeJVXKCQwmUN5Ez
	9C1Ub8ihIiQS7xj6sP9FU/esY2j8+xmbe2FZdcjJA8gqaMVPOXjIq9P+9YpOCNa4UCOUYPQnq9d
	pgvgoWgjzGmVIDKTk/U/MPipegFWeXX02TbCKVi/p06zAe9qFBF351HpE66B6bLYf2fH//sLLq8
	fLrkJ7IpXOWA==
X-Received: by 2002:a05:690c:6983:b0:798:1637:ff29 with SMTP id 00721157ae682-798dd77fc95mr89858247b3.17.1773015053125;
        Sun, 08 Mar 2026 17:10:53 -0700 (PDT)
Received: from tofu.. ([128.210.0.165])
        by smtp.googlemail.com with ESMTPSA id 00721157ae682-798dee89fe0sm37890847b3.47.2026.03.08.17.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 17:10:52 -0700 (PDT)
From: Sungwoo Kim <iam@sung-woo.kim>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Ben Widawsky <bwidawsk@kernel.org>
Cc: Dave Tian <daveti@purdue.edu>,
	Sungwoo Kim <iam@sung-woo.kim>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] cxl/hdm: fix a warning in devm_remove_action()
Date: Sun,  8 Mar 2026 20:08:10 -0400
Message-ID: <20260309000810.2632065-2-iam@sung-woo.kim>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the following race scenario, devm_remove_action() can be called
before devm_add_action(), triggering a warning because there is no
action to remove.

To fix this, extend a critical section to embrace both
__cxl_dpa_reserve() and devm_add_action().

task 1:
cxl_dpa_alloc()
  __cxl_dpa_reserve()    ...(1)
  devm_add_action()      ...(4)

task 2:
cxl_dpa_free()
  guard()
  if (!cxled->dpa_res)   ...(2) pass, due to (1)
    return 0;
  devm_cxl_dpa_release()
    devm_remove_action()  ...(3) warning, no action is added yet

Warning log:

WARNING: ./include/linux/device/devres.h:160 at devm_remove_action include/linux/device/devres.h:160 [inline], CPU#0: syz.1.6464/25993
WARNING: ./include/linux/device/devres.h:160 at devm_cxl_dpa_release drivers/cxl/core/hdm.c:290 [inline], CPU#0: syz.1.6464/25993
WARNING: ./include/linux/device/devres.h:160 at cxl_dpa_free+0x2a4/0x320 drivers/cxl/core/hdm.c:572, CPU#0: syz.1.6464/25993
Modules linked in:
CPU: 0 UID: 0 PID: 25993 Comm: syz.1.6464 Not tainted 6.19.0-g15a37b05f387 #10 PREEMPT(lazy)
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
RIP: 0010:devm_remove_action include/linux/device/devres.h:160 [inline]
RIP: 0010:devm_cxl_dpa_release drivers/cxl/core/hdm.c:290 [inline]
RIP: 0010:cxl_dpa_free+0x2a4/0x320 drivers/cxl/core/hdm.c:572
Code: 01 31 ff 41 89 c4 89 c6 e8 a9 91 1d fe 45 85 e4 0f 85 55 ff ff ff e8 4b 96 1d fe 90 0f 0b 90 e9 47 ff ff ff e8 3d 96 1d fe 90 <0f> 0b 90 e9 63 ff ff ff bb f0 ff ff ff e9 68 ff ff ff 48 c7 c7 f4
RSP: 0018:ffff888129f77bb8 EFLAGS: 00010282
RAX: 00000000000000f3 RBX: ffff888102f64000 RCX: ffffffff837301d3
RDX: 0000000000080000 RSI: ffffc90001c5a000 RDI: 0000000000000005
RBP: 00000000fffffffe R08: 0000000000000001 R09: ffff888123f98000
R10: 00000000fffffffe R11: 0000000000000000 R12: 0000000000000001
R13: ffff888102f64040 R14: dffffc0000000000 R15: ffff888102f64000
FS:  00007fae0488d6c0(0000) GS:ffff88827086d000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000012f7d6003 CR4: 0000000000770ef0
PKRU: 80000000
Call Trace:
 <TASK>
 dpa_size_store+0xfb/0x230 drivers/cxl/core/port.c:269
 dev_attr_store+0x58/0x80 drivers/base/core.c:2437
 sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:142
 kernfs_fop_write_iter+0x3d6/0x5d0 fs/kernfs/file.c:352
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x68e/0x1050 fs/read_write.c:688
 ksys_write+0x12a/0x250 fs/read_write.c:740
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfc/0x670 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fae0399c669
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fae0488d028 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fae03c15fa0 RCX: 00007fae0399c669
RDX: 000000000000000a RSI: 00002000000001c0 RDI: 0000000000000009
RBP: 00007fae03a32c71 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fae03c16038 R14: 00007fae03c15fa0 R15: 00007ffe53519fb8
 </TASK>
irq event stamp: 1021
hardirqs last  enabled at (1029): [<ffffffffb7d04c4b>] __up_console_sem+0x7b/0x90 kernel/printk/printk.c:347
hardirqs last disabled at (1038): [<ffffffffb7d04c30>] __up_console_sem+0x60/0x90 kernel/printk/printk.c:345
softirqs last  enabled at (1016): [<ffffffffb7b73b93>] __do_softirq kernel/softirq.c:656 [inline]
softirqs last  enabled at (1016): [<ffffffffb7b73b93>] invoke_softirq kernel/softirq.c:496 [inline]
softirqs last  enabled at (1016): [<ffffffffb7b73b93>] __irq_exit_rcu+0xb3/0xe0 kernel/softirq.c:723
softirqs last disabled at (1005): [<ffffffffb7b73b93>] __do_softirq kernel/softirq.c:656 [inline]
softirqs last disabled at (1005): [<ffffffffb7b73b93>] invoke_softirq kernel/softirq.c:496 [inline]
softirqs last disabled at (1005): [<ffffffffb7b73b93>] __irq_exit_rcu+0xb3/0xe0 kernel/softirq.c:723

Fixes: cf880423b6a0 ("cxl/hdm: Add support for allocating DPA to an endpoint decoder")
Fixes: 9c57cde0dcbd ("cxl/hdm: Enumerate allocated DPA")
Signed-off-by: Sungwoo Kim <iam@sung-woo.kim>
---
 drivers/cxl/core/hdm.c | 34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index e3f0c39e68124..86239b1790a31 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -509,13 +509,20 @@ int devm_cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
 	struct cxl_port *port = cxled_to_port(cxled);
 	int rc;
 
-	scoped_guard(rwsem_write, &cxl_rwsem.dpa)
-		rc = __cxl_dpa_reserve(cxled, base, len, skipped);
+	guard(rwsem_write)(&cxl_rwsem.dpa);
+	rc = __cxl_dpa_reserve(cxled, base, len, skipped);
 
 	if (rc)
 		return rc;
 
-	return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);
+	/* See comments in cxl_dpa_alloc()*/
+	rc = devm_add_action(&port->dev, cxl_dpa_release, cxled);
+	if (rc) {
+		__cxl_dpa_release(cxled);
+		return rc;
+	}
+
+	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_dpa_reserve, "CXL");
 
@@ -613,7 +620,7 @@ static int __cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size)
 	struct resource *p, *last;
 	int part;
 
-	guard(rwsem_write)(&cxl_rwsem.dpa);
+	lockdep_assert_held_write(&cxl_rwsem.dpa);
 	if (cxled->cxld.region) {
 		dev_dbg(dev, "decoder attached to %s\n",
 			dev_name(&cxled->cxld.region->dev));
@@ -679,11 +686,28 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size)
 	struct cxl_port *port = cxled_to_port(cxled);
 	int rc;
 
+	guard(rwsem_write)(&cxl_rwsem.dpa);
 	rc = __cxl_dpa_alloc(cxled, size);
 	if (rc)
 		return rc;
 
-	return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);
+	/*
+	 * Add the devres action while still holding cxl_rwsem.dpa to prevent
+	 * a race with cxl_dpa_free(). Without this, a concurrent cxl_dpa_free()
+	 * can observe dpa_res set (by __cxl_dpa_reserve()) and attempt
+	 * devm_remove_action() before devm_add_action() has been called,
+	 * triggering a WARN_ON in devm_remove_action().
+	 * Also, devm_add_action_or_reset() cannot be used here because
+	 * cxl_dpa_release() tries to hold the dpa lock that is already held,
+	 * causing a self deadlock.
+	 */
+	rc = devm_add_action(&port->dev, cxl_dpa_release, cxled);
+	if (rc) {
+		__cxl_dpa_release(cxled);
+		return rc;
+	}
+
+	return 0;
 }
 
 static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
-- 
2.47.3

