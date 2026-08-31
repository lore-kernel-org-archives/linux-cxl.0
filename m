Received: from earwig.ash.relay.mailchannels.net (earwig.ash.relay.mailchannels.net [23.83.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A19D2EEE6C
	for <linux-cxl@vger.kernel.org>; Mon, 31 Aug 2026 19:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788203396; cv=none; b=hQxt/j15iiQFtzxyTENaaHnQfHqUoGI2xbVgeQXxbMlRVM2Mr0yF8X7LYUmd19pOcNx7pZageUI5suEYF6jKV/YxZwbY5oTmcsbk8ZQxhA+6EGQnfehCdGU9rEwIAI/WHfJtW1u7ZWqAjCaa/nmmnH9jHpd5Bw3hF3wkbTjkbJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788203396; c=relaxed/simple;
	bh=Km3oznIRQnnuWlPFD+9rb19FGLYttA8wNkXzEXyVZec=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K7fwAhrVpZmX/nmU6uy7b0Fb33lXVd9zeFBsF9wA0yv70a40rt/rWid7T6MV8h5AGQJbRn3F1tEn3kSx+7dGqAJwj4DmKX4cLj7u1F/9SJcxJHKRQSKsuwDxl+Eu2aiHdtdaLjjiz1mSCE3u8qt/ePfgVFPcnlP6P6Vojq00vgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=HOsnRzcm; arc=none smtp.client-ip=23.83.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="HOsnRzcm"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id D4F75403008;
	Mon, 31 Aug 2026 17:51:35 +0000 (UTC)
Received: from pdx1-sub0-mail-a249.dreamhost.com (trex-green-3.trex.outbound.svc.cluster.local [100.96.170.102])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 5C9AF4030BE;
	Mon, 31 Aug 2026 17:51:35 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Versed-Chemical: 3494e4a340e96f08_1788198695639_564788910
X-MC-Loop-Signature: 1788198695639:1922323608
X-MC-Ingress-Time: 1788198695638
Received: from pdx1-sub0-mail-a249.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.170.102 (trex/8.0.2);
	Mon, 31 Aug 2026 17:51:35 +0000
Received: from offworld.lan (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a249.dreamhost.com (Postfix) with ESMTPSA id 4hYc4Q5ldnzyrF;
	Mon, 31 Aug 2026 10:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1788198695;
	bh=jCybLKS9JLbQNg8ofERWtzjY1512tHFPHaTfIrW8ejs=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=HOsnRzcmnx++ymDlasorOw7RqNozFG/JMJUFVQ6b0AIi9+oY4qdm78XTOnww52Mx0
	 neT22ae9bZ0q19/zfpvQp/kx679U10mrOh3TZo4kQCol4FBdkE42iptvam2lBhfjjg
	 4faU/K18bpsAqKKC0YwbHzsRJE3cen/XBq9h7zyI/wV0Ng4IweCEVWo0kYAn+n52F+
	 cMrWJBmGhbTK0Fq9+kSOGKcPiXr0VMr1KqgOD214vLsJuxKFijDV5ydyAAKKNxrWnm
	 3WFyg7rvtD/CbV7Tow09pcBZ7XyiMXzp9bqkCDIXeY5YuZ6JIN2Ha+ReWPA1Z0CuEV
	 rkzhDAlWyPBTw==
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com
Cc: jic23@kernel.org,
	alison.schofield@intel.com,
	gourry@gourry.net,
	shaikhkamal2012@gmail.com,
	linux-cxl@vger.kernel.org,
	dave@stgolabs.net
Subject: [PATCH v2] cxl/test: Map mock device nodes to an online node
Date: Mon, 31 Aug 2026 10:51:19 -0700
Message-Id: <20260831175119.3247915-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cxl_type3_mem_init() and cxl_type2_mem_init() assign alternating NUMA
nodes to the mock memdevs to model multi-node topologies. On a
single-node host node 1 has no pgdat, and the first node-aware
allocation in an odd device's probe faults on a NULL zonelist:

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
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Tested-by: Alison Schofield <alison.schofield@intel.com>
Tested-by: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
---
 tools/testing/cxl/test/cxl.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 62bd92b3be45..221be4addb0e 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -1945,7 +1945,7 @@ static int cxl_type2_mem_init(void)
 			goto err_mem;
 		}
 		pdev->dev.parent = &dport->dev;
-		set_dev_node(&pdev->dev, i % 2);
+		set_dev_node(&pdev->dev, numa_map_to_online_node(i % 2));
 
 		rc = cxl_mock_platform_device_add(pdev, &cxl_mem[i]);
 		if (rc)
@@ -1974,7 +1974,7 @@ static int cxl_type3_mem_init(void)
 			goto err_mem;
 		}
 		pdev->dev.parent = &dport->dev;
-		set_dev_node(&pdev->dev, i % 2);
+		set_dev_node(&pdev->dev, numa_map_to_online_node(i % 2));
 
 		rc = cxl_mock_platform_device_add(pdev, &cxl_mem[i]);
 		if (rc)
@@ -1991,7 +1991,7 @@ static int cxl_type3_mem_init(void)
 			goto err_single;
 		}
 		pdev->dev.parent = &dport->dev;
-		set_dev_node(&pdev->dev, i % 2);
+		set_dev_node(&pdev->dev, numa_map_to_online_node(i % 2));
 
 		rc = cxl_mock_platform_device_add(pdev, &cxl_mem_single[i]);
 		if (rc)
@@ -2009,7 +2009,7 @@ static int cxl_type3_mem_init(void)
 			goto err_rcd;
 		}
 		pdev->dev.parent = &rch->dev;
-		set_dev_node(&pdev->dev, i % 2);
+		set_dev_node(&pdev->dev, numa_map_to_online_node(i % 2));
 
 		rc = cxl_mock_platform_device_add(pdev, &cxl_rcd[i]);
 		if (rc)
-- 
2.39.5

