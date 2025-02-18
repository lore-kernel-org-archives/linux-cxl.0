Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F59C1A5BAB
	for <linux-cxl@vger.kernel.org>; Tue, 18 Feb 2025 05:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739857634; cv=none; b=fgvt3ee0xuLqOiCjdPN3oxifXU9bW/smmDeXEsTfoZnk9x9DBnvaCETe5Mgs0kx+lq2B4gqXEfEpM0xrm3lVY91+fircSDQoGb1Mc20arO56JdctaQuSh9E63aNgTyykwEJMopx2CP3KnbrJWzg7H948HgpHBGcNnUOYKcCJhEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739857634; c=relaxed/simple;
	bh=+QxBuj2+h01L4qirI0BR9xknLtwaksHt0u+olDgMgIM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=Y62FV6gjr2Cptzl4TRxKjUJPu/YUmUH7KyVEiUM4xeO/PeOY7L/M3sCeK+RumyYDfpUgJHSfYClOfo51NuM29KN8WJaYX6XHKGJ03LTVLwmBDVyYQgJeoutLvfyT5Wr9PpFL3ZNODqLLmdmTkdauSa1yO2v1kksUOfSz5lcensA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=qp91sVxC; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="qp91sVxC"
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250218054703epoutp01ce1413619ec4121b88ad4207db813bc8~lN0piP1zn1737517375epoutp010
	for <linux-cxl@vger.kernel.org>; Tue, 18 Feb 2025 05:47:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250218054703epoutp01ce1413619ec4121b88ad4207db813bc8~lN0piP1zn1737517375epoutp010
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1739857623;
	bh=OhDGtxEtqMboNDEnDtHKf6de49csfyXC2Q6EUnrKIdg=;
	h=From:To:Cc:Subject:Date:References:From;
	b=qp91sVxCBIOzE1GMuq7iohy88wO3S3K7MdrBh4PT6X2uNK529BonO+jd1cchLLf2r
	 uy9K0kQNVgSAvEqpWv/SAaGxPa4F5y6uxXrGvNCEJi8V6pAcTicG4+NTI0Nfg4C1xD
	 AVm0QYUBEY67MCqjz2gIIsXflxvp8l79n+qhnM3g=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20250218054703epcas5p23c025dcd905809e506186e35d27cac7b~lN0pDX2Te0575405754epcas5p2V;
	Tue, 18 Feb 2025 05:47:03 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.178]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4YxpSP0g3sz4x9Q2; Tue, 18 Feb
	2025 05:47:01 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	AD.CA.29212.3DE14B76; Tue, 18 Feb 2025 14:46:59 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250218052813epcas5p2834e4e039b4aa130af45b90459e14881~lNkMjPYkx2994529945epcas5p2z;
	Tue, 18 Feb 2025 05:28:13 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250218052813epsmtrp249ebac93ad71bd3df1af19d98154c739~lNkMhwlzj2736827368epsmtrp2n;
	Tue, 18 Feb 2025 05:28:12 +0000 (GMT)
X-AuditID: b6c32a50-801fa7000000721c-76-67b41ed3a3ac
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	89.69.18729.C6A14B76; Tue, 18 Feb 2025 14:28:12 +0900 (KST)
Received: from test-PowerEdge-R740xd.samsungds.net (unknown [107.99.41.79])
	by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250218052811epsmtip2303007b70f71098f2fa69b3f69035f40~lNkK_-q-w1360313603epsmtip2e;
	Tue, 18 Feb 2025 05:28:11 +0000 (GMT)
From: Sweta Kumari <s5.kumari@samsung.com>
To: qemu-devel@nongnu.org
Cc: gost.dev@samsung.com, linux-cxl@vger.kernel.org, nifan.cxl@gmail.com,
	dave@stgolabs.net, vishak.g@samsung.com, krish.reddy@samsung.com,
	a.manzanares@samsung.com, alok.rathore@samsung.com, Sweta Kumari
	<s5.kumari@samsung.com>
Subject: [PATCH v3] hw/cxl/cxl-mailbox-utils: CXL CCI Get/Set alert config
 commands implmented as per CXL Specification 3.2 section 8.2.10.9.3
