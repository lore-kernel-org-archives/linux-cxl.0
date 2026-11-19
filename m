Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795052678;
	b=5dMQd73sYG9yWjKvZefz13y6v0PHRjazE30YfLFwlxAvyV5tapAi6YUfsO8yi5+wuLEQ
	 0fn+QEECrtOXSlcpswfT0thmrehapwajaXZnmwKNfNd3QDHCCrdsFb11aQVkNNUJ2PCV/
	 6h3rm+LCSB4kWsw3xAPUVb/rFeryAcw4SrXKa3bIyBEOgtOAP3oXmplq2x2tqXdjty28t
	 lWNFEXx4yEDw9TwWo3tzQhve71dmcrw4n62972OAztnL1PTCaGQ5MEDwph7NVFNTjKJL0
	 wfz2PYOiynD2J1WrJdj+vLjsnN63oLWVQFJm0c+kOqIarVtSI1hDUAe92NAgYqBGFVw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795052678;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=cnK7ZBiBaKI1wtqWRmai1VEkIh10lPuIV34Zp2OGQBs=;
	b=HiImNxUJkafDGvlLIVfrRpuqB0RjAbXMZED164XBRozw1rne10CaJ3CFLD8HmZ4HydSo
	 NSRm2TwfVISEtSrAHAm9XcG8YNJjsqx5s7zUP72Wrlp7dMX64FzwU2Tpb+SiUE+HE0sds
	 OHab+s/YTRPrNTFqnFRLu3P237CeQf+hAOSeFUXkv+EQ88D6m/9dVNnsybo3u6IAsLUri
	 BrzVmDj8CMyJ970px1LgkQdknwI7rfspr/rW85QxfbH47a+cWixaxGddzBZYKBcwaFyBy
	 rYmhoMRjXVXumaWcf7hQPabhAGnRVU7xM5/1rNgmE6jhS1eT1Cf0soOg1n+MeBjvHaw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HbUUQCY+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F030E606A332;
	Thu, 19 Nov 2026 01:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HbUUQCY+
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795052677;
	b=WGASDUjfqp8FPTy5LYKcXpKSZqT8jKIupeZUsHIPtX30HHoHy51dy84t3SorwLkhhhy2
	 VrfdP6kFakAD2R9LlVwoTwYn1irMlXXpQE55DK3cXKJghpl1DyJpwIJdjHPFhJDFe1Rxx
	 P6QEQTbjxMbqHuZP9FPTTeMFbVRm+scJ7S0afwStpP/tt1dRO/ibT7Yht2zu4Orfe0tst
	 8bArZ30RlKQmM0snKWC0xkh39L4o6zqPPWHk152BvwTtuQ7uRw9yC/8xaczjbOKn5xWG5
	 shCo8p7dLQHBxPDCoEzHAM5xJnu5XS2fpjjJY2SxxUHOeRxAVM8HjXwm/LSYqfolRHA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795052677;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=cnK7ZBiBaKI1wtqWRmai1VEkIh10lPuIV34Zp2OGQBs=;
	b=VBWjnFKjxephhrtRW/FEFnDGrERHMoEfLYQ/11TeVRPcaFkLwkFM1dHj0M4mQrooE3PP
	 qQLxjfiWGr4RkJRCujXTumTS87HM2TL5JSYW0Buigl0LIEyBokMxVN/NhkGfZI168ZdME
	 tTq6MLCmJCB+lThBVxFsUjJQvqj/06ySla7/OcSPFQkkxKj5ucSZ2SOe4XcLQbHFP8THl
	 /ME7zpLlq6QXHMW8LmAjnPg5TCJgKE8mu4ZVXgJdphDroHqihDgSg5EoFj3K72rpZWRzW
	 zH7OgCumA5KYI3/8gHTRDfRt9j5WBx11oqjzy5t1+ERLqhd88xFBuW4HYWBxdbRnsnw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 252C71F000C7;
	Thu, 19 Nov 2026 01:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795052677;
	bh=cnK7ZBiBaKI1wtqWRmai1VEkIh10lPuIV34Zp2OGQBs=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=HbUUQCY+enpn050nWnV5iFURe8gAF+UuUh+WyoeliCKh1FveFMzow+6mM0/ybuWNh
	 nQeOveMdYJRHlnbokCpvGgh6tibNS2opO/7oWqWYPK/33PDLb2yFTP0ABzgs2YVVIc
	 UguicG6pEJ9ihL27yBsNsjEiGumV7J5V2ca7cPE6Uh9x40K2MLWCCbu92bIyaAzMik
	 3CSqKqKbhemR7uVQI7lPy8wLWCbUzDpY5MgzvZPldYIFSFdAnln1D0CBgZ2reeB6l3
	 nMUlEat3wUdlHAmlIn93594UOkTy0QIX4nckw67YzVUJeRqGULZCR44rHPCEwjUWGa
	 hzCbkeoIY0hGg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 7B03C4B071;
	Thu, 19 Nov 2026 01:44:36 +0000 (UTC)
