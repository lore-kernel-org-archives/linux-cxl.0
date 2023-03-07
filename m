Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A9A4C742A7
	for <linux-cxl@archiver.kernel.org>; Tue,  7 Mar 2023 08:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjCGIUL (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 7 Mar 2023 03:20:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbjCGITt (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 7 Mar 2023 03:19:49 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667BC4FF35
        for <linux-cxl@vger.kernel.org>; Tue,  7 Mar 2023 00:19:30 -0800 (PST)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230307081927epoutp028084868cadac39ad48c6d8e066a59edb~KFT4bctY-0959209592epoutp02Z
        for <linux-cxl@vger.kernel.org>; Tue,  7 Mar 2023 08:19:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230307081927epoutp028084868cadac39ad48c6d8e066a59edb~KFT4bctY-0959209592epoutp02Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1678177167;
        bh=Ll/mV2/avNgcA01Rk0ybYYBeA3ug2+bwDroZZOjjMOc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T63XLJ7oDZL/d65lewCriBkTl1z4dTJLlWMPHqzzq1x9EdN7HNbSCQBErsS9wzUPY
         KpjkL/TmS6clUNd68SWUyGZ6cAndqIB1Elt/svewB2f5j2yIpN1EZuZ00/rDCO5LmG
         VR+Ke2ySIoR0M8ZU8RpKBsADynwY/5TRPxHyidVM=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20230307081926epcas2p1ffa2f81fe35309d0c0dcd8db6549942a~KFT3xR6af1880718807epcas2p1x;
        Tue,  7 Mar 2023 08:19:26 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.90]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4PW7dp2BTMz4x9Q0; Tue,  7 Mar
        2023 08:19:26 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        F0.11.08750.E83F6046; Tue,  7 Mar 2023 17:19:26 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20230307081925epcas2p1c94af34f67c1f18efc428a5aeef9037e~KFT23Yxjv0867608676epcas2p16;
        Tue,  7 Mar 2023 08:19:25 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230307081925epsmtrp2457ad985b267168fecfdd5aff2a15419~KFT22qy7W0621606216epsmtrp2h;
        Tue,  7 Mar 2023 08:19:25 +0000 (GMT)
X-AuditID: b6c32a47-f8935a800000222e-9e-6406f38e71d2
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        39.22.18071.D83F6046; Tue,  7 Mar 2023 17:19:25 +0900 (KST)
Received: from dell-Precision-7920-Tower.dsn.sec.samsung.com (unknown
        [10.229.83.133]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230307081925epsmtip24ad9057431bc041f2c1ed204cb2e0359~KFT2oScj-3041430414epsmtip2a;
        Tue,  7 Mar 2023 08:19:25 +0000 (GMT)
From:   Jehoon Park <jehoon.park@samsung.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, alison.schofield@intel.com,
        bwidawsk@kernel.org, jehoon park <jehoon.park@samsung.com>
Subject: [ndctl patch RFC 1/2] libcxl: add accessors for IDENTIFY command
Date:   Tue,  7 Mar 2023 17:21:01 +0900
Message-Id: <20230307082102.27195-2-jehoon.park@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230307082102.27195-1-jehoon.park@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGKsWRmVeSWpSXmKPExsWy7bCmqW7fZ7YUg9lzuC3uPr7AZtE8eTGj
        xfSpFxgt9j99zmJx4HUDu8X5WadYLG5NOMbkwO6xeM9LJo9NqzrZPPq2rGL0+LxJLoAlKtsm
        IzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJxSdA1y0zB+gCJYWyxJxS
        oFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BeYFecWJucWleul5eaomVoYGBkSlQYUJ2xp3f
        ugU3dSsWL/nC2sD4Ur2LkZNDQsBE4sv/7UxdjFwcQgI7GCUuvVjNCOF8YpQ4s/I2C4TzjVHi
        79/fzDAt/+btBbOFBPYySpz/kQ1R1M0ksWf7dDaQBJuAtsT97RvAbBEBWYnmdQ/AdjALLGeU
        WLz/J1i3sICnxOzebkYQm0VAVaJj7kcmEJtXwEZi1b2/UNvkJVZvOABmcwrYSqx81skGMkhC
        YB+7xLSWA2wQRS4SJw59YoewhSVeHd8CZUtJfH63F6omX+LnyVusEHaBxKcvH1ggbGOJdzef
        A8U5gK7TlFi/Sx/ElBBQljhyC6yCWYBPouPwX3aIMK9ER5sQRKOqRNfxD4wQtrTE4StHoS72
        kPh9/AI0SCcwSiw4uZN1AqPcLIQFCxgZVzGKpRYU56anFhsVGMMjLDk/dxMjOIFpue9gnPH2
        g94hRiYOxkOMEhzMSiK8b9+xpQjxpiRWVqUW5ccXleakFh9iNAWG3URmKdHkfGAKzSuJNzSx
        NDAxMzM0NzI1MFcS55W2PZksJJCeWJKanZpakFoE08fEwSnVwORxl8di/u8pfCc6eypWRlkH
        PUz9ffWXuKB5S0Hv/hYGx03vYvcVbGWdvc898AmXt4j0S36p5tMiuZsvKtSvFTv+dYnXRv+6
        eQdmfjePmmZgySu1Jf6B78z1WVa+rw8+kts3R6DNqPCpxF0p7xcePAINa2IO7tea0LBIyv5M
        gti8trWfv6Z/7Zi5Tf3HttXVOrtzayxeJZ86Y9N01Lln8pU1P4+8P3Vq9/6Pj2Q9rkXe31jh
        LLhFUmBR8qPjNTcXZDFO0tL4t121f7uFYBn/rPquy33XS66fyHKfd+2t6V/5L3azLoop/q20
        iP1x1X9NC7Phu7PCD0N7qjp3nNutMuFMpzJD+am397ZsnHTC9pSeEktxRqKhFnNRcSIApADL
        5ukDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprILMWRmVeSWpSXmKPExsWy7bCSvG7vZ7YUg4l3DC3uPr7AZtE8eTGj
        xfSpFxgt9j99zmJx4HUDu8X5WadYLG5NOMbkwO6xeM9LJo9NqzrZPPq2rGL0+LxJLoAlissm
        JTUnsyy1SN8ugSvjzm/dgpu6FYuXfGFtYHyp3sXIySEhYCLxb95e5i5GLg4hgd2MEocbelgg
        EtIS95qvsEPYwhL3W46wQhR1Mkns2DKFDSTBJqAtcX/7BjBbREBWonndAyYQm1lgLaPEuTZh
        EFtYwFNidm83I4jNIqAq0TH3I1gNr4CNxKp7f5khFshLrN5wAMzmFLCVWPmsE2ymEFBN48al
        bBMY+RYwMqxilEwtKM5Nzy02LDDMSy3XK07MLS7NS9dLzs/dxAgONS3NHYzbV33QO8TIxMF4
        iFGCg1lJhPftO7YUId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rwXuk7GCwmkJ5akZqemFqQWwWSZ
        ODilGpgavLXXvBPzO81nFJTjuj952kS+9N9NmlWHLM1dfhqtWf3KeZ793szKnzacTvryf6dP
        sNt9d+b9bWrB58X1fJdoNx/0XbegnC/C/Me0Y+VRCt3l0b5Gf6VOPIrJiV1uZZLHdC3bWXpK
        nXNhziwnTyXhlbePB/32sFS/GWutM6GgNuqOZb3C1j/KTgEsQq3rJ+Uu69iU9ftGRkrddOZP
        8/atqfyW3WVYkJbt7scTeJfxyPTL749/3Hdg1ZH7xYocZ+c5fZ4qaxTvt226g9dTh6ep286t
        OZjoWZT8S3vFsx/Be6wUd8gelrnH4nhX4NeLA9byImlGl42UWk4VbX4l0GW5QUQ/S23xzMmH
        7qluf6rEUpyRaKjFXFScCABXMVYmpAIAAA==
X-CMS-MailID: 20230307081925epcas2p1c94af34f67c1f18efc428a5aeef9037e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230307081925epcas2p1c94af34f67c1f18efc428a5aeef9037e
References: <20230307082102.27195-1-jehoon.park@samsung.com>
        <CGME20230307081925epcas2p1c94af34f67c1f18efc428a5aeef9037e@epcas2p1.samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: jehoon park <jehoon.park@samsung.com>

Add accessors to retrieve event log size, poison list size,
inject poison limit, poison handling capabilities and QoS
telemetry capabilities from output payload of IDENTIFY command.

Signed-off-by: jehoon park <jehoon.park@samsung.com>
---
 cxl/lib/libcxl.c   | 73 ++++++++++++++++++++++++++++++++++++++++++++++
 cxl/lib/libcxl.sym | 11 +++++++
 cxl/lib/private.h  | 11 +++++++
 cxl/libcxl.h       | 16 ++++++++++
 4 files changed, 111 insertions(+)

diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
index 59e5bdb..12d8e63 100644
--- a/cxl/lib/libcxl.c
+++ b/cxl/lib/libcxl.c
@@ -3775,6 +3775,79 @@ cxl_cmd_identify_get_persistent_only_size(struct cxl_cmd *cmd)
 	return cxl_capacity_to_bytes(c->persistent_capacity);
 }
 
+CXL_EXPORT int
+cxl_cmd_identify_get_event_log_size(struct cxl_cmd *cmd,
+				    enum cxl_identify_event event)
+{
+	struct cxl_cmd_identify *id =
+		(struct cxl_cmd_identify *)cmd->send_cmd->out.payload;
+	int rc = cxl_cmd_validate_status(cmd, CXL_MEM_COMMAND_ID_IDENTIFY);
+	if (rc)
+		return rc;
+
+	switch (event) {
+	case CXL_IDENTIFY_INFO:
+		return le16_to_cpu(id->info_event_log_size);
+	case CXL_IDENTIFY_WARN:
+		return le16_to_cpu(id->warning_event_log_size);
+	case CXL_IDENTIFY_FAIL:
+		return le16_to_cpu(id->failure_event_log_size);
+	case CXL_IDENTIFY_FATAL:
+		return le16_to_cpu(id->fatal_event_log_size);
+	default:
+		return -EINVAL;
+	}
+}
+
+CXL_EXPORT int cxl_cmd_identify_get_poison_list_max(struct cxl_cmd *cmd)
+{
+	unsigned int max_records = 0;
+	struct cxl_cmd_identify *id =
+		(struct cxl_cmd_identify *)cmd->send_cmd->out.payload;
+	int rc = cxl_cmd_validate_status(cmd, CXL_MEM_COMMAND_ID_IDENTIFY);
+	if (rc)
+		return rc;
+
+	for (int i = 0; i < 3; i++)
+		max_records += id->poison_list_max_mer[i] << (8 * i);
+
+	return max_records;
+}
+
+CXL_EXPORT int cxl_cmd_identify_get_inject_poison_limit(struct cxl_cmd *cmd)
+{
+	cmd_get_field_u16(cmd, identify, IDENTIFY, inject_poison_limit);
+}
+
+CXL_EXPORT int cxl_cmd_identify_injects_persistent_poison(struct cxl_cmd *cmd)
+{
+	cmd_get_field_u8_mask(
+		cmd, identify, IDENTIFY, poison_caps,
+		CXL_CMD_IDENTIFY_POISON_HANDLING_CAPABILITIES_INJECTS_PERSISTENT_POISON);
+}
+
+CXL_EXPORT int cxl_cmd_identify_scans_for_poison(struct cxl_cmd *cmd)
+{
+	cmd_get_field_u8_mask(
+		cmd, identify, IDENTIFY, poison_caps,
+		CXL_CMD_IDENTIFY_POISON_HANDLING_CAPABILITIES_SCANS_FOR_POISON);
+}
+
+CXL_EXPORT int cxl_cmd_identify_egress_port_congestion(struct cxl_cmd *cmd)
+{
+	cmd_get_field_u8_mask(
+		cmd, identify, IDENTIFY, qos_telemetry_caps,
+		CXL_CMD_IDENTIFY_QOS_TELEMETRY_CAPABILITIES_EGRESS_PORT_CONGESTION);
+}
+
+CXL_EXPORT int
+cxl_cmd_identify_temporary_throughput_reduction(struct cxl_cmd *cmd)
+{
+	cmd_get_field_u8_mask(
+		cmd, identify, IDENTIFY, qos_telemetry_caps,
+		CXL_CMD_IDENTIFY_QOS_TELEMETRY_CAPABILITIES_TEMPORARY_THROUGHPUT_REDUCTION);
+}
+
 CXL_EXPORT struct cxl_cmd *cxl_cmd_new_raw(struct cxl_memdev *memdev,
 		int opcode)
 {
diff --git a/cxl/lib/libcxl.sym b/cxl/lib/libcxl.sym
index 1c6177c..2bd209e 100644
--- a/cxl/lib/libcxl.sym
+++ b/cxl/lib/libcxl.sym
@@ -249,3 +249,14 @@ global:
 	cxl_decoder_create_ram_region;
 	cxl_region_get_daxctl_region;
 } LIBCXL_4;
+
+LIBCXL_6 {
+global:
+	cxl_cmd_identify_get_event_log_size;
+	cxl_cmd_identify_get_poison_list_max;
+	cxl_cmd_identify_get_inject_poison_limit;
+	cxl_cmd_identify_injects_persistent_poison;
+	cxl_cmd_identify_scans_for_poison;
+	cxl_cmd_identify_egress_port_congestion;
+	cxl_cmd_identify_temporary_throughput_reduction;
+} LIBCXL_5;
diff --git a/cxl/lib/private.h b/cxl/lib/private.h
index d648992..aab1552 100644
--- a/cxl/lib/private.h
+++ b/cxl/lib/private.h
@@ -211,6 +211,17 @@ struct cxl_cmd_identify {
 	u8 qos_telemetry_caps;
 } __attribute__((packed));
 
+/* CXL 3.0 8.2.9.8.1.1 Identify Memory Device Poison Handling Capabilities */
+#define CXL_CMD_IDENTIFY_POISON_HANDLING_CAPABILITIES_INJECTS_PERSISTENT_POISON \
+	BIT(0)
+#define CXL_CMD_IDENTIFY_POISON_HANDLING_CAPABILITIES_SCANS_FOR_POISON BIT(1)
+
+/* CXL 3.0 8.2.9.8.1.1 Identify Memory Device QoS Telemetry Capabilities */
+#define CXL_CMD_IDENTIFY_QOS_TELEMETRY_CAPABILITIES_EGRESS_PORT_CONGESTION \
+	BIT(0)
+#define CXL_CMD_IDENTIFY_QOS_TELEMETRY_CAPABILITIES_TEMPORARY_THROUGHPUT_REDUCTION \
+	BIT(1)
+
 struct cxl_cmd_get_lsa_in {
 	le32 offset;
 	le32 length;
diff --git a/cxl/libcxl.h b/cxl/libcxl.h
index 54d9f10..1856bee 100644
--- a/cxl/libcxl.h
+++ b/cxl/libcxl.h
@@ -334,6 +334,22 @@ unsigned long long cxl_cmd_identify_get_volatile_only_size(struct cxl_cmd *cmd);
 unsigned long long cxl_cmd_identify_get_persistent_only_size(struct cxl_cmd *cmd);
 unsigned long long cxl_cmd_identify_get_partition_align(struct cxl_cmd *cmd);
 unsigned int cxl_cmd_identify_get_label_size(struct cxl_cmd *cmd);
+
+enum cxl_identify_event {
+	CXL_IDENTIFY_INFO,
+	CXL_IDENTIFY_WARN,
+	CXL_IDENTIFY_FAIL,
+	CXL_IDENTIFY_FATAL,
+};
+
+int cxl_cmd_identify_get_event_log_size(struct cxl_cmd *cmd,
+					enum cxl_identify_event event);
+int cxl_cmd_identify_get_poison_list_max(struct cxl_cmd *cmd);
+int cxl_cmd_identify_get_inject_poison_limit(struct cxl_cmd *cmd);
+int cxl_cmd_identify_injects_persistent_poison(struct cxl_cmd *cmd);
+int cxl_cmd_identify_scans_for_poison(struct cxl_cmd *cmd);
+int cxl_cmd_identify_egress_port_congestion(struct cxl_cmd *cmd);
+int cxl_cmd_identify_temporary_throughput_reduction(struct cxl_cmd *cmd);
 struct cxl_cmd *cxl_cmd_new_get_health_info(struct cxl_memdev *memdev);
 int cxl_cmd_health_info_get_maintenance_needed(struct cxl_cmd *cmd);
 int cxl_cmd_health_info_get_performance_degraded(struct cxl_cmd *cmd);
-- 
2.17.1