Date: Tue, 18 Feb 2025 10:58:00 +0530
Message-Id: <20250218052800.134176-1-s5.kumari@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEJsWRmVeSWpSXmKPExsWy7bCmpu5luS3pBovXm1hMP6xo8eX0HjaL
	1TfXMFrcPLCTyWLhxmVMFudnnWKx+LttL6PF8d4dLBZrzn1mAYrNYXfg8tg56y67x5Nrm5k8
	+rasYvSYOrve4/MmuQDWqGybjNTElNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTc
	VFslF58AXbfMHKCblBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkFJgV6xYm5xaV5
	6Xp5qSVWhgYGRqZAhQnZGT8bXrMVrHer+LXnDlsD422TLkZODgkBE4mrX/ezdTFycQgJ7GGU
	+DGhhRXC+cQocXfdY1aQKiGBb4wSO05XwXTsf9zGCFG0l1HiSf8lFgingUni66xbYB1sAloS
	Pz4/YAaxRQQkJX53nWYGKWIWeMUosXFDK9hCYYEJjBLH3n9iA6liEVCV+NS2HqyDV8Ba4ljT
	CjaIffIS+w+ehYoLSpyc+YQFxGYGijdvnQ02VULgEbtE/6+dUA0uEq/2HGOBsIUlXh3fwg5h
	S0l8frcXqiZb4u7WTii7ROLD7d1MELa9ROupfqChHEALNCXW79KHCMtKTD21jgliL59E7+8n
	UOW8EjvmwdjKElv+LWeFsCUlVnxeAmV7SHx/u4MFZKSQQKxEy3GdCYzys5B8MwvJN7MQFi9g
	ZF7FKJVaUJybnppsWmCom5daDo/a5PzcTYzgxKkVsINx9Ya/eocYmTgYDzFKcDArifAe6tqQ
	LsSbklhZlVqUH19UmpNafIjRFBjGE5mlRJPzgak7ryTe0MTSwMTMzMzE0tjMUEmct3lnS7qQ
	QHpiSWp2ampBahFMHxMHp1QDk/6xnNjk5o12CZmrPY6dkpmbnGwyoyfTiO/0oqaPohfC/vg7
	n3DQ/z7DXFaGpf3nLc+srJsJvDlKe2tCn7n/eJvTeMHhUdIk/f2vz07gutLHJ9krcMT7bKN0
	wZ5eq8xXmZ+eTj3OOuvbvNyas3wW00MDRQ4oPRacxNpn9HaTomPvlDz1o2Vxpf8+cW9T883g
	d1xzy/eT1v3utyLSk0tOhkTE79j90mrxXIXzNy85HNo3zSzZ6sHHwOQgHRax5uC7nAJ39gVs
	nn50UuuHNaXbuV76i7/4K6uUta/t69r5NlqGVzfYbFm4qW+GjbKauphuTVGLrcPlXZo8HZNM
	0x0j308ROyr55P6sSZLzbpk7KbEUZyQaajEXFScCAHd1nNwlBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLLMWRmVeSWpSXmKPExsWy7bCSvG6O1JZ0gyNXDSymH1a0+HJ6D5vF
	6ptrGC1uHtjJZLFw4zImi/OzTrFY/N22l9HieO8OFos15z6zAMXmsDtweeycdZfd48m1zUwe
	fVtWMXpMnV3v8XmTXABrFJdNSmpOZllqkb5dAlfGz4bXbAXr3Sp+7bnD1sB426SLkZNDQsBE
	Yv/jNsYuRi4OIYHdjBKrVr9gh0hISrw9c4kRwhaWWPnvOVhcSOAfo8TaTl0Qm01AS+LH5wfM
	ILYIUP3vrtPMIIOYBb4wSkxp+MoE4ggL9DFKXFnfAzaJRUBV4lPberAOXgFriWNNK9ggNshL
	7D94FiouKHFy5hMWEJsZKN68dTbzBEa+WUhSs5CkFjAyrWKUTC0ozk3PLTYsMMxLLdcrTswt
	Ls1L10vOz93ECA5hLc0djNtXfdA7xMjEwXiIUYKDWUmE91DXhnQh3pTEyqrUovz4otKc1OJD
	jNIcLErivOIvelOEBNITS1KzU1MLUotgskwcnFINTOn3OZQ/CuVr9jFece3833z40frf+ySr
	Hs51WVV8YsmKmf9ufvSrbM28FThTrVra1Fbk6O/n7t0XKz6uYd4qzCNc8j++JTm88mXX57Wi
	qWw64pprPM4ZVh/nfutX4pkhd2v78m8KX240brMW22njs1t7x90n4irPmJqu8vb6fry0LXpX
	a/DdSUuTMli83e70PS7ZsSVX99dc6X6hyPYAx4ZJIW9nSq+tqZ17OfpZ33yPDTahj3ifq0+c
	e+hV2V7tdXOz1s6NE4v7cOwFl1dyRnUe3/e0WHX1Z5M27HGXWl/2uYv5nVDmj4UJ6Yrb/M2T
	NOws9lhe+fjHMHHaj+v9K5a7/9/y73LNzaKXz48osSixFGckGmoxFxUnAgBU0p/s0AIAAA==
