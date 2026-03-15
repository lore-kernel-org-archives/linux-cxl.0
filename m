Received: from buffalo.tulip.relay.mailchannels.net (buffalo.tulip.relay.mailchannels.net [23.83.218.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A9A1B81D3
	for <linux-cxl@vger.kernel.org>; Sun, 15 Mar 2026 22:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773614900; cv=pass; b=DkYH40NMLyLEHuju1sLdNs3kc20azHHkaz5EKW/YtrvHlsGICHv4Z/5mBC12v1W0iLVV9u+voig5MMFyjljF8FGFp7Kc6fR5FUukgNOWYRWMcsK9DDIbeLy2Mk/7NR0vTNKtAEvaR3tt+hhXbpebrlwdOsuxcIACDDZBM6+OI6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773614900; c=relaxed/simple;
	bh=XcrzQf6Y9QH1O8+dmOX16PZhKBxVmZl0l0DLGKZ7Ba0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GIH5jksl3Jk5u802Ie0bGiVDpoK4a+fBzBOS3a7Sycoh29TRga2gQnEFtje2ITXfcYyFXsp8349Jc3yVRzRKM4+J7pzFdzJTokrCr0aVJD9pdwgZ+Tpdlzpz+4U3TEplybDsyRIOLfFC2bkXcGLedSeY1DnMjNgLDUJEKWHJUi0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=bIgZV9fv; arc=pass smtp.client-ip=23.83.218.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="bIgZV9fv"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 1029A762BD6;
	Sun, 15 Mar 2026 20:27:47 +0000 (UTC)
Received: from pdx1-sub0-mail-a246.dreamhost.com (100-114-133-181.trex-nlb.outbound.svc.cluster.local [100.114.133.181])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id AEBB5761688;
	Sun, 15 Mar 2026 20:27:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1773606466;
	b=QkwRYQITqADz+Cpdx9LF3rLPT+eFs8UGtplLQXWTSew1Xhaa1HlT1Xs6tpbmWn8fe+9zGh
	MIBZwO0hpWn6Dm1j6y1JMZvuy0eFSI3jxMlR776Sw24MGH6afA5phjnC9YfeT6CHNrfnQi
	eY4Mk6Jtbe33NzbQvaRgjjeORoeSXg1KH4AILsDAZlOpAYfvhGTU9AfkUOMKvXj77it9fA
	3XcpTb8qvEYN1Vtq7XmvMKENMeva0qlufFNoEyjuXkdJ1xvJTbZRfiF50BoluyRHrVOl0z
	ZCx9GpBZZMyRb2RXl7R5Dmh3MTiUU9rpQE+Sv2/7wj4T2sb7n9fNGjWMzuxx6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1773606466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=jc0AjQE7eqYxhHH7DprTJB25dBIseM77Vw5j5zWN6LU=;
	b=6I2tWgl0rzhcIvsXeVZvmiVx86j55H9asIQ+T4zst9a40+NwM30nnK10gwqVpBtgKkvv7B
	WVWR6LqBm7hqNjp8ulKd+tJ2avaCwCV3oe6ZEyDXMNDIqVUComcTsY5pc6krHolL6kSNVs
	usCC7C0RV6miY70rU8j/8dmtLv2wk7wL/Z+ytZOGF9DtfmJjIIb0BoMfo2/IAuV4WDt9GY
	7rmUmADFa4vB4LnSoxLB7vFygATK2aWc/R7jdnrbny8Z9f2g6irTZyAG9wyA8q5n4w50JM
	kkITBSYawsjr8WD50CsR570fd4jfz8ch9sYsSGrFW/x59jfSaDMz+/c6Ht0PEg==
ARC-Authentication-Results: i=1;
	rspamd-c9674b64d-qm5f5;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Eight-Harbor: 71a6fb4179f23aee_1773606466974_3530060355
X-MC-Loop-Signature: 1773606466974:1243553964
X-MC-Ingress-Time: 1773606466974
Received: from pdx1-sub0-mail-a246.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.114.133.181 (trex/7.1.5);
	Sun, 15 Mar 2026 20:27:46 +0000
Received: from offworld.lan (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a246.dreamhost.com (Postfix) with ESMTPSA id 4fYqXf0HhFz107t;
	Sun, 15 Mar 2026 13:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1773606466;
	bh=jc0AjQE7eqYxhHH7DprTJB25dBIseM77Vw5j5zWN6LU=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=bIgZV9fviv3nc3IE7t2NIxRIIpnAcYhOsN9rQWtQUzzmeRgTOQIdufDEnvz6ZwtfC
	 c5erzUCtoR9bctpS+UmcxnyRhVydo04HfZiAIQNFLhlS6FoZfYqpPXPNSD3v24LUbi
	 PY69KYvXU9B8EtKITC0wItqAO0fAaPNaqU3T5Sl9Pw5nRUY7mRoG/ICyOM8yeDaaFN
	 oTr+i0eqinEVTs/GmS+tsi4EQUaKNq8wSdYRidLU8dkH3+IfS8VO/AowOzy9iAfsdW
	 HAUGemEIJ2nOpuaWHzZIGpJzLuNbR0qLHhS5GZUegbzDhrtJ9tnBN4sogiGyaMtkFQ
	 TTACkGVBvCSgw==
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com,
	dan.j.williams@intel.com
Cc: jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	ira.weiny@intel.com,
	gourry@gourry.net,
	dongjoo.seo1@samsung.com,
	anisa.su@samsung.com,
	linux-cxl@vger.kernel.org,
	Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH 4/6] cxl: Wire BI setup and dealloc into device lifecycle
Date: Sun, 15 Mar 2026 13:27:39 -0700
Message-Id: <20260315202741.3264295-5-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260315202741.3264295-1-dave@stgolabs.net>
References: <20260315202741.3264295-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Setup BI flows during cxl_mem_probe() after endpoint enumeration and
EDAC registration, and tear down BI during endpoint detach.

BI setup failure is non-fatal - the device continues to operate
in HDM-H mode without back-invalidate support.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/cxl/mem.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index fcffe24dcb42..3adee41885c5 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -65,6 +65,11 @@ static int cxl_debugfs_poison_clear(void *data, u64 dpa)
 DEFINE_DEBUGFS_ATTRIBUTE(cxl_poison_clear_fops, NULL,
 			 cxl_debugfs_poison_clear, "%llx\n");
 
+static void devm_cxl_bi_dealloc(void *data)
+{
+	cxl_bi_dealloc(data);
+}
+
 static int cxl_mem_probe(struct device *dev)
 {
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
@@ -150,6 +155,21 @@ static int cxl_mem_probe(struct device *dev)
 	if (rc)
 		dev_dbg(dev, "CXL memdev EDAC registration failed rc=%d\n", rc);
 
+	rc = cxl_bi_setup(cxlds);
+	if (rc)
+		dev_dbg(dev, "BI setup failed rc=%d\n", rc);
+
+	/*
+	 * Register BI dealloc after setup so devm ordering ensures
+	 * it runs before the endpoint is removed by delete_endpoint().
+	 */
+	if (cxlds->bi) {
+		rc = devm_add_action_or_reset(dev, devm_cxl_bi_dealloc,
+					      cxlds);
+		if (rc)
+			return rc;
+	}
+
 	/*
 	 * The kernel may be operating out of CXL memory on this device,
 	 * there is no spec defined way to determine whether this device
-- 
2.39.5

