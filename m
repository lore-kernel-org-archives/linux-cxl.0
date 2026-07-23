Received: from rusty.tulip.relay.mailchannels.net (rusty.tulip.relay.mailchannels.net [23.83.218.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E99448BAF
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jul 2026 18:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.218.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784831098; cv=none; b=bbgM5f5QuYv94/mVVPB1bWDZ89jQF+vFvpzrinbJ4b8J1Xkojs1QofChYqn/reon/ii6Z7l1GJxXnf6My+IBD60+L9vrPaWMzThJ3d9y9PeUKruGPfn3Qc3u7fb6WciCe9sEhCgqMjIGhdLGOEfSsLx1F46QwXaKxAihnyOov6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784831098; c=relaxed/simple;
	bh=Xw/6BYLhGI/U0uqatOAd9A+KjU6c54Dz9UVI5ryjZmA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=myxOV14SSewy8tNuV50qv5WrI4JX/vWXHZd1mhxzH0n9Py/pIRb+Gh1v3p20+ueN9R4ku1vgv/6y+pNnytjv9BbEVr4t9Ap8tRpPEqfjA+VhRff5rsdTfULmfdsqqM0tiSA9HTT3afaUieGflui51Cb8qq6d4upxzS6D51gtsac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=BtZdAPQl; arc=none smtp.client-ip=23.83.218.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="BtZdAPQl"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 77A2A380935;
	Thu, 23 Jul 2026 18:07:39 +0000 (UTC)
Received: from pdx1-sub0-mail-a220.dreamhost.com (trex-green-7.trex.outbound.svc.cluster.local [100.104.242.227])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 095C0380E70;
	Thu, 23 Jul 2026 18:07:39 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Bitter-Hysterical: 5fb7ba616bd2d2dc_1784830059296_3476109976
X-MC-Loop-Signature: 1784830059296:4213602275
X-MC-Ingress-Time: 1784830059295
Received: from pdx1-sub0-mail-a220.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.104.242.227 (trex/8.0.2);
	Thu, 23 Jul 2026 18:07:39 +0000
Received: from offworld.lan (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a220.dreamhost.com (Postfix) with ESMTPSA id 4h5fGy3hlQz1K;
	Thu, 23 Jul 2026 11:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1784830058;
	bh=KIG3llslZg4nhF09WX/da7CaM26qq8l9vcHf8cHNbpA=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=BtZdAPQlXZs8KhxqGlfSGRIwzLX/NbOfplrE4RKCwQ2bNuVKRNhb+wW9FNGvfTT+r
	 0fOgoGWQNaXPOjx+/VdELMTwNJH7pceUGGlcCtrUDSZml0oXmYA6m+/Y0fQ4+dL1GJ
	 VySNnbKPOpIlEs0Jb0bVLFp/zW1K/xxgNG0E7vYgUwgZGcwtSBOIvdVyjErdxkbHva
	 AwA4ad4QtFciesDqrvGfkwVwqmbiTryMsEagJcee+FdJmhPGvjCzfDMVdzLkPaI4cX
	 QcTRMljX6Y22csOkdthTgaxfFPX4Yd0Mekrp8spKoP5r69aZMdjUqqFDs4McUc4JQ6
	 tUjz0o74GVwkg==
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com
Cc: djbw@kernel.org,
	jic23@kernel.org,
	alison.schofield@intel.com,
	linux-cxl@vger.kernel.org,
	Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH] cxl/test: Map mock device nodes to an online node
Date: Thu, 23 Jul 2026 11:06:30 -0700
Message-Id: <20260723180630.1302871-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cxl_mem_init() assigns alternating NUMA nodes to the mock memdevs
to model multi-node topologies. On a single-node host node 1 has
no pgdat, and the first node-aware allocation in an odd device's
probe faults on a NULL zonelist:

  Oops: general protection fault, probably for non-canonical address 0xdffffc00000006e3
  KASAN: probably user-memory-access in range [0x0000000000003718-0x000000000000371f]
  Workqueue: async async_run_entry_fn
  RIP: __alloc_frozen_pages_noprof+0x288
   new_slab
   ___slab_alloc
   __kmalloc_node_track_caller_noprof
   devm_kmalloc
   cxl_mock_mem_probe

Map the requested node to an online one, as dax_hmem already does
for its target node.

Fixes: cf1f6877b088 ("cxl/memdev: Add numa_node attribute")
Fixes: e41c8452b9b2 ("tools/testing/cxl: Add a single-port host-bridge regression config")
Fixes: c9435dbee119 ("tools/testing/cxl: Add an RCH topology")
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
Found while regression testing unrelated work.

 tools/testing/cxl/test/cxl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index ef92dd35e030..5156516a82d2 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -1748,7 +1748,7 @@ static int cxl_mem_init(void)
 		if (!pdev)
 			goto err_mem;
 		pdev->dev.parent = &dport->dev;
-		set_dev_node(&pdev->dev, i % 2);
+		set_dev_node(&pdev->dev, numa_map_to_online_node(i % 2));
 
 		rc = cxl_mock_platform_device_add(pdev, &cxl_mem[i]);
 		if (rc)
@@ -1763,7 +1763,7 @@ static int cxl_mem_init(void)
 		if (!pdev)
 			goto err_single;
 		pdev->dev.parent = &dport->dev;
-		set_dev_node(&pdev->dev, i % 2);
+		set_dev_node(&pdev->dev, numa_map_to_online_node(i % 2));
 
 		rc = cxl_mock_platform_device_add(pdev, &cxl_mem_single[i]);
 		if (rc)
@@ -1779,7 +1779,7 @@ static int cxl_mem_init(void)
 		if (!pdev)
 			goto err_rcd;
 		pdev->dev.parent = &rch->dev;
-		set_dev_node(&pdev->dev, i % 2);
+		set_dev_node(&pdev->dev, numa_map_to_online_node(i % 2));
 
 		rc = cxl_mock_platform_device_add(pdev, &cxl_rcd[i]);
 		if (rc)
-- 
2.39.5

