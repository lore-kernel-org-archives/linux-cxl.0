Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.83.222.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793748525;
	b=xHEWD1cCUkad3kYLQRjQOVNkRaPiS9pppQIYlhq6ibQs5OpryK5JhMko+9CUSDq0fg6/
	 8VsnxuxPZ6irFzM5c8kDFKCqRovFKgLUjQez26WEqJPnxMsoqsnbSB2M/Wq0VK5VQixfB
	 nIDQr51BdH9i/g/Qd0rD0KRoEfM1nEJq+WPYIHopXriGtLn6pSA3wwiZw/8aq8XvUSfCV
	 Wr91ihKvBaUh71YHrXyzcVCXKyFNcj2pc8dp4rIGr5n0ZjqdoRz/QuVhfwbOQKotQKdqU
	 +KcifRr1drbE628zEhFGqqe8CLDRIyKmL/XqLaF6eRw2riOOMDUa/01hydikFIXufZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793748525;
	h=DMARC-Filter:X-Sender-Id:Received:Received:X-Sender-Id:X-MC-Relay:
	 X-MailChannels-SenderId:X-MailChannels-Auth-Id:X-Spot-Trail:
	 X-MC-Loop-Signature:X-MC-Ingress-Time:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ApOi53mnuxAwA4VAMXSsvQa5OHFSRBlmfNcYtGS1vKU=;
	b=dGmoMzeJQju7atkF1X9bSjwTwq0WHXLPkX+8+s1j5byTpCvXlurAxQ58ZdNrHxvz11nF
	 e+1Dr7gJw/QR4Qsz6pnLNQGbxrU7ZIIHui86NU3lQfwLrGA6NpCgt9TUixMXGF6V0qDJ/
	 5I87cqqkWF0Ahw5CBfqpPI2Zlp3bUzdpPrnynb4MIAXhuZRJPUWE5Hir3XFqYieDESf3c
	 rSgUu1qzQefT+bixe/BQk82DofkgJQkFQvuZDmkYXoa5tVdNU5bLP5j5LRgrwz60q41za
	 fVvEghJ7z/77CKMRDrrdQgGQ4qdXFk/bFaVJXKjqRlwscLagTQ/8Qc1Pq1LFhwY06Gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=stgolabs.net;
	spf=fail smtp.mailfrom=stgolabs.net;
	dkim=pass header.d=stgolabs.net header.i=@stgolabs.net header.a=rsa-sha256 header.s=dreamhost header.b=CXljzgWd;
	arc=none smtp.remote-ip=23.83.222.47
Received: from cyan.ash.relay.mailchannels.net (cyan.ash.relay.mailchannels.net [23.83.222.47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0013B606A31B
	for <linux-cxl@vger.kernel.org>; Tue,  3 Nov 2026 23:28:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0013B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=stgolabs.net header.i=@stgolabs.net header.a=rsa-sha256 header.s=dreamhost header.b=CXljzgWd
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 33F1B640E37;
	Tue, 03 Nov 2026 23:28:38 +0000 (UTC)
Received: from pdx1-sub0-mail-a217.dreamhost.com (100-99-175-136.trex-nlb.outbound.svc.cluster.local [100.99.175.136])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id C58B764121B;
	Tue, 03 Nov 2026 23:28:33 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Spot-Trail: 0eafd3d3078be5f9_1793748518063_2374062927
X-MC-Loop-Signature: 1793748518063:3923310327
X-MC-Ingress-Time: 1793748518063
Received: from pdx1-sub0-mail-a217.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.175.136 (trex/8.0.2);
	Tue, 03 Nov 2026 23:28:38 +0000
Received: from offworld.tailf5af7a.ts.net (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a217.dreamhost.com (Postfix) with ESMTPSA id 4jK4Wj0dYRzL1;
	Tue,  3 Nov 2026 15:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1793748513;
	bh=ApOi53mnuxAwA4VAMXSsvQa5OHFSRBlmfNcYtGS1vKU=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=CXljzgWdXzzG2E71PCPMe7/pgPOwrW67l3twqcTsAfRJTydkB0iOWPCpzjJfOOeMe
	 UHI1GkuGAJuwVxp4DkM1eqNhyMviUWPXwd3mdugcLs3KHX9Ssgwba7VZ7MXoL2loZM
	 ytBPMWglze6Uu6dj7LJJ5lL0SlHKbDnNrtjG1IR2LhkBCFHfx15GpWuw56alnX+71u
	 DF85XEXs1oLjNiZd38+5thkUvBkvogPmLlgJaKE1JlGmofQcCJTYQGrsqHQ407OLlr
	 JkIjiQDBa5TOW22fi4XjhnnXkQBB9mtt8Bex54ku15QL6KTTAHrYmQXgrmK5GsPcXH
	 EVRkbIku7NsbA==
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com
Cc: jic23@kernel.org,
	alison.schofield@intel.com,
	ming.li@zohomail.com,
	icheng@nvidia.com,
	linux-cxl@vger.kernel.org,
	Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH] cxl/region: Restore a target's position from its slot after sorting
Date: Tue,  3 Nov 2026 15:28:22 -0800
Message-Id: <20261103232822.2482024-1-dave@stgolabs.net>
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
be detached from by position: deleting that region runs __cxl_decoder_detach(),
which finds pos < 0 and triggers:

  cxl region0: expected mem0:decoder3.0 at position -6
  WARNING: drivers/cxl/core/region.c:2314 at __cxl_decoder_detach+0x483/0x910

A decoder committed by firmware behind a switch whose own decoders
were not committed for the range is enough to get there

The same stale position is what commit cbda6a2c2bec ("cxl/region: Fix
out-of-bounds access in cxl_cancel_auto_attach()") had to work around
by walking the array instead of indexing it.

Restore cxled->pos from the member's slot after the sort.

Fixes: 0cf36a85c140 ("cxl/region: Use cxl_calc_interleave_pos() for auto-discovery")
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
Found while battle testing BI changes.

 drivers/cxl/core/region.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index a048bd5c06cb..d344bc4b5aab 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2045,7 +2045,14 @@ static int cxl_region_sort_targets(struct cxl_region *cxlr)
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

