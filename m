Received: from dog.birch.relay.mailchannels.net (dog.birch.relay.mailchannels.net [23.83.209.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C47F17B505
	for <linux-cxl@vger.kernel.org>; Fri, 20 Feb 2026 00:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.209.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771546583; cv=pass; b=E8xiMRtMHwpcne7k5so7F7O5lJJK9CbY/kooEnlik5XGnrpVDNJ4gjXmlMpL/Pt1wdaTKbehg/UwlwXwg4H1YWgQ5DQNL0zrevyrqd7zjRp87cH722grjA9q8M8SgoIN/K9MlDT+mzY7LQTjc0UjS9YrXTEzj263civ2XhKmn1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771546583; c=relaxed/simple;
	bh=WCc5DKEomRZqtV1LycmkRJZkRcpuulQPR+HVZ4qgnb4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QxYpZWY06nPQCuqmBSqmnqzx9rntQbTMI6+Rb8YZDmJVr4aRlFKKY/R6kQCokEZZoKh3tMyCTrMyVgT3bwv349M0RDN5KhgAhzd++Pms3M1/SbSOCnQe5v7IP9TRefUeWLEJqvkGkrltgf9aR53jAhaYDnIf7wPE5qbKZ2U8W50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=SMswreWz; arc=pass smtp.client-ip=23.83.209.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="SMswreWz"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 8C700222A75;
	Fri, 20 Feb 2026 00:16:21 +0000 (UTC)
Received: from pdx1-sub0-mail-a248.dreamhost.com (100-99-98-27.trex-nlb.outbound.svc.cluster.local [100.99.98.27])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 2BDB8222B65;
	Fri, 20 Feb 2026 00:16:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1771546581;
	b=OehFdrfJfvDcA/1ma3NE84zreQ24HZzurburNx3G7+0oL4h7XyHkynuYXskEENKB/98z/p
	peWX5qLIIfMcxtYlVhwspgxzdgBuIe+g1XcAfDV3RPqXN0f1gmQLyRuRzn1a1/03T83HP+
	zlJILHFFvOYszoaN720JSCXNXCJV4QXNdMDKv/dAoFNJ9cJXB9FFlAd/nJHB3d3HtEjNB6
	G9NHHP8IztXDA3tqOj0epsjCJ5GY59WuR+93HtMRuhIwqw1jkwqUimQGDJCBnwrrv72iY5
	cJNqnsC4+umwWB5ByYobeXVcSVtKUvwvpBYpEeDli3Z6s0sduSh9/PQJuBMakA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1771546581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=fMn4uQjMFK22iI+AP9iGeX3uVRcla8gOixug5wEiRFc=;
	b=IPARqMJFZM0xL48lNi1B/0M7zs8rGPU6S7g8GSxIAqVRwQZLuyRad4/pT8OiUeHVkueIYH
	LaPznZrGAD6Tqmojqdy+cQXg1Mg/L0wSZHsYkAt4fwp87dev0huyFMhqPl4dV3Oztkcy1n
	tUMlDTCsNaTcS1dAX2KklXMzZiy0SD1qgZWwZv/NrYFOq4fVxjvbwxHqFxTCQ8jovyTCMh
	9s0IvfPXgV3r405HwpW21lyBQt3gXqilKbAG9ckJbeU5v6Gqb5sBBGpEqBMnVXTmB0Qllf
	+9zkSk0Z8lgz2MdHsMKSHI+YUCWkWUzmtiYWIDW08AmNlbiEkWQNr4JU6dhy8Q==
ARC-Authentication-Results: i=1;
	rspamd-659f7bc6cc-mn88h;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Vacuous-Thread: 1b390e6770bc84df_1771546581476_29967661
X-MC-Loop-Signature: 1771546581476:2923426341
X-MC-Ingress-Time: 1771546581476
Received: from pdx1-sub0-mail-a248.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.98.27 (trex/7.1.3);
	Fri, 20 Feb 2026 00:16:21 +0000
Received: from offworld.lan (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a248.dreamhost.com (Postfix) with ESMTPSA id 4fH9lS4HFPz106N;
	Thu, 19 Feb 2026 16:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1771546581;
	bh=fMn4uQjMFK22iI+AP9iGeX3uVRcla8gOixug5wEiRFc=;
	h=From:To:Cc:Subject:Date:Content-Type:Content-Transfer-Encoding;
	b=SMswreWzVqR/j6zEh2OcEx17sTjR9IiiNezGKAQQL5MHsOEMEe90MbJpYwdIONdu+
	 tohqyRTMpVcrpp6gj/zcsN/iKh0DAVicuiHCZvyoWN2E+WjRhf9Nnkq6Xv1SUStUf+
	 JW8XRXpqThTRh1EexjLJhs78tNe4pXvgPxRWz2VdPSvLfrrF9y4ykIIG2Scb9e0zz3
	 R1MXCLd66ls2lQbhrSQj4DaRk4joEqM14uXGDUepu1th3R9GhqzufdaYbe99Efeab9
	 E+fzh/hwfAAyu5uwJkLJjf7zcIqf/f8XhIy3PmdvKeWP18lV/gmzW5yynshoqxrdHa
	 nDxIhsB3yH9Fg==
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com
Cc: jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	linux-cxl@vger.kernel.org,
	Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH 1/2] cxl/mbox: validate payload size before accessing contents in cxl_payload_from_user_allowed()
Date: Thu, 19 Feb 2026 16:16:17 -0800
Message-Id: <20260220001618.963490-2-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260220001618.963490-1-dave@stgolabs.net>
References: <20260220001618.963490-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

cxl_payload_from_user_allowed() casts and dereferences the input
payload without first verifying its size. When a raw mailbox command
is sent with an undersized payload (ie: 1 byte for CXL_MBOX_OP_CLEAR_LOG,
which expects a 16-byte UUID), uuid_equal() reads past the allocated buffer,
triggering a KASAN splat:

BUG: KASAN: slab-out-of-bounds in memcmp+0x176/0x1d0 lib/string.c:683
Read of size 8 at addr ffff88810130f5c0 by task syz.1.62/2258

CPU: 2 UID: 0 PID: 2258 Comm: syz.1.62 Not tainted 6.19.0-dirty #3 PREEMPT(voluntary)
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0xab/0xe0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xce/0x650 mm/kasan/report.c:482
 kasan_report+0xce/0x100 mm/kasan/report.c:595
 memcmp+0x176/0x1d0 lib/string.c:683
 uuid_equal include/linux/uuid.h:73 [inline]
 cxl_payload_from_user_allowed drivers/cxl/core/mbox.c:345 [inline]
 cxl_mbox_cmd_ctor drivers/cxl/core/mbox.c:368 [inline]
 cxl_validate_cmd_from_user drivers/cxl/core/mbox.c:522 [inline]
 cxl_send_cmd+0x9c0/0xb50 drivers/cxl/core/mbox.c:643
 __cxl_memdev_ioctl drivers/cxl/core/memdev.c:698 [inline]
 cxl_memdev_ioctl+0x14f/0x190 drivers/cxl/core/memdev.c:713
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl fs/ioctl.c:583 [inline]
 __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xa8/0x330 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fdaf331ba79
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fdaf1d77038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fdaf3585fa0 RCX: 00007fdaf331ba79
RDX: 00002000000001c0 RSI: 00000000c030ce02 RDI: 0000000000000003
RBP: 00007fdaf33749df R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fdaf3586038 R14: 00007fdaf3585fa0 R15: 00007ffced2af768
 </TASK>

Add 'in_size' parameter to cxl_payload_from_user_allowed() and validate
the payload is large enough.

Fixes: 6179045ccc0c ("cxl/mbox: Block immediate mode in SET_PARTITION_INFO command")
Fixes: 206f9fa9d555 ("cxl/mbox: Add Clear Log mailbox command")
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/cxl/core/mbox.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index fa6dd0c94656..e7a6452bf544 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -311,6 +311,7 @@ static bool cxl_mem_raw_command_allowed(u16 opcode)
  * cxl_payload_from_user_allowed() - Check contents of in_payload.
  * @opcode: The mailbox command opcode.
  * @payload_in: Pointer to the input payload passed in from user space.
+ * @in_size: Size of @payload_in in bytes.
  *
  * Return:
  *  * true	- payload_in passes check for @opcode.
@@ -325,12 +326,15 @@ static bool cxl_mem_raw_command_allowed(u16 opcode)
  *
  * The specific checks are determined by the opcode.
  */
-static bool cxl_payload_from_user_allowed(u16 opcode, void *payload_in)
+static bool cxl_payload_from_user_allowed(u16 opcode, void *payload_in,
+					  size_t in_size)
 {
 	switch (opcode) {
 	case CXL_MBOX_OP_SET_PARTITION_INFO: {
 		struct cxl_mbox_set_partition_info *pi = payload_in;
 
+		if (in_size < sizeof(*pi))
+			return false;
 		if (pi->flags & CXL_SET_PARTITION_IMMEDIATE_FLAG)
 			return false;
 		break;
@@ -338,6 +342,8 @@ static bool cxl_payload_from_user_allowed(u16 opcode, void *payload_in)
 	case CXL_MBOX_OP_CLEAR_LOG: {
 		const uuid_t *uuid = (uuid_t *)payload_in;
 
+		if (in_size < sizeof(uuid_t))
+			return false;
 		/*
 		 * Restrict the ‘Clear log’ action to only apply to
 		 * Vendor debug logs.
@@ -365,7 +371,8 @@ static int cxl_mbox_cmd_ctor(struct cxl_mbox_cmd *mbox_cmd,
 		if (IS_ERR(mbox_cmd->payload_in))
 			return PTR_ERR(mbox_cmd->payload_in);
 
-		if (!cxl_payload_from_user_allowed(opcode, mbox_cmd->payload_in)) {
+		if (!cxl_payload_from_user_allowed(opcode, mbox_cmd->payload_in,
+						  in_size)) {
 			dev_dbg(cxl_mbox->host, "%s: input payload not allowed\n",
 				cxl_mem_opcode_to_name(opcode));
 			kvfree(mbox_cmd->payload_in);
-- 
2.39.5

