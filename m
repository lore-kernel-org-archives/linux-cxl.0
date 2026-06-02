Received: from rusty.tulip.relay.mailchannels.net (rusty.tulip.relay.mailchannels.net [23.83.218.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5681DC1AB
	for <linux-cxl@vger.kernel.org>; Tue,  2 Jun 2026 06:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.218.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780383024; cv=none; b=XiviMwtN/4/Vj8dAcs7tzH0ZKqM1KN5ka+oZdfFumG6UW9vH7RjlAvu4su56A5EYAWw79rZKqQQNXZ9iLdzJzjLO2BPMQBWi/OeEycpeurzIv7wCPlU/IQSGMGOw8VF2MW1TYC6l1seE6icR29tTRmX2UkjgF7YUWNrJ4LXaOPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780383024; c=relaxed/simple;
	bh=WzYJQt3ki0AtMwZa+zi/yxL+12zDAFJW+L+Awh8FH00=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Xz0S421zyiTco2PX4d2PjlQJzaLOEWqxZbEWPBxmypSQjqCQX0kh7Da2Ibk+3xYhMzOTzRinNY7bwBtXa+I1rxenXp88Ez7ovyWMAX5u1y9L3h/0+GpsmHeRvmSF4jpsbBBRlfmWRqC+IzaIa+urACtczXTPcPJAk2Pgpc7ImYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=olgfPA0x; arc=none smtp.client-ip=23.83.218.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="olgfPA0x"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 827074027C;
	Tue, 02 Jun 2026 04:30:51 +0000 (UTC)
Received: from pdx1-sub0-mail-a207.dreamhost.com (trex-green-2.trex.outbound.svc.cluster.local [100.109.200.72])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id E2D8C41AE4;
	Tue, 02 Jun 2026 04:30:50 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Skirt-Society: 3daaed3a31903071_1780374651354_34399279
X-MC-Loop-Signature: 1780374651354:361391816
X-MC-Ingress-Time: 1780374651353
Received: from pdx1-sub0-mail-a207.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.109.200.72 (trex/7.1.5);
	Tue, 02 Jun 2026 04:30:51 +0000
Received: from localhost.localdomain (unknown [181.212.92.203])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a207.dreamhost.com (Postfix) with ESMTPSA id 4gTyZ13Yllz18l;
	Mon,  1 Jun 2026 21:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1780374650;
	bh=B3WfiMD2XseJxICu1hT/rD9vHKRHNKodtQMwLZ2U56M=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=olgfPA0x0R+jfcs9qqBn1mkgyUtEA39D4DeNgirTi9y5UyGmlxPciFK4xIgzjQ4+Q
	 pNmLZlpFReBcoPI7RGkb48k73iQPdZw/byf6v1BoQNETCDLizmG/A8VMdaKqslC2Sw
	 PoeM7m1vBPVoM1eUmK8UtC+yiXb1XTwK4I/zy7te66/d/xWkkQ7Gz0g4Qzdke6zBRB
	 NtDLrEvxWfZSzBOmqa3ai7jSMUNO7ezijqJS1BZQ+zV+bzeETp5DWWKPn8pX+apOyi
	 U+iIv4XEG4S5FGfQRpamMApIpAM4jXhuA8625ZjDoZibjXJsesc+VAmPZ3rKLXAugR
	 X8ahA65sqE+RQ==
From: Davidlohr Bueso <dave@stgolabs.net>
To: jic23@kernel.org
Cc: linux-cxl@vger.kernel.org,
	qemu-devel@nongnu.org,
	dave@stgolabs.net
Subject: [PATCH -qemu] hw/cxl: Use host-only coherency for default CFMW restrictions
Date: Mon,  1 Jun 2026 21:30:29 -0700
Message-Id: <20260602043029.2341246-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change the default CXL Fixed Memory Window restrictions from
0x2f to 0xe, dropping Device Coherent and Back-Invalidate,
which are considered spec violations when using in combination
with host-only.

For HDM-D and HDM-DB models, the user will need to explicitly
pass the correct restrictions bitmask.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 docs/system/devices/cxl.rst | 5 +++--
 hw/cxl/cxl-host.c           | 2 +-
 qapi/machine.json           | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/docs/system/devices/cxl.rst b/docs/system/devices/cxl.rst
index 32b1b5d7733b..079f65660dc3 100644
--- a/docs/system/devices/cxl.rst
+++ b/docs/system/devices/cxl.rst
@@ -385,7 +385,8 @@ An example of 4 devices below a switch suitable for 1, 2 or 4 way interleave::
   -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=4k
 
 An example of 4 type3 devices with volatile memory below a switch. Two of the devices
-use HDM-DB for coherence, which requires operating in Flit mode::
+use HDM-DB for coherence, which requires operating in Flit mode with the CXL Window
+configured with Back-Invalidate restrictions::
 
   qemu-system-x86_64 -M q35,cxl=on -m 4G,maxmem=8G,slots=8 -smp 4 \
   ...
@@ -405,7 +406,7 @@ use HDM-DB for coherence, which requires operating in Flit mode::
   -device cxl-type3,bus=swport2,volatile-memdev=cxl-mem2,id=cxl-mem2,sn=0x3 \
   -device cxl-downstream,port=3,bus=us0,id=swport3,chassis=0,slot=7 \
   -device cxl-type3,bus=swport3,volatile-memdev=cxl-mem3,id=cxl-mem3,sn=0x4 \
-  -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=4k
+  -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=4k,cxl-fmw.0.restrictions=0x2d
 
 A simple arm/virt example featuring a single direct connected CXL Type 3
 Volatile Memory device::
diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index 11a455b28ab8..a2595633ff0c 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -64,7 +64,7 @@ static void cxl_fixed_memory_window_config(CXLFixedMemoryWindowOptions *object,
     if (object->has_restrictions) {
         fw->restrictions = object->restrictions;
     } else {
-        fw->restrictions = 0x2f; /* No restrictions */
+        fw->restrictions = 0xe; /* host-only coherent, volatile, pmem */
     }
 
     fw->targets = g_malloc0_n(fw->num_targets, sizeof(*fw->targets));
diff --git a/qapi/machine.json b/qapi/machine.json
index 11ce0457d2f1..f832f0b84a53 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -558,7 +558,7 @@
 #     BIT(3) - Persistent
 #     BIT(4) - Fixed Device Config
 #     BIT(5) - BI
-#     Default is 0x2F
+#     Default is 0xE
 #
 # @targets: Target root bridge IDs from -device ...,id=<ID> for each
 #     root bridge.
-- 
2.39.5

