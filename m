Received: from shrimp.cherry.relay.mailchannels.net (shrimp.cherry.relay.mailchannels.net [23.83.223.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F44A4734C0
	for <linux-cxl@vger.kernel.org>; Tue, 28 Jul 2026 23:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.223.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785279823; cv=none; b=PWNNJG9q3hT3R1nc5PCJC2a8J5ICDp4jCZ85QoD7nyBrVW1+YtJ+Sz91JipWDOp5EjuGTWnacQFjCG4cmTZTtJ5ymSJX2b7cF8csI+uDHjmg+WAd9Y7iJsfJD36rX8qUDwq3TQMoxh2f/VvWSiOeXrRfiW6LSZdVAtJq8iXZ+H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785279823; c=relaxed/simple;
	bh=4gKagWPQS1jDXInpuwZBftAjjCiiMh3626K2hdoGkI4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l4jEOHoTSPbiFSiSL+NMe3DCcRHS+Z8aoTlEE3vSqZfi8ca7lFD/QGJRwtZZbGHh6rTSRsKiWglGzOUh5uDCQMDnzc6KKMN2uwYqQKu4nSKj1dlepa1IH+HIUH75At5MhPPWC/NIGFxFAWp29QxoQ0HV5LaQJB3riDa6ooGj0OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=oDQj2eI5; arc=none smtp.client-ip=23.83.223.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="oDQj2eI5"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id AD9B7720E8D;
	Tue, 28 Jul 2026 23:03:34 +0000 (UTC)
Received: from pdx1-sub0-mail-a209.dreamhost.com (trex-green-0.trex.outbound.svc.cluster.local [100.111.241.90])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 576C872041C;
	Tue, 28 Jul 2026 23:03:34 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Abaft-Cure: 6eb068e214a8447e_1785279814571_410084613
X-MC-Loop-Signature: 1785279814571:2702893786
X-MC-Ingress-Time: 1785279814571
Received: from pdx1-sub0-mail-a209.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.111.241.90 (trex/8.0.2);
	Tue, 28 Jul 2026 23:03:34 +0000
Received: from offworld.lan (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a209.dreamhost.com (Postfix) with ESMTPSA id 4h8rc55ssBz1QL;
	Tue, 28 Jul 2026 16:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1785279814;
	bh=J1BqEphkzvUnxVSs1v57+RQqrJMzXG4J/q1xhe/U3j0=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=oDQj2eI5FdI/5qaJXKn2+aVTy6o0qR1R+wBF6kdUiFBL6r4Y4dEnkQA8qZPIFd6lF
	 24Zt5kOhUUooc0MS+6bFCglqlNa/RmM0TdUsZofx4J2ttIe6lJMtLXxNHv6e7wq3e4
	 vknBhK5/rcnQJA6qEgPkki+aP8yQFSeDrsCnBu3JSg6JPujRwaB68j8UeCnJyZKUPA
	 r3KucqOCDnQ38BfoCVxqqItwVyOMFt4HXORBqKWNAZVBybdoScugUdF9cXFXkqrna1
	 iW5+LSyue+uzSTvAHfCRA46HjsVx8aLtJ3MdkpjyU21DB1EdVWlry7xTHoMxVolJBg
	 u17QzYgNOIS+A==
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com
Cc: jic23@kernel.org,
	alison.schofield@intel.com,
	linux-cxl@vger.kernel.org,
	Davidlohr Bueso <dave@stgolabs.net>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH] cxl/hdm: Robustify decoder target list reads
Date: Tue, 28 Jul 2026 16:02:29 -0700
Message-Id: <20260728230228.781303-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the target_list union is fixed at 8 entries, if a CXL switch
device has an IW value larger than 8 (such as 12 or 16 way), things
can go bad:

  BUG: KASAN: stack-out-of-bounds in devm_cxl_enumerate_decoders+0xefd/0x1b00
  Read of size 1 at addr ffff8881003bf180 by task kworker/u16:0/12
   kasan_report+0xe0/0x110
   devm_cxl_enumerate_decoders+0xefd/0x1b00
   cxl_port_add_dport+0x9c/0x200
   devm_cxl_enumerate_ports+0xa36/0x1190
   cxl_mem_probe+0x26f/0x710

  The buggy address belongs to stack of task kworker/u16:0/12
   and is located at offset 40 in frame:
   devm_cxl_enumerate_decoders+0x0/0x1b00
  This frame has 1 object:
   [32, 40) 'target_list'

While this is out of spec (see Table 123), we can robustify and
just reject such a decoder - noting that cxl_port_setup_targets()
already refuses to program more than 8 ways.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Fixes: d17d0540a0db ("cxl/core/hdm: Add CXL standard decoder enumeration to the core")
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/cxl/core/hdm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 0c80b76a5f9b..87bdadeccb5f 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -1084,6 +1084,13 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 		cxld->interleave_ways, cxld->interleave_granularity);
 
 	if (!cxled) {
+		if (cxld->interleave_ways > ARRAY_SIZE(target_list.target_id)) {
+			dev_warn(&port->dev,
+				 "decoder%d.%d: Invalid target list (iw: %d)\n",
+				 port->id, cxld->id, cxld->interleave_ways);
+			return -EINVAL;
+		}
+
 		lo = readl(hdm + CXL_HDM_DECODER0_TL_LOW(which));
 		hi = readl(hdm + CXL_HDM_DECODER0_TL_HIGH(which));
 		target_list.value = (hi << 32) + lo;
-- 
2.39.5

