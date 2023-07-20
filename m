Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3949DC0015E
	for <linux-cxl@archiver.kernel.org>; Thu, 20 Jul 2023 20:38:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbjGTUii (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 20 Jul 2023 16:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjGTUih (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 20 Jul 2023 16:38:37 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2058.outbound.protection.outlook.com [40.92.107.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48302271E
        for <linux-cxl@vger.kernel.org>; Thu, 20 Jul 2023 13:38:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MWUXVJEWl2frjECw3/4bYzHXPupcZud7oFZydAXpEpcCEV4i5q0aoEM3ZJNIFIRzO+pSPZzm/aoEHvs1naQy6xO9U/+sfu5J+z3DLAr3bWvr3KpbmZdZYm70SefzEq7Tp40sRaJ7GO52XV+JNRfAT0TyGxH05YLG0gcYnEMjgWqw7yotrdzLwlL3zwDj5O5JfNliURGCYTSz2Hg33Dg1HD01aF/WRguUMR24q0cIhs4yimBTX1RHhzSF9/eq0cY4tXCO/YdAwJI7AhKhLGp3cBpTUmuGfNeYpLgsJWmoKZcqx3CWpXThZAyl//YQ+XHF2p0tX/uWahf3BCvgF0VfBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zc3snFHch0Yog7PbxZY00Kvf0mJgyeR3W6EURrCYLtA=;
 b=BjnMrhmHNw0zuttPLpBjl20Gn4adv8IgG30Cqq+VMngfMMqp4FUFDb9/9MzOXbm6PXF4RH3BETd/mrZd23aodouOBAgEONEvcU7/LP0MK0bIyL6XMbcb/+MhRfjPQtqFauTYx84VDAnieoQHLnH/NU8PZm/tIWz+373IUXgIYxXNO6qpwcJy0KdMG2mtQ4zqUnZC0TCGkyu7q42HVpDR+QGIH/pmA0ixcvD6ZiYW4+mKQm9yJh/LXhs8io6xCfWWeV9TT/35n4JTAUA70j0zf0wHrxnBO37ten31GBMm+vJKkdMruoYaAU8PC9nQAzhRCPSudaS5LdD1jAFwlFsE2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zc3snFHch0Yog7PbxZY00Kvf0mJgyeR3W6EURrCYLtA=;
 b=lLzvTZAfrIMAgl7dylTM7viNJlTsvXTLMSrp3vXEqn2pYDrVC8Qm8lJbknH/bdlAxnkMC8INGfXaHij+L7txGEOTmHnqUHeBujT8u581xO+Ynx7IG9g5xfDIf13ppuNybIIm8Jup0w2gdl0vOikKGa59ZACMkD4qPGg0SfzffqR9wdgqEg7fz2ubC2uJqFZZKNQ+0ebuFF183HmXXEJlBuarJWown8Lthu6rur4rgxwYX0lKzg3IX261q8JUEq1qBPRlUf8oZYmpJN/4UnPg56oDpnwJ54Tt79pajgdTPVwgnw4IsmUDnqpUg8u7URcmIrm+iRRgFsxjliKGDrHoeQ==
Received: from SG2PR06MB3397.apcprd06.prod.outlook.com (2603:1096:4:7a::17) by
 KL1PR0601MB4100.apcprd06.prod.outlook.com (2603:1096:820:24::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Thu, 20 Jul
 2023 20:38:29 +0000
Received: from SG2PR06MB3397.apcprd06.prod.outlook.com
 ([fe80::450:9c8c:9058:c94c]) by SG2PR06MB3397.apcprd06.prod.outlook.com
 ([fe80::450:9c8c:9058:c94c%5]) with mapi id 15.20.6609.024; Thu, 20 Jul 2023
 20:38:29 +0000
From:   nifan@outlook.com
To:     qemu-devel@nongnu.org
Cc:     jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
        gregory.price@memverge.com, hchkuo@avery-design.com.tw,
        cbrowy@avery-design.com, ira.weiny@intel.com,
        dan.j.williams@intel.com, a.manzanares@samsung.com,
        dave@stgolabs.net, nmtadam.samsung@gmail.com,
        Fan Ni <nifan@outlook.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PATCH 1/9] hw/cxl/cxl-mailbox-utils: Add dc_event_log_size field to output payload of identify memory device command
Date:   Thu, 20 Jul 2023 13:37:00 -0700
Message-ID: <SG2PR06MB3397F3E74A083607F7492FA4B23EA@SG2PR06MB3397.apcprd06.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230720203708.25825-1-nifan@outlook.com>
References: <20230720203708.25825-1-nifan@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [ZWUtNriF/S9k+E5ELQxCU4jKTSI1uvfD]
X-ClientProxiedBy: BYAPR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::21) To SG2PR06MB3397.apcprd06.prod.outlook.com
 (2603:1096:4:7a::17)
X-Microsoft-Original-Message-ID: <20230720203708.25825-2-nifan@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3397:EE_|KL1PR0601MB4100:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b7c0c3b-d6db-40e2-e421-08db89612440
X-MS-Exchange-SLBlob-MailProps: quCBMN2EvO/qzAKd82WE1LuLgf/v/GCyttTW/NfaJP+njiN2Q09vijKbf4HcMlm9miLmM8HjhSWih62GlvObcwv7XfEzomJzIejInGrQ9/32FfIqXZsi2IrYdbhqZbmqH1UJv/zQKocXE0zi/YQ5DQ/9WCediFPfpJ+OZhgh5pGkl/xc7iBy+XcNxDDsQBa+9JCmIhzLuGFUfURURAKPSzC4hucOgcXlWDmpuzpMlDb7oP8w1HuKo2o5sywz8DkseRB1aj1GlU9HhSsVJ1OKN10/FArG2CbF/jMF0FBntadwDU5t2t+sx1KZsGXz/MlprtYTf+OCJQeUSrG2A+b9U6TWd6ehRdCkS8nQpMA2i6T3gELkZbXbX3nIiEX/mquUjjRij02ivLKa4rEzYtJYBMw0x9PvQGrkyS8z50NdUi8qmqivcg1insl2NCrzMuaRbcQ587fTvOKsaB7dZGWV1je6uQprhQMoQnafvWtBb0ZNaS3zoTBoyRMaAyerl2G8noWmheF2jl7B4CsvVc+BSRQT0cWGcolucwKXyRXuMCe/VpP8y1Dlk3wz4OuLT3XHQsxDGrOlQ7f8C11AIY8slHTebDP972XvzvIEECL0oSwlKmHJ96pyz0b3bwkZNDxx39o+61R/gI1/VlktTRg5yra/io4ALvuuelGL0pgnDY1TXUGD3vQcuLhDoUhEQpabL/E7loP+WP/eGydtLBb3hg==
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9si9HO14/g6U71kMMZL522i4ryOkDp2K8aZOSiUhb1RnXmDuIAVp5A1igzU8nBpD3ZInyYlRxSxOFMz76iOx0bilBcN09P3Jm8qL9nLqjS9dQZOpXpKglHiTQiuJXfXszJlAm29m0tQNJZGw8M3YIjbmTtbMLVU9ji6lNOr9C/lzNwvModJR2leuJOnwhblhQnQ1jeeJDJBNlAxyYuqdDNIT4ZQbWepbdNxC7Bs6jzZygKLd9RyRBzaVViMC/bgyFYacr9sWz6nSAjpV30rV6QYxLQ8pPQgl2uocknda5lBV7LX4+ac6FgwkyZapJZW14bd5uBq/t4uoQWOT6g+mPBLDW3UPLMVxXBl/0HPsug+LWzq2Lr+soP8S8rLdA7a8n5sbF1UwnvVXAVpzbmBrfduLvACsxURTPxobJP4sazJrOuCByrCihTjf07ycyvByMaWjGnvZSeV9TxXzF/4LtLG+A9qJ+oJPWVqJuex0EVVDIvHofa2cqmtlfIR5bqAIrz5cCXupMXlFrxzUA5VrU4YcoAS5gOvvzEcySWgGnEocCzGT2aalYpO3LyzIt3GY680YmKuL4rzoO5rZCmtSLOPlUWvVkoD+yT0wB/9kcam8EArO28envzhIFHTy5SIQ
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xQEMKXR52+B0vrymMtemDk4mgc7S87hxG4wpo8GnyBrLNKISeCD7RxlUDyBm?=
 =?us-ascii?Q?LK7XEfpVE1kVQ1nJeH6vvXmeoAJ2aP5B41T2gizHfpBNB9tvNJLrvSDpOXrk?=
 =?us-ascii?Q?qc3li4uKaVcwDsQJmGZjvdZkiNJYoT0TMPYCNahI3enW32GELukv7M8yjf8y?=
 =?us-ascii?Q?44l9Ip90B9xLqvU58Dsy0HkQ05FhX83pEuhoFa270cbg8Dxmdsot74TdpKGq?=
 =?us-ascii?Q?699pXRNfq2lbSICmP2cEwR9SRAyofrAZRclhHDyeniCGzDHAvSGjNv9gFoA5?=
 =?us-ascii?Q?OSAoCO/xLrUt56EErjaG1xTAo3VRdu6a4t+x1LWAVP/smOZj48xKKmZqd/TM?=
 =?us-ascii?Q?E/5XBt6Xz70o8IKu//fCBUP0Nd1Vab/cHClBaZOIE8J3urZ+jEUQB5APaNM7?=
 =?us-ascii?Q?rUjKT5bh7oYylJHMqrNS3xEvy/ifTebAwmuGgIGnJkiEh3ISOTEnQON15cca?=
 =?us-ascii?Q?sWV2EKU7vdCWHT+3LV5gOBhJBl0yHJIvydWNNxQyaHEjiKcWZmdUT0Iymcch?=
 =?us-ascii?Q?24Vs+9CAC8VVg9OeoQwKrcmFitA/fDoTVYT4slPSdzXgGBxF1STAvp2wLWAM?=
 =?us-ascii?Q?r3eRBBXdP2Nh3kowQZEoGLNgREPGkZ4G8uQe7uYSNsIKRGvcMTsshRsFi4gO?=
 =?us-ascii?Q?eNDRE9QafMKDcGwzYPkhqTs/fAvcwOGfSnY+nOgK7n0q084WSLa1CZn9znJS?=
 =?us-ascii?Q?x5G0yAD1PnkKcrdhvoTTPr+s0AwJjNBiFaibgI9TPQJ8d0MWtWo4FtqhjmGr?=
 =?us-ascii?Q?NK4IjNVWGTxrwVY2WUJuU8kQjC3hWzTTJR2WY+JOlC3Yp5V0HR9jxHnG2a+y?=
 =?us-ascii?Q?dFuN7AbR9HkKMw3iMAcn/zOTb3PH5Fsk0LAMJSKSy7awhIbTUkw5mgbGfYVZ?=
 =?us-ascii?Q?OdG2daWqHozHulXBsi4QHn5pRWE/uXqIKAUA67DFBK/InqdisN4wNRgIW/FJ?=
 =?us-ascii?Q?3mWlAMEPzj0UJUJ3z631mqh0AFMlFSmP0FN129RPiiz3sZwvxydRj5vFitGE?=
 =?us-ascii?Q?rJtzYe78e72SUhOqLK1n0lz2N3i8GqKVbXTJ055TOarUsKRjT0PjcO0J10Jb?=
 =?us-ascii?Q?JKzKJPXz4WKE/0c8RF78Vw5fTC6yYzkcGwtgyS0gvdgteoM/whxuiJDthKO3?=
 =?us-ascii?Q?rHJ6EOs8WWPqoPXONkNM9q3hsOW2GaDYKZ5H6EJAHNIeQnthQgYpUCBoTNtW?=
 =?us-ascii?Q?etCHf8ComZmssTfcK5iZFMcBsPH/fgBM4gIKWw=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b7c0c3b-d6db-40e2-e421-08db89612440
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3397.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 20:37:31.8432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4100
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Fan Ni <nifan@outlook.com>

Based on CXL spec 3.0 Table 8-94 (Identify Memory Device Output
Payload), dynamic capacity event log size should be part of
output of the Identify command.
Add dc_event_log_size to the output payload for the host to get the info.

Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index ad7a6116e4..b013e30314 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -21,6 +21,8 @@
 #include "sysemu/hostmem.h"
 
 #define CXL_CAPACITY_MULTIPLIER   (256 * MiB)
+/* Experimental value: dynamic capacity event log size */
+#define CXL_DC_EVENT_LOG_SIZE 8
 
 /*
  * How to add a new command, example. The command set FOO, with cmd BAR.
@@ -519,8 +521,9 @@ static CXLRetCode cmd_identify_memory_device(struct cxl_cmd *cmd,
         uint16_t inject_poison_limit;
         uint8_t poison_caps;
         uint8_t qos_telemetry_caps;
+        uint16_t dc_event_log_size;
     } QEMU_PACKED *id;
-    QEMU_BUILD_BUG_ON(sizeof(*id) != 0x43);
+    QEMU_BUILD_BUG_ON(sizeof(*id) != 0x45);
 
     CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
     CXLType3Class *cvc = CXL_TYPE3_GET_CLASS(ct3d);
@@ -543,6 +546,7 @@ static CXLRetCode cmd_identify_memory_device(struct cxl_cmd *cmd,
     st24_le_p(id->poison_list_max_mer, 256);
     /* No limit - so limited by main poison record limit */
     stw_le_p(&id->inject_poison_limit, 0);
+    stw_le_p(&id->dc_event_log_size, CXL_DC_EVENT_LOG_SIZE);
 
     *len = sizeof(*id);
     return CXL_MBOX_SUCCESS;
-- 
2.39.2

