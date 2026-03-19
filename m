Received: from iguana.tulip.relay.mailchannels.net (iguana.tulip.relay.mailchannels.net [23.83.218.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA7C2F8BD3
	for <linux-cxl@vger.kernel.org>; Thu, 19 Mar 2026 18:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.253
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773946388; cv=pass; b=jaS0cxhx72oU00caPRklY98iZIujr+Bg29gZsrnVqhiaYoMemuwDQ2rQ8o12V/YCXmEeE45eXTfpvIzrcTrW62UmV+g8oiCOD3RxiZsWvcJ/zvMRawTTbtTCcNDdG1KDYLQuFosGUJShP9isdZ4c7GB2tqFBuLZmFYzbTxJWPak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773946388; c=relaxed/simple;
	bh=jRZOVsKVdw+UksV21yL2SbpxJ7fyM/Filr0vDqXNVmc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HkRx2DVa2+Owj9Lfq4pEZpZ6a+NYXWJIwcfzUZh2Ov3UddzGg07E96lzIsWEnABWNHVGyI5XX4ASWJaNCoTojnc1f9Mnw5or9rs/kTTt3fJEunR+fHXAcnJb5qtarYDA/3RdHctgqZ8wlk4mV22HVXCAv5eFxnbH1va2rOfVPw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=KQ/70ria; arc=pass smtp.client-ip=23.83.218.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="KQ/70ria"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 810C16C1EF8;
	Thu, 19 Mar 2026 18:43:14 +0000 (UTC)
Received: from pdx1-sub0-mail-a227.dreamhost.com (trex-green-1.trex.outbound.svc.cluster.local [100.117.57.254])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 2CBED6C1EA4;
	Thu, 19 Mar 2026 18:43:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1773945794;
	b=WVWlmv+CUR+e5RSuut2hyHI3PgtmRgM3VmAa+VJLQ1Xpw4ADUSNmquqr1v51M+EN8Gzsiz
	yO2i+JgobLa9PBsC1fYiT5UW9XRb2AQG8gaexMINi4DG73nEdwML9r2ufugXG3FtM12Z3F
	BeqDYV6O5gq42n3L83YN3HIUZYLT1Vih6w3tbDKKZP1UGQmbj5XJp+19xgcBKVx89fgl+G
	QPvG/t2WPBTq7ucbaVJCyfXS8puuU9JiWV7MKdQ27w8mnaQaP3d9hXt0A5ygtnrEgiAxRV
	bV0RYObciLKr2fqJ1jbjnn6qJQXPep+SdZLcFG74nuOb3YJLCXaaS/qWEKbPkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1773945794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=RIbQtIMyzdXuMVMoDhozBVahIPjXPJ8h2fuqB+pj6EE=;
	b=Zd4YSpai5YxGjx+xUItuQlMcPteKG8qQX2LgkIW+zqC0/p+MjeGERhYAmqWScIv3a4+E7M
	RMtTP8QqUmtdZ2eWuUI7QCyt1/zJeRE8rMl3838cLVwFbGD9ZpjyOhK7uRDIMBxH2WdNcr
	SvdKajvJ16J/8ldeJG4fF8KDsnEvacjtuY8S9cZhZEpBHd+yrtvr6NWTpajSqxH03oU3Vb
	bOPQm4yVV3BwMyA6FYQWjNFrdOVhZgfHpia++aNYP73HkhjrBYCDsyZpDWNdqTqkRbPCAc
	ySJ4ft1AFOHDT5iGX/gfMKeY07ucfBDvN2b6VQ9jqv0Vns8+j1x2awZuzoHpYQ==
ARC-Authentication-Results: i=1;
	rspamd-6d4cb6745-t2cws;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Invention-Quick: 382cf0ca1031cfcc_1773945794423_907135795
X-MC-Loop-Signature: 1773945794423:878038627
X-MC-Ingress-Time: 1773945794423
Received: from pdx1-sub0-mail-a227.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.117.57.254 (trex/7.1.5);
	Thu, 19 Mar 2026 18:43:14 +0000
Received: from offworld.lan (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a227.dreamhost.com (Postfix) with ESMTPSA id 4fcF294Fdrz3P;
	Thu, 19 Mar 2026 11:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1773945793;
	bh=RIbQtIMyzdXuMVMoDhozBVahIPjXPJ8h2fuqB+pj6EE=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=KQ/70riacnd6U++PMQmFq+2ud8Fo840lbJzMbuuOS9jHr9ICMWSGCOyjQKJ9vSfwK
	 CSkSv2lkRWjb2EltyOuQtW9tJOsulmq6fHx8a2y35dR4bQP+4C4Q+flzI4PiYSj5xb
	 nkNGZvJFJ6Q1+5xmfoRKLdJurKfuoK6YUKWbcEe5wR/CZF7TmNKTyvEeWogRCTEDzp
	 BCrAlZqKwTQ/unML+dYU5osXBUO3NYhneSouxHyqwbXum9zOhyhz9tP1bRpV0kCAtB
	 nugIiwLludnwwT8XEi6t0mRc/K7K2WO3RzA6fZQe9dBo6JIivEpJHDsqlHStyiE+ng
	 vMYaNokTjUROA==
From: Davidlohr Bueso <dave@stgolabs.net>
To: mst@redhat.com,
	jonathan.cameron@huawei.com
Cc: qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org,
	dave@stgolabs.net
Subject: [PATCH 1/2] hw/cxl: Respect Media Operation max ops discovery semantics
Date: Thu, 19 Mar 2026 11:42:55 -0700
Message-Id: <20260319184256.3762391-2-dave@stgolabs.net>
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

The Discovery rejects requests where start_index + num_ops
exceeds the total number of supported operations. Per CXL 4.0
Table 8-332, num_ops is the "Maximum number of Media Operation to
return" - a maximum, not an exact count. The device should return
up to that many entries, not reject the request.

Cap num_ops to the available entries from start_index instead of
erroring the command.

Fixes: 77a8e9fe0ecb ("hw/cxl/cxl-mailbox-utils: Add support for Media operations discovery commands cxl r3.2 (8.2.10.9.5.3)")
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 hw/cxl/cxl-mailbox-utils.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index a3143f3faa23..c628f775ac48 100644
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
+                media_op_matrix[start_index + i].media_op_subclass;
+        count++;
     }
 
     media_out_pl->num_of_supported_operations = count;
-- 
2.39.5

