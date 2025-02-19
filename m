Received: from zebra.cherry.relay.mailchannels.net (zebra.cherry.relay.mailchannels.net [23.83.223.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5204B1BBBDD
	for <linux-cxl@vger.kernel.org>; Wed, 19 Feb 2025 06:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=23.83.223.195
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739946557; cv=fail; b=OnS0Pxx8STdoT3iriUyf6BiTexnuIYl+jg94ftUviAvGUXnr3bOQmXtLDMq/2LpkgPWZ7znS82rHtq+o+SL2Fhgw9CmvR1tSVz3rpnoLvR/us6x3RdiGXZ7ML27fdJobzLcExumO6nnRr9j+BuZsHWDXnrBorObdR2Fe06b1qps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739946557; c=relaxed/simple;
	bh=h8tA71RFrlQhtkBAcVa/w8gdbj9HNuaepjd4KEiMaGQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SCN9ipVGPPygejCHZrCLJM/aN528wQ9JIRGCKH2jni9PFbLX3ynTrjGJyCINcVmdXc0Artyz1r40jatHRox0cWWS30bUySWyK9Rbb8VWLypSVvwXEOS+zTp5Z2smCfx/9A8zgE7DE4MAiq+BnobqZ+iLBE/95yHj/brR5vRtzOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=pR/zpc5L; arc=fail smtp.client-ip=23.83.223.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="pR/zpc5L"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 88DE1322191;
	Wed, 19 Feb 2025 06:29:13 +0000 (UTC)
Received: from pdx1-sub0-mail-a223.dreamhost.com (trex-7.trex.outbound.svc.cluster.local [100.97.164.218])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id F1D633209EF;
	Wed, 19 Feb 2025 06:29:12 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1739946553; a=rsa-sha256;
	cv=none;
	b=H2qsQsotqqbdF2P5Yu74PjLWSsewD45Z0luJdiYZwLDDi/SmE3XDPrROcOtTovV26t5f1W
	QrSO9l8Eq8wKIddqHGM+NYi5KiiuVedt4+bbpSxnPGChsPvH52yTxHhbSMH/fCH1hzWFn+
	1LARf8e8f9ruvbX+G2BW9tHYEXeHyhWTccMTWBJOPt5UNfR/t2E+DR8QBNFlpZ2yHQHJYG
	xzxR9m1wp+/m6Nrepw1I9iFFkzGBMY1rU7klaHm++Hr8xc7nSNDSXxTU26NVRU05voeGLg
	A54jM9XIsT/5BKP8wU+kH94feUb/H1QZbmlRP840FTnpLaKK4olWmjEMT5/qMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1739946553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=kNnIhAIy8y5jzKquXxkJ9feqPL5tQp8S1l6poafr0YA=;
	b=lc1Sl8fwvrp6QBtfYj7hKH+7NC2BSMwSdbfTkQUy+NPmrMsWgw93Oxdzdjmt+yCciDAvNk
	Sm/x4yU/KKqWdM83qtCIlzgt7tYtJs+ThsrN1OcUp0VIjtz49sApDErp+YIWUwX2bc0acu
	yUYG/ViPcJQO3PTSA9Dt8FqeOGfPNTfM2G50E1LQJn6bfhlSMWhA3NJ7PTQ9NZRodFWlyZ
	38LdKNQzEi87ikyUs822/vCwpOZyYaTZrCjWwb0WWEUdZ/z/e/0Ky4qGz07YEmFg94HEBW
	BkwDvBDr0fJt7TU3vnE8/HN8scDKdLM0lpZCKY05IP5GmQ0R014zb2+fQiRmtw==
ARC-Authentication-Results: i=1;
	rspamd-6d7cc6b78d-k4sxl;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Sponge-Grain: 27d0246870c368aa_1739946553416_541140854
X-MC-Loop-Signature: 1739946553416:1448416348
X-MC-Ingress-Time: 1739946553416
Received: from pdx1-sub0-mail-a223.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.97.164.218 (trex/7.0.2);
	Wed, 19 Feb 2025 06:29:13 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a223.dreamhost.com (Postfix) with ESMTPSA id 4YyRLc0rLgzKn;
	Tue, 18 Feb 2025 22:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1739946552;
	bh=AwjeP9Ekg1SXiXHrkOJ5S+lDI+lScxRU4Ayfo04F65U=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=pR/zpc5LFHBOLUneHfY5mGWV95AOuqd7Cooj9Q5uNq0Fo7VOy4vDpVoNiPSWp00kB
	 iWgrI5+TZyyQWSELLD4At63UWLts6X07OFh4eZMlahgAj0Ac34nzNYf/wP0DYKoYn3
	 eN8fqQiKGHsmnhFRGPNh4k4ySXuAUFDblshmzgy7cmAXhc5+ltzRqri/V5GzOlIgEm
	 0LQywL95WDkLmKFGWGafLGGUv7TL0NitZDaEITrQgjvkihUK+iqaEW/L3aadxONqQa
	 h5lWaJg79QvSqd6XPteTYCNC0NZDvrSEWoWHS/Xxn8Clf/VUg/vcFlKpdbPGIhS68z
	 pe8tBwfVL7r6A==
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com,
	dan.j.williams@intel.com
Cc: jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	ira.weiny@intel.com,
	vishal.l.verma@intel.com,
	seven.yi.lee@gmail.com,
	a.manzanares@samsung.com,
	fan.ni@samsung.com,
	anisa.su@samsung.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org
Subject: [PATCH 2/4] cxl/pmem: Rename cxl_dirty_shutdown_state()
Date: Tue, 18 Feb 2025 22:28:30 -0800
Message-Id: <20250219062832.237881-3-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250219062832.237881-1-dave@stgolabs.net>
References: <20250219062832.237881-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

... to a better suited 'cxl_arm_dirty_shutdown()'.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/cxl/core/mbox.c | 4 ++--
 drivers/cxl/cxlmem.h    | 2 +-
 drivers/cxl/pmem.c      | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index c5eedcae3b02..86d13f4a1c18 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1281,7 +1281,7 @@ int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_mem_dpa_fetch, "CXL");
 
-int cxl_dirty_shutdown_state(struct cxl_memdev_state *mds)
+int cxl_arm_dirty_shutdown(struct cxl_memdev_state *mds)
 {
 	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
 	struct cxl_mbox_cmd mbox_cmd;
@@ -1297,7 +1297,7 @@ int cxl_dirty_shutdown_state(struct cxl_memdev_state *mds)
 
 	return cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
 }
-EXPORT_SYMBOL_NS_GPL(cxl_dirty_shutdown_state, "CXL");
+EXPORT_SYMBOL_NS_GPL(cxl_arm_dirty_shutdown, "CXL");
 
 int cxl_set_timestamp(struct cxl_memdev_state *mds)
 {
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 8e1e46c348f5..6d60030139df 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -822,7 +822,7 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
 			    enum cxl_event_log_type type,
 			    enum cxl_event_type event_type,
 			    const uuid_t *uuid, union cxl_event *evt);
-int cxl_dirty_shutdown_state(struct cxl_memdev_state *mds);
+int cxl_arm_dirty_shutdown(struct cxl_memdev_state *mds);
 int cxl_set_timestamp(struct cxl_memdev_state *mds);
 int cxl_poison_state_init(struct cxl_memdev_state *mds);
 int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
index a39e2c52d7ab..6b284962592f 100644
--- a/drivers/cxl/pmem.c
+++ b/drivers/cxl/pmem.c
@@ -90,7 +90,7 @@ static int cxl_nvdimm_probe(struct device *dev)
 	 * clear it upon a successful GPF flow. The exception to this
 	 * is upon Viral detection, per CXL 3.2 section 12.4.2.
 	 */
-	if (cxl_dirty_shutdown_state(mds))
+	if (cxl_arm_dirty_shutdown(mds))
 		dev_warn(dev, "GPF: could not dirty shutdown state\n");
 
 	dev_set_drvdata(dev, nvdimm);
-- 
2.39.5

