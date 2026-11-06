Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.83.209.93
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794008248;
	b=jHZWQvZd0JLOMrkc+tr4bTkiJm8jhy+Lt6FzNj005/FrHeUGibcqeYBVxvbysZaCnE6V
	 wC8hh1oWPrheH/40F29WtfXpLOp7LfHd/RMqnAx0UQVCTFhOoi4mWa4Ansts2vPlAJtx0
	 U2uakdpcZ/hBaxXc3dhfJRL4S90De+QDn/LlYkFJapNd3n61fWrrdXgVQxmTk1WGq8ZwC
	 cYCNGvVcmjseZ9yXjCzToSDRn6inyv7WWdBd5/zZ0tR6JFcy/bkO6BuYnIDmu7c+CwrJE
	 qWtg9HOHNQZhQDu8lDechrXsKKxhcfDvBELL6vSD3eSWEOx5UBYOg359zTZ0R0QeX9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794008248;
	h=DMARC-Filter:X-Sender-Id:Received:Received:X-Sender-Id:X-MC-Relay:
	 X-MailChannels-SenderId:X-MailChannels-Auth-Id:X-Power-Imminent:
	 X-MC-Loop-Signature:X-MC-Ingress-Time:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=9cJ1JKkMan6XUFw9Kp0spPpk+AvpKE2kCIxeivlz+SI=;
	b=FTdxdTqnWNEWs1GT84lUJSWUC+1EGLmtiEOV72Vu8eHlvRmQr0SdgGvBeoKIhU0uNf/7
	 g4JKjstjAHwFZr00WmByEp/iPBjz6FDJE+y9Twnamb3YItrXzfdqwsbeA3Ru4kL0ZhuR1
	 LD85JpQ5LFQWX0/AoHmuED8srDIV4vBcm7wJu0htqV75ne+QPBLhSE9X2YrcN8y5J1/IA
	 jGpnQqltdwm8ILduASn8NX7hOYFgfzuiU5DlU7HXe1sQuaZl9YUmBRifq/84+jkmcVud9
	 2j3+WRVDd3qObpLAqewlxkV7uNMFXARqqekSWsPnyOUAIw8QIAFaOtBC5oUs/jlExAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=stgolabs.net;
	spf=fail smtp.mailfrom=stgolabs.net;
	dkim=pass header.d=stgolabs.net header.i=@stgolabs.net header.a=rsa-sha256 header.s=dreamhost header.b=rdvj1AHQ;
	arc=none smtp.remote-ip=23.83.209.93
Received: from insect.birch.relay.mailchannels.net (insect.birch.relay.mailchannels.net [23.83.209.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E6D606A326
	for <linux-cxl@vger.kernel.org>; Fri,  6 Nov 2026 23:37:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2E6D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=stgolabs.net header.i=@stgolabs.net header.a=rsa-sha256 header.s=dreamhost header.b=rdvj1AHQ
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 6FF5E7E23B3;
	Fri, 06 Nov 2026 23:37:21 +0000 (UTC)
Received: from pdx1-sub0-mail-a248.dreamhost.com (100-99-178-124.trex-nlb.outbound.svc.cluster.local [100.99.178.124])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 1459B7E227A;
	Fri, 06 Nov 2026 23:37:19 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Power-Imminent: 1d0f12940035173f_1794008241304_1367528645
X-MC-Loop-Signature: 1794008241304:1489265538
X-MC-Ingress-Time: 1794008241304
Received: from pdx1-sub0-mail-a248.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.178.124 (trex/8.0.2);
	Fri, 06 Nov 2026 23:37:21 +0000
Received: from offworld.tailf5af7a.ts.net (unknown [172.56.210.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a248.dreamhost.com (Postfix) with ESMTPSA id 4jLwZQ047vz103P;
	Fri,  6 Nov 2026 15:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1794008238;
	bh=9cJ1JKkMan6XUFw9Kp0spPpk+AvpKE2kCIxeivlz+SI=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=rdvj1AHQfu3KLcofJtaNRBwpzNUkBv17T35mnaWFaa4Domeh/5/ZntyzhGIuC2OWM
	 Mw7vQIoaKJNuQd2AAbmKPH81H9aqAeKgvY0uaLzKS/T67S9OvKWcYO3wub8bdwZglN
	 g2b+bgU0AcRXS9p7EiHOib6wEQ2ip3ChBlB7Rc0jC4Ctl6l29qLERD0KrCdAEeg7NJ
	 0Opgddgv1cnktlZcyOFiTOb9xgVsUYHlAYFRPETbA59Sl5wYN1B1DAcTUPj1WV3fng
	 EUPwZPK7/FemPUFZ8sAPIXlMsoIgtceeouJXqt2IDQknrd+m8VPEdYGPo4WsAcvucn
	 xz3k0Ocs7zcGQ==
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com
Cc: jic23@kernel.org,
	alison.schofield@intel.com,
	icheng@nvidia.com,
	ming.li@zohomail.com,
	benjamin.cheatham@amd.com,
	linux-cxl@vger.kernel.org,
	Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH v2] cxl/region: Restore a target's position from its slot after sorting
Date: Fri,  6 Nov 2026 15:37:11 -0800
Message-Id: <20261106233711.2654827-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
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

Region auto-discovery records each arriving endpoint decoder in the
first free @targets slot and sets cxled->pos to that slot. Once every
member has arrived, cxl_region_sort_targets() calculates each one's
interleave position and sorts the array by it. The original version of
that function then restored cxled->pos from the member's slot in the
sorted array, so that follow-on code could rely on
p->targets[cxled->pos] naming the member, failed sort or not.

Commit 0cf36a85c140 ("cxl/region: Use cxl_calc_interleave_pos() for
auto-discovery") dropped that restore. cxled->pos now keeps whatever
cxl_calc_interleave_pos() returned, which on failure is a negative
errno. A member that could not be placed is left in a region it cannot
be detached from by position: deleting that region runs
__cxl_decoder_detach(), which finds pos < 0 and triggers:

  cxl region0: expected mem0:decoder3.0 at position -6
  WARNING: drivers/cxl/core/region.c:2314 at __cxl_decoder_detach+0x483/0x910

A decoder committed by firmware behind a switch whose own decoders
were not committed for the range is enough to get there

The same stale position is what commit cbda6a2c2bec ("cxl/region: Fix
out-of-bounds access in cxl_cancel_auto_attach()") had to work around
by walking the array instead of indexing it.

Restore cxled->pos from the member's slot after the sort.

Fixes: 0cf36a85c140 ("cxl/region: Use cxl_calc_interleave_pos() for auto-discovery")
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
Found while battle testing BI changes.

Changes in v2:
 - fix the hunk header

 drivers/cxl/core/region.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index a048bd5c06cb..d344bc4b5aab 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2045,6 +2045,14 @@ static int cxl_region_sort_targets(struct cxl_region *cxlr)
 	sort(p->targets, p->nr_targets, sizeof(p->targets[0]),
 	     cmp_interleave_pos, NULL);
 
+	/*
+	 * Restore cxled->pos from its ->targets[] slot so that follow-on
+	 * code paths can reliably do p->targets[cxled->pos] to
+	 * self-reference their entry, whether or not the sort succeeded.
+	 */
+	for (i = 0; i < p->nr_targets; i++)
+		p->targets[i]->pos = i;
+
 	dev_dbg(&cxlr->dev, "region sort %s\n", rc ? "failed" : "successful");
 	return rc;
 }
-- 
2.39.5

