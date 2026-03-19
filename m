Received: from seahorse.cherry.relay.mailchannels.net (seahorse.cherry.relay.mailchannels.net [23.83.223.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D825030CD94
	for <linux-cxl@vger.kernel.org>; Thu, 19 Mar 2026 18:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.161
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773945803; cv=pass; b=iE0CqBJRsD5JU2Dcb0RgS+hxMMygkQZwXv6a+zBix4k5SPfUHlTQ6BGDJ+smtG5twdAWv9OkYoCje90F7nwgvghufYb+yhwOZReUPTjklLjtj2CrPSEaQBdnToXv6P3o33Gd1TjDD7s+6iKEX/TDRvpQIUt3XNxSP2ZG2LMjLSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773945803; c=relaxed/simple;
	bh=bUqY5pqJmdOrPh2FvhS5gVCBVoe+SkvmRqDS8WXrvfQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rdd0emO+8yiDxqSMptR1q5wThWUSB5uNYlNhtWSCu9Q/pAdZNLL2YwF1hpexEhxLm8mkYQGuiBQT4v2PdQ3FI6Q3yMk3LAry7DxEBt5bFpnEhy7bPOs6KZ5v2f+VU5099xvYA0Go3wn9ULvFXp02Qa0KgFT+UYAaywPjNe3Pc6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=ahu6Sxt6; arc=pass smtp.client-ip=23.83.223.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="ahu6Sxt6"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 0C868823B0C;
	Thu, 19 Mar 2026 18:43:15 +0000 (UTC)
Received: from pdx1-sub0-mail-a227.dreamhost.com (100-115-116-28.trex-nlb.outbound.svc.cluster.local [100.115.116.28])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 799B6823B68;
	Thu, 19 Mar 2026 18:43:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1773945794;
	b=FANOe5QurSWHW0Sl2domycUXXa1lVPJuXzWFIHBlHzkimutBqtibnI2bWkDe0ayt4xWpTJ
	+faDhHwxb52nlTfXlkCc2/Luef/BorMzVEmo04OaKlyp/azeknc6j3/O9rbIoBC2jsWwLv
	XUEE2tty9/JjyInWQ6Jfz8TxSCfaYPdudFDG4c5bZW9zbYy548KF5t59uZUuBLPAH5LKhG
	jEMLxJsu8XAjw6eX3k7U93n848f963/hK2kIxRtFYzlCl7CbiQvvs2HkDrJ/+Uh4NX5wRU
	/V/ZmrEv0uDBZRd//Y7C1ClZqsBJSCHb8i0egC++2xwcYpdIt4ZCC8a+81fazw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1773945794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=PoI4BK3hvU2nKIds7DnxJnNUvQd2NTtab+MbLNuAEt8=;
	b=N2u1xxeaauXu3Ki1wM4GLdXEiSK4e3iRaNYErPXWu6I6l0Yv32YBACjamOVUrmePuSVinJ
	l4oLOlerldIr/exU3gafo5oPixW7UwYfEI8XScFILI/nD5xwj4adXw2oajoRSiX1vtJ4JL
	f31wMgWKfqQw4J4bUXkJ9uH315BHdzSULargWgoz3DFKQrnI7ezGJ0jppiH380aRAqbGdE
	+jDF+6kGA8t7965lSIbpzbA2iJcyGzEeFKTKLHyMHhwV5FLbVFap1IyhCJL3Qo63RHsnpP
	L62fh32M7kFZJwlqhZlzzCScwLojk24F+qBTMMR5yBZpShtXg7hy69ZRFG1/8A==
ARC-Authentication-Results: i=1;
	rspamd-7f98bb5847-7xrmz;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Tasty-Continue: 207cc2b574cbcc62_1773945794938_171937942
X-MC-Loop-Signature: 1773945794938:617296039
X-MC-Ingress-Time: 1773945794937
Received: from pdx1-sub0-mail-a227.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.115.116.28 (trex/7.1.5);
	Thu, 19 Mar 2026 18:43:14 +0000
Received: from offworld.lan (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a227.dreamhost.com (Postfix) with ESMTPSA id 4fcF2B0K0Mz2P;
	Thu, 19 Mar 2026 11:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1773945794;
	bh=PoI4BK3hvU2nKIds7DnxJnNUvQd2NTtab+MbLNuAEt8=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=ahu6Sxt6X+am35BnljL0eFLcwF1K+MK9Q8DRI0Y08gTvEsERDYKW+jq6qJR3UqHTr
	 YO+uMBWT+hKAhAF5CxoLk/DC3GCRdscNMXTF8Wf2iP6q+2rPwio3/aRPe/eG9HMbnB
	 n4JAp3k1+kPehvEwKJnlHMgQzv+vgTcgiZ9wNIKBKQjO4vrSrZgoNswcy7Nxejlxna
	 g9jRueistD7knMBA8Q+dhFHPoikS2KVHWmcdNw9Pu1VJQfgvE6OPv3RfvJXRWJcCJt
	 szTzkQmfZGiH+io8Ez5fnS+IycLBDZ7/DODqk4eDMGs6rwM4H5JndL/BjH3K051rp3
	 pVy28lEj7wSYA==
From: Davidlohr Bueso <dave@stgolabs.net>
To: mst@redhat.com,
	jonathan.cameron@huawei.com
Cc: qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org,
	dave@stgolabs.net
Subject: [PATCH 2/2] hw/cxl: Exclude Discovery from Media Operation Discovery output
Date: Thu, 19 Mar 2026 11:42:56 -0700
Message-Id: <20260319184256.3762391-3-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260319184256.3762391-1-dave@stgolabs.net>
References: <20260319184256.3762391-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Per CXL 4.0 Table 8-331, the Discovery operation "returns a list of
all Media Operations that the device supports, with the exception of
the Discovery operation (Class=0, Subclass=0)."

Filter out Discovery entries when building the output list and adjust
total_supported_operations accordingly.

Fixes: 77a8e9fe0ecb ("hw/cxl/cxl-mailbox-utils: Add support for Media operations discovery commands cxl r3.2 (8.2.10.9.5.3)")
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 hw/cxl/cxl-mailbox-utils.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index c628f775ac48..9a5caf62417a 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -2593,7 +2593,7 @@ static CXLRetCode media_operations_discovery(uint8_t *payload_in,
     } QEMU_PACKED *media_op_in_disc_pl = (void *)payload_in;
     struct media_op_discovery_out_pl *media_out_pl =
         (struct media_op_discovery_out_pl *)payload_out;
-    int total = ARRAY_SIZE(media_op_matrix);
+    int total = ARRAY_SIZE(media_op_matrix) - 1; /* exclude Discovery */
     int num_ops, start_index, i;
     int count = 0;
 
@@ -2619,10 +2619,12 @@ static CXLRetCode media_operations_discovery(uint8_t *payload_in,
 
     num_ops = MIN(num_ops, total - start_index);
     for (i = 0; i < num_ops; i++) {
+        int idx = start_index + i + 1; /* skip Discovery (first entry) */
+
         media_out_pl->entry[count].media_op_class =
-                media_op_matrix[start_index + i].media_op_class;
+                media_op_matrix[idx].media_op_class;
         media_out_pl->entry[count].media_op_subclass =
-                media_op_matrix[start_index + i].media_op_subclass;
+                media_op_matrix[idx].media_op_subclass;
         count++;
     }
 
-- 
2.39.5

