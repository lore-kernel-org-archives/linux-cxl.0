Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7575E30F95E
	for <linux-cxl@vger.kernel.org>; Sun,  8 Mar 2026 19:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772996487; cv=none; b=Va/KwhJ/TXsI6x5Ld0T9ZtQHousZz+AuZpJvxK/fW5w9ig+aaFqqDhxwEUdTk9JP7boZP6pYRj/dXWLlaFk+oLTlGQAviSIGji9oa+z3mzaS5S4cEXV2DccCO/z7W8TB+ZOIiWTtYDV8YQdzT9x8jiK4JDGpviSbKyRgaTVAuAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772996487; c=relaxed/simple;
	bh=kwNjh7nBz0/ihSOH2k9NfMPYUQJjAIxEcy5DnS/C7r0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=igVJjKoGhCo2Wx2HGvD1h+koqJ8ZAVdpwxuQy/tohziMV02fp+SeyVw8dt3UaAHiDozjyj3ut2ckwbUGzuzKHdYQOMIunSrjLXXapTn5IF6USFsrAwIySYMsGe+VL/ppF3kuie90cHmzu39uiyAIyt7m797ZvnDBI9lNpq0/y5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-79800183233so147661357b3.1
        for <linux-cxl@vger.kernel.org>; Sun, 08 Mar 2026 12:01:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772996485; x=1773601285;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F5H35xhS3P8RWoUbWgTUSKLhPQ8zUPaXAMXnOLUpuWg=;
        b=SUrYZhL+rKaZ9U2V3w/We+TahNtSni/dG2d7/QrNQW856Wb+LaFBnhtX8fyUYx/1qT
         s4N4g1ZuyaQKjbslXKsACrtp7X3uMFtwM87r3+aeDE5fD88tUqKg+15ZzDhPPZOpVwWk
         1e9+AfBCaPFIKQDRv9B/IVE5kqz6Ud+PSqquQh3eJPW9NB5baDKrJ3Wol4wzwP+bajlw
         Fla24bL5LW11xkxOt1e+nGlX2aiXZ2bp0TmhbMDapgKymaeCyncYuDMNYOCqCCUZhX6F
         tqAMkeQpGs9DVtrYYg3z1eM5CrSC/6hgyUW3KQbXjY6HQ83kgsN7wdq4FeBfy1fIeBP0
         vuog==
X-Forwarded-Encrypted: i=1; AJvYcCUy2Raw71X7RCdcrP5JFyaW3RZJXFu62ebOiZsit07FJseK8Zd9+pS1RVC6THzbI22PJBOeYrISAjk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIdNeOgaiCqd02UbjxL0kjYHFoVwAHG41F9d39Rawr4X9Tq6fN
	qUlCwXycm3P4mzshetDvn9t8EN8p10hAA5ay2/NsKov4iNfVJOwTA/RM
X-Gm-Gg: ATEYQzxldcF7rHRGmQFWCkNZXkqmnT0Hq7xPp+8XLF61nv3WxE7eSyda9abcnDH308i
	ozt/dP44NQerdNOKehS2f7tmRanw0ivDHEqXeEgJVrGQVx4wLd7g+afiSUIZjIuJt3c6aEuE6gu
	2TdMFIqZQe13xKsurs6RIogzOutpIRo2iuS7V1zBkLeSd0AhoPd/s2VCMg4zuiUcUyrbOwT0p/e
	dNG9r1N2kgz2fD+jiUDECwZQY5bz2F9BPLj4/Aw6VpTHKn+fxQ+J/rhOpRfbV8yqzIBMG+RWvE/
	jPTKaUL2DStMh/0+TTewne6S/C3ou35zd97NuXiVpaITaV9XGJhBaHMSERQ3LB/+UePqNt05ucc
	rxTw2jDyoyiPljaBlIbpK9doacEHg3fl/wR777h5EiEeeDsifB3TGEXhY76rd2C6SWAbANAaXqS
	Csk7/SbKVwOQ==
X-Received: by 2002:a05:690c:2602:b0:796:2f6c:70b7 with SMTP id 00721157ae682-798d1eebf8emr102505307b3.27.1772996485435;
        Sun, 08 Mar 2026 12:01:25 -0700 (PDT)
Received: from tofu.. ([128.210.0.165])
        by smtp.googlemail.com with ESMTPSA id 00721157ae682-798decdd38dsm34981287b3.21.2026.03.08.12.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 12:01:24 -0700 (PDT)
From: Sungwoo Kim <iam@sung-woo.kim>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Ben Widawsky <bwidawsk@kernel.org>
Cc: daveti@purdue.edu,
	Sungwoo Kim <iam@sung-woo.kim>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] cxl/region: Fix a race bug in delete_region_store
Date: Sun,  8 Mar 2026 14:59:58 -0400
Message-ID: <20260308185958.2453707-2-iam@sung-woo.kim>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A race exists when two concurrent sysfs writes to delete_region specify
the same region name. Both calls succeed in cxl_find_region_by_name()
(which only does device_find_child_by_name and takes a reference), and
both then proceed to call devm_release_action(). The first call atomically
removes and releases the devres entry successfully. The second call finds
no matching entry, causing devres_release() to return -ENOENT, which trips
the WARN_ON.

