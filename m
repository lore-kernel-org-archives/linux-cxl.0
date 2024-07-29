Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCDC74055
	for <linux-cxl@vger.kernel.org>; Mon, 29 Jul 2024 10:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722248460; cv=fail; b=c1+ifeOAs/JRT7QCADzAeZiUZfc60jua86LDY3OUj0r7Css2/wAfV+ALP8ATYK8SKVgm74H3VaqxlSiomQUPfN9BizsDhiLFIk43bIEqhTeuGKdC3cmzJCWKphcYXuER4/uoz25KssVIfXDgpIZnAZF+0hJmUDOB4ZPIoLd4W5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722248460; c=relaxed/simple;
	bh=OyM/Mlfp0JxF/qztun0/vF4OV2bchhm1q19qAnTNY0o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NKB4AY34r0vCpUbJbBr5R3zw7fEMnog2mE4uNDpvT1mHsjBvuc0CnWoPzGOnr/wnYzDgKt9DnCa5M1Yk2UOLkwE1TQeJdiEm/n9tTFtpdImHokEObS9mkqKmzzvMvVUgs6qEq0/nVBZEPyJW354L4t5co7kuXCz4j0vLTEa0vlU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=micron.com; spf=pass smtp.mailfrom=micron.com; dkim=pass (2048-bit key) header.d=micron.com header.i=@micron.com header.b=JJkDMSdy; arc=fail smtp.client-ip=40.107.93.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=micron.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=micron.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=micron.com header.i=@micron.com header.b="JJkDMSdy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wgfb/M7mjQxFfwuyu0DsoA89SjaCHcrcPGYE0k/toXVcTE0qQwAgWXcsdObumL51EVsuvjlcBqdi1Ny7/TPlpYhHqRRjy+P4Dy3Qx0kfe65qaFiFptyoc4aFiQcK2id/haXG3lIERbSCUTYH7EZGV9lxhXb5Mhi0p02NdlKMZuPR/93ub49THz5I5pp9tUtkvN0D+xZ0FqbI8QSPwsjTl7m9Q1xUe0MBF1abbohzyh7viYwboJB/jllGew5EGTIzBrd6vDsB1wPwENtOvhNlqVmgkGz9WXXZKF9MMP8zXIw51whXWYFmzCQXiuxwleJFdbUAmUp3ClEiRzGDjmIW6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LfD4A+rEW1MXM6FF0WHSTQBqhPEblfXksUHrE2N1lPM=;
 b=KwU3MusJ6vUi9wrMaJIaShV/8w3OnW59djtBBwF/YxDAAto6xhJqF14oha3D7hfWJAROnWYHnh0qXehz1A0WLfV3hEMqzldqXC0dp65kIsOouofSefp/Jg4K7nPLlmirl4/5dPrBjdM7TNPyQzxl7Aoi36wl93/5oOT/4dkx2RU+eoscJEXfFJZtku7SRjmyxU2nGXAMlf+7qQIK6DhjSNYkQjA+sndXsi3rViPyom7H/vuQIR1DFCjezrgN+nOJWVJinokCRhTvuaUsPLvuR4EtrIFJRTY1eKy4+/RXQDjRYsCDhOWEESjqDtwpFedk02eM7RWVt9O76n+WgY8FYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.201.242.130) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=micron.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=micron.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LfD4A+rEW1MXM6FF0WHSTQBqhPEblfXksUHrE2N1lPM=;
 b=JJkDMSdymlhAJ9Cc8DAtdX4KQJ8o/yb0cHbSSOQ4ZdKduzxfhpWKjCTN0TsCAL8NsWn0OTwrxIVQ+AUt7ItLOSg5dPfVAC0Av++GaK6AWX2g5if6ZaEG23C9PnYvfS3sWKvwdE7iBHZAA6cp0Jdzn0chY9EmjVPUYVmv+LZRnreFJCtbNhVtIRwqviLU/xeoAjh1SXuEayY/xy2ekK0U+1GAy+91X5r+ybYBf4O+FrPeIkMc4ItfSvifIFEukLY7iC2e1MUzeWOTjqnI348okkNjsMfgbzb/Szo5fsoU/wg3Oqv/vKQtDSr6ukK2Da62SSuudwmdoucihiSWG60jow==
