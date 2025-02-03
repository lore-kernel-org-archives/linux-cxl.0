Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A62C171E43
	for <linux-cxl@vger.kernel.org>; Tue,  4 Feb 2025 05:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738647086; cv=none; b=dKyYfq5FvTC6HH7NIiyfkhNBivBYSJ0w4ahnYfwcRHgtyRYHMDr4Q3H1OiEsBxyrwpbT0MHLGD2KGFdX3x8Z0sQ9NPfbKc6IMfRPS04sZZ70Q9GbUlbm327mfTVRhx3ozGPO5EHmOUBG4H8Pij6JUIF47GWmVxNKvjMHPZPW8dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738647086; c=relaxed/simple;
	bh=Bwp72dFWixWmaEzApNtWPMg0vXARFeWm5sddaCQ3T5M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=OpG/aPqNegEAnOlV33R1t8b858Xa52xhxL7W+iNgesSiWXk197xUlGlhdMlOLDYXvJMnpZcCbuX0on4uSILcTeUXOrsehjolRHdCEjgAPUTuUkjj+4MLpfdP0OQ4Hb2Fhkk3wiBys4QLmELVX6BdGpsSnMFQZELV3SW5wFV7CCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=tv6kAlw3; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="tv6kAlw3"
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250204053115epoutp02627658d3eea5b8f18a728fec94e7694f~g6k25LPPg1308613086epoutp02m
	for <linux-cxl@vger.kernel.org>; Tue,  4 Feb 2025 05:31:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250204053115epoutp02627658d3eea5b8f18a728fec94e7694f~g6k25LPPg1308613086epoutp02m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1738647075;
	bh=REi/vF2W9CZCEJwagJbxZuNbkTO6LlcHQHKpyKxXquI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tv6kAlw3UtasbV3MxdaUj2AsUQ2sTKDDZCapitpasb+hPxSGmP6GLuBohaVc0R0MV
	 akB6nPV4qm7kFsMW1piLYDmCgyKVQMwC8DTQoIDJXvEfW6tzqDNYTihi5+ZARMqYUd
	 I2A2wH2rT9GYmspi4QMHw7Xg33i6nsgSlcBqRPvA=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20250204053115epcas5p29723ce5b8f7a28822504aaed47904f0a~g6k2nGYR92676526765epcas5p2_;
	Tue,  4 Feb 2025 05:31:15 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.178]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4YnBmf0WLlz4x9Pw; Tue,  4 Feb
	2025 05:31:14 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	7C.06.19710.126A1A76; Tue,  4 Feb 2025 14:31:13 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250203114459epcas5p33839b8e8150427947f9b5419ce9cd611~gsB4pbRVC2875328753epcas5p3X;
	Mon,  3 Feb 2025 11:44:59 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250203114459epsmtrp1ca6e1556f760e7881aadcaf4e43d7c89~gsB4os6bs3216432164epsmtrp1g;
	Mon,  3 Feb 2025 11:44:59 +0000 (GMT)
X-AuditID: b6c32a44-36bdd70000004cfe-1b-67a1a6219cd2
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	F7.E9.18949.B3CA0A76; Mon,  3 Feb 2025 20:44:59 +0900 (KST)
Received: from test-PowerEdge-R740xd.samsungds.net (unknown [107.99.41.79])
	by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250203114458epsmtip2e62f708bb2ac0b062149008a2eea8ed9~gsB3A68411414714147epsmtip2M;
	Mon,  3 Feb 2025 11:44:57 +0000 (GMT)
From: Sweta Kumari <s5.kumari@samsung.com>
To: qemu-devel@nongnu.org
Cc: gost.dev@samsung.com, linux-cxl@vger.kernel.org, nifan.cxl@gmail.com,
	dave@stgolabs.net, vishak.g@samsung.com, krish.reddy@samsung.com,
	a.manzanares@samsung.com, alok.rathore@samsung.com, Sweta Kumari
	<s5.kumari@samsung.com>