Fix this by replacing devm_release_action() with devm_remove_action_nowarn()
followed by a manual call to unregister_region(). devm_remove_action_nowarn()
removes the devres tracking entry and returns an error code.

------------[ cut here ]------------
WARNING: drivers/base/devres.c:824 at devm_release_action drivers/base/devres.c:824 [inline], CPU#0: syz.1.12224/47589
WARNING: drivers/base/devres.c:824 at devm_release_action+0x2b2/0x360 drivers/base/devres.c:817, CPU#0: syz.1.12224/47589
Modules linked in:
CPU: 0 UID: 0 PID: 47589 Comm: syz.1.12224 Not tainted 6.19.0-g15a37b05f387 #10 PREEMPT(lazy) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
RIP: 0010:devm_release_action drivers/base/devres.c:824 [inline]
RIP: 0010:devm_release_action+0x2b2/0x360 drivers/base/devres.c:817
Code: 41 5c 41 5d 41 5e 41 5f e9 86 1a b3 fd e8 86 71 33 fe e8 81 71 33 fe 48 8b 74 24 08 4c 89 f7 e8 04 34 8a 01 e8 6f 71 33 fe 90 <0f> 0b 90 eb c6 e8 64 71 33 fe 90 0f 0b e8 2c f1 71 fe e9 f4 fd ff
RSP: 0018:ffff88813e5f7bf8 EFLAGS: 00010282
RAX: 0000000000000125 RBX: dffffc0000000000 RCX: ffffffff835d26a1
RDX: 0000000000080000 RSI: ffffc9000685b000 RDI: ffffffff8e875adf
RBP: ffff888101059010 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffff888101059428
R13: ffff888100e05c30 R14: ffff8881010593e8 R15: ffff888101059428
FS:  00007fae6afb46c0(0000) GS:ffff8882a526d000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fae6a12b8c0 CR3: 0000000127f1b005 CR4: 0000000000770ef0
PKRU: 80000000
Call Trace:
 <TASK>
 delete_region_store+0x106/0x1d0 drivers/cxl/core/region.c:2753
 dev_attr_store+0x58/0x80 drivers/base/core.c:2437
 sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:142
 kernfs_fop_write_iter+0x3d6/0x5d0 fs/kernfs/file.c:352
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x68e/0x1050 fs/read_write.c:688
 ksys_write+0x12a/0x250 fs/read_write.c:740
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfc/0x670 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fae6a19c669
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fae6afb4028 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fae6a415fa0 RCX: 00007fae6a19c669
RDX: 0000000000000008 RSI: 0000200000000580 RDI: 0000000000000005
RBP: 00007fae6a232c71 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fae6a416038 R14: 00007fae6a415fa0 R15: 00007ffc10522c58
 </TASK>
irq event stamp: 885
hardirqs last  enabled at (893): [<ffffffff8b104c4b>] __up_console_sem+0x7b/0x90 kernel/printk/printk.c:347
hardirqs last disabled at (902): [<ffffffff8b104c30>] __up_console_sem+0x60/0x90 kernel/printk/printk.c:345
softirqs last  enabled at (822): [<ffffffff8af73b93>] __do_softirq kernel/softirq.c:656 [inline]
softirqs last  enabled at (822): [<ffffffff8af73b93>] invoke_softirq kernel/softirq.c:496 [inline]
softirqs last  enabled at (822): [<ffffffff8af73b93>] __irq_exit_rcu+0xb3/0xe0 kernel/softirq.c:723
softirqs last disabled at (811): [<ffffffff8af73b93>] __do_softirq kernel/softirq.c:656 [inline]
softirqs last disabled at (811): [<ffffffff8af73b93>] invoke_softirq kernel/softirq.c:496 [inline]
softirqs last disabled at (811): [<ffffffff8af73b93>] __irq_exit_rcu+0xb3/0xe0 kernel/softirq.c:723
---[ end trace 0000000000000000 ]---

Fixes: 779dd20cfb56 ("cxl/region: Add region creation support")
Signed-off-by: Sungwoo Kim <iam@sung-woo.kim>
---
 drivers/cxl/core/region.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 08fa3deef70ab..7ade9aa2aeecc 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2745,12 +2745,19 @@ static ssize_t delete_region_store(struct device *dev,
 	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev);
 	struct cxl_port *port = to_cxl_port(dev->parent);
 	struct cxl_region *cxlr;
+	int err;
 
 	cxlr = cxl_find_region_by_name(cxlrd, buf);
 	if (IS_ERR(cxlr))
 		return PTR_ERR(cxlr);
 
-	devm_release_action(port->uport_dev, unregister_region, cxlr);
+	err = devm_remove_action_nowarn(port->uport_dev, unregister_region,
+				       cxlr);
+	if (err) {
+		put_device(&cxlr->dev);
+		return err;
+	}
+	unregister_region(cxlr);
 	put_device(&cxlr->dev);
 
 	return len;
-- 
2.47.3

