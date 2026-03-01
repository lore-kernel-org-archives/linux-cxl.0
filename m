Received: from buffalo.tulip.relay.mailchannels.net (buffalo.tulip.relay.mailchannels.net [23.83.218.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF25A3B2AA
	for <linux-cxl@vger.kernel.org>; Sun,  1 Mar 2026 22:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772403480; cv=pass; b=OKGQxGXo9Z0qCtweDwSQ/V223HMkSjlI6VuvLtkd8xKv4troBgYTu2Ad6/khDxh20ULdBZe4zfoXvUzGTVGSBeJnF8vTH6Jn8mCV7sNJsKLNAG2MVoWH+5JYn3qC3OVEZlE3bWDuCI/MjiuBYTO2X6jqoCfEW24KhzV1GhS5I7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772403480; c=relaxed/simple;
	bh=EIpRXf34l3+ewfOwknI58ufa0xiFg2OsSOW0sMrltTY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XJbsFMAJD9zfwmCfV3qKQ4aJcfdkCg11WU+sFYxGhiJnSXrZ4Sc+OuXJkOwx9bszy3tAZ11bdD7GrTa38iGmORq6arb0wnnSBgPs29ETHOI1G3JZpOYoU0SmDOwHrDPgcrXnU/fSEgX2zCG31iOcXAEE+Kc1hiY4Qvo3FHhg2u8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=lpAbeNlm; arc=pass smtp.client-ip=23.83.218.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="lpAbeNlm"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id A06FD462440;
	Sun, 01 Mar 2026 22:17:53 +0000 (UTC)
Received: from pdx1-sub0-mail-a204.dreamhost.com (100-110-51-5.trex-nlb.outbound.svc.cluster.local [100.110.51.5])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 3558A4623FC;
	Sun, 01 Mar 2026 22:17:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1772403473;
	b=LisrnUNtawB4eflpTN9brh2y0l1nGluIKQ3adgsqXXcXFuVFa8PsmrxvLBtrNAiiYD3W41
	poJkmIMclN2RbBKov5mWQ8KNkBqN7MRyLTvkbWR6AAB2UElnMJf3BzHBoq+Su1GO7VgU3o
	53Ll8hryen17qYul3iXeQUXoO9EZI4D4eVzE5TFrSXQXUw5/3ME1SfsbnMPClluhKwu7c2
	s/rMAo142YLQScPVlPWFTjxfIZMvqUGEZG1q2Q7sdsB0F9qqmAVqQRew37oPMGApuc9+We
	0S/+hoZJlQAF579V+EeSVPoSCZEZhn8gPynQgHV+ajJWIFH/gn7zDZnru7PdHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1772403473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=NIAUP+KEGox+vun8+ef2xVLMmdUj0SALd7GBPSTxjcU=;
	b=IamEupyPaJVpSfA5pb6pv+1cFLt1YaTATITg1XE/leRMBIqQFzQg64Q4Uj9TSfXW+k1NYM
	0pqnEnC/sjq097DU8VbUHmS2fdticMAaYTFKOocyhMG39/X/D0Y37EeKE/+4zj82Hufwfj
	kWEF/Rw2WiaFOkMyjYcjZ7t/A2jugFGJFbiPzIHE82aRKdaDcACdIsSu5ahBx8Db7rvz4+
	gSK4TMrL8MNXiYagytYcIqTiJiGIcuECM7K4uSOmn5Y7hgbN2IB0MmluaGBXqufrYF9lwg
	bXblVz9uWTODyVDo6RTLQG47jiu9rRw3jhQaCTOrd9ZTssvgpnFubIe/MMbptg==
ARC-Authentication-Results: i=1;
	rspamd-6fbd58c58b-9chvd;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Vacuous-Exultant: 6eafc5de19f29f3d_1772403473467_1736561549
X-MC-Loop-Signature: 1772403473467:988673757
X-MC-Ingress-Time: 1772403473466
Received: from pdx1-sub0-mail-a204.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.110.51.5 (trex/7.1.3);
	Sun, 01 Mar 2026 22:17:53 +0000
Received: from offworld.lan (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a204.dreamhost.com (Postfix) with ESMTPSA id 4fPGf84LcRzNg;
	Sun,  1 Mar 2026 14:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1772403473;
	bh=NIAUP+KEGox+vun8+ef2xVLMmdUj0SALd7GBPSTxjcU=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=lpAbeNlms/qZzHA2HN8w96YL7SQ5OtLiZJnA0+JKPGrbmjoIVdcQc5mdCEPGFhY8C
	 8nhyY5s/lxrg/ic3LmkDD+XbTLNfNib153FhLajC1NzM2TgsZXrOl0fZysBE6Sd2Dz
	 Ko3+w5DDyFuxXMjX78/iNvh1R8ziotZSXY0bfCD55oGbafAU2+dS+FO/y2PFwhIxNz
	 1DYRQ3TB5lnL4ovWkgv7y4vF73JBfdIgnmKQYBIHqPQ0cte/UcMhqzvxtk1nG6lbkU
	 mt64MQM0veomwkwpV65bnqdUTExlCCi0hXjkd3jjvtw0dr6cTQ+Zvv5dYBMFvZVsOw
	 8MlEKGkWRRr5g==
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com
Cc: jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	linux-cxl@vger.kernel.org,
	Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH] cxl/mbox: Use proper endpoint validity check upon sanitize
Date: Sun,  1 Mar 2026 14:17:39 -0800
Message-Id: <20260301221739.1726722-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fuzzying CXL triggered:

BUG: KASAN: null-ptr-deref in cxl_num_decoders_committed+0x3e/0x80 drivers/cxl/core/port.c:49
Read of size 4 at addr 0000000000000642 by task syz.0.97/2282

CPU: 2 UID: 0 PID: 2282 Comm: syz.0.97 Not tainted 7.0.0-rc1-gebd11be59f74-dirty #494 PREEMPT(full)
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 kasan_report+0xe0/0x110 mm/kasan/report.c:595
 cxl_num_decoders_committed+0x3e/0x80 drivers/cxl/core/port.c:49
 cxl_mem_sanitize+0x141/0x170 drivers/cxl/core/mbox.c:1304
 security_sanitize_store+0xb0/0x120 drivers/cxl/core/memdev.c:173
 dev_attr_store+0x46/0x70 drivers/base/core.c:2437
 sysfs_kf_write+0x95/0xb0 fs/sysfs/file.c:142
 kernfs_fop_write_iter+0x276/0x330 fs/kernfs/file.c:352
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x5df/0xaa0 fs/read_write.c:688
 ksys_write+0x103/0x1f0 fs/read_write.c:740
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x111/0x680 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f60a584ba79
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f60a42a7038 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f60a5ab5fa0 RCX: 00007f60a584ba79
RDX: 0000000000000002 RSI: 00002000000001c0 RDI: 0000000000000003
RBP: 00007f60a58a49df R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f60a5ab6038 R14: 00007f60a5ab5fa0 R15: 00007ffe58fad8b8
 </TASK>

This goes away using the correct check instead of abusing cxlmd->endpoint,
which is unusable (ENXIO) until the driver has probed. During that window
the memdev sysfs attributes are already visible, as soon as device_add()
completes.

Fixes: 29317f8dc6ed ("cxl/mem: Introduce cxl_memdev_attach for CXL-dependent operation")
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/cxl/core/mbox.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index e7a6452bf544..12386d912705 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1301,7 +1301,7 @@ int cxl_mem_sanitize(struct cxl_memdev *cxlmd, u16 cmd)
 	 * Require an endpoint to be safe otherwise the driver can not
 	 * be sure that the device is unmapped.
 	 */
-	if (endpoint && cxl_num_decoders_committed(endpoint) == 0)
+	if (cxlmd->dev.driver && cxl_num_decoders_committed(endpoint) == 0)
 		return __cxl_mem_sanitize(mds, cmd);
 
 	return -EBUSY;
-- 
2.39.5