Subject: [PATCH 1/1] Added support for get/set alert configuration commands
Date: Mon,  3 Feb 2025 17:14:45 +0530
Message-Id: <20250203114445.64088-2-s5.kumari@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250203114445.64088-1-s5.kumari@samsung.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLJsWRmVeSWpSXmKPExsWy7bCmhq7SsoXpBi98LKYfVrT4cnoPm8Xq
	m2sYLW4e2MlksXDjMiaL87NOsVj83baX0eJ47w4WizXnPrMAxeawO3B57Jx1l93jybXNTB59
	W1YxekydXe/xeZNcAGtUtk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmBoa6hpYW5kkJeYm6q
	rZKLT4CuW2YO0ElKCmWJOaVAoYDE4mIlfTubovzSklSFjPziElul1IKUnAKTAr3ixNzi0rx0
	vbzUEitDAwMjU6DChOyMuSc2MxU8tqxomn2FtYHxqFYXIyeHhICJxMtlZ5m6GLk4hAR2M0rM
	+fgTyvnEKPF6+RxGCOcbo8TH9v3sMC33Vp5nhUjsZZS41/0EqqqBSWL3lKnMIFVsAloSPz4/
	ALNFBCQlfnedZgYpYhZ4xSixcUMrG0hCWMBbYvfXSYwgNouAqsTKLZ/AGngFrCRmrJvKBrFO
	XmL/wbNgcU4Ba4mnH3ugagQlTs58wgJiMwPVNG+dzQxR/5Nd4kODBITtIjHtxD2os4UlXh3f
	AmVLSbzsb4OysyXubu2E2lUi8eH2biYI216i9VQ/0EwOoPmaEut36UOEZSWmnlrHBLGWT6L3
	9xOocl6JHfNgbGWJLf+Ws0LYkhIrPi+Bsj0kZj5thoZvH6PE19/NrBMYFWYheWcWkndmIaxe
	wMi8ilEytaA4Nz012bTAMC+1HB7Nyfm5mxjB6VTLZQfjjfn/9A4xMnEwHmKU4GBWEuE9vX1B
	uhBvSmJlVWpRfnxRaU5q8SFGU2B4T2SWEk3OByb0vJJ4QxNLAxMzMzMTS2MzQyVx3uadLelC
	AumJJanZqakFqUUwfUwcnFINTEbrXI4p7XybHMLz8pBTou+pJN96OR8vS+7YsNlXb2Sq3Pki
	qVN+o+V3fqcHx7Ou75OaeixzDY4Yi8xJ+ZUkltR8uqj34N1q5fuez/LO2HSx9Ux9KLp0rcyU
	RU4nl/L11r/uivBvWSTKf+Xbw/dvFy3/PztA8ZzvgWOndz+I3zZxYsT97gseWptrC/rX7NPc
	EbpDUvNf5TRphca6zsOOD09+YnrRwFztnpb/6GTdXJWibalP/pyz6XsXV855XkDZRP7N0rUn
	fH7N3b7IJfL+3AyPY9Ji4T4sf1y0PH/te6jwzf/77H374m9Yar0uMA2b+GvbR9afK8R3hJuK
	WB0KzdBy+rftp5icbP+1U1Mi1JRYijMSDbWYi4oTAaY29A8wBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKLMWRmVeSWpSXmKPExsWy7bCSvK71mgXpBqfXqFhMP6xo8eX0HjaL
	1TfXMFrcPLCTyWLhxmVMFudnnWKx+LttL6PF8d4dLBZrzn1mAYrNYXfg8tg56y67x5Nrm5k8
	+rasYvSYOrve4/MmuQDWKC6blNSczLLUIn27BK6MuSc2MxU8tqxomn2FtYHxqFYXIyeHhICJ
	xL2V51m7GLk4hAR2M0p09i9ghUhISrw9c4kRwhaWWPnvOTtE0T9GiW17JrODJNgEtCR+fH7A
	DGKLADX87jrNDFLELPCFUWJKw1cmkISwgLfE7q+TwCaxCKhKrNzyCayBV8BKYsa6qWwQG+Ql
	9h88CxbnFLCWePqxB8wWAqq5uW85C0S9oMTJmU/AbGag+uats5knMArMQpKahSS1gJFpFaNk
	akFxbnpusWGBUV5quV5xYm5xaV66XnJ+7iZGcMhrae1g3LPqg94hRiYOxkOMEhzMSiK8HIfn
	pAvxpiRWVqUW5ccXleakFh9ilOZgURLn/fa6N0VIID2xJDU7NbUgtQgmy8TBKdXANMf/0r6d
	Ur8X+0fz/jDfutjRb49i9vbFuclvdMRWPstfduKW5QP9nSaV8w5rKGyWeFAj3/fOYqv9sRx+
	y7OOZbMyTepUb3bJPc13F9h0iXOnx3TpDH9/nfPb9miLSytsiFjWfWyRbZLKfDHXe/ftTnVb
	fbrMbF4ZbeFwxuHcF7aGLy577qXFqm2canPAwbV+UmvBkSU3b1epT5oraz1f+9iHJj3ueaod
	04uurTsmt69846XbDD2Hr238tLckvfiV+xavzw0ZUVO4P/SLxE/5+in79jvW15wCZcoPr6oo
	Pzryd8vD9NyDwhZpc3cmc7WeV+IX45Jo2L0+t815l+nSPae6tD+61+Y0X+BaIGJ7WYmlOCPR
	UIu5qDgRAGYRHYzoAgAA
