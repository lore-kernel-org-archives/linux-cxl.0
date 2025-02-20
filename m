Received: from buffalo.ash.relay.mailchannels.net (buffalo.ash.relay.mailchannels.net [23.83.222.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819A029D0D
	for <linux-cxl@vger.kernel.org>; Thu, 20 Feb 2025 01:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.222.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740015429; cv=pass; b=py7JV/6DIQdoUVVILlu2L+poHU9c0dypEf6Kgz2f/6Z3qfqOSIzP0CEiYYWG8MPQdUEzZ7B8VHNaE2SVKnS8V+Tl1dcysYrBPTIFKQpkbZUQNiC98x3D70m+2dQ/uOE9yUYqVxXi14WL9dK/30m5ozfHjsl0kwa5LVg7jfjEAJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740015429; c=relaxed/simple;
	bh=XOYfcWKKp6UQ4hfZ6iHvoJSyLUVQqt4OW//2UP/sqkw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bfOhijrFVXvHwwJ+wM4jxecd/rY7YMw9C6iWxGkudzxDzw/gUOAyX2ExvhCoWaliUEXt2q42rYgtb/OjBvuC9j1IYdHO2H0rZdqMTTETYXou0ZFc3pmmAVMjohCoVrfHXXuFL+jL6wdkquRaCArx8tbjg4ASbc0hjoPI8/JIX1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=XUnZvQ4J; arc=pass smtp.client-ip=23.83.222.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="XUnZvQ4J"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 33BFE2C3390;
	Thu, 20 Feb 2025 01:37:06 +0000 (UTC)
Received: from pdx1-sub0-mail-a300.dreamhost.com (trex-7.trex.outbound.svc.cluster.local [100.97.164.218])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id BFF612C3480;
	Thu, 20 Feb 2025 01:37:05 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1740015425; a=rsa-sha256;
	cv=none;
	b=mhs78QGHUnkaPJwPYIfcO60/e89KJSMmGyxKi36xkijTtXCbUU/C70uCNP9MI+9HVsOMC8
	JHUeQY9r/87wKjoWCB7VLatPTOAPwWxt/pwQTxBFYuc+MAQZA0/ao2eTGn3d5wa+w5wzA/
	rFalV/pgiNFn5QgFunsssMN9DxeeAMX136ewG0eHVOUAyDwMUvS0SdZI7X6tMmkzFaj1xk
	yTKHgj5BiuFb40jvYcUKoASIR+7jUCLBLAjgXpyt8UIKKI51GJES6MWDB5mscghxKe3gcB
	p0bs8KZ+ns57ZLBK+dZ/g3srCDBahoqyisYDlBR+wH2dmjevt5JWgU7HDt0FGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1740015425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=tWTNVAH4s0mHhP+iPTPF+2TPMGJ0Jwgc24059ZrjHZY=;
	b=L9tu/MzWNX2qK8r73aWMNV+1RfOj7Y7t11oK6rEU4ouenm6fO9GsOrO39n9qj0Xmiq4Lhk
	td9BoR0Z31zmdSYllX/CHiQqemOo1rFsWIH0xDtrB3CrxSY/82J7CAP6me1hO2FZdC7yvl
	2mk2gaeNdWRDbm8jrB4Ueh/0Vyw/83ThS1lQjINo+QaS+MPc0H3/KKwtubeYE/o9v1b14u
	Ax9HpXT1tn4DzzTRQnfNLDL40PM4C7VIFeAfZjR5J6SUDOSFooBCo6kzlIC0Ssu3dkcDzx
	PRh+hd7OZNOD+gg56RnjXfft9rVI9z8XC0A84WsQg/7qRk+mi8BtvhcYfb4G3w==
ARC-Authentication-Results: i=1;
	rspamd-6d7cc6b78d-4bqgv;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Inform-Trail: 6e2f1b8778accfd5_1740015426083_4172267739
X-MC-Loop-Signature: 1740015426083:3800332283
X-MC-Ingress-Time: 1740015426083
Received: from pdx1-sub0-mail-a300.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.97.164.218 (trex/7.0.2);
	Thu, 20 Feb 2025 01:37:06 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a300.dreamhost.com (Postfix) with ESMTPSA id 4Yywq46hN5z5y;
	Wed, 19 Feb 2025 17:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1740015425;
	bh=tWTNVAH4s0mHhP+iPTPF+2TPMGJ0Jwgc24059ZrjHZY=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=XUnZvQ4JuISfyaE+kZLflz4e2skW7GeiEwjjKqcauU6+DlE3jphyYM5MUCcFojitd
	 szuqiyTuTLSLC/DgU89LpigtwoB3vtG3F32PVf/H2q1VGzpmCXovmihLThtUOBRd1I
	 Nz+pZgky7d+zrmCrFEgIUNE2/5K5KwBY8xuxbCl9PQsZr5kcw+qsSvi7GrPCw0ICEX
	 R7mHOWVPntwlL/noG51WiXT9xEkK1i3PjlgYp8gUuiZ4eBcwV1MLKMJSU4DdhFF/HR
	 a9LQXIY0g90RHogUHRdfBEBwD1Zce/bW+to14pQn4MbmXr7h7rSDrGC/sDcWTO5C5e
	 snKwcY5LeIuMw==
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
Date: Wed, 19 Feb 2025 17:36:01 -0800
Message-Id: <20250220013604.263489-2-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250220013604.263489-1-dave@stgolabs.net>
References: <20250220013604.263489-1-dave@stgolabs.net>
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

Reviewed-by: Li Ming <ming.li@zohomail.com>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
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

