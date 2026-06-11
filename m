Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADF2388E57
	for <linux-cxl@vger.kernel.org>; Thu, 11 Jun 2026 06:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781160832; cv=none; b=MV+sbtPHPokbOix34bhmDjJXNGzOLZlxh3xay7vybihiZt93bHL2rDb0qcVx/kHQGqyyPvYb81HmuLbsWSjHe7Hs7ED5IXbAOAZNKYHeKh7mts+R9Wt3EPtNVm3s/KJx4ibX863tsSj8kNPnXzmKnqOwNFBgidLzFL4iKmW+E+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781160832; c=relaxed/simple;
	bh=mi/AXbKiKl5jLdXE4Q3gMAEbPnG58Ck9tvhBVlV+p+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ahb8xbr5b4r0EdtlCxGAJzcLWHAsPNU35PYWXs7sOP3GOJJ+x19607kLUELNwfoMqEpWS96pgqe6m4KaMuevskykwSPLTbJwN5MlPsKAePM51YmbKFJAQV+n4FEcX0ukF+a9mapVONhNZrCOzXXN2shk5mnTC9uhWcSQlGYoukw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ek7ZczRq; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ek7ZczRq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781160827; x=1812696827;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mi/AXbKiKl5jLdXE4Q3gMAEbPnG58Ck9tvhBVlV+p+M=;
  b=Ek7ZczRqGs8B5KhdSqC9hB+dtZlqpdVcRRd7DTnraZPm91WZ4eeMLtha
   4cPQ6Cjyi91KMJAHMUFTrloIk52ZQ98CUcaWPVl7bUAqZE66j63siex31
   +Tgay7sutF3Jived8OeK7a8YZEvIYF0Vl5N8Lnd1Fz3TF81HG3AcAz+fa
   MiBaPJPtKEU1qQioeDPV2cx4Z9Z0ElUHDyyHZyfN682hjRxjya9DWJMFp
   +4tfm2jbfK1o3atbPCN/ekKazn6F9bw7gMjXr5dk5QI0uhvq3aBZgxPOS
   YtBh/8BdgUwYERVv+IJOAVGq16KdtAdNKp86C20uN50v5meIAr7Ba1ilx
   w==;
X-CSE-ConnectionGUID: VNWx7jgmS1a8kH2HTi+ZAw==
X-CSE-MsgGUID: SOkOSmnGTNG8rEAUPf8hqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="85595462"
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; 
   d="scan'208";a="85595462"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 23:53:46 -0700
X-CSE-ConnectionGUID: 4dTmxVGfTKOMcmse1DvzJw==
X-CSE-MsgGUID: rVi8GgPzSq2G/zpCfTM8zA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; 
   d="scan'208";a="246469784"
Received: from junjie-desk-dev.bj.intel.com ([10.238.152.71])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 23:53:44 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: jic23@kernel.org
Cc: fan.ni@samsung.com,
	qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org,
	junjie.cao@intel.com
Subject: [PATCH v2 2/5] hw/cxl: trace mailbox command dispatch and payload errors
Date: Thu, 11 Jun 2026 14:30:24 +0800
Message-ID: <20260611063027.1166493-3-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260611063027.1166493-1-junjie.cao@intel.com>
References: <20260611063027.1166493-1-junjie.cao@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add trace events for CXL mailbox command processing: command entry,
handler completion, and all payload-length validation failures.

Three trace points are added:

  cxl_mailbox_cmd           - command entry with set, cmd, name, len_in
  cxl_mailbox_cmd_done      - handler return with ret code and len_out
  cxl_mailbox_payload_error - payload length mismatch (all 21 sites)

To make set/cmd accessible inside individual command handlers (which
do not receive them as parameters), add a current_opcode field to
CXLCCI that is set before handler dispatch.  This mirrors the existing
cci->bg.opcode pattern used for background operations.

The payload_error event covers not only the centralised entry check in
cxl_process_cci_message() but also every handler-internal return of
CXL_MBOX_INVALID_PAYLOAD_LENGTH, including variable-length command
validators in tunnelling, DCD, firmware update, set-feature, media
operations, and physical-port commands.

