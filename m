Received: from dog.elm.relay.mailchannels.net (dog.elm.relay.mailchannels.net [23.83.212.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A162113AF2
	for <linux-cxl@vger.kernel.org>; Thu, 20 Feb 2025 22:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.212.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740088971; cv=pass; b=azdlpXVtWPC/RAJVjREMBniwoSPUQMQW9MXNhwNUObfG5mhskY7lIpRh+MQYxArogDehqKEHMh0F4HJZORTzmqIG1npvITOMYVWeYzNLpgnWGewghlzNKTfBqAe59I1Z9sFHP2jxtfWQC+kBl2g1b3Fiwmar+mD1QUoeWiGMrr0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740088971; c=relaxed/simple;
	bh=T6X6Nus0NuL+WZ7NVqf3xFTp75/HHq9ff79FUj61MUQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZM9KhWOcad2zmLZXqnm+Jk1Y3pSdC6bHbNAN1tT9vL76YyZHh35Xu87XIn0C8X2CEe9K+tTodr5C8kgmT0y9eDvUVEkRAY026xaLJVtslayTyE5KJOBNhYoCSw/QsJT/3r/RO9oX+6cgkkiiIX4qAreV+tZ7J1K18GWC9aSzEgk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=DVn4nOsF; arc=pass smtp.client-ip=23.83.212.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="DVn4nOsF"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 139F2322F14;
	Thu, 20 Feb 2025 22:02:43 +0000 (UTC)
Received: from pdx1-sub0-mail-a229.dreamhost.com (100-97-164-218.trex-nlb.outbound.svc.cluster.local [100.97.164.218])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 78D3F322E1D;
	Thu, 20 Feb 2025 22:02:42 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1740088962; a=rsa-sha256;
	cv=none;
	b=zlUrBCdtaqggN0sLQfx2YsfUvOSzDIZHip9LmZj2G2e5DvFrhsiWlq1PxVmQQmeCHVfgGi
	vKbZvRQvgvvqdFmTJDMxQxpurTaKpaTlZtsxS/4QwLoYwKZefC1K+d13yCklQtYqjlnEU8
	5fc7XrBDB4L4UzcxaDPxocU/kuh346xXGF7EsTQ9hVPr7YCZ51E/HURoGw8KmJs8oCL+8N
	Qsu4OggkbP+vF2LNjpdrXLWBCUpS4ZkJNcXlxljoetAtHzmIkrgZ6p8mkQwt1iGvykXORv
	ql7c+EJwGNgnyElTe2sdHp5Nkm0FBPYDcYIB6CowWXx9d8pAP19cI8VTdVlBUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1740088962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=72sYCn7I+OYIEe3d08oE4hyDAJIRHvAK/V8mex0RX5Y=;
	b=h0myI9nZFmgSKAEedO9iwKD8LtruzawLLyWDqkNYKfF40IC8scTuoyl/BoPv9hPtDYNY99
	OC+mbwGPcHbCDleiqokIyRz5/wc0C+ZaErNCFkXcu7cNbwp7Pa1wLCzKsYduVbHua7jmr1
	JejShrYLmwiv3BkT6j/UroUaFVY5lZu2NpfTRzc07sAb+EHd201Mm+mUcXKDraFZTz8qeP
	kPQV4pINxBFGrN752ZqWI13HXWsdqqF9TNHQiMaKXXLuVHnFBLhHZJ9YTdYSJFVhBsEsGI
	r2zKHbLSBQGA0VUh2oAio0dJwZD2ldoo4SXz2RxjP68fUUsmNk1HWYU12BPsgw==
ARC-Authentication-Results: i=1;
	rspamd-6d7cc6b78d-js9cv;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Celery-Lonely: 2f8682f6479343ce_1740088962857_1014700243
X-MC-Loop-Signature: 1740088962857:1219598333
X-MC-Ingress-Time: 1740088962856
Received: from pdx1-sub0-mail-a229.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.97.164.218 (trex/7.0.2);
	Thu, 20 Feb 2025 22:02:42 +0000
Received: from localhost.localdomain (unknown [104.36.25.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a229.dreamhost.com (Postfix) with ESMTPSA id 4YzS1F2L5kzGr;
	Thu, 20 Feb 2025 14:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1740088962;
	bh=72sYCn7I+OYIEe3d08oE4hyDAJIRHvAK/V8mex0RX5Y=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=DVn4nOsFruUWRF4MhZ5n4l00/TJz5Naq/aMUE1DT1gvdI9lZMh8BjLfFdCzM+YizP
	 ZrtRwVAzJaxGc9t0PSx5SppTvk+UWnEuHcF73ZADHxveSMz62CoN2EGm5N/LMK+uFC
	 ibBjBQGQvKA+io2saY7AXxT24VpBqA40Xp+xjqBWQmsmzFNXrQTVIuCRneMwpgpCaX
	 dOt7ljLGvNL6MXH8II+wKqp/AbB9MtjCuVlWo1A3CyilZ0qgSMgHgkcPRpFPlK0/F9
	 42scsWTU2ljCGPqWBUGL/PvcquUP+JZO/CJqhOiME0EzExdyvCb3YT/65+yxeFPkAU
	 fvtYvWT3iDshA==
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com,
	dan.j.williams@intel.com
Cc: jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	ira.weiny@intel.com,
	vishal.l.verma@intel.com,
	seven.yi.lee@gmail.com,
	ming.li@zohomail.com,
	a.manzanares@samsung.com,
	fan.ni@samsung.com,
	anisa.su@samsung.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org
Subject: [PATCH 1/4] cxl/pci: Introduce cxl_gpf_get_dvsec()
Date: Thu, 20 Feb 2025 14:02:32 -0800
Message-Id: <20250220220235.276831-2-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250220220235.276831-1-dave@stgolabs.net>
References: <20250220220235.276831-1-dave@stgolabs.net>
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
Reviewed-by: Li Ming <ming.li@zohomail.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/cxl/core/pci.c | 30 ++++++++++++++++++++----------
 drivers/cxl/cxl.h      |  2 ++
 2 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index a5c65f79db18..96fecb799cbc 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -1072,6 +1072,22 @@ int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c)
 #define GPF_TIMEOUT_BASE_MAX 2
 #define GPF_TIMEOUT_SCALE_MAX 7 /* 10 seconds */
 
+u16 cxl_gpf_get_dvsec(struct device *dev, bool is_port)
+{
+	u16 dvsec;
+
+	if (!dev_is_pci(dev))
+		return 0;
+
+	dvsec = pci_find_dvsec_capability(to_pci_dev(dev), PCI_VENDOR_ID_CXL,
+			is_port ? CXL_DVSEC_PORT_GPF : CXL_DVSEC_DEVICE_GPF);
+	if (!dvsec)
+		dev_warn(dev, "%s GPF DVSEC not present\n",
+			 is_port ? "Port" : "Device");
+	return dvsec;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_gpf_get_dvsec, "CXL");
+
 static int update_gpf_port_dvsec(struct pci_dev *pdev, int dvsec, int phase)
 {
 	u64 base, scale;
@@ -1116,26 +1132,20 @@ int cxl_gpf_port_setup(struct device *dport_dev, struct cxl_port *port)
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
+		if (!dvsec)
 			return -EINVAL;
-		}
 
 		port->gpf_dvsec = dvsec;
 	}
 
+	pdev = to_pci_dev(dport_dev);
 	update_gpf_port_dvsec(pdev, port->gpf_dvsec, 1);
 	update_gpf_port_dvsec(pdev, port->gpf_dvsec, 2);
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 6baec4ba9141..29f2ab0d5bf6 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -901,4 +901,6 @@ bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
 #define __mock static
 #endif
 
+u16 cxl_gpf_get_dvsec(struct device *dev, bool is_port);
+
 #endif /* __CXL_H__ */
-- 
2.39.5