X-CMS-MailID: 20250218052813epcas5p2834e4e039b4aa130af45b90459e14881
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250218052813epcas5p2834e4e039b4aa130af45b90459e14881
References: <CGME20250218052813epcas5p2834e4e039b4aa130af45b90459e14881@epcas5p2.samsung.com>

1)get alert configuration(Opcode 4201h)
2)set alert configuration(Opcode 4202h)

The patch is generated against the Johnathan's tree
https://gitlab.com/jic23/qemu.git and branch cxl-2024-11-27.

Signed-off-by: Sweta Kumari <s5.kumari@samsung.com>
---
Changes in V2:
- Removed cover letter as it's a single patch
- Added latest spec reference
- Fixed alignment issues
- Updated shorter variable names to be more descriptive
- Replaced field-by-field initialization in 'init_alert_config' with structured initialization for improved readability.
- Replaced bit fields with 'uint8_t' and added defines for individual bits.

Changes in v3:
- Addressed the review comments from Jonathan Cameron.
- Shortened macro and field names for improved readability.

 hw/cxl/cxl-mailbox-utils.c  | 105 ++++++++++++++++++++++++++++++++++++
 hw/mem/cxl_type3.c          |  16 ++++++
 include/hw/cxl/cxl_device.h |  15 ++++++
 3 files changed, 136 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 9c7ea5bc35..5187f1605e 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -28,6 +28,11 @@
 #define CXL_DC_EVENT_LOG_SIZE 8
 #define CXL_NUM_EXTENTS_SUPPORTED 512
 #define CXL_NUM_TAGS_SUPPORTED 0