As a minor cleanup, add a CXLCCI *cci parameter to
media_operations_discovery() so it can access current_opcode.  This
aligns it with media_operations_sanitize() which already receives cci.

Signed-off-by: Junjie Cao <junjie.cao@intel.com>
---
 hw/cxl/cxl-mailbox-utils.c  | 71 +++++++++++++++++++++++++++++++++++--
 hw/cxl/trace-events         |  5 +++
 include/hw/cxl/cxl_device.h |  1 +
 3 files changed, 75 insertions(+), 2 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index d8ba7e8625..10af11dc1f 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -27,6 +27,7 @@
 #include "system/hostmem.h"
 #include "qemu/range.h"
 #include "qapi/qapi-types-cxl.h"
+#include "trace.h"
 
 #define CXL_CAPACITY_MULTIPLIER   (256 * MiB)
 #define CXL_DC_EVENT_LOG_SIZE 8
@@ -179,14 +180,23 @@ static CXLRetCode cmd_tunnel_management_cmd(const struct cxl_cmd *cmd,
     out = (void *)payload_out;
 
     if (len_in < sizeof(*in)) {
+        trace_cxl_mailbox_payload_error(cci->current_opcode >> 8,
+                                        cci->current_opcode & 0xff,
+                                        cmd->name, len_in);
         return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
     }
     /* Enough room for minimum sized message - no payload */
     if (in->size < sizeof(in->ccimessage)) {
+        trace_cxl_mailbox_payload_error(cci->current_opcode >> 8,
+                                        cci->current_opcode & 0xff,
+                                        cmd->name, len_in);
         return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
     }
     /* Length of input payload should be in->size + a wrapping tunnel header */
     if (in->size != len_in - offsetof(typeof(*out), ccimessage)) {
+        trace_cxl_mailbox_payload_error(cci->current_opcode >> 8,
+                                        cci->current_opcode & 0xff,
+                                        cmd->name, len_in);
         return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
     }
     if (in->ccimessage.category != CXL_CCI_CAT_REQ) {
@@ -299,6 +309,9 @@ static CXLRetCode cmd_events_clear_records(const struct cxl_cmd *cmd,
 
     if (len_in < sizeof(*pl) ||
         len_in < sizeof(*pl) + sizeof(*pl->handle) * pl->nr_recs) {
+        trace_cxl_mailbox_payload_error(cci->current_opcode >> 8,
+                                        cci->current_opcode & 0xff,
+                                        cmd->name, len_in);
         return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
     }
 
@@ -361,6 +374,9 @@ static CXLRetCode cmd_events_set_interrupt_policy(const struct cxl_cmd *cmd,
     CXLEventLog *log;
 
     if (len_in < CXL_EVENT_INT_SETTING_MIN_LEN) {
+        trace_cxl_mailbox_payload_error(cci->current_opcode >> 8,
+                                        cci->current_opcode & 0xff,
+                                        cmd->name, len_in);
         return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
     }
 
@@ -604,6 +620,9 @@ static CXLRetCode cmd_get_physical_port_state(const struct cxl_cmd *cmd,
     out = (struct cxl_fmapi_get_phys_port_state_resp_pl *)payload_out;
 
     if (len_in < sizeof(*in)) {
+        trace_cxl_mailbox_payload_error(cci->current_opcode >> 8,
+                                        cci->current_opcode & 0xff,
+                                        cmd->name, len_in);
         return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
     }
     /* Check if what was requested can fit */
@@ -782,6 +801,9 @@ static CXLRetCode cmd_physical_port_control(const struct cxl_cmd *cmd,
     } QEMU_PACKED *in = (void *)payload_in;
 
     if (len_in < sizeof(*in)) {
+        trace_cxl_mailbox_payload_error(cci->current_opcode >> 8,
+                                        cci->current_opcode & 0xff,
+                                        cmd->name, len_in);
         return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
     }
 
@@ -961,6 +983,9 @@ static CXLRetCode cmd_firmware_update_transfer(const struct cxl_cmd *cmd,
     size_t offset, length;
 
     if (len < sizeof(*fw_transfer)) {
+        trace_cxl_mailbox_payload_error(cci->current_opcode >> 8,
+                                        cci->current_opcode & 0xff,
+                                        cmd->name, len);
         return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
     }
 
@@ -1718,6 +1743,9 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
     uint16_t count;
 
     if (len_in < sizeof(*hdr)) {
+        trace_cxl_mailbox_payload_error(cci->current_opcode >> 8,
+                                        cci->current_opcode & 0xff,
+                                        cmd->name, len_in);
         return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
     }
 
@@ -1748,6 +1776,9 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
     bytes_to_copy = len_in - sizeof(CXLSetFeatureInHeader);
 
     if (bytes_to_copy == 0) {
+        trace_cxl_mailbox_payload_error(cci->current_opcode >> 8,
+                                        cci->current_opcode & 0xff,
+                                        cmd->name, len_in);
         return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
     }
 
@@ -1762,6 +1793,9 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
 
         if ((uint32_t)hdr->offset + bytes_to_copy >
             sizeof(ct3d->patrol_scrub_wr_attrs)) {
+            trace_cxl_mailbox_payload_error(cci->current_opcode >> 8,
+                                            cci->current_opcode & 0xff,
+                                            cmd->name, len_in);
             return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
         }
         memcpy((uint8_t *)&ct3d->patrol_scrub_wr_attrs + hdr->offset,
@@ -1789,6 +1823,9 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
 
         if ((uint32_t)hdr->offset + bytes_to_copy >
             sizeof(ct3d->ecs_wr_attrs)) {
+            trace_cxl_mailbox_payload_error(cci->current_opcode >> 8,
+                                            cci->current_opcode & 0xff,
+                                            cmd->name, len_in);
             return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
         }
         memcpy((uint8_t *)&ct3d->ecs_wr_attrs + hdr->offset,
@@ -2294,6 +2331,9 @@ static CXLRetCode cmd_ccls_set_lsa(const struct cxl_cmd *cmd,
 
     *len_out = 0;
     if (len_in < hdr_len) {
+        trace_cxl_mailbox_payload_error(cci->current_opcode >> 8,
+                                        cci->current_opcode & 0xff,
+                                        cmd->name, len_in);
         return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
     }
 
@@ -2661,7 +2701,8 @@ static const struct media_op_supported_list_entry media_op_matrix[] = {
 static CXLRetCode media_operations_discovery(uint8_t *payload_in,
                                              size_t len_in,
                                              uint8_t *payload_out,
-                                             size_t *len_out)
+                                             size_t *len_out,
+                                             CXLCCI *cci)
 {
     struct {
         uint8_t media_operation_class;
@@ -2680,6 +2721,9 @@ static CXLRetCode media_operations_discovery(uint8_t *payload_in,
     int count = 0;
 
     if (len_in < sizeof(*media_op_in_disc_pl)) {
+        trace_cxl_mailbox_payload_error(cci->current_opcode >> 8,
+                                        cci->current_opcode & 0xff,
+                                        "MEDIA_OPERATIONS", len_in);
         return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
     }
 
@@ -2741,6 +2785,9 @@ static CXLRetCode media_operations_sanitize(CXLType3Dev *ct3d,
 
     dpa_range_list_size = dpa_range_count * sizeof(struct dpa_range_list_entry);
     if (len_in < (sizeof(*media_op_in_sanitize_pl) + dpa_range_list_size)) {
+        trace_cxl_mailbox_payload_error(cci->current_opcode >> 8,
+                                        cci->current_opcode & 0xff,
+                                        "MEDIA_OPERATIONS", len_in);
         return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
     }
 
@@ -2792,6 +2839,9 @@ static CXLRetCode cmd_media_operations(const struct cxl_cmd *cmd,
     uint8_t media_op_subclass = 0;
 
     if (len_in < sizeof(*media_op_in_common_pl)) {
+        trace_cxl_mailbox_payload_error(cci->current_opcode >> 8,
+                                        cci->current_opcode & 0xff,
+                                        cmd->name, len_in);
         return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
     }
 
@@ -2805,7 +2855,7 @@ static CXLRetCode cmd_media_operations(const struct cxl_cmd *cmd,
         }
 
         return media_operations_discovery(payload_in, len_in, payload_out,
-                                             len_out);
+                                             len_out, cci);
     case MEDIA_OP_CLASS_SANITIZE:
         switch (media_op_subclass) {
         case MEDIA_OP_SAN_SUBC_SANITIZE:
@@ -3712,6 +3762,9 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
     CXLRetCode ret;
 
     if (len_in < sizeof(*in)) {
+        trace_cxl_mailbox_payload_error(cci->current_opcode >> 8,
+                                        cci->current_opcode & 0xff,
+                                        cmd->name, len_in);
         return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
     }
 
@@ -3723,6 +3776,9 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
 
     if (len_in <
         sizeof(*in) + sizeof(*in->updated_entries) * in->num_entries_updated) {
+        trace_cxl_mailbox_payload_error(cci->current_opcode >> 8,
+                                        cci->current_opcode & 0xff,
+                                        cmd->name, len_in);
         return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
     }
 
@@ -3883,6 +3939,9 @@ static CXLRetCode cmd_dcd_release_dyn_cap(const struct cxl_cmd *cmd,
     CXLRetCode ret;
 
     if (len_in < sizeof(*in)) {
+        trace_cxl_mailbox_payload_error(cci->current_opcode >> 8,
+                                        cci->current_opcode & 0xff,
+                                        cmd->name, len_in);
         return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
     }
 
@@ -3892,6 +3951,9 @@ static CXLRetCode cmd_dcd_release_dyn_cap(const struct cxl_cmd *cmd,
 
     if (len_in <
         sizeof(*in) + sizeof(*in->updated_entries) * in->num_entries_updated) {
+        trace_cxl_mailbox_payload_error(cci->current_opcode >> 8,
+                                        cci->current_opcode & 0xff,
+                                        cmd->name, len_in);
         return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
     }
 
@@ -4588,7 +4650,11 @@ int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
         return CXL_MBOX_UNSUPPORTED;
     }
 
+    cci->current_opcode = (set << 8) | cmd;
+    trace_cxl_mailbox_cmd(set, cmd, cxl_cmd->name, len_in);
+
     if (len_in != cxl_cmd->in && cxl_cmd->in != ~0) {
+        trace_cxl_mailbox_payload_error(set, cmd, cxl_cmd->name, len_in);
         return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
     }
 
@@ -4620,6 +4686,7 @@ int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
     }
 
     ret = (*h)(cxl_cmd, pl_in, len_in, pl_out, len_out, cci);
+    trace_cxl_mailbox_cmd_done(set, cmd, ret, *len_out);
     if ((cxl_cmd->effect & CXL_MBOX_BACKGROUND_OPERATION) &&
         ret == CXL_MBOX_BG_STARTED) {
         *bg_started = true;
diff --git a/hw/cxl/trace-events b/hw/cxl/trace-events
index 23bc9b19b9..609def2dec 100644
--- a/hw/cxl/trace-events
+++ b/hw/cxl/trace-events
@@ -1 +1,6 @@
 # See docs/devel/tracing.rst for syntax documentation.
+
+# cxl-mailbox-utils.c
+cxl_mailbox_cmd(uint8_t set, uint8_t cmd, const char *name, size_t len_in) "set=0x%02x cmd=0x%02x [%s] len_in=%zu"
+cxl_mailbox_cmd_done(uint8_t set, uint8_t cmd, int ret, size_t len_out) "set=0x%02x cmd=0x%02x ret=%d len_out=%zu"
+cxl_mailbox_payload_error(uint8_t set, uint8_t cmd, const char *name, size_t len_in) "set=0x%02x cmd=0x%02x [%s] len_in=%zu"
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 393f312217..3237d59ab2 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -207,6 +207,7 @@ typedef struct CXLCCI {
         time_t last_partxfer;
     } fw;
 
+    uint16_t current_opcode;
     size_t payload_max;
     /* Pointer to device hosting the CCI */
     DeviceState *d;
-- 
2.43.0

