Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47971EB64DD
	for <linux-cxl@archiver.kernel.org>; Thu, 20 Jul 2023 20:38:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjGTUij (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 20 Jul 2023 16:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjGTUij (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 20 Jul 2023 16:38:39 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2058.outbound.protection.outlook.com [40.92.107.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E968D1731
        for <linux-cxl@vger.kernel.org>; Thu, 20 Jul 2023 13:38:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fhqe5WwifhNAEfA/zRqXb6DYXC3sH/iRcIP2L4nznXvhMYtKY8D1Ohc5gousEd/YnNFd0ran+e3EAFAsu1l+POSUHcwqf0SIyZ8BZq47MlS0D2xt+cS4jIp1k8L8LlfYnkriKcsT13pD//MPlnq8JL7pg1KI+2kTSdpiciwuMPjhwhUPlmPjloHn5hYzHAb8CrJYVq7lKC+meDbjuDOX2bCg02MA+PHn/7hrsphZxjvL5wf31/3569hyXRTOpB5Vt3sTO1HtA5gyn5lBo0KPC2DKKQuUd77FRZ9y0WtmrYFRdIfawwmrfvczh9JdLc+sTUfRpYGXpuHHXGCZ9urvtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p1Ls8RaUR8iOs9aFBBtVavJgh3k6/iM7CXqLOqQfHho=;
 b=TJgn+6/dUP5S6kxP2pv14gKc/j7nlUPr/NqRUhzlQ8XclkMsvraQc08Bh9KFg8FcoS1asEj+xwMh8koL2LKnjFLM/SYevyorKeedE4GaLKCfrZNf15kS6R+9k+hE9ix/vhOm62d5bK7lubxNwMuuAEpSGlC5E30UdtELhPfZg3ws8lkldDBxzXbItOX4C3uwUqOS8GqFciXeG2FG3foD7ZKzBmqV0febs37sxL3w+YvjR8BXT0Ipkrx+AZLni+v1C/kQIN+Cjn+mHz+3rtV953dj8PIh7k4wVFD5Eyfm5vagY4RFK+/dV1JS6zv/fDM91EW2KNMp1II5PA37SiKGRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p1Ls8RaUR8iOs9aFBBtVavJgh3k6/iM7CXqLOqQfHho=;
 b=NHAGkTE7f0ie4jflXGZmEsyrJZYjjKEf59pAybk3zeV5eIDZfD4ROfZxPlQhvqUHxZZFWkoywcdRasiT0JAmdYXHy2D1mI6DkK8fDmr6Vf8nfxVzxPwL8Tk2fxCIxg8v9m7oTz9Z+2T/8zOeTgfbg8RPOTGC6tlJCxP/lB5d/yj097xJ6bFbD4I3LWGU7oAN/XrhuMAISyZzFuvIfq86fhc1W6huQNB37F3YnnlVBU9VZ3+w2+QBYchRCyDqPQNzgbrAHdjI7y0jWJVWC68QzY7MUJvvIOSKwkrVFM0DG2RB9iGFyfjbVN7PJQ7KPVG9moVEmuMhhOhWXOPnFB3wdQ==
Received: from SG2PR06MB3397.apcprd06.prod.outlook.com (2603:1096:4:7a::17) by
 KL1PR0601MB4100.apcprd06.prod.outlook.com (2603:1096:820:24::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Thu, 20 Jul
 2023 20:38:30 +0000
Received: from SG2PR06MB3397.apcprd06.prod.outlook.com
 ([fe80::450:9c8c:9058:c94c]) by SG2PR06MB3397.apcprd06.prod.outlook.com
 ([fe80::450:9c8c:9058:c94c%5]) with mapi id 15.20.6609.024; Thu, 20 Jul 2023
 20:38:30 +0000
From:   nifan@outlook.com
To:     qemu-devel@nongnu.org
Cc:     jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
        gregory.price@memverge.com, hchkuo@avery-design.com.tw,
        cbrowy@avery-design.com, ira.weiny@intel.com,
        dan.j.williams@intel.com, a.manzanares@samsung.com,
        dave@stgolabs.net, nmtadam.samsung@gmail.com,
        Fan Ni <nifan@outlook.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PATCH 3/9] include/hw/cxl/cxl_device: Rename mem_size as static_mem_size for type3 memory devices
Date:   Thu, 20 Jul 2023 13:37:02 -0700
Message-ID: <SG2PR06MB3397A2B9E035B1CA15C0C0F6B23EA@SG2PR06MB3397.apcprd06.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230720203708.25825-1-nifan@outlook.com>
References: <20230720203708.25825-1-nifan@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [vAKZQcoDvyBdDGL92Wqx4vXCLo+YG/1/]
X-ClientProxiedBy: BYAPR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::21) To SG2PR06MB3397.apcprd06.prod.outlook.com
 (2603:1096:4:7a::17)
X-Microsoft-Original-Message-ID: <20230720203708.25825-4-nifan@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3397:EE_|KL1PR0601MB4100:EE_
X-MS-Office365-Filtering-Correlation-Id: 4320e7b0-b47e-46ff-26b6-08db89612887
X-MS-Exchange-SLBlob-MailProps: quCBMN2EvO/qzAKd82WE1LuLgf/v/GCyfCN3eiEvalunYMK4N9yliiWxkhPIwJNy+TfDmzQCvhqgkpCJ3BGxzkL0IIqUs3zNwVyqQ7FfV9ueVkLGLitN/HsXVLCPZxXm2lOJNp/b/s25KdgeS06pYufuxafwPYddkMFrrEp/Dsnck08bQjgu7W2VOKoWfB0RrlPAOzlDmbbu6PpwgqwQWfis2P9eiGVoBh8SkEOif9X0MtdB7jZTI7KvLhS6B1uRZYU/dQ8Fg9la7FJNrMNEmxSvAVdXxDEUbxyKkCeZphldsqOGtYUwn6yLkCb6FjS2c8pVGzSZJCJK3ADnsE0tAD4Fuwkn+QCP3yY6Bdt0KE/908kLo7TQddFO9xGKEAOdRVGBpAMJnoCMvIB7m2oKdWjahbEbqTpg1kFTgsA98LJUuqhC8kNrhNb+Lg9TMV1ZDqQswONPeayP6Sbob7SUJx3RoGMBww0KdwihKWioL8OT1fhZLIjpM4EtbtNyQQ7sCMapL/SAQOe1Ib9r1BCbpiw22DeIytKS2WZgYGXtLgkE3jNpim2gdrhPXUWWAUqlfXeCyNu1LhtVRi6zqMvBvK5erA3VVy6TJeuj0l3IHAVWDH0q5XfgiLivWXczHYkSYU6RLYqgDJVotxe5GLfxqzvz8sGZqbv1ceXboYv3hjBDyn3iczTji7Fu12Iwp2P/Y0g7AanYCpzm2fS95J2qvA==
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tMHaSwdf3Pzcn4/hfRARAzraO6dhCRLn4/dCsalFeHnoPeBcsVABvvFy8wJN6tyTVEQ3D+3KkLeAQgBwPJ97XCiBkK8ATnHK6xGG+Uy02OC8mUdPNGGaUuAoUiA+cfXNzO/a4Mc09IG8lwZIdRBWZ5+VR4ypydP4qh50LuommglV6Ji9umMuQsO6zRZBKCOqd33efOwwqUl8L5kEJcm7RjHpNVlYf8wVny7xqXqvx26Drk8YmIjjwB6YuylyB2b09IEC/tMdQOH2AGTsH1j1QJZ3GDsnwPWjTl7Qb1tjkzKTPLtEorzrv+b0kZHUHmU/fZ6LI7V3Pf7tubdj5gXQWEARNChiAKLA9G75rY5XxWy/ReeNCHlMKHArJ6g8SLTdodeTKimE95B3ZUVErAJRujsvNr8h8NczZjRhrReb4Y/7e1Eax9+UkcjFQgt8PXksMr1Baj8jS0FWAuNmuUg6mXCK/tW+bUQ+1yuEYhM4cdWWdgxDEzT7EMPe2p9Z481VwaNMQ3eyJzhdoOSKT/RHjl08hI2kSckuhjcq+Whe344RBg/DmNsxRclfoZmAEe53/mCL8Sv96PZonH727ZDMOkKQ59GWxcTf10pwB8XjAcY7/vO7IZ5JYJtKSYnC/P9f
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+ovWXiLCZ5PKa/xCCNINiSg23le/WvWg+GqsyKYIBGT3+t4HZ6xpJ6FwzfPu?=
 =?us-ascii?Q?JqkoCWEphF+ts1sWYSuwRRJ/U/mSe2QsFZpys2rBXr4XdyeePyaD4ugLXhrs?=
 =?us-ascii?Q?wFaaWHrYe+SWtFBVaPORrkwRhHCty/d2L0xw/gwKxUTuFTB53+WULeqDbJhd?=
 =?us-ascii?Q?Jeth08PAskJbtVItSDbGQVpg9kDeP7Kd5AGBETjdsuh6FARZsSCqNm/muZfN?=
 =?us-ascii?Q?JQGf9UAHbSfJepdUMnuLSq7R8MnmbOIDwnRzmIxBSC4OdQoadzt02uFdXbAM?=
 =?us-ascii?Q?nY9GuAOHO4/bt2BicGzdYZw0w2yDIeOXGA/d7ZumjPU+wHhgu5N3izQ/7Zv2?=
 =?us-ascii?Q?EhBAZMWbZQgcVGmzI2GWHxONDYioU6SLHUeVf8vzMlKZ5qsMgdpzISO0QKzb?=
 =?us-ascii?Q?oGPRUzXF9X7ausqeEpSF+YdR+rlhI23AQBqacOCo7lLkqXTgf+x1EfsRjH1S?=
 =?us-ascii?Q?MhA2k6LecrA/KVCu0dEXCxBMBU0HwzgNjdj941lnqGWpjmmKz1nzqoP2qDIf?=
 =?us-ascii?Q?1CJEbttCOZmkDrRFFdrPzdpgN+tlFhS17sPqdidFRqTRoqsmcPoyUoSpdM6o?=
 =?us-ascii?Q?wR3GQ1WD41bQfXghFLQBGt2KM8cYKKGdjBHhyYGHJs8GwYy+SiGG5EWtbz8P?=
 =?us-ascii?Q?XuMxJU3J8AXIioWWPn0Yxjt/pizMmsZ7DbZnvQDtB6/M/qszKKp6GSBgt6rV?=
 =?us-ascii?Q?pZ/bByeQnG6kJ7o3nNXl2f5C+fHW8kmVnKUyIRLPMXqWvWmk27/y+e3S2R9A?=
 =?us-ascii?Q?EPyOWcveNuKLOUzRjvbkjxqioVkR1G9FJgOrN17bnDCTMLBVWoWAtwT+M7Tz?=
 =?us-ascii?Q?MRYVbJIexTqHizPWYWjRaF6jYshl+03tCYeLJqJDVTKK4PD0rBL4h6QefJ/p?=
 =?us-ascii?Q?M+xUSUzes2rRO0LPIGT+QfWmwghqmAXI0jtFH3AIYuX69YAfjOKGF4wwhUgE?=
 =?us-ascii?Q?AYJAfnlNh1ABTTMtDTHd6/127GbGYZnZhPZm7uZJvpSwxCBphm/NZObKNGxf?=
 =?us-ascii?Q?89y3QHRjp1/8wrB0y+T3JiyekmCeYpoStSs2u0/fsUhng9oxH13d3CycqM93?=
 =?us-ascii?Q?eFpg6lF5XZ8JMOp1gpyzVm7tT3PJM2CS0haaPNYOWq4RYPAmQYHT8XDlOSaQ?=
 =?us-ascii?Q?RzvlpBU76qrOf9H/nNTqHe8MaRkPunWulJUTtRIpGdYeLm+LDBmrHRYl9rX+?=
 =?us-ascii?Q?AVtaP9/jQVPJXpZSZ5ElhQWSWsMGZE4pdeUrzw=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4320e7b0-b47e-46ff-26b6-08db89612887
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3397.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 20:37:39.0356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4100
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Fan Ni <nifan@outlook.com>

Rename mem_size as static_mem_size for type3 memdev to cover static RAM and
pmem capacity, preparing for the introduction of dynamic capacity to support
dynamic capacity devices.

Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c  | 5 +++--
 hw/mem/cxl_type3.c          | 8 ++++----
 include/hw/cxl/cxl_device.h | 2 +-
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 41e43ec231..59d57ae245 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -540,7 +540,8 @@ static CXLRetCode cmd_identify_memory_device(struct cxl_cmd *cmd,
 
     snprintf(id->fw_revision, 0x10, "BWFW VERSION %02d", 0);
 
-    stq_le_p(&id->total_capacity, cxl_dstate->mem_size / CXL_CAPACITY_MULTIPLIER);
+    stq_le_p(&id->total_capacity,
+            cxl_dstate->static_mem_size / CXL_CAPACITY_MULTIPLIER);
     stq_le_p(&id->persistent_capacity, cxl_dstate->pmem_size / CXL_CAPACITY_MULTIPLIER);
     stq_le_p(&id->volatile_capacity, cxl_dstate->vmem_size / CXL_CAPACITY_MULTIPLIER);
     stl_le_p(&id->lsa_size, cvc->get_lsa_size(ct3d));
@@ -879,7 +880,7 @@ static CXLRetCode cmd_media_clear_poison(struct cxl_cmd *cmd,
     struct clear_poison_pl *in = (void *)cmd->payload;
 
     dpa = ldq_le_p(&in->dpa);
-    if (dpa + CXL_CACHE_LINE_SIZE > cxl_dstate->mem_size) {
+    if (dpa + CXL_CACHE_LINE_SIZE > cxl_dstate->static_mem_size) {
         return CXL_MBOX_INVALID_PA;
     }
 
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 862107c5ef..237b544b9c 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -748,7 +748,7 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
         }
         address_space_init(&ct3d->hostvmem_as, vmr, v_name);
         ct3d->cxl_dstate.vmem_size = memory_region_size(vmr);
-        ct3d->cxl_dstate.mem_size += memory_region_size(vmr);
+        ct3d->cxl_dstate.static_mem_size += memory_region_size(vmr);
         g_free(v_name);
     }
 
@@ -771,7 +771,7 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
         }
         address_space_init(&ct3d->hostpmem_as, pmr, p_name);
         ct3d->cxl_dstate.pmem_size = memory_region_size(pmr);
-        ct3d->cxl_dstate.mem_size += memory_region_size(pmr);
+        ct3d->cxl_dstate.static_mem_size += memory_region_size(pmr);
         g_free(p_name);
     }
 
@@ -984,7 +984,7 @@ static int cxl_type3_hpa_to_as_and_dpa(CXLType3Dev *ct3d,
         return -EINVAL;
     }
 
-    if (*dpa_offset > ct3d->cxl_dstate.mem_size) {
+    if (*dpa_offset > ct3d->cxl_dstate.static_mem_size) {
         return -EINVAL;
     }
 
@@ -1142,7 +1142,7 @@ static bool set_cacheline(CXLType3Dev *ct3d, uint64_t dpa_offset, uint8_t *data)
         return false;
     }
 
-    if (dpa_offset + CXL_CACHE_LINE_SIZE > ct3d->cxl_dstate.mem_size) {
+    if (dpa_offset + CXL_CACHE_LINE_SIZE > ct3d->cxl_dstate.static_mem_size) {
         return false;
     }
 
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index bf564f4a0b..a32ee6d6ba 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -209,7 +209,7 @@ typedef struct cxl_device_state {
     } timestamp;
 
     /* memory region size, HDM */
-    uint64_t mem_size;
+    uint64_t static_mem_size;
     uint64_t pmem_size;
     uint64_t vmem_size;
 
-- 
2.39.2

