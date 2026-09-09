Received: from iguana.tulip.relay.mailchannels.net (iguana.tulip.relay.mailchannels.net [23.83.218.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2DF33B970
	for <linux-cxl@vger.kernel.org>; Wed,  9 Sep 2026 17:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.218.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788973420; cv=none; b=OQWs++S0btXN9pdS0CFNldrB46OnUBLfHMfrUuABR86+UfKdALpE+T44ZvvxHdK/edayz2fCwmzBqGfEadlmCelgCLXjJmkdRVoJmreKGtq5zFOzMhcZ21l9DmzR2uBREAGOevOVP9K34J/z8acjmgn6WqnLqDgRXatCPrSZtRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788973420; c=relaxed/simple;
	bh=7FW3BuozXe5ptMNAeQXR+LzJEgs7YrdLNtO4EKXrMGU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jhM3lX0R8lDmROhYNzCAJMjVI+LvkFoLp7Z1NUz4sqxt2+RlO/eYOKhq88ricP8UE9iI1HyNTIWexT0FLRRbArrVrOeQsRU9uJhYFqG+kaAHgjjQgzLLIoFuB2gMabUdbtclM13YpMQZ3eyfBgJnN+iZbiHzsZgQe238oyM2QIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=H63T14r4; arc=none smtp.client-ip=23.83.218.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="H63T14r4"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 91EF5629AB;
	Wed, 09 Sep 2026 17:03:32 +0000 (UTC)
Received: from pdx1-sub0-mail-a213.dreamhost.com (100-98-23-243.trex-nlb.outbound.svc.cluster.local [100.98.23.243])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 604FA6396A;
	Wed, 09 Sep 2026 17:03:32 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Scare-Coil: 6754ee4e54b43fa4_1788973412489_1366598741
X-MC-Loop-Signature: 1788973412489:221873434
X-MC-Ingress-Time: 1788973412488
Received: from pdx1-sub0-mail-a213.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.98.23.243 (trex/8.0.2);
	Wed, 09 Sep 2026 17:03:32 +0000
Received: from offworld.lan (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a213.dreamhost.com (Postfix) with ESMTPSA id 4hg6Zq57pwz1dC;
	Wed,  9 Sep 2026 10:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1788973412;
	bh=VT95OGeCGzxtkKfxh7TY4CFcOg+AQ3hXPCQXumSUKgc=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=H63T14r4yOvkwzdPXXTt+OzRAdvGjOXexR6JZi+tW7ZWTul9xB/xn7+0+85oHVmVH
	 5wKrbmI7PQHZXlg8EGhAtnmY+oKHqlBbDsXiYgYe6tiX8xmcPZRUkWFK2MN168/6ia
	 hgRZiP22VmE+2Uvnkw9kA7LDo+080C8+0MEqH4VD4g/i+zyF7M9vPyFj2NJsk0YIVh
	 jNbky5ywfzaFU5cz5Ny9KUH6nYl+8Bs3cfTp3LAzpu4ObeIDHajy9lbMvKxfxKPmtE
	 B3irvxZxHGKFR0Jzc6aDidhMNeqAYEV6y9qYuj813MwlqXjCM59xI5O2foLct4Lwxu
	 1B6LyH3CMtO7Q==
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com
Cc: jic23@kernel.org,
	alison.schofield@intel.com,
	icheng@nvidia.com,
	ming.li@zohomail.com,
	benjamin.cheatham@amd.com,
	alucerop@amd.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org
Subject: [PATCH v8 06/10] cxl/region: Log the coherency model at region creation
Date: Wed,  9 Sep 2026 10:02:58 -0700
Message-Id: <20260909170302.1550680-7-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260909170302.1550680-1-dave@stgolabs.net>
References: <20260909170302.1550680-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Region assembly emits plenty of debug information - resources,
interleave geometry, target placement - but not the coherency model
the region operates in.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/cxl/core/region.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 6ccb3b387619..9874be7732d4 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1843,6 +1843,13 @@ static int cxl_region_attach_position(struct cxl_region *cxlr,
 	return rc;
 }
 
+static const char *cxl_coherency_name(enum cxl_decoder_type type, bool bi)
+{
+	if (type == CXL_DECODER_HOSTONLYMEM)
+		return "HDM-H";
+	return bi ? "HDM-DB" : "HDM-D";
+}
+
 static int cxl_region_attach_auto(struct cxl_region *cxlr,
 				  struct cxl_endpoint_decoder *cxled, int pos)
 {
@@ -2797,8 +2804,10 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
 		return ERR_PTR(rc);
 	}
 
-	dev_dbg(port->uport_dev, "%s: created %s\n",
-		dev_name(&cxlrd->cxlsd.cxld.dev), dev_name(dev));
+	dev_dbg(port->uport_dev, "%s: created %s %s\n",
+		dev_name(&cxlrd->cxlsd.cxld.dev),
+		cxl_coherency_name(cxlr->type, cxl_root_decoder_is_bi(cxlrd)),
+		dev_name(dev));
 	return cxlr;
 err:
 	put_device(dev);
-- 
2.39.5