+#define CXL_ALERTS_LIFE_USED_WARN_THRESH (1 << 0)
+#define CXL_ALERTS_OVER_TEMP_WARN_THRESH (1 << 1)
+#define CXL_ALERTS_UNDER_TEMP_WARN_THRESH (1 << 2)
+#define CXL_ALERTS_COR_VMEM_ERR_WARN_THRESH (1 << 3)
+#define CXL_ALERTS_COR_PMEM_ERR_WARN_THRESH (1 << 4)
 
 /*
  * How to add a new command, example. The command set FOO, with cmd BAR.
@@ -86,6 +91,9 @@ enum {
         #define GET_PARTITION_INFO     0x0
         #define GET_LSA       0x2
         #define SET_LSA       0x3
+    HEALTH_INFO_ALERTS = 0x42,
+        #define GET_ALERT_CONFIG 0x1
+        #define SET_ALERT_CONFIG 0x2
     SANITIZE    = 0x44,
         #define OVERWRITE     0x0
         #define SECURE_ERASE  0x1
@@ -1625,6 +1633,97 @@ static CXLRetCode cmd_ccls_set_lsa(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+/* CXL r3.2 Section 8.2.10.9.3.2 Get Alert Configuration (Opcode 4201h) */
+static CXLRetCode cmd_get_alert_config(const struct cxl_cmd *cmd,
+                                       uint8_t *payload_in,
+                                       size_t len_in,
+                                       uint8_t *payload_out,
+                                       size_t *len_out,
+                                       CXLCCI *cci)
+{
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+    CXLAlertConfig *out = (CXLAlertConfig *)payload_out;
+
+    memcpy(out, &ct3d->alert_config, sizeof(ct3d->alert_config));
+    *len_out = sizeof(ct3d->alert_config);
+
+    return CXL_MBOX_SUCCESS;
+}
+
+/* CXL r3.2 Section 8.2.10.9.3.3 Set Alert Configuration (Opcode 4202h) */
+static CXLRetCode cmd_set_alert_config(const struct cxl_cmd *cmd,
+                                       uint8_t *payload_in,
+                                       size_t len_in,
+                                       uint8_t *payload_out,
+                                       size_t *len_out,
+                                       CXLCCI *cci)
+{
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+    CXLAlertConfig *alert_config = &ct3d->alert_config;
+    struct {
+        uint8_t valid_alert_actions;
+        uint8_t enable_alert_actions;
+        uint8_t life_used_warn_thresh;
+        uint8_t rsvd;
+        uint16_t over_temp_warn_thresh;
+        uint16_t under_temp_warn_thresh;
+        uint16_t cor_vmem_err_warn_thresh;
+        uint16_t cor_pmem_err_warn_thresh;
+    } QEMU_PACKED *in = (void *)payload_in;
+
+    if (in->valid_alert_actions & CXL_ALERTS_LIFE_USED_WARN_THRESH) {
+        /*
+         * CXL 3.2 Table 8-149 The life used warning threshold shall be
+         * less than the life used critical alert value.
+         */
+        if (in->life_used_warn_thresh >=
+            alert_config->life_used_crit_alert_thresh) {
+            return CXL_MBOX_INVALID_INPUT;
+        }
+        alert_config->life_used_warn_thresh = in->life_used_warn_thresh;
+        alert_config->enable_alerts |= CXL_ALERTS_LIFE_USED_WARN_THRESH;
+    }
+
+    if (in->valid_alert_actions & CXL_ALERTS_OVER_TEMP_WARN_THRESH) {
+        /*
+         * CXL 3.2 Table 8-149 The Device Over-Temperature Warning Threshold
+         * shall be less than the the Device Over-Temperature Critical
+         * Alert Threshold.
+         */
+        if (in->over_temp_warn_thresh >=
+            alert_config->over_temp_crit_alert_thresh) {
+            return CXL_MBOX_INVALID_INPUT;
+        }
+        alert_config->over_temp_warn_thresh = in->over_temp_warn_thresh;
+        alert_config->enable_alerts |= CXL_ALERTS_OVER_TEMP_WARN_THRESH;
+    }
+
+    if (in->valid_alert_actions & CXL_ALERTS_UNDER_TEMP_WARN_THRESH) {
+        /*
+         * CXL 3.2 Table 8-149 The Device Under-Temperature Warning Threshold
+         * shall be higher than the the Device Under-Temperature Critical
+         * Alert Threshold.
+         */
+        if (in->under_temp_warn_thresh <=
+            alert_config->under_temp_crit_alert_thresh) {
+            return CXL_MBOX_INVALID_INPUT;
+        }
+        alert_config->under_temp_warn_thresh = in->under_temp_warn_thresh;
+        alert_config->enable_alerts |= CXL_ALERTS_UNDER_TEMP_WARN_THRESH;
+    }
+
+    if (in->valid_alert_actions & CXL_ALERTS_COR_VMEM_ERR_WARN_THRESH) {
+        alert_config->cor_vmem_err_warn_thresh = in->cor_vmem_err_warn_thresh;
+        alert_config->enable_alerts |= CXL_ALERTS_COR_VMEM_ERR_WARN_THRESH;
+    }
+
+    if (in->valid_alert_actions & CXL_ALERTS_COR_PMEM_ERR_WARN_THRESH) {
+        alert_config->cor_pmem_err_warn_thresh = in->cor_pmem_err_warn_thresh;
+        alert_config->enable_alerts |= CXL_ALERTS_COR_PMEM_ERR_WARN_THRESH;
+    }
+    return CXL_MBOX_SUCCESS;
+}
+
 /* Perform the actual device zeroing */
 static void __do_sanitization(CXLType3Dev *ct3d)
 {
@@ -2859,6 +2958,12 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
     [CCLS][GET_LSA] = { "CCLS_GET_LSA", cmd_ccls_get_lsa, 8, 0 },
     [CCLS][SET_LSA] = { "CCLS_SET_LSA", cmd_ccls_set_lsa,
         ~0, CXL_MBOX_IMMEDIATE_CONFIG_CHANGE | CXL_MBOX_IMMEDIATE_DATA_CHANGE },
+    [HEALTH_INFO_ALERTS][GET_ALERT_CONFIG] = {
+        "HEALTH_INFO_ALERTS_GET_ALERT_CONFIG",
+        cmd_get_alert_config, 0, 0 },
+    [HEALTH_INFO_ALERTS][SET_ALERT_CONFIG] = {
+        "HEALTH_INFO_ALERTS_SET_ALERT_CONFIG",
+        cmd_set_alert_config, 12, CXL_MBOX_IMMEDIATE_POLICY_CHANGE },
     [SANITIZE][OVERWRITE] = { "SANITIZE_OVERWRITE", cmd_sanitize_overwrite, 0,
         (CXL_MBOX_IMMEDIATE_DATA_CHANGE |
          CXL_MBOX_SECURITY_STATE_CHANGE |
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 5f365afb4d..ecbaa60210 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -956,6 +956,21 @@ static DOEProtocol doe_comp_prot[] = {
     { }
 };
 
+/*
+ * Initialize CXL device alerts with default threshold values.
+ */
+static void init_alert_config(CXLType3Dev *ct3d)
+{
+    ct3d->alert_config = (CXLAlertConfig) {
+        .life_used_crit_alert_thresh = 75,
+        .life_used_warn_thresh = 40,
+        .over_temp_crit_alert_thresh = 35,
+        .under_temp_crit_alert_thresh = 10,
+        .over_temp_warn_thresh = 25,
+        .under_temp_warn_thresh = 20
+    };
+}
+
 void ct3_realize(PCIDevice *pci_dev, Error **errp)
 {
     ERRP_GUARD();
@@ -1030,6 +1045,7 @@ void ct3_realize(PCIDevice *pci_dev, Error **errp)
         goto err_free_special_ops;
     }
 
+    init_alert_config(ct3d);
     pcie_cap_deverr_init(pci_dev);
     /* Leave a bit of room for expansion */
     rc = pcie_aer_init(pci_dev, PCI_ERR_VER, 0x200, PCI_ERR_SIZEOF, NULL);
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index a64739be25..7f96bd8637 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -581,6 +581,19 @@ typedef struct CXLSetFeatureInfo {
     size_t data_size;
 } CXLSetFeatureInfo;
 
+typedef struct CXLAlertConfig {
+    uint8_t valid_alerts;
+    uint8_t enable_alerts;
+    uint8_t life_used_crit_alert_thresh;
+    uint8_t life_used_warn_thresh;
+    uint16_t over_temp_crit_alert_thresh;
+    uint16_t under_temp_crit_alert_thresh;
+    uint16_t over_temp_warn_thresh;
+    uint16_t under_temp_warn_thresh;
+    uint16_t cor_vmem_err_warn_thresh;
+    uint16_t cor_pmem_err_warn_thresh;
+} QEMU_PACKED CXLAlertConfig;
+
 struct CXLType3Dev {
     /* Private */
     PCIDevice parent_obj;
@@ -605,6 +618,8 @@ struct CXLType3Dev {
     CXLCCI vdm_fm_owned_ld_mctp_cci;
     CXLCCI ld0_cci;
 
+    CXLAlertConfig alert_config;
+
     /* PCIe link characteristics */
     PCIExpLinkSpeed speed;
     PCIExpLinkWidth width;
-- 
2.34.1

