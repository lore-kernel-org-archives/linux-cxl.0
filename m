Received: from slategray.cherry.relay.mailchannels.net (slategray.cherry.relay.mailchannels.net [23.83.223.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13BB28628D
	for <linux-cxl@vger.kernel.org>; Wed, 19 Feb 2025 03:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739934367; cv=pass; b=QNNPchwplP5ZRnSeO5KOHjTY3j56OSo76M1vjnhFkmKNrLq3brcevS1fCROwGJ+3MZQoanKSKlJ1EvKS9XWHIrXTkgiypLI+zxwRBCAfqkizVGiq2SvbZt1Mv9qiM76UPMuiTPqWx3YPhvadJHJu8xIZp6B1/0+MLMVNXHAe2Yw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739934367; c=relaxed/simple;
	bh=v36LvLSZyPoWkkvMFHJw30bhV3LPqHkLEhalZQr+Ck8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cMebCctr0y0MI1ztUJ5eJw3LBI/cK/VUkuhT3Q6WdmFFCXjL/zwo0orSzEsj+xwbq1CmGPAR2JPCa0qlX5ShZorLK8BIJ/z/SKynHqUvAAvNN5hxmbhkFA1OaUU1kye7rnNhoeVk/ZafGXf1z9NIhHxH/Sk5uqXHqJ5BMyRhvTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=Cdbcmmgt; arc=pass smtp.client-ip=23.83.223.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="Cdbcmmgt"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 31165900E51;
	Wed, 19 Feb 2025 03:06:01 +0000 (UTC)
Received: from pdx1-sub0-mail-a289.dreamhost.com (100-101-191-136.trex-nlb.outbound.svc.cluster.local [100.101.191.136])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id C5480901912;
	Wed, 19 Feb 2025 03:06:00 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1739934360; a=rsa-sha256;
	cv=none;
	b=oITG9a5uzMFQuDBu8PxCJiuys4GwKXduTXRy0TWPOKKdcZAvZ6QJR7LN1H9O5/TFrXk1HU
	n+P9s+YTn7G/St9zz3IqP7m+m6LK0WTfVoKdUSA2bpOY9Q6Uoxef+wleLJONyQ/o7zGm8D
	DlNESOKq3VFlxXwjTEJaZVLhxkd+wCdq7Q7syb1nosi/3jh1uM8NAr6dKlnwx+lrF4I/QF
	62Azr+fItt4Di3W6+QJFCN8PCqG+Qpub+O0FNsHf3PCEIEdDdFewRtOHXJFuKkBIRRiEX3
	mVpplGaSaYupPOA5b8Nan6rSY05r7aE+ettCgjupXTl3FE0YPfBL/PFG0K9Ezw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1739934360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=tFtZ+ioYAnA8eERmLGxwju+zYUC5gkPAWas38tgbIto=;
	b=3JuBVGG7t60hqHV7zfhY8eZUnLY/BV5vsZBStRhjP1bXIYuZHrQu2irp7Fkc3FruXP9ZJw
	HX84gaFtyo/KGEM34cwBSttdLnkwM/tmWZtRoRWIaYxyphJa+T/V11NAS7dT/dJg7ZLDlU
	t7Ts0L/gA/GnQ48AJZCDgmNYITSdNQf2GdTru0GD0Nalh0JzLRYKuAVlTA3+72u1s1tOso
	GD+pL4BG7uSwSccgfzCQf6uL14AEcRvWANo9hyLNg+TvAVfmeh0TGwoV6eaCZPW0xBqJeX
	N6mY98rGd+OyLBhtmj+N2F66X5nQbxDcRuFus/DeHkMVYsAdLO8vEHQ5wJ6OxQ==
ARC-Authentication-Results: i=1;
	rspamd-6d7cc6b78d-cf5kg;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Shelf-Imminent: 224acb1001a1f784_1739934361093_1309498705
X-MC-Loop-Signature: 1739934361093:1105247147
X-MC-Ingress-Time: 1739934361093
Received: from pdx1-sub0-mail-a289.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.101.191.136 (trex/7.0.2);
	Wed, 19 Feb 2025 03:06:01 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a289.dreamhost.com (Postfix) with ESMTPSA id 4YyLr76zmSzHw;
	Tue, 18 Feb 2025 19:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1739934360;
	bh=tFtZ+ioYAnA8eERmLGxwju+zYUC5gkPAWas38tgbIto=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=CdbcmmgtANY4LETtb0FPC9bt6ge0OehBGKqY1nWYy3qiBvVK7VOgibkwgc5//1UPi
	 VkPrQn9pltIREzyY/CET3qo57bMKH13GjB8eLyGhzQDAioYcqXMhKaJouZ5XQnUzyS
	 ox1Gazh71OggGanO9S4WI6VIbkRD8c2QlkguNN0T4AVHGCd5LvAxrZWpZSznKl8O1t
	 54oF97Ab0CHHCtX0Mn9XYCJ2jxwnmGCjxnUHmnf6sj0l1/eYvruqH6OSY/WTJJKA2C
	 oNwGGoqNJX0geLFJqBOBLu46oDHoK/PV6wgkQRoYxngCfJY8dZRtyZKQg4a3CeyrkP
	 M45GwMfKXvQGA==
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
Subject: [PATCH 1/4] cxl/pci: Introduce cxl_gpf_get_dvsec()
Date: Tue, 18 Feb 2025 19:05:17 -0800
Message-Id: <20250219030520.237207-2-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250219030520.237207-1-dave@stgolabs.net>
References: <20250219030520.237207-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a helper to fetch the port/device GPF dvsecs. This is
currently only used for ports, but a later patch to export
dirty count to users will make use of the device one.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/cxl/core/pci.c | 38 ++++++++++++++++++++++++++++----------
 drivers/cxl/cxl.h      |  2 ++
 2 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index a5c65f79db18..2226cca3382d 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -1072,6 +1072,27 @@ int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c)
 #define GPF_TIMEOUT_BASE_MAX 2
 #define GPF_TIMEOUT_SCALE_MAX 7 /* 10 seconds */
 
+int cxl_gpf_get_dvsec(struct device *dev, bool port)
+{
+	struct pci_dev *pdev;
+	int dvsec;
+
+	if (!dev_is_pci(dev))
+		return -EINVAL;
+
+	pdev = to_pci_dev(dev);
+	if (!pdev)
+		return -EINVAL;
+
+	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
+			port ? CXL_DVSEC_PORT_GPF : CXL_DVSEC_DEVICE_GPF);
+	if (!dvsec)
+		pci_warn(pdev, "%s GPF DVSEC not present\n",
+			 port ? "Port" : "Device");
+	return dvsec;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_gpf_get_dvsec, "CXL");
+
 static int update_gpf_port_dvsec(struct pci_dev *pdev, int dvsec, int phase)
 {
 	u64 base, scale;
@@ -1116,26 +1137,23 @@ int cxl_gpf_port_setup(struct device *dport_dev, struct cxl_port *port)
 {
 	struct pci_dev *pdev;
 
-	if (!dev_is_pci(dport_dev))
-		return 0;
-
-	pdev = to_pci_dev(dport_dev);
-	if (!pdev || !port)
+	if (!port)
 		return -EINVAL;
 
 	if (!port->gpf_dvsec) {
 		int dvsec;
 
-		dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
-						  CXL_DVSEC_PORT_GPF);
-		if (!dvsec) {
-			pci_warn(pdev, "Port GPF DVSEC not present\n");
+		dvsec = cxl_gpf_get_dvsec(dport_dev, true);
+		if (dvsec <= 0)
 			return -EINVAL;
-		}
 
 		port->gpf_dvsec = dvsec;
 	}
 
+	pdev = to_pci_dev(dport_dev);
+	if (!pdev)
+		return -EINVAL;
+
 	update_gpf_port_dvsec(pdev, port->gpf_dvsec, 1);
 	update_gpf_port_dvsec(pdev, port->gpf_dvsec, 2);
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 6baec4ba9141..acbbba41356d 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -901,4 +901,6 @@ bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
 #define __mock static
 #endif
 
+int cxl_gpf_get_dvsec(struct device *dev, bool port);
+
 #endif /* __CXL_H__ */
-- 
2.39.5