From: Junho Cha via B4 Relay <devnull+junho.cha.xcena.com@kernel.org>
Date: Thu, 19 Nov 2026 10:44:36 +0900
Subject: [PATCH v2] cxl/region: Fix self-deadlock when
 cxl_memdev_attach_region() fails
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261119-junhomax-fix-cxl-attach-region-deadlock-v2-1-32ddef645e52@xcena.com>
X-B4-Tracking: v=1; b=H4sIAINU/moC/42Oyw4CIQxFf8WwtiqM4ySu/A8zi07pCD7AAE4wZ
 v5d0Lh3edre0/sSkYPlKPaLlwg82Wi9K6CWC0EG3YnB6sJCbdROStnA+eGMv2GG0WagfAVMCcl
 A4FOJgmbUV08XGGmDW9WOndq1otjugUvi8+nYfzk+hjNTqvp6MWBkGAI6MnVU3GvHOdWVsTH58
 Py0nGRV/Ap1fxeaJEgYm65B2bSstTpkYocr8jfRz/P8Bjz7J3wLAQAA
X-Change-ID: 20261113-junhomax-fix-cxl-attach-region-deadlock-fc0a425f7265
To: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org
Cc: Davidlohr Bueso <dave@stgolabs.net>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, 
 Li Ming <ming.li@zohomail.com>, Ben Cheatham <benjamin.cheatham@amd.com>, 
 Alejandro Lucero <alucerop@amd.com>, Richard Cheng <icheng@nvidia.com>, 
 linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>, 
 Junho Cha <junho.cha@xcena.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795052675; l=4969;
 i=junho.cha@xcena.com; s=20261113; h=from:subject:message-id;
 bh=BzCoR+CtJdDu/2UmEZ5eieYhLBnjjCJCk7PJaGYt0VM=;
 b=R8gEPdS1ts+/teNCGYIS1PUdYfum3DZ3Pe8lqwiCWS65WPngOAm8oI373gSWHLTgwXKQ8InHI
 CBvdUtJR9CRBXAIFxghz2b4BwsjVWv7oDt7FjD1ue2yPYna772vEdsg
X-Developer-Key: i=junho.cha@xcena.com; a=ed25519;
 pk=OkFm4PnuJSze1AVqDdvnpHO7nnDQIheH2qYwg2a6Dyc=
X-Endpoint-Received: by B4 Relay for junho.cha@xcena.com/20261113 with
 auth_id=1507
X-Original-From: Junho Cha <junho.cha@xcena.com>
Reply-To: junho.cha@xcena.com
Content-Transfer-Encoding: 7bit

From: Junho Cha <junho.cha@xcena.com>

cxl_memdev_attach_region() holds cxl_rwsem.region for read while it
registers endpoint_unregister_region() with devm_add_action_or_reset().
If registering the action fails, devm_add_action_or_reset() runs the
action at once, which reaches cxl_decoder_detach() through
unregister_region() and detach_target():

  cxl_memdev_attach_region()
    down_read(&cxl_rwsem.region)
    devm_add_action_or_reset()          /* fails with -ENOMEM */
      endpoint_unregister_region()
        unregister_region()
          detach_target()
            cxl_decoder_detach()
              down_write_killable(&cxl_rwsem.region)

The task then waits for a write lock while holding the same rwsem for
read, and never makes progress.  Before it hangs, lockdep also reports
a circular dependency: endpoint_unregister_region() takes
cxlrd->regions_lock under cxl_rwsem.dpa, while cxl_add_to_region()
takes cxlrd->regions_lock before both rwsems.

Register the action with devm_add_action() instead, still under both
rwsems, and if that fails, run it only after the rwsems are dropped.
The endpoint device lock stays held throughout, as before.