X-CMS-MailID: 20250203114459epcas5p33839b8e8150427947f9b5419ce9cd611
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250203114459epcas5p33839b8e8150427947f9b5419ce9cd611
References: <20250203114445.64088-1-s5.kumari@samsung.com>
	<CGME20250203114459epcas5p33839b8e8150427947f9b5419ce9cd611@epcas5p3.samsung.com>

Signed-off-by: Sweta Kumari <s5.kumari@samsung.com>
Reviewed-by: Alok Rathore <alok.rathore@samsung.com>
Reviewed-by: Krishna Kanth Reddy <krish.reddy@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c  | 91 +++++++++++++++++++++++++++++++++++++
 hw/mem/cxl_type3.c          | 20 ++++++++
 include/hw/cxl/cxl_device.h | 24 ++++++++++
 3 files changed, 135 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 9c7ea5bc35..7a054c059d 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -86,6 +86,9 @@ enum {
         #define GET_PARTITION_INFO     0x0
         #define GET_LSA       0x2
         #define SET_LSA       0x3
+    HEALTH_INFO_ALERTS = 0x42,
+        #define GET_ALERT_CONFIGURATION 0x1
+        #define SET_ALERT_CONFIGURATION 0x2
     SANITIZE    = 0x44,
         #define OVERWRITE     0x0
         #define SECURE_ERASE  0x1
@@ -1625,6 +1628,90 @@ static CXLRetCode cmd_ccls_set_lsa(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+/* CXL r3.1 Section 8.2.9.9.3.2 Get Alert Configuration (Opcode 4201h) */
+static CXLRetCode cmd_get_alert_config(const struct cxl_cmd *cmd,
+                                   uint8_t *payload_in,
+                                   size_t len_in,
+                                   uint8_t *payload_out,
+                                   size_t *len_out,
+                                   CXLCCI *cci)
+{
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+    CXLAlertConfig *out = (void *)payload_out;
+    memcpy(out, &ct3d->alert_config, sizeof(ct3d->alert_config));
+    *len_out = sizeof(ct3d->alert_config);
+    return CXL_MBOX_SUCCESS;
+
+}
+
+/* CXL r3.1 Section 8.2.9.9.3.3 Set Alert Configuration (Opcode 4202h) */
+static CXLRetCode cmd_set_alert_config(const struct cxl_cmd *cmd,
+                                   uint8_t *payload_in,
+                                   size_t len_in,
+                                   uint8_t *payload_out,
+                                   size_t *len_out,
+                                   CXLCCI *cci)
+{
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+    CXLAlertConfig *alert_config = &ct3d->alert_config;
+    struct {
+        CXLValidEnableAlerts valid_alert_actions;
+        CXLValidEnableAlerts enable_alert_actions;
+        uint8_t lupwt;
+        uint8_t reserve;
+        uint16_t dotpwt;
+        uint16_t dutpwt;
+        uint16_t cvmepwt;
+        uint16_t cpmepwt;
+    } QEMU_PACKED *in = (void *)payload_in;
+
+    if (in->valid_alert_actions.lupwt) {
+        if ((in->lupwt > 100) || (in->lupwt >= alert_config->lucat)) {
+            return CXL_MBOX_INVALID_INPUT;
+        }
+
+        if (in->enable_alert_actions.lupwt) {
+            alert_config->lupwt = in->lupwt;
+        }
+        alert_config->enable_alerts.lupwt = in->enable_alert_actions.lupwt;
+    }
+
+    if (in->valid_alert_actions.dotpwt) {
+        if (in->dotpwt >= alert_config->dotcat) {
+            return CXL_MBOX_INVALID_INPUT;
+        }
+        if (in->enable_alert_actions.dotpwt) {
+            alert_config->dotpwt = in->dotpwt;
+        }
+        alert_config->enable_alerts.dotpwt = in->enable_alert_actions.dotpwt;
+    }
+
+    if (in->valid_alert_actions.dutpwt) {
+        if (in->dutpwt < alert_config->dutcat) {
+            return CXL_MBOX_INVALID_INPUT;
+        }
+        if (in->enable_alert_actions.dutpwt) {
+            alert_config->dutpwt = in->dutpwt;
+        }
+        alert_config->enable_alerts.dutpwt = in->enable_alert_actions.dutpwt;
+    }
+
+    if (in->valid_alert_actions.cvmepwt) {
+        if (in->enable_alert_actions.cvmepwt) {
+            alert_config->cvmepwt = in->cvmepwt;
+        }
+        alert_config->enable_alerts.cvmepwt = in->valid_alert_actions.cvmepwt;
+    }
+
+    if (in->valid_alert_actions.cpmepwt) {
+        if (in->enable_alert_actions.cpmepwt) {
+            alert_config->cpmepwt = in->cpmepwt;
+        }
+        alert_config->enable_alerts.cpmepwt = in->valid_alert_actions.cpmepwt;
+    }
+    return CXL_MBOX_SUCCESS;
+}
+
 /* Perform the actual device zeroing */
 static void __do_sanitization(CXLType3Dev *ct3d)
 {
@@ -2859,6 +2946,10 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
     [CCLS][GET_LSA] = { "CCLS_GET_LSA", cmd_ccls_get_lsa, 8, 0 },
     [CCLS][SET_LSA] = { "CCLS_SET_LSA", cmd_ccls_set_lsa,
         ~0, CXL_MBOX_IMMEDIATE_CONFIG_CHANGE | CXL_MBOX_IMMEDIATE_DATA_CHANGE },
+    [HEALTH_INFO_ALERTS][GET_ALERT_CONFIGURATION] = {"GET_ALERT_CONFIGURATION",
+        cmd_get_alert_config, 0, 0 },
+    [HEALTH_INFO_ALERTS][SET_ALERT_CONFIGURATION] = {"SET_ALERT_CONFIGURATION",
+        cmd_set_alert_config, 12, CXL_MBOX_IMMEDIATE_POLICY_CHANGE },
     [SANITIZE][OVERWRITE] = { "SANITIZE_OVERWRITE", cmd_sanitize_overwrite, 0,
         (CXL_MBOX_IMMEDIATE_DATA_CHANGE |
          CXL_MBOX_SECURITY_STATE_CHANGE |
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 5f365afb4d..ce5a4962da 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -956,6 +956,25 @@ static DOEProtocol doe_comp_prot[] = {
     { }
 };
 
+/*
+ * Initialize CXL device alerts with default threshold values.
+ */
+static void init_alert_config(CXLType3Dev *ct3d)
+{
+    CXLAlertConfig *alert_config = &ct3d->alert_config;
+
+    memset(&alert_config->valid_alerts, 0, sizeof(CXLValidEnableAlerts));
+    memset(&alert_config->enable_alerts, 0, sizeof(CXLValidEnableAlerts));
+    alert_config->lucat = 75;
+    alert_config->lupwt = 0;
+    alert_config->dotcat = 35;
+    alert_config->dutcat = 10;
+    alert_config->dotpwt = 25;
+    alert_config->dutpwt = 20;
+    alert_config->cvmepwt = 0;
+    alert_config->cpmepwt = 0;
+}
+
 void ct3_realize(PCIDevice *pci_dev, Error **errp)
 {
     ERRP_GUARD();
@@ -1030,6 +1049,7 @@ void ct3_realize(PCIDevice *pci_dev, Error **errp)
         goto err_free_special_ops;
     }
 
+    init_alert_config(ct3d);
     pcie_cap_deverr_init(pci_dev);
     /* Leave a bit of room for expansion */
     rc = pcie_aer_init(pci_dev, PCI_ERR_VER, 0x200, PCI_ERR_SIZEOF, NULL);
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index a64739be25..6acae7d74d 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -581,6 +581,28 @@ typedef struct CXLSetFeatureInfo {
     size_t data_size;
 } CXLSetFeatureInfo;
 
+typedef struct CXLValidEnableAlerts {
+    uint8_t lupwt:1;
+    uint8_t dotpwt:1;
+    uint8_t dutpwt:1;
+    uint8_t cvmepwt:1;
+    uint8_t cpmepwt:1;
+    uint8_t reserved:3;
+} CXLValidEnableAlerts;
+
+typedef struct CXLAlertConfig {
+    CXLValidEnableAlerts valid_alerts;
+    CXLValidEnableAlerts enable_alerts;
+    uint8_t lucat;
+    uint8_t lupwt;
+    uint16_t dotcat;
+    uint16_t dutcat;
+    uint16_t dotpwt;
+    uint16_t dutpwt;
+    uint16_t cvmepwt;
+    uint16_t cpmepwt;
+} QEMU_PACKED CXLAlertConfig;
+
 struct CXLType3Dev {
     /* Private */
     PCIDevice parent_obj;
@@ -605,6 +627,8 @@ struct CXLType3Dev {
     CXLCCI vdm_fm_owned_ld_mctp_cci;
     CXLCCI ld0_cci;
 
+    CXLAlertConfig alert_config;
+
     /* PCIe link characteristics */
     PCIExpLinkSpeed speed;
     PCIExpLinkWidth width;
-- 
2.34.1

