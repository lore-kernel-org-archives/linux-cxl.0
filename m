Received: from tiger.tulip.relay.mailchannels.net (tiger.tulip.relay.mailchannels.net [23.83.218.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D081B145B16
	for <linux-cxl@vger.kernel.org>; Tue, 30 Sep 2025 03:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.248
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759203082; cv=pass; b=EJYJdW6pNoU05doJo+XyjO2rTaWoxrGViZ2kmPpq4mObXrXA/naOaJXspuQztmC3SuO93ttji95D+6IeZiqtfnmVqhdGJ57npWH4M1TL1Bo2B0/0Hn7D7kYeK0reNCZ4sbQZSYxKaiVl3flvLYbva3950x37isawuk8AXlslvkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759203082; c=relaxed/simple;
	bh=49dX/45Mizzg+eh+rwbGpo6pMN2mUNfn5MujbFjYpA0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CLqRNGpGchY9lsteZ12k6Difoosenv8s6negoW5qGGtrCeSto9Oz43/94K0LtRp6BjAvoiFYiESYs/rBJ5N5kWf9HkCyp+E+I33jMzyxXtzYg7kc9dOjm5yVWaOKHiy2ew/MYdaaNdmw4vQ1mHpqFW88/AmK0iNLyrJO9nqarxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=jKCs+249; arc=pass smtp.client-ip=23.83.218.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="jKCs+249"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 726CE70129B;
	Tue, 30 Sep 2025 03:22:35 +0000 (UTC)
Received: from pdx1-sub0-mail-a315.dreamhost.com (trex-blue-2.trex.outbound.svc.cluster.local [100.113.90.84])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id EEE22701406;
	Tue, 30 Sep 2025 03:22:34 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1759202555; a=rsa-sha256;
	cv=none;
	b=0Ul5Ruien2kSpKHn2jCm384i6BCIWmvavKMUhRKq+5ZxFnkDd2Km8JiTuY5fK8MoFM/RB9
	EWd84ZkT47NWNXcqO/FQ1wkx0Wh2SNl1pgaamuGFiGky80EaHjsl8SnOZHQBvQ7S27qHqp
	QLDHbhjAdffAxgi1s4tbCYz7pkzCJwue8uFLGIyxn7qkp0eTWrUSZBTrHmBWYCJwEYwD/t
	HQVwQdWNlV8RASiZ78OFQBolFhL/AB+BzhWZHj9v8kM4X+EDuWl9+yRZJ/WMA/kUJEShcH
	jTqs0fj84BvWIA4aIzMMrkKDzQNHkn84baBH3lVsL+iPO0aBaSZUN2KVor2tGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1759202555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=F0QSnTgOLesF0aCE7qfgqoYpipQeSin3zJuG38HwYM8=;
	b=TMqHu2Ri93H+5dQ2YjY9H2rEJ4m13lqhjNrImCNK1XMH+G99Q8kgtHxniYfeK1kW5ipicy
	4TsrybgTLLFqae19+TlvBAPMmN+ew0C03lCGVOAbPX5slZyxyufT5SVEenBWY4dmZV/PhB
	qlQBP62Fir2LEMY4hgqfJ2hom5nhxBWJj7/oFxHsqRUIzYx24si+3TDqmPMRULuP8z1py4
	gOfMRqw+awSPz4BXbrEEYmOENOMd4gFc+Vk+Rmh9ufn2Ug7yBc1Gvo1QNqZwW8WPBcQDX/
	4KuQsl93eU93zI+UIr/0YlEtkuFN8bJmOVystBjbFGMMhGE8FttVhvs9pK9O8Q==
ARC-Authentication-Results: i=1;
	rspamd-9695c5dfc-p4zkv;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Cooperative-Versed: 68da6c04334e97d8_1759202555264_1212884388
X-MC-Loop-Signature: 1759202555264:581522535
X-MC-Ingress-Time: 1759202555264
Received: from pdx1-sub0-mail-a315.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.113.90.84 (trex/7.1.3);
	Tue, 30 Sep 2025 03:22:35 +0000
Received: from offworld.lan (syn-076-167-199-067.res.spectrum.com [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a315.dreamhost.com (Postfix) with ESMTPSA id 4cbNfL1tjLzGS;
	Mon, 29 Sep 2025 20:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1759202554;
	bh=F0QSnTgOLesF0aCE7qfgqoYpipQeSin3zJuG38HwYM8=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=jKCs+249ODl+OMJQ8q0UIwgAzyfaHcCKnW0NhJZ19uBk6xN7QHcAsk6fZuqm5tFBN
	 DhanNshHxb+G9x/kVmLMkWZu/ljcMtAJleRivE2BLw1sSlsgVudjzBzoAI04xQncF8
	 0f+9uHeYdsg1+HyQw6u5BSISHL6Q1lEmJg1VjdY0jGAGthPUM2Vu4I5Q+p5Zmq8n9e
	 yuC/M+3NB7tEfLExEGL4OVpYolEUqGiDYbnGEZq0NmIdfk2iVpv7K4UBRRl4TOd3DV
	 aoJOdBmciA0db2YIbot3ST66PofmsUvhGf2MCdOLY2tNno54qDBSr4PKysxmUwf3p3
	 hD7yMUduI3Q5Q==
From: Davidlohr Bueso <dave@stgolabs.net>
To: jonathan.cameron@huawei.com
Cc: ira.weiny@intel.com,
	lucerop@amd.com,
	a.manzanares@samsung.com,
	mst@redhat.com,
	marcel.apfelbaum@gmail.com,
	armbru@redhat.com,
	linux-cxl@vger.kernel.org,
	qemu-devel@nongnu.org,
	dave@stgolabs.net
Subject: [PATCH 3/5] hw/cxl: Allow BI by default in Window restrictions
Date: Mon, 29 Sep 2025 20:21:51 -0700
Message-Id: <20250930032153.1127773-4-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250930032153.1127773-1-dave@stgolabs.net>
References: <20250930032153.1127773-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the CFMW restrictions to also permit Back-Invalidate
flows by default, which is aligned with the no-restrictions
policy.

While at it, document the 'restrictions=' option.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 hw/cxl/cxl-host.c | 2 +-
 qapi/machine.json | 3 ++-
 qemu-options.hx   | 4 +++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index def2cf75be61..0d17ea3e4c26 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -64,7 +64,7 @@ static void cxl_fixed_memory_window_config(CXLFixedMemoryWindowOptions *object,
     if (object->has_restrictions) {
         fw->restrictions = object->restrictions;
     } else {
-        fw->restrictions = 0xf; /* No restrictions */
+        fw->restrictions = 0x2f; /* No restrictions */
     }
 
     fw->targets = g_malloc0_n(fw->num_targets, sizeof(*fw->targets));
diff --git a/qapi/machine.json b/qapi/machine.json
index ac258578e4ab..ea8ba71305b0 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -589,7 +589,8 @@
 #     BIT(2) - Volatile
 #     BIT(3) - Persistent
 #     BIT(4) - Fixed Device Config
-#     Default is 0xF
+#     BIT(5) - BI
+#     Default is 0x2F
 #
 # @targets: Target root bridge IDs from -device ...,id=<ID> for each
 #     root bridge.
diff --git a/qemu-options.hx b/qemu-options.hx
index 1f862b19a676..2da65fad3c9f 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -142,7 +142,7 @@ SRST
             -machine memory-backend=pc.ram
             -m 512M
 
-    ``cxl-fmw.0.targets.0=firsttarget,cxl-fmw.0.targets.1=secondtarget,cxl-fmw.0.size=size[,cxl-fmw.0.interleave-granularity=granularity]``
+    ``cxl-fmw.0.targets.0=firsttarget,cxl-fmw.0.targets.1=secondtarget,cxl-fmw.0.size=size[,cxl-fmw.0.interleave-granularity=granularity,restrictions=restrictions]``
         Define a CXL Fixed Memory Window (CFMW).
 
         Described in the CXL 2.0 ECN: CEDT CFMWS & QTG _DSM.
@@ -168,6 +168,8 @@ SRST
         interleave. Default 256 (bytes). Only 256, 512, 1k, 2k,
         4k, 8k and 16k granularities supported.
 
+        ``restrictions=restrictions`` bitmask with the restrictions of the CFMW.
+
         Example:
 
         ::
-- 
2.39.5

