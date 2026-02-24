Received: from bumble.birch.relay.mailchannels.net (bumble.birch.relay.mailchannels.net [23.83.209.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF94D265606
	for <linux-cxl@vger.kernel.org>; Tue, 24 Feb 2026 02:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.209.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771900994; cv=pass; b=nNLzXG3SXtKeq7u3QeBZgEL4X5FqFL7sjZUMMCGWc9u0yna2qQF3b4292YS1J4CMT5J0pdxg4qXVR2V9T+ZYjIj/z0FCoR7O7vfp4x+8snp9GKjqACHRL7JIJ+Uw+QGnbgmlYxUqhjf9HLKNRTYslffSbQaGtS5+i4mNbEkDgms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771900994; c=relaxed/simple;
	bh=ywG+q4LCsa1Zc4HGzhkQqbYWR7RahjfU42H3Lmp6n5o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oV0tXHkE12lLnU7/bKD4i6HoxzV58f4bgrjdGcCMI9OdS6K1duO/WYFJk5hl6Ye1QlSlRL/tw6XQ7Y45qH9k6cjRVH5VjYbGkD3+edV7WRIJYWxNSfZ5n2kEowo4VZSAyNQAtHWrD8fDq3XVnPTXTaTi0+CwRLDo/URNED7Y4+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=cuFDP+z3; arc=pass smtp.client-ip=23.83.209.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="cuFDP+z3"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 905A9582759;
	Tue, 24 Feb 2026 02:36:18 +0000 (UTC)
Received: from pdx1-sub0-mail-a258.dreamhost.com (100-107-38-69.trex-nlb.outbound.svc.cluster.local [100.107.38.69])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 26500581F33;
	Tue, 24 Feb 2026 02:36:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1771900578;
	b=zlq8PIPahvCX+2yrIoKPkqgrIM031X47VaW8MP4OpzauKYq9cEXFMeSGdRi6W6uy03mik7
	2E2cd3OMjdYM7ds4zKBFVcByqnX+0A1k5YODmx0nCDRRbgHhYsxwR5njo4PdgM/yVY0VzV
	I14FG4jJ05VeZunST7x1Cn7wfn5wmUMI1KyKb4zhPOxgfS6GyBhF8wlAW2fBmaaLMHvI7F
	KAHxjrUvHDdAr1yOKn4XZv/519qvDdbjS3QHR1z11j0oCiJ/QoL3/n5yZ+HFIFNP8uWRAN
	b02U/oei5b9q4r5Hu0EDqXLlgQVh+o8rBGH0mFpmueh4YEx3lnSkptmGsF5IVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1771900578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=58QLWYfSiiAtpFYECoGMwR2AGYqGkdp8l5N/QQTOag0=;
	b=12+Oz7LYxL4tvILPze3JfE+PUFMRwNN1W5vxX2BYC/8X1uVIxStV6eeDYsMtmreujmqDOQ
	iT8zmwNgRRQjhiZIe/ywK/dBBkcGtkxBIckm5ycMKSBUP2E5PCkNzNfpCL7ITemBr+gcEU
	0fv2Za1DcgnRzavV2JGSsjRs5BiBl2pekS9QQXJJH+j7yrvCl39OARkBgjag8BTLji6WXU
	tFoAW/x5UzOLZokMZzJaMiC6+C/8iNUI6jGi0TZ7NqehgFDh10+sJXdLoWmlG8SpeTnOES
	x1zjLV07maKacz193pSxUVNZZrOzNOyndqgJ63y2iixAgT3inJV1m+8nL9bWNQ==
ARC-Authentication-Results: i=1;
	rspamd-6fbd58c58b-xw44s;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Wipe-Tasty: 74a2ab256c58e95b_1771900578427_813556303
X-MC-Loop-Signature: 1771900578427:2115203144
X-MC-Ingress-Time: 1771900578427
Received: from pdx1-sub0-mail-a258.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.107.38.69 (trex/7.1.3);
	Tue, 24 Feb 2026 02:36:18 +0000
Received: from offworld.lan (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a258.dreamhost.com (Postfix) with ESMTPSA id 4fKhg53vmbz1041;
	Mon, 23 Feb 2026 18:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1771900578;
	bh=58QLWYfSiiAtpFYECoGMwR2AGYqGkdp8l5N/QQTOag0=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=cuFDP+z3Zr7ccGaA2gJEHlduznZHE5F+V7kiQW16TQrrXYRKGeapFosaJ0z5MitHl
	 jzhJJV45qOUojkf0rPzMSv0wLYflZ/Du7T+gBJkmSIbYPKZzCQH7ly4pQHKltVq902
	 yhmemcTLiNt2Hc5AHfJ89ZuJFD8TuSupdmxKVscbPoyn+yP9HJy8u9ItbniIIH4qv1
	 l4XDuw/6sayGfZlEEXMjZryDG2lEDLwBUOghGGN/u027DuKijcUqZukTO6zJYVLcx1
	 +SO83Bf3GCfTeS5vMZBiV/ISzElMSSGAdsfccRmTaJJDcfAPb8v9RTS9PxFWfne5C7
	 f06lOszt4k55w==
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com
Cc: dan.j.williams@intel.com,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org
Subject: [PATCH] cxl: Handle ERR_PTR endpoint in sysfs-accessible paths
Date: Mon, 23 Feb 2026 18:36:09 -0800
Message-Id: <20260224023609.1059138-1-dave@stgolabs.net>
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

cxl_memdev_alloc() initializes cxlmd->endpoint to ERR_PTR(-ENXIO) as a
sentinel until the endpoint driver has probed. During that window the
memdev sysfs attributes are already visible, as soon as device_add()
completes.

Use IS_ERR_OR_NULL() instead of just NULL checks in all sysfs paths that
use cxlmd->endpoint to avoid the user prematurely accessing it.

Fixes: 29317f8dc6ed ("cxl/mem: Introduce cxl_memdev_attach for CXL-dependent operation")
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/cxl/core/edac.c   | 2 +-
 drivers/cxl/core/mbox.c   | 2 +-
 drivers/cxl/core/memdev.c | 2 +-
 drivers/cxl/core/region.c | 3 ++-
 4 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
index b321971fef58..65b37460d1a8 100644
--- a/drivers/cxl/core/edac.c
+++ b/drivers/cxl/core/edac.c
@@ -1149,7 +1149,7 @@ static bool cxl_is_memdev_memory_online(const struct cxl_memdev *cxlmd)
 {
 	struct cxl_port *port = cxlmd->endpoint;
 
-	if (port && cxl_num_decoders_committed(port))
+	if (!IS_ERR_OR_NULL(port) && cxl_num_decoders_committed(port))
 		return true;
 
 	return false;
diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index e7a6452bf544..f2308db13c5d 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1301,7 +1301,7 @@ int cxl_mem_sanitize(struct cxl_memdev *cxlmd, u16 cmd)
 	 * Require an endpoint to be safe otherwise the driver can not
 	 * be sure that the device is unmapped.
 	 */
-	if (endpoint && cxl_num_decoders_committed(endpoint) == 0)
+	if (!IS_ERR_OR_NULL(endpoint) && cxl_num_decoders_committed(endpoint) == 0)
 		return __cxl_mem_sanitize(mds, cmd);
 
 	return -EBUSY;
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 273c22118d3d..f0a97aaaaf35 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -236,7 +236,7 @@ int cxl_trigger_poison_list(struct cxl_memdev *cxlmd)
 	int rc;
 
 	port = cxlmd->endpoint;
-	if (!port || !is_cxl_endpoint(port))
+	if (IS_ERR_OR_NULL(port) || !is_cxl_endpoint(port))
 		return -EINVAL;
 
 	ACQUIRE(rwsem_read_intr, region_rwsem)(&cxl_rwsem.region);
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 42874948b589..5ff5a086ca0d 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2956,7 +2956,8 @@ struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa)
 		.dpa = dpa,
 	};
 	port = cxlmd->endpoint;
-	if (port && is_cxl_endpoint(port) && cxl_num_decoders_committed(port))
+	if (!IS_ERR_OR_NULL(port) && is_cxl_endpoint(port) &&
+	    cxl_num_decoders_committed(port))
 		device_for_each_child(&port->dev, &ctx, __cxl_dpa_to_region);
 
 	return ctx.cxlr;
-- 
2.39.5