Reproduced with cxl_test (type2_test=1) by failing the devres
allocation through failslab, with the stack filter limited to
cxl_memdev_attach_region().  Without this patch the probing task hangs
in cxl_decoder_detach().  With it, the cxl_mem probe fails with
-ENOMEM, the region is unregistered, and lockdep stays quiet.

Fixes: d8dcb0b74b04 ("cxl/region: Introduce devm_cxl_probe_mem()")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/all/20260805080537.7489E1F000E9@smtp.kernel.org/
Assisted-by: LLM
Signed-off-by: Junho Cha <junho.cha@xcena.com>
---
Dave pointed at this reset path while reviewing the Type2 multipf
series [1]. This is a standalone fix for the existing code that keeps
the region teardown when registering the action fails.

[1] https://lore.kernel.org/linux-cxl/6bc33514-8bfb-44d6-8fde-28f45dff5eb9@intel.com/
---
Changes in v2:
- Register the action under both rwsems as before and only run the
  unwind after dropping them.  v1 left a window where the region could
  be detached before the action was registered (Ben).
- Add Reported-by/Link for Sashiko.
- Drop Alejandro's Reviewed-by, since the fix changed.
- Link to v1: https://patch.msgid.link/20261117-junhomax-fix-cxl-attach-region-deadlock-v1-1-f373a135edd2@xcena.com
---
 drivers/cxl/core/region.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 237172b33f55..f9538ac98a1f 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -4437,7 +4437,8 @@ static int first_mapped_decoder(struct device *dev, const void *data)
  * Runs in cxl_mem_probe context after successful endpoint probe, assumes the
  * simple case of single mapped decoder per memdev.
  */
-int cxl_memdev_attach_region(struct cxl_memdev *cxlmd)
+static int __cxl_memdev_attach_region(struct cxl_memdev *cxlmd,
+				      struct cxl_region **unwind)
 {
 	struct cxl_attach_region *attach =
 		container_of(cxlmd->attach, typeof(*attach), attach);
@@ -4446,10 +4447,6 @@ int cxl_memdev_attach_region(struct cxl_memdev *cxlmd)
 	struct cxl_region *cxlr;
 	int rc;
 
-	/* hold endpoint lock to setup autoremove of the region */
-	guard(device)(&endpoint->dev);
-	if (!endpoint->dev.driver)
-		return -ENXIO;
 	guard(rwsem_read)(&cxl_rwsem.region);
 	guard(rwsem_read)(&cxl_rwsem.dpa);
 
@@ -4484,10 +4481,11 @@ int cxl_memdev_attach_region(struct cxl_memdev *cxlmd)
 
 	/* Only teardown regions that pass validation, ignore the rest */
 	get_device(&cxlr->dev);
-	rc = devm_add_action_or_reset(&endpoint->dev,
-				      endpoint_unregister_region, cxlr);
-	if (rc)
+	rc = devm_add_action(&endpoint->dev, endpoint_unregister_region, cxlr);
+	if (rc) {
+		*unwind = cxlr;
 		return rc;
+	}
 
 	attach->hpa_range = (struct range) {
 		.start = cxlr->params.res->start,
@@ -4495,6 +4493,24 @@ int cxl_memdev_attach_region(struct cxl_memdev *cxlmd)
 	};
 	return 0;
 }
+
+int cxl_memdev_attach_region(struct cxl_memdev *cxlmd)
+{
+	struct cxl_port *endpoint = cxlmd->endpoint;
+	struct cxl_region *unwind = NULL;
+	int rc;
+
+	/* hold endpoint lock to setup autoremove of the region */
+	guard(device)(&endpoint->dev);
+	if (!endpoint->dev.driver)
+		return -ENXIO;
+
+	/* Detaching the region takes cxl_rwsem.region, so unwind without it */
+	rc = __cxl_memdev_attach_region(cxlmd, &unwind);
+	if (unwind)
+		endpoint_unregister_region(unwind);
+	return rc;
+}
 EXPORT_SYMBOL_FOR_MODULES(cxl_memdev_attach_region, "cxl_mem");
 
 /*

---
base-commit: 32af7819352bae9c690ebe277a44eceb501d5c68
change-id: 20261113-junhomax-fix-cxl-attach-region-deadlock-fc0a425f7265

Best regards,
--  
Junho Cha <junho.cha@xcena.com>


