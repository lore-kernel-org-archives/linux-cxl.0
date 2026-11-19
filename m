Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.83.218.249
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795055445;
	b=0ahGL2h0rO8FaWDCadcucJsnOE/5SN7zMCmqtjDk3ejsoHwbuGTuRe2JlMo0tdmbVmaq
	 IkpfB8Je/rn8SryO/HgNyOKHKCFo5BoMRbqvxwl5mGJVaPPicRApZN23RY7eBrSJTY2Vq
	 1seOKSL2Ns6eP5fGyngNm/7gymparFOplpgLHksoVWnT7UBJHFT1lqr7cbipsjKmE4kUd
	 1N8qA1pyWi7B3Rt65CBhz2L9co/OKqD09MviXp0wWLUjfwuUO4Y/r8mP3JCwGNaUOppOj
	 wqVS15+OPMWU7uspmqIyBBa9iffKO7hhrzKjsMZnPegAtAIa6JdqjlAmjyaSARRzI6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795055445;
	h=DMARC-Filter:X-Sender-Id:Received:Received:X-Sender-Id:X-MC-Relay:
	 X-MailChannels-SenderId:X-MailChannels-Auth-Id:X-Arithmetic-Minister:
	 X-MC-Loop-Signature:X-MC-Ingress-Time:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=CK99k7ZrFFe/plebNUXP/E45oIIe0yK+zqz0ph+NLoY=;
	b=2e9x8VvLiahKvdR3lQqSEqy+B+slBWvoLAGkIJcI3lhmK/Byk7uuYho8+ofMoIKf+cQy
	 1XBROmeCGmHjxrmy/vWz3LGJDCfMt88XBjhOWhPRK8/P001Fx6RoIH5OgBrHkn43TWA14
	 rEM6Uxp+glvlz6sQiqYBCLCnv0hKcc7hIn8CDsbdHYe6NtA04zrpwRDRxB7UnUwr8jYN8
	 0MbnoAaiigSbD0rQ4+B4EAzYON9BI7BwtNEBfhKTW/NiQA0vbx8rlqVQTx0BJ0KZd8ooZ
	 tQ6yiiaX3szwczxrD0UE4bxBPby6XUPI01pokVeTngWvd4ra16W2aH4r4X9VLxu2I2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=stgolabs.net;
	spf=fail smtp.mailfrom=stgolabs.net;
	dkim=pass header.d=stgolabs.net header.i=@stgolabs.net header.a=rsa-sha256 header.s=dreamhost header.b=l98yshuP;
	arc=none smtp.remote-ip=23.83.218.249
Received: from poodle.tulip.relay.mailchannels.net (poodle.tulip.relay.mailchannels.net [23.83.218.249])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD480606A333
	for <linux-cxl@vger.kernel.org>; Thu, 19 Nov 2026 02:30:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD480606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.a=rsa-sha256 header.s=dreamhost header.b=l98yshuP
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 290627E1B6B;
	Thu, 19 Nov 2026 02:30:37 +0000 (UTC)
Received: from pdx1-sub0-mail-a220.dreamhost.com (100-97-189-238.trex-nlb.outbound.svc.cluster.local [100.97.189.238])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id B31F97E141A;
	Thu, 19 Nov 2026 02:30:36 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Arithmetic-Minister: 70386a5546db3043_1795055436937_711781136
X-MC-Loop-Signature: 1795055436937:602298790
X-MC-Ingress-Time: 1795055436937
Received: from pdx1-sub0-mail-a220.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.97.189.238 (trex/8.0.2);
	Thu, 19 Nov 2026 02:30:36 +0000
