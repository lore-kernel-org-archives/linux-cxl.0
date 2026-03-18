Received: from buffalo.birch.relay.mailchannels.net (buffalo.birch.relay.mailchannels.net [23.83.209.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6452366DAE
	for <linux-cxl@vger.kernel.org>; Wed, 18 Mar 2026 19:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.209.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773860690; cv=pass; b=ACu1oMX5e2Yhv59is5vXQAj5UodZKqOPT0okqWqzEMzNUQhscFgn6VttSOucrXgHQjSeiiVA+n7CDkLI/XU4e7dceAiJDpG5bD7KRwDFNFWTHWNd+qRG24LfDwH+eHZVDtZRtoMDBJQAv3zhyztUm5u4uuW/CgoWbZE7Jts5/ew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773860690; c=relaxed/simple;
	bh=da5EmkeZSmB2o30V8XB2S0w/4FgjA5pFL/CGV8jW3ZU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T85KnKss42k/OtHBOHIg5KHlU6fq/016jAz9ovTf/wezxtPTRl8ijbI0aoA3Hym/FG8BikrP9/vqu6D44wP5UN2/gEYocpvULsibQmm8l+jeTKo4xAdeJz9HahXA+CpxTiGMFzam7aW9narAVzzpCI5WoytAPFvt0lIMFKsR5ME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=a6PZ3Waa; arc=pass smtp.client-ip=23.83.209.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="a6PZ3Waa"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 49ED080241C;
	Wed, 18 Mar 2026 18:55:24 +0000 (UTC)
Received: from pdx1-sub0-mail-a234.dreamhost.com (trex-green-1.trex.outbound.svc.cluster.local [100.117.57.254])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id EDF84801090;
	Wed, 18 Mar 2026 18:55:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1773860124;
	b=w3RT5iz6nqau5+vo6cx0W77qvxFSDI0svTT03q/fLgMhobZst1aTrWIBVK62+MLE9KU+7+
	gUYtnRnE/A4UTOPyVpUesMGa/NXIMUPSdsi7QQKlE+7FftHP5S70d3V/z3zGuzaN+opDzs
	DXCxxcabGo7roYJEpuXo8yHEsVTmXg40R/Evs2rt4LA6iArRcZ82JbRFPLrAnkOPPYAfMm
	wdcYbFXvTOZHEZm26mrT1DA5bMm72nhFX6zdo12cyZwSyuJ1H8HItGob5MRGYe7o0TzqRW
	B4roWahgivxmO4Fvg4SHh1crl15x1quvLSPtlVlk41XAXhRXTni57fP63ifGPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1773860124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=nZPQxWJbTH2wzVLrbyTk3/yQ3pbXmRcf7ppDh2wu9DY=;
	b=2XGEtXkK6vx44/spkMQeOgDz6P1jdVGTSmnyrLBYHbQIx+muZ7lk2IUs654fIAnAWEUaJ7
	PuCmo+rnkIXr0r7QcAGocTTHiEohB8S8rLlau5VLxa+QqUQueCmGVfdvNEt6ArQ8IBOwUt
	Bciu63Vj0gdlbg29TboJDO5zXv3C5WKKX1LUQay5HYA5oiyfU5bP/1VuWsLx00IRTGU7nv
	+R/Puzqk7ecf61QMfeHAS2ezFaHLJY/fMQaSPz8T2oG0oGZTxvd2O1H33Agu+22RQa/vyI
	VnkpRP+3Gj9/j+HTUvrPCOXylYj/rN+gi4arM1pAPkwTycGEz0F6hGRb8GR+1Q==
ARC-Authentication-Results: i=1;
	rspamd-6d4cb6745-tplqm;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Thoughtful-Army: 32f9276553bdffee_1773860124203_2027179416
X-MC-Loop-Signature: 1773860124203:338686361
X-MC-Ingress-Time: 1773860124202
Received: from pdx1-sub0-mail-a234.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.117.57.254 (trex/7.1.5);
	Wed, 18 Mar 2026 18:55:24 +0000
Received: from offworld.lan (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a234.dreamhost.com (Postfix) with ESMTPSA id 4fbdLg3dWJz103R;
	Wed, 18 Mar 2026 11:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1773860123;
	bh=nZPQxWJbTH2wzVLrbyTk3/yQ3pbXmRcf7ppDh2wu9DY=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=a6PZ3WaaQNcrXfGLdzcipZDB25eg5nHDwMtbxwHOp1xG/DDxuhjhQOOH/xBCgFZCD
	 wIjw7/Gsp/GeaIRfpsDa5a26Ck5WyrRuYTJdEAocZWRiRiYUxaE1Gv+0eGeN5eeKVa
	 4koxDKcO9QE/1x37mKFIM9vITs4/UyX42Rv0mJbdt/oq/tR64HcY75ajh76853ssS/
	 YMur9QJa9gnWDUQ25yN1zliG6bV2c23ZRrcgyZKNfH909Oz6hitJ4zFPlgt4K0qNrR
	 QDkaQkD9UkvJIco+98BGx1/5i0Elk0hc5as2QeZC0U6zeVu+C9cFmVx1/y8IqHA6QB
	 DacNAWz5ybQjQ==
From: Davidlohr Bueso <dave@stgolabs.net>
To: jonathan.cameron@huawei.com
Cc: qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org,
	dave@stgolabs.net
Subject: [PATCH 1/2] hw/cxl: Respect Media Operation max ops discovery semantics
Date: Wed, 18 Mar 2026 11:55:07 -0700
Message-Id: <20260318185508.3683044-2-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260318185508.3683044-1-dave@stgolabs.net>
References: <20260318185508.3683044-1-dave@stgolabs.net>
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

