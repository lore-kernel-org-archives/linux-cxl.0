Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486E228DC4
	for <linux-cxl@vger.kernel.org>; Wed, 22 Apr 2026 23:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776898970; cv=none; b=VJgG6WG29Y89kFaztJzWxXTG2lygweDlgyp3b8FOuTZkopWKJmjXEQDogz6Rdest3V4voWkUlXtidKF0S+JAodeIrcxF3EjpPif15Hv/hpvyrCKg9SSiMHlAvkiAXd3a5AjlvdumXBZjRuWlCU0uvK5v87U8FbBtwSHkFv/SbTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776898970; c=relaxed/simple;
	bh=ln4HUaE32ZWoiptHwluomU/KjvA9rqcfFKTFUHP2nJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XpNOZ2L55xC6kT2FIEEjpQEDZflE3UBdIlrWWxbGHGi2V/Ho4QSo1/JdEO/UitozYr/ikkAOxEgae6wdz9bH7yeHNGhB20KrVGQhLEG8pxY17T2GORJqmjp3nyTXEZSdBwqEmY5Kz9yEHCcqHMoHyHnDo11C/ZiQrAlASSjjNn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3ECBC19425;
	Wed, 22 Apr 2026 23:02:49 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jic23@kernel.org,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	djbw@kernel.org
Subject: [PATCH 7/7] cxl: Fix double unregistration of CXL regions for type2 devices
Date: Wed, 22 Apr 2026 16:02:37 -0700
Message-ID: <20260422230237.2599333-8-dave.jiang@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422230237.2599333-1-dave.jiang@intel.com>
References: <20260422230237.2599333-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For a type2 device cxl_memdev_attach_region() is provided as the callback
to devm_cxl_add_memdev() call. In cxl_memdev_attach_region() a devm
action cxl_endpoint_region_autoremove() is registered to remove the
region when the device is removed. And this action calls
unregister_region() on trigger.

When the endpoint port driver is probed, discover_region() is called
to register a region. The call tree becomes discover_region() ->
cxl_add_to_region() -> construct_region() -> __create_region() ->
devm_cxl_add_region(). In devm_cxl_add_region(), unregister_region()
is also added as a devm action.

When removing the cxl_test module, the platform devices are removed
and that triggers the endpoint driver removal and calling of
unregister_region(). And then when the mock type2 device driver is being
removed, the devm action of unregister_region() is called again, which
causes a kernel warning about double unregistration of the same region.
Add a check to see if the devm action is already removed before calling
unregister_region() for cxl_endpoint_region_autoremove().

Signed-off-by: Dave Jiang <dave.jiang@intel.com>

---
- Need to add a fixes tag when the patch commit that introduces
  cxl_endpoint_region_autoremove() is stable.
---
 drivers/cxl/core/region.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 61a3efdbf3c9..1a7c0895bb88 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -4296,7 +4296,8 @@ static void cxl_endpoint_region_autoremove(void *_cxlr)
 	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	struct cxl_port *port = cxlrd_to_port(cxlrd);
 
-	devm_release_action(port->uport_dev, unregister_region, cxlr);
+	if (!devm_remove_action_nowarn(port->uport_dev, unregister_region, cxlr))
+		unregister_region(cxlr);
 }
 
 /*
-- 
2.53.0

