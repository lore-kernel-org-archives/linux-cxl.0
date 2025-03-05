Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6741F5826
	for <linux-cxl@vger.kernel.org>; Wed,  5 Mar 2025 09:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741166893; cv=none; b=tgVr/BIvHPjdUT9C9a5OiDG7TJSJyEF4jqKnuaWD7/j/sl3uWgfsa2umNJilCLuQitWKB9P7nCeZDOpws1CmFYKrlOTJ551HltNUae1tk5Dk5jbjuEDHoG1EOFks5oIWAjc1Uqcl1rxSQNMA5yO6GNNhoHDaIJjyEpH6gs2XG4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741166893; c=relaxed/simple;
	bh=9doAse/ctfLSheDaLrIWQGjR5HGH2ueu36o+QjOJo04=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PXEnqKDPvs5jwssn6Ak8+I13DThA/OOg1VGSNe4z/Vj56+Y6BDlFHRW6qqBqOEWS0IcDjZgnEEuIDgnFsV+Pwn6pryfcfCqUX3+Rct3Xx6mN1bNlR8veU9ZMuYM5t/CqQY/aWKfzdY0fVqqB5AMfHVdPS9enIwi9hqYIbnc2u0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Z76Yv19Nxz6L54Y;
	Wed,  5 Mar 2025 17:24:03 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 0711D140A34;
	Wed,  5 Mar 2025 17:28:09 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 5 Mar 2025 10:28:08 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <linux-cxl@vger.kernel.org>, <qemu-devel@nongnu.org>, <mst@redhat.com>
CC: <linuxarm@huawei.com>, <fan.ni@samsung.com>, Yuquan Wang
	<wangyuquan1236@phytium.com.cn>, Arpit Kumar <arpit1.kumar@samsung.com>,
	Sweta Kumari <s5.kumari@samsung.com>, Vinayak Holikatti
	<vinayak.kh@samsung.com>, Davidlohr Bueso <dave@stgolabs.net>, Ajay Joshi
	<ajay.opensrc@micron.com>
Subject: [PATCH qemu 6/8] hw/cxl/cxl-mailbox-utils: CXL CCI Get/Set alert config commands
Date: Wed, 5 Mar 2025 09:24:57 +0000
Message-ID: <20250305092501.191929-7-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250305092501.191929-1-Jonathan.Cameron@huawei.com>
References: <20250305092501.191929-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)

From: Sweta Kumari <s5.kumari@samsung.com>

1) get alert configuration(Opcode 4201h)
2) set alert configuration(Opcode 4202h)

Signed-off-by: Sweta Kumari <s5.kumari@samsung.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/hw/cxl/cxl_device.h |  15 ++++++
 hw/cxl/cxl-mailbox-utils.c  | 105 ++++++++++++++++++++++++++++++++++++
 hw/mem/cxl_type3.c          |  14 +++++
 3 files changed, 134 insertions(+)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 3ec7be3809..ed6cd50c67 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -542,6 +542,19 @@ typedef struct CXLSetFeatureInfo {
 
 struct CXLSanitizeInfo;
 
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
@@ -563,6 +576,8 @@ struct CXLType3Dev {
     CXLCCI vdm_fm_owned_ld_mctp_cci;
     CXLCCI ld0_cci;
 
+    CXLAlertConfig alert_config;
+
     /* PCIe link characteristics */
     PCIExpLinkSpeed speed;
     PCIExpLinkWidth width;
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 2c6db70e5f..299f232f26 100644
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
@@ -1610,6 +1618,97 @@ static CXLRetCode cmd_ccls_set_lsa(const struct cxl_cmd *cmd,
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
+         * CXL r3.2 Table 8-149 The life used warning threshold shall be
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
+         * CXL r3.2 Table 8-149 The Device Over-Temperature Warning Threshold
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
+         * CXL r3.2 Table 8-149 The Device Under-Temperature Warning Threshold
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
@@ -3173,6 +3272,12 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
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
index be670ae3f3..73845dd50d 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -843,6 +843,19 @@ static DOEProtocol doe_cdat_prot[] = {
     { }
 };
 
+/* Initialize CXL device alerts with default threshold values. */
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
 static void ct3_realize(PCIDevice *pci_dev, Error **errp)
 {
     ERRP_GUARD();
@@ -910,6 +923,7 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
         goto err_msix_uninit;
     }
 
+    init_alert_config(ct3d);
     pcie_cap_deverr_init(pci_dev);
     /* Leave a bit of room for expansion */
     rc = pcie_aer_init(pci_dev, PCI_ERR_VER, 0x200, PCI_ERR_SIZEOF, errp);
-- 
2.43.0