Received: from BL6PEPF00016415.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:d) by LV8PR08MB9197.namprd08.prod.outlook.com
 (2603:10b6:408:1fc::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.23; Mon, 29 Jul
 2024 10:20:54 +0000
Received: from BN3PEPF0000B06E.namprd21.prod.outlook.com
 (2a01:111:f403:f908::) by BL6PEPF00016415.outlook.office365.com
 (2603:1036:903:4::a) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36 via Frontend
 Transport; Mon, 29 Jul 2024 10:20:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 137.201.242.130)
 smtp.mailfrom=micron.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=micron.com;
Received-SPF: Pass (protection.outlook.com: domain of micron.com designates
 137.201.242.130 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.201.242.130; helo=mail.micron.com; pr=C
Received: from mail.micron.com (137.201.242.130) by
 BN3PEPF0000B06E.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.0 via Frontend Transport; Mon, 29 Jul 2024 10:20:53 +0000
Received: from BOW17EX19B.micron.com (137.201.21.219) by BOW17EX19A.micron.com
 (137.201.21.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 29 Jul
 2024 04:20:50 -0600
Received: from AJAYJOSH-LAP.sing.micron.com (10.3.66.158) by
 RestrictedRelay17EX19B.micron.com (137.201.21.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4
 via Frontend Transport; Mon, 29 Jul 2024 04:20:46 -0600
From: <ajay.opensrc@micron.com>
To: <Jonathan.Cameron@Huawei.com>
CC: <linux-cxl@vger.kernel.org>, <john@jagalactic.com>,
	<emirakhur@micron.com>, <ajayjoshi@micron.com>, <sthanneeru@micron.com>,
	<ravis.opensrc@micron.com>, <arramesh@micron.com>, Ajay Joshi
	<ajay.opensrc@micron.com>, Tushar Mulgund <tmmulgund@micron.com>
Subject: [PATCH] hw/cxl: Add support for abort of background operation
Date: Mon, 29 Jul 2024 15:50:10 +0530
Message-ID: <20240729102010.20996-1-ajay.opensrc@micron.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MT-Whitelisted: matched
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06E:EE_|LV8PR08MB9197:EE_
X-MS-Office365-Filtering-Correlation-Id: d6e8936e-2064-48c7-df67-08dcafb82075
X-EXT-ByPass: 1
X-MT-RULE-Whitelisted: Triggered
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5slTHJT6qEWh9yzcS7cp3GjF10fQoZlvWHg8G5FP+gzbSy0rUInK0kIX5CSm?=
 =?us-ascii?Q?9zP41d8g/8LSywdAGUIA77paDMtr+roTcv9N6uFWzymfE1XEagJDoKiQ5IBz?=
 =?us-ascii?Q?WOlURYw/m09wXB1s8LXOl8cOOxE6RMrsVGY8peNWg1qmlW9PtcNIpSbUgv3r?=
 =?us-ascii?Q?Ke8TScLkV6K2P1sO4UK2O1t041PFLA6U/DUxUctthVmnIuwuEzFnEpiuX71U?=
 =?us-ascii?Q?g17TgfPTeTwHMNHyz/vQGMVDqV6aBIwMi/HKY4hOfLI2If6+qtb4tySGfG5Y?=
 =?us-ascii?Q?JbI4KAgGeUIkbmYlbsbhS5xRd5tg6sRyUKEXN54/EEO/omGmKAfs7wWpXSGL?=
 =?us-ascii?Q?3E2GYeQ4eF81oHr06sfh2XZEb83H9KGJXzeEqaARvqul/0wiPsJ9n49zAfum?=
 =?us-ascii?Q?dPafcDQiQ26LCLDGDr6qv2+yss6D4Uk6uct39CFpsT74hNQMYyT2jJ7QRJGN?=
 =?us-ascii?Q?2t5R97CellRWrCC94gBvdCv3f44GZsTa4geUKLecXNnXFIWD1fh/n+40vdv+?=
 =?us-ascii?Q?XH74yFyihBVNCyvzUNVuPD0OuvP/KK8pqGdpX2ttfap3zYgO7hqH4fNAKlKQ?=
 =?us-ascii?Q?eGoq0w4FsfAYPMLMU/NLVAjsjqz7fypqL2lUyiru+tjjsSagX7to7zKIaDZi?=
 =?us-ascii?Q?uwYHN8rbcDELkFZNNqOsqkJ0N4BvT3T9C0cijAyKkBficmplpAYCYFVKsu7C?=
 =?us-ascii?Q?XB1861BV00143kXCF+XQoYmsWN+ZwvfxBuSam5AFQB0WsMVfzipelZeO4wJ2?=
 =?us-ascii?Q?nw+4SyesX05Gciu/5S2GAJclffZlW4k5NK2s9e+GZV3yKcuDt3PtbYAMuP0w?=
 =?us-ascii?Q?dBcGeceqEtHGhGrBmnDrfMXY5P3RoaZvP/mWRrVoyfliw8nWwZPeglFmEoIX?=
 =?us-ascii?Q?9V3ip9r492z3qsrzJy/mXh+60V/dN5rGLBK7awo8vrpqqtdGEfyPOSEo+kGM?=
 =?us-ascii?Q?ElCmNtEzl1UZkXVH9GVMXuw1mphaPRYk660Xb4BMnXl0lgbCzYODxsBpjCFv?=
 =?us-ascii?Q?Dh9DPsI0me7SofKStFxdiMn7WcBfv5+67klxIO36EBMpMLgDsrzMbs3XHbh1?=
 =?us-ascii?Q?o97kIqdOsG1m7zav4k/EH3jHYTJndN+Zlad4zrohSJxyh2DynqpSyf1ikfzq?=
 =?us-ascii?Q?IuuOQuJhVuTtKmPq98TYGUlueeMBqWtV5+DO7dIJ9Jf2RyUBveKrYzwzP+mH?=
 =?us-ascii?Q?1o6dMNkskTVRIb49XIE2AuhCiRn4WcUsZUXUhjp9G42D07DHKAM7aBFf3IIP?=
 =?us-ascii?Q?EOWFdPeydVMWlacCQmhhinYXJyawNsQmOkfjk82oh/Jsa8xJqsaTeFurZqCX?=
 =?us-ascii?Q?T56fIgpmb6Rp7OiBwNTxcp9Fx5P0TBtEqnmv5PBbFoFf0+gfjTYqeap5aROq?=
 =?us-ascii?Q?WrfLIMPmZJyQHPVYJfnz25amZQTCxzxmY1F+NRdk7kp8md3kwvufTnjNGEFM?=
 =?us-ascii?Q?NPt+8XMQ96FMQH7nKA38KNdf20lVIL9Z?=
X-Forefront-Antispam-Report:
	CIP:137.201.242.130;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.micron.com;PTR:masquerade.micron.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 10:20:53.1488
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6e8936e-2064-48c7-df67-08dcafb82075
X-MS-Exchange-CrossTenant-Id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f38a5ecd-2813-4862-b11b-ac1d563c806f;Ip=[137.201.242.130];Helo=[mail.micron.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR08MB9197

From: Ajay Joshi <ajay.opensrc@micron.com>

This patch adds the support for aborting the background
operation if one is progress(r3.1 8.2.9.1.5)

"Request Abort Background Operation" command is requested
by the host to cancel an ongoing background operation. When
the command is sent, the device will abort the ongoing
background operation.  When the operation is aborted,
background command status register will maintain a completion
percentage value of less then 100. The "Request Abort
Background Operation" command support has to be advertised in
the Command Effects Log to be honoured.

Tested-by: Tushar Mulgund <tmmulgund@micron.com>
Signed-off-by: Ajay Joshi <ajay.opensrc@micron.com>
---
 hw/cxl/cxl-mailbox-utils.c   | 77 ++++++++++++++++++++++++++++--------
 include/hw/cxl/cxl_device.h  |  1 +
 include/hw/cxl/cxl_mailbox.h |  1 +
 3 files changed, 63 insertions(+), 16 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index c2ed251bb3..43c934f1fc 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -56,6 +56,7 @@ enum {
     INFOSTAT    = 0x00,
         #define IS_IDENTIFY   0x1
         #define BACKGROUND_OPERATION_STATUS    0x2
+        #define REQUEST_ABORT_BACKGROUND_OPERATION  0x5
     EVENTS      = 0x01,
         #define GET_RECORDS   0x0
         #define CLEAR_RECORDS   0x1
@@ -641,6 +642,28 @@ static CXLRetCode cmd_infostat_bg_op_sts(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+/*
+ * CXL r3.1 Section 8.2.9.1.5: Request Background Abort Operation
+ * (Opcode 0005h)
+ */
+static CXLRetCode cmd_infostat_bg_abort_op(const struct cxl_cmd *cmd,
+                                        uint8_t *payload_in,
+                                        size_t len_in,
+                                        uint8_t *payload_out,
+                                        size_t *len_out,
+                                        CXLCCI *cci)
+{
+    if (cci->bg.runtime > 0) {
+        if (cci->bg.abort != true) {
+            cci->bg.abort = true;
+        }
+    } else {
+        return CXL_MBOX_REQUEST_ABORT_NOTSUP;
+    }
+
+    return CXL_MBOX_SUCCESS;
+}
+
 /* CXL r3.1 Section 8.2.9.3.1: Get FW Info (Opcode 0200h) */
 static CXLRetCode cmd_firmware_update_get_info(const struct cxl_cmd *cmd,
                                                uint8_t *payload_in,
@@ -2502,6 +2525,9 @@ static CXLRetCode cmd_dcd_release_dyn_cap(const struct cxl_cmd *cmd,
 }
 
 static const struct cxl_cmd cxl_cmd_set[256][256] = {
+    [INFOSTAT][REQUEST_ABORT_BACKGROUND_OPERATION] = {
+        "REQUEST_ABORT_BACKGROUND_OPERATION",
+        cmd_infostat_bg_abort_op, 0, 0 },
     [EVENTS][GET_RECORDS] = { "EVENTS_GET_RECORDS",
         cmd_events_get_records, 1, 0 },
     [EVENTS][CLEAR_RECORDS] = { "EVENTS_CLEAR_RECORDS",
@@ -2541,7 +2567,8 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
     [SANITIZE][OVERWRITE] = { "SANITIZE_OVERWRITE", cmd_sanitize_overwrite, 0,
         (CXL_MBOX_IMMEDIATE_DATA_CHANGE |
          CXL_MBOX_SECURITY_STATE_CHANGE |
-         CXL_MBOX_BACKGROUND_OPERATION)},
+         CXL_MBOX_BACKGROUND_OPERATION  |
+         CXL_MBOX_REQUEST_ABORT_BACKGROUND_OPERATION)},
     [PERSISTENT_MEM][GET_SECURITY_STATE] = { "GET_SECURITY_STATE",
         cmd_get_security_state, 0, 0 },
     [MEDIA_AND_POISON][GET_POISON_LIST] = { "MEDIA_AND_POISON_GET_POISON_LIST",
@@ -2554,7 +2581,9 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
         "MEDIA_AND_POISON_GET_SCAN_MEDIA_CAPABILITIES",
         cmd_media_get_scan_media_capabilities, 16, 0 },
     [MEDIA_AND_POISON][SCAN_MEDIA] = { "MEDIA_AND_POISON_SCAN_MEDIA",
-        cmd_media_scan_media, 17, CXL_MBOX_BACKGROUND_OPERATION },
+        cmd_media_scan_media, 17,
+        (CXL_MBOX_BACKGROUND_OPERATION |
+        CXL_MBOX_REQUEST_ABORT_BACKGROUND_OPERATION)},
     [MEDIA_AND_POISON][GET_SCAN_MEDIA_RESULTS] = {
         "MEDIA_AND_POISON_GET_SCAN_MEDIA_RESULTS",
         cmd_media_get_scan_media_results, 0, 0 },
@@ -2579,6 +2608,9 @@ static const struct cxl_cmd cxl_cmd_set_sw[256][256] = {
     [INFOSTAT][IS_IDENTIFY] = { "IDENTIFY", cmd_infostat_identify, 0, 0 },
     [INFOSTAT][BACKGROUND_OPERATION_STATUS] = { "BACKGROUND_OPERATION_STATUS",
         cmd_infostat_bg_op_sts, 0, 0 },
+    [INFOSTAT][REQUEST_ABORT_BACKGROUND_OPERATION] = {
+        "REQUEST_ABORT_BACKGROUND_OPERATION",
+        cmd_infostat_bg_abort_op, 0, 0 },
     [TIMESTAMP][GET] = { "TIMESTAMP_GET", cmd_timestamp_get, 0, 0 },
     [TIMESTAMP][SET] = { "TIMESTAMP_SET", cmd_timestamp_set, 8,
                          CXL_MBOX_IMMEDIATE_POLICY_CHANGE },
@@ -2673,6 +2705,24 @@ int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
     return ret;
 }
 
+static void bg_notify_host(CXLCCI *cci)
+{
+    /* TODO: generalize to switch CCI */
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+    CXLDeviceState *cxl_dstate = &ct3d->cxl_dstate;
+    PCIDevice *pdev = PCI_DEVICE(cci->d);
+
+    cci->bg.starttime = 0;
+    /* registers are updated, allow new bg-capable cmds */
+    cci->bg.runtime = 0;
+
+    if (msix_enabled(pdev)) {
+        msix_notify(pdev, cxl_dstate->mbox_msi_n);
+    } else if (msi_enabled(pdev)) {
+        msi_notify(pdev, cxl_dstate->mbox_msi_n);
+    }
+}
+
 static void bg_timercb(void *opaque)
 {
     CXLCCI *cci = opaque;
@@ -2709,24 +2759,19 @@ static void bg_timercb(void *opaque)
     } else {
         /* estimate only */
         cci->bg.complete_pct = 100 * now / total_time;
+        if (cci->bg.abort == true) {
+            uint16_t ret = CXL_MBOX_SUCCESS;
+
+            cci->bg.ret_code = ret;
+            cci->bg.abort = false;
+            bg_notify_host(cci);
+            return;
+        }
         timer_mod(cci->bg.timer, now + CXL_MBOX_BG_UPDATE_FREQ);
     }
 
     if (cci->bg.complete_pct == 100) {
-        /* TODO: generalize to switch CCI */
-        CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
-        CXLDeviceState *cxl_dstate = &ct3d->cxl_dstate;
-        PCIDevice *pdev = PCI_DEVICE(cci->d);
-
-        cci->bg.starttime = 0;
-        /* registers are updated, allow new bg-capable cmds */
-        cci->bg.runtime = 0;
-
-        if (msix_enabled(pdev)) {
-            msix_notify(pdev, cxl_dstate->mbox_msi_n);
-        } else if (msi_enabled(pdev)) {
-            msi_notify(pdev, cxl_dstate->mbox_msi_n);
-        }
+        bg_notify_host(cci);
     }
 }
 
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index dd02adda27..daad578027 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -201,6 +201,7 @@ typedef struct CXLCCI {
         uint64_t starttime;
         /* set by each bg cmd, cleared by the bg_timer when complete */
         uint64_t runtime;
+        bool abort; /*abort if the bg operation is in progress*/
         QEMUTimer *timer;
     } bg;
     size_t payload_max;
diff --git a/include/hw/cxl/cxl_mailbox.h b/include/hw/cxl/cxl_mailbox.h
index beb048052e..a8a6beb712 100644
--- a/include/hw/cxl/cxl_mailbox.h
+++ b/include/hw/cxl/cxl_mailbox.h
@@ -14,5 +14,6 @@
 #define CXL_MBOX_IMMEDIATE_LOG_CHANGE (1 << 4)
 #define CXL_MBOX_SECURITY_STATE_CHANGE (1 << 5)
 #define CXL_MBOX_BACKGROUND_OPERATION (1 << 6)
+#define CXL_MBOX_REQUEST_ABORT_BACKGROUND_OPERATION (1 << 8)
 
 #endif
-- 
2.34.1

