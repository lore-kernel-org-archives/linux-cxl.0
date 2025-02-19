Received: from giraffe.ash.relay.mailchannels.net (giraffe.ash.relay.mailchannels.net [23.83.222.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7C519D882
	for <linux-cxl@vger.kernel.org>; Wed, 19 Feb 2025 06:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.222.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739946555; cv=pass; b=mXBD1foBDzl93BjFQWoikrmJYts8smMAGB0fuepUkmJBPN8t/wl5GPDlvy/inAaHxGp75a3gn6itCF3a8F900CCOYdDVW60nL6WyaA5Yb9dh/Jg6m9o+C/JfH6wUGs5xZIZKvRGZ9h7FLOwOHYW67nIyBS2k1OFgfBI/rQWF2LQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739946555; c=relaxed/simple;
	bh=v36LvLSZyPoWkkvMFHJw30bhV3LPqHkLEhalZQr+Ck8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kwAIkEPsOHj6KwzaX1tlYEx+tHCWootvdzFn6yDyOb2tvmsKKOpESC9renvONJG+e8cuFnKYvMklxEEm76ROz41SH7ehHq8WQ4EuJUNZImDtEHjQ5Go6tDBe5nYDo5TXkZIRsWgjHQuJXZeub8WMgJscvdUUnBtavA2MvBlqQmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=gGswqqZN; arc=pass smtp.client-ip=23.83.222.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="gGswqqZN"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 8BC3C2C2980;
	Wed, 19 Feb 2025 06:29:12 +0000 (UTC)
Received: from pdx1-sub0-mail-a223.dreamhost.com (100-99-192-59.trex-nlb.outbound.svc.cluster.local [100.99.192.59])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 1B5752C1751;
	Wed, 19 Feb 2025 06:29:12 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1739946552; a=rsa-sha256;
	cv=none;
	b=O+Eq3/sbaUy7VI7X/ISpD2NUg5A0d6zygUHiOLDuDGCz+nyee9woNTt81N/lq50gJd/jY4
	f7kuO8Z+/JYxoNWm39EGf8m8xmRC1og98Ui+uzF95OQl2bU2rMXN6xIySeObDDizdOk726
	VN8cvG25DtmWzwyVtAa6sIdJ19NEh+PzTHrGDAXB7ozDnI5WcaI3DgdYhWy05blSSP3YGc
	IZ33UeQMV0k0xxzlVtzX9v4kROHv/bGmOcSXPV8O98K0QX2dp4DGaFvYdl5WAeTF+0+Wpo
	Vg2+QkDnsA1AKI65EDAjZabjYmfmv/Sr7514An4UjiQ013c173j+ErdN8M30JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1739946552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=tFtZ+ioYAnA8eERmLGxwju+zYUC5gkPAWas38tgbIto=;
	b=FoYmnQ7FamO8FTQl+JwLmBG/N6fMmwDhiG4QAbsYluSHnkA0vcnQm9ZHz6BqCC09TPtOww
	acjFb1ZQDujmgRCfcvQ4VX8J9D37bdYmUCEfjwSIr0N/idQkftGl5Pw99AF+CN16jYs1ZS
	Sib/ATq61/XErID1vQLnhAMgksuhxxz2MOR/I6ozBA4+I2ABlJR+FwXrdnSzjl+hMyo6Zz
	XRtOePBDUKJ0e2ct2FLXnFIoXet7WllaN7Bwghn7L74t1x6oEwxJb0C9/Gj1M62UW9olyW
	E4zA9cjERfRIOeTl03T9q6F2zHMjiE4X0V044PSyTyUF7Pzxz1YAUb1qHBtZVw==
ARC-Authentication-Results: i=1;
	rspamd-6d7cc6b78d-cr46q;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Hook-Cure: 1d9b26293fee4e82_1739946552407_3590763540
X-MC-Loop-Signature: 1739946552407:3251624839
X-MC-Ingress-Time: 1739946552406
Received: from pdx1-sub0-mail-a223.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.192.59 (trex/7.0.2);
	Wed, 19 Feb 2025 06:29:12 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a223.dreamhost.com (Postfix) with ESMTPSA id 4YyRLb2Hs8zFh;
	Tue, 18 Feb 2025 22:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1739946552;
	bh=tFtZ+ioYAnA8eERmLGxwju+zYUC5gkPAWas38tgbIto=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=gGswqqZNij0dYi6e/pWcbd5OcMR4Jjo0Mpk4uYsAGWUc+awq633ENoNcwgFpeDhzn
	 iVikcddtgKCtyGNKmQvkiTk9nZ/6fx2JjcmWUiCRLmuAn8PItOybfjTE9Pn6FVBGh8
	 izyYgaIGHo7kmL7GJgmykjruFBDqXZiCcAz9dM0LT9hbe3rJ0hWBKHCvcr4O9dWanm
	 dVsr6aQbTMD/fM0RgkpYeXgrny4T4Cv2hOgbQryP5Cz9eRJrlDISHQCTUSXL4ozKSh
	 EZxphMs5xzaZthm3eY8CCT4tGYHwHcB6Lk71ax7dLqvVo+8X3qsUkQevRzr+Qxbynv
	 +9/tMQducRWdQ==
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
Date: Tue, 18 Feb 2025 22:28:29 -0800
Message-Id: <20250219062832.237881-2-dave@stgolabs.net>
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