Received: from offworld.tailf5af7a.ts.net (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a220.dreamhost.com (Postfix) with ESMTPSA id 4jVMrr26LdzS6;
	Wed, 18 Nov 2026 18:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1795055436;
	bh=CK99k7ZrFFe/plebNUXP/E45oIIe0yK+zqz0ph+NLoY=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=l98yshuPy3hM/seZUoDmKTd+O7a1HHAVJk7b8vikUqmhcgMrMg6sIa7Kja+OzqBVt
	 sWGpsg+lvN8TBeMA1dXU3SvXgDq4mz7Azi2r6wH0IThkl/Ltt5yuWnQKPYl6TmzyYs
	 mOovLk36dgrFHuDGnpfhaU0wnnbSsezpoml3Bj1ugtsue8bjCqktNq2w/rQxlbOOz0
	 gO88mqZ1FqNa99MpDPDglLqZTW2WU4ok4XPbGizmoGoGCmRW2WrdoLUZHanZl8sQBd
	 sbat802gosE4coKx8Ak0IuoTaLan5evEpBYnG8qApin5rv/o8O8evmr0XIXQ9WKsUe
	 2ES+LHL9FC1jg==
From: Davidlohr Bueso <dave@stgolabs.net>
To: alison.schofield@intel.com
Cc: dave.jiang@intel.com,
	linux-cxl@vger.kernel.org,
	dave@stgolabs.net
Subject: [PATCH 1/2] test/cxl-back-invalidate.sh: add a Back-Invalidate region test
Date: Wed, 18 Nov 2026 18:30:27 -0800
Message-Id: <c476fd6bbc8a88dd0efbb24f93c1154316f05d0a.1795050773.git.dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1795050773.git.dave@stgolabs.net>
References: <cover.1795050773.git.dave@stgolabs.net>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cxl_test now mocks a Back-Invalidate topology: an HDM-DB window that
parses into a root decoder with cap_back_invalidate set, and BI capable
endpoints below it.

Test the coherency model a region inherits from that window: create a
region on the BI root decoder, verify the endpoint decoder came up
device-coherent with back_invalidate set, and that a cxl_acpi rebind
replays the region with the model intact. Both attributes are read from
sysfs. Skip when no BI window is present.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 test/cxl-back-invalidate.sh | 111 ++++++++++++++++++++++++++++++++++++
 test/meson.build            |   2 +
 2 files changed, 113 insertions(+)
 create mode 100755 test/cxl-back-invalidate.sh

diff --git a/test/cxl-back-invalidate.sh b/test/cxl-back-invalidate.sh
new file mode 100755
index 000000000000..804ba63af5a8
--- /dev/null
+++ b/test/cxl-back-invalidate.sh
@@ -0,0 +1,111 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+. $(dirname $0)/common
+
+rc=77
+
+set -ex
+
+trap 'err $LINENO' ERR
+
+check_prereq "jq"
+
+modprobe -r cxl_test
+modprobe cxl_test
+
+CXLDEV=/sys/bus/cxl/devices
+
+# A Back-Invalidate capable window is advertised by the root decoder as
+# cap_back_invalidate. Without one the kernel has no BI support, or
+# cxl_test predates the mock BI topology.
+find_bi_root()
+{
+	local d
+
+	for d in $CXLDEV/decoder*; do
+		[ -e "$d/cap_back_invalidate" ] || continue
+		[ "$(cat $d/cap_back_invalidate)" = 1 ] || continue
+		basename "$d"
+		return
+	done
+}
+
+bi_root=$(find_bi_root)
+if [ -z "$bi_root" ]; then
+	do_skip "test requires a back-invalidate capable window"
+fi
+
+# Replay support is exposed by cxl_acpi after cxl_test loads
+if [ ! -e /sys/bus/platform/devices/cxl_acpi.0/decoder_reset_preserve_registry ]; then
+	do_skip "test requires decoder registry replay support"
+fi
+
+rc=1
+
+# A region under a BI window is HDM-DB: device-coherent, with the BI bit
+# programmed into the endpoint decoder at commit. Only memdevs below the
+# host bridge the window targets can attach to it.
+create_bi_region()
+{
+	local port_dev mem
+
+	port_dev=$("$CXL" list -T -d "$bi_root" |
+		jq -r ".[] | .targets | .[0].target")
+	[[ $port_dev ]] || return 1
+
+	for mem in $("$CXL" list -M -p "$port_dev" | jq -r ".[].memdev"); do
+		BI_REGION=$("$CXL" create-region -d "$bi_root" -m "$mem" \
+			-t ram 2>/dev/null | jq -r ".region")
+		[[ $BI_REGION && $BI_REGION != null ]] || continue
+
+		BI_DECODER=$("$CXL" list -R --targets -r "$BI_REGION" |
+			jq -r ".[0].mappings | .[0].decoder")
+		[[ $BI_DECODER && $BI_DECODER != null ]] || return 1
+		return 0
+	done
+
+	echo "no memdev below $port_dev could back a region on $bi_root"
+	return 1
+}
+
+BI_REGION=""
+BI_DECODER=""
+create_bi_region || err "$LINENO"
+
+# The endpoint decoder inherits the window's coherency model: HDM-DB is
+# device-coherent with the BI bit set.
+[ "$(cat $CXLDEV/$BI_DECODER/back_invalidate)" = "1" ] || err "$LINENO"
+[ "$(cat $CXLDEV/$BI_DECODER/target_type)" = "accelerator" ] || err "$LINENO"
+
+[ "$(cat $CXLDEV/$BI_REGION/commit)" = "1" ] || err "$LINENO"
+
+# The committed HDM-DB region must survive a cxl_acpi rebind and come
+# back with its coherency model intact.
+replay_regions || err "$LINENO"
+
+bi_root=$(find_bi_root)
+[ -n "$bi_root" ] || err "$LINENO"
+
+replayed=""
+for r in $CXLDEV/region*; do
+	[ -d "$r" ] || continue
+	[ "$(cat "$r/commit" 2>/dev/null)" = "1" ] || continue
+	readlink -f "$r" | grep -q "/$bi_root/" || continue
+	[ -z "$replayed" ] || err "$LINENO"
+	replayed=$(basename "$r")
+done
+[ -n "$replayed" ] || err "$LINENO"
+
+# decoder ids are not stable across the rebind, so ask the replayed
+# region which endpoint decoder it came back on.
+replayed_dec=$("$CXL" list -R --targets -r "$replayed" |
+	jq -r ".[0].mappings | .[0].decoder")
+[[ $replayed_dec && $replayed_dec != null ]] || err "$LINENO"
+[ "$(cat $CXLDEV/$replayed_dec/back_invalidate)" = "1" ] || err "$LINENO"
+
+"$CXL" destroy-region -f -b "$CXL_TEST_BUS" "$replayed"
+
+check_dmesg "$LINENO"
+
+modprobe -r cxl_test
diff --git a/test/meson.build b/test/meson.build
index 56aed9cc3c9d..53297e8fcbfa 100644
--- a/test/meson.build
+++ b/test/meson.build
@@ -171,6 +171,7 @@ cxl_translate = find_program('cxl-translate.sh')
 cxl_elc = find_program('cxl-elc.sh')
 cxl_dax_hmem = find_program('cxl-dax-hmem.sh')
 cxl_region_replay = find_program('cxl-region-replay.sh')
+cxl_back_invalidate = find_program('cxl-back-invalidate.sh')
 
 tests = [
   [ 'libndctl',               libndctl,		  'ndctl' ],
@@ -207,6 +208,7 @@ tests = [
   [ 'cxl-elc.sh',             cxl_elc,            'cxl'   ],
   [ 'cxl-dax-hmem.sh',        cxl_dax_hmem,       'cxl'   ],
   [ 'cxl-region-replay.sh',   cxl_region_replay,  'cxl'   ],
+  [ 'cxl-back-invalidate.sh', cxl_back_invalidate, 'cxl'   ],
 ]
 
 if get_option('destructive').enabled()
-- 
2.39.5

