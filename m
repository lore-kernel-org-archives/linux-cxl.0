Received: from bumble.birch.relay.mailchannels.net (bumble.birch.relay.mailchannels.net [23.83.209.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E222ED860
	for <linux-cxl@vger.kernel.org>; Wed, 18 Mar 2026 19:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.209.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773861552; cv=pass; b=T7nscmD73hPZpdU1KITgPyL76WQg3DlbHMHZ2EK9ZqSYN3PP9YQF25HDPCW6M23Nw5cSn32KZugJ46oeZY+AGRxE7YxZ3iazmGUpUa3Bv837Gl416FNkYLUUpR2GsrR/hHQ62tlbhx7w6LsK2xUtB0aBk6itatHvpekXBSI+Ncs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773861552; c=relaxed/simple;
	bh=da5EmkeZSmB2o30V8XB2S0w/4FgjA5pFL/CGV8jW3ZU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WX0NPavNDQ8qvCZAMSgz5RMPCoOcJzvEzB/s3Xp8WQ4jAHsM4LEgYimlE8Bpm8lWIrYzhElbBJNHoUIAUdLOpKyIdul3Wco3h6g8ieofYuPzEWC730OCo+TcB6F2+TU/BikXidMNa7KiMfuFX5orOgNxMR2Gr5sSXq7JWrQbPb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=Q8AmT7e4; arc=pass smtp.client-ip=23.83.209.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="Q8AmT7e4"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 44855563242;
	Wed, 18 Mar 2026 18:43:04 +0000 (UTC)
Received: from pdx1-sub0-mail-a234.dreamhost.com (trex-green-3.trex.outbound.svc.cluster.local [100.119.11.147])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id EC796562147;
	Wed, 18 Mar 2026 18:43:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1773859384;
	b=50Syu+A3EGHXqetX3x3EKIyGVe+0fzIJXxozjSfU9sQrKU2EqxDDPCjzLmS5RKSoxr4Ww9
	ev3/NETOiurEQVfXl09G6cmABtjfHWtvTsXQKmf8wSTQ08/o5AGxdPUR4SK66n+Bni/6NP
	3CHLFeDP7WsJdR5Dia6zn4merYPK06YV+26msalpFgJPGMw+sV9vgke71W3OcaPY630gw5
	2skj90uUM3xIIxPRGWgSihXo/kf0ze97ybbC6V1zdg3INIn61cU36dxtq2VW5S4FFZRCPZ
	Wer8FJ4NHfEh5Oq5vKkUUx0Atlxg7lgtxoOVC/k/9wtON/5R2SKIvcCzYe0KCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1773859384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=nZPQxWJbTH2wzVLrbyTk3/yQ3pbXmRcf7ppDh2wu9DY=;
	b=zCNPhny0Ho5tlD0SYd8S5mDkjy4DlmxBEiXO25iqvbhHiIEdZSuJteWUbJMxCkLkYl9+Jv
	GJ8pQR0o8kidR0fWwIvn9QlhZ6a2wPs8T5XAeXatiXLS+FXZ/bkHCN89eyjw+b3Yr97un0
	NzXCQqWGZxTWfvFxWkVxbmENUnZ8qq8yuTxeBt7fJ9Q+BVEj1yBPKlr7ohpMq7/N5q9MCR
	13ng9+vAzxu82XOQlg7i22I3PVwFsetmmMt+W2EXcFkwoo0qvc5+23GLqLc00kpzsPkMaO
	yBfZxKK2WP3gZJqPe5TIMYvbSz5R3hZZOUGCm6NpYy9ZoFxym4EapXOPqtl7dQ==
ARC-Authentication-Results: i=1;
	rspamd-6d4cb6745-247dc;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Turn-Unite: 6b723cc63ca56a5f_1773859384180_1099865106
X-MC-Loop-Signature: 1773859384180:2440543161
X-MC-Ingress-Time: 1773859384180
Received: from pdx1-sub0-mail-a234.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.119.11.147 (trex/7.1.5);
	Wed, 18 Mar 2026 18:43:04 +0000
Received: from offworld.lan (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a234.dreamhost.com (Postfix) with ESMTPSA id 4fbd4R3p3Xz107D;
	Wed, 18 Mar 2026 11:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1773859383;
	bh=nZPQxWJbTH2wzVLrbyTk3/yQ3pbXmRcf7ppDh2wu9DY=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=Q8AmT7e4gCi9sRd5SdC3Az5kjo8YUK1O3K/DtopS8Wte9W7eA0q/Ds1VoDfvf5ijh
	 JUG6wv64eVFNcS0vwi2q8Mk5EgkctnYBj2sS+daVdakX/TPa7PxFV803EXxwKJqFHP
	 MlC/TrLfUAd51klBdnZyiYWQjKJTQnpcr5h5qO9WJh8vy05wTJdaGqQ4Mc3pORjpG2
	 DegrmFyVnzlRo9wHLm68xH5AfqKhS1M1QGEl7NAXH9UK0HUNS4BJ2Af/tKjheBiVrr
	 o1oJENTDgFijkO1U63i4M9/A8L2d42ujxFqW3gWAEQx0llvhtFZGpaVOGDwkS+VHok
	 Ly5uh1TxRBw9w==
From: Davidlohr Bueso <dave@stgolabs.net>
To: jonathan.cameron@huawei.com
Cc: qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org,
	dave@stgolabs.net
Subject: [PATCH 1/2] hw/cxl: Respect Media Operation max ops discovery semantics
Date: Wed, 18 Mar 2026 11:42:55 -0700
Message-Id: <20260318184256.3680349-2-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260318184256.3680349-1-dave@stgolabs.net>
References: <20260318184256.3680349-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Discovery handler rejects requests where start_index + num_ops
exceeds the total number of supported operations. Per CXL 4.0
Table 8-332, num_ops is the "Maximum number of Media Operation to
return" - a maximum, not an exact count. The device should return
up to that many entries, not reject the request.

Cap num_ops to the available entries from start_index instead of
erroring the command.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 hw/cxl/cxl-mailbox-utils.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index a3143f3faa23..71a012121c87 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -2593,6 +2593,7 @@ static CXLRetCode media_operations_discovery(uint8_t *payload_in,
     } QEMU_PACKED *media_op_in_disc_pl = (void *)payload_in;
     struct media_op_discovery_out_pl *media_out_pl =
         (struct media_op_discovery_out_pl *)payload_out;
+    int total = ARRAY_SIZE(media_op_matrix);
     int num_ops, start_index, i;
     int count = 0;
 
@@ -2609,24 +2610,20 @@ static CXLRetCode media_operations_discovery(uint8_t *payload_in,
      * sub class command.
      */
     if (media_op_in_disc_pl->dpa_range_count ||
-        start_index + num_ops > ARRAY_SIZE(media_op_matrix)) {
+        start_index >= total) {
         return CXL_MBOX_INVALID_INPUT;
     }
 
     media_out_pl->dpa_range_granularity = CXL_CACHE_LINE_SIZE;
-    media_out_pl->total_supported_operations =
-                                     ARRAY_SIZE(media_op_matrix);
-    if (num_ops > 0) {
-        for (i = start_index; i < start_index + num_ops; i++) {
-            media_out_pl->entry[count].media_op_class =
-                    media_op_matrix[i].media_op_class;
-            media_out_pl->entry[count].media_op_subclass =
-                        media_op_matrix[i].media_op_subclass;
-            count++;
-            if (count == num_ops) {
-                break;
-            }
-        }
+    media_out_pl->total_supported_operations = total;
+
+    num_ops = MIN(num_ops, total - start_index);
+    for (i = 0; i < num_ops; i++) {
+        media_out_pl->entry[count].media_op_class =
+                media_op_matrix[start_index + i].media_op_class;
+        media_out_pl->entry[count].media_op_subclass =
+                    media_op_matrix[start_index + i].media_op_subclass;
+        count++;
     }
 
     media_out_pl->num_of_supported_operations = count;
-- 
2.39.5

