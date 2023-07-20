Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61711C0015E
	for <linux-cxl@archiver.kernel.org>; Thu, 20 Jul 2023 20:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjGTUil (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 20 Jul 2023 16:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjGTUik (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 20 Jul 2023 16:38:40 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2058.outbound.protection.outlook.com [40.92.107.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4056D12F
        for <linux-cxl@vger.kernel.org>; Thu, 20 Jul 2023 13:38:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fZADlUvaGAQobXDMx268vc/R1Gzgbt4areglWItLF5Z1oVAKgEyfR0W0FMR0gL3t+10JeBaLY/WBuilU9VmfKjYL25rNklcrle3CTUVXZ6voR/TLn/MyE2F0I8uZdT+gr3H96WaO266VYwqr34VYJPyubot/uRCfP/TyTLQBLjcUZkzH5leSYuV8I3csEQ27Tyr90wgB+eIYijPBL2LdtyHCpTKLc+w90xgXqCqD3f3EpZMFvb9Hhs0NpX4qIIEyfScXl6dvRc78NDgcAQap6jh40EvOyJFFt0oG1VhOTs2ylOg7flReT+sNSFTr798Z0zGczrLeRQfz1p+uXO1BYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3wmXxe1gyKy7AQ4oFe0GksrcExFDiVNkf0Ah1Nc6Hp8=;
 b=LUWlmF41GkI4w8EZ7zxxDGusk/Gj8zsO/J8u3xJWzNklTfmUDrSOqZZAwef2vtRJA6CN40U/pDP2v3xD+3vMcx/dFPA7bD6EnOudyMAk06VNTyPi8nHN5UhvXCusX9YzPkqhE+jN3ZgFzaqbFyV/jphPivq5GVfyEO4jPf2bgg0Qmdnj8bytAUSkJCVzpGRjD6EUSB7ySTfnj9RDM7CdNQED7L2qeueiBdPFdL2M0X6gjJgrCvKToqHHCQ/lfHff+ggYYOCKNrlEChaLtWYnBJpDSz0HpW6wtoUPnXgOJxtmRyBJQ2EWJTqwWGbW4VzTAEimmoe9YQiAV5t0n91qoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3wmXxe1gyKy7AQ4oFe0GksrcExFDiVNkf0Ah1Nc6Hp8=;
 b=q697sDWz3IZdylaW4azGZMdg2zgJBxruwWxYIZCRNzv9vKkSGAp8Iio30cMkQRhxqP89MR2oudnF7bEE+VmRP9+V4VLac22HS5q5OjZw0bAtfeC0kXtw4VMWqkLwif5nrPjNocu1iCVQAmAKC5n/yKaWyQnJfWkgzJXa4/920qHfltsdZKK6S1/NZ7437oEyHtEpab4rfe/WCAcwFu9pK0kOOLxzgzeiwzwb5ft2TO1fWHop19gEH8IdMI+D3xsGg6DlaaUjAKZf25CWR3A19nidAfQjkQYzafk3XLMqiEK3uddWsn5gi0v27Dg4lvWVMbAG+nBXhc1Y9bBTtWlk4w==
Received: from SG2PR06MB3397.apcprd06.prod.outlook.com (2603:1096:4:7a::17) by
 KL1PR0601MB4100.apcprd06.prod.outlook.com (2603:1096:820:24::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Thu, 20 Jul
 2023 20:38:31 +0000
Received: from SG2PR06MB3397.apcprd06.prod.outlook.com
 ([fe80::450:9c8c:9058:c94c]) by SG2PR06MB3397.apcprd06.prod.outlook.com
 ([fe80::450:9c8c:9058:c94c%5]) with mapi id 15.20.6609.024; Thu, 20 Jul 2023
 20:38:31 +0000
From:   nifan@outlook.com
To:     qemu-devel@nongnu.org
Cc:     jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
        gregory.price@memverge.com, hchkuo@avery-design.com.tw,
        cbrowy@avery-design.com, ira.weiny@intel.com,
        dan.j.williams@intel.com, a.manzanares@samsung.com,
        dave@stgolabs.net, nmtadam.samsung@gmail.com,
        Fan Ni <nifan@outlook.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PATCH 4/9] hw/mem/cxl_type3: Add support to create DC regions to type3 memory devices
Date:   Thu, 20 Jul 2023 13:37:03 -0700
Message-ID: <SG2PR06MB33977044F6CB2DB157532D92B23EA@SG2PR06MB3397.apcprd06.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230720203708.25825-1-nifan@outlook.com>
References: <20230720203708.25825-1-nifan@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [5N0zCWzcSMM0hWh2ySV3mmZ1xAp0XQzV]
X-ClientProxiedBy: BYAPR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::21) To SG2PR06MB3397.apcprd06.prod.outlook.com
 (2603:1096:4:7a::17)
X-Microsoft-Original-Message-ID: <20230720203708.25825-5-nifan@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3397:EE_|KL1PR0601MB4100:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f346219-a653-4afe-10d7-08db89612b06
X-MS-Exchange-SLBlob-MailProps: 9IecXKUgicAYce+YIvRqgnoEwnxu+bmnqdflpIQ3k/CEHtXQ09WBJacqPfWQMr2f9LcZyJFw1Jt94o/U+oh1vWaxKqpmSgUyccXMCYnP4JP+30LlbrMVjUXcWM+qbnOcl5cPI1KHvO2YuVG7gIzC62mcnjl1T9/JL0ZAqTTtuOC5tVGnxLypYJtYxZ68sDep3W/wxESKIETstpaY7/zsjB+TRPJJ0G+33Q9lhRnsjbITiEgRZSzqLfcEUjey46bOkNKjfcVssTb1PjUbywvq44mt2obxEaGPjEhSeJHjBAaP2CSuZg1j/BKhuo2qv9aQNtxhx7nQ0cBNY9yOFTUuMOwv9dkPDQcrglRGO+2zj4RKXTvXFL3uylcaY9R6M7Da18OrTl2mfgQ/pniiJE1vFuZsR4GMKglDI6DhJhshhtsInZ9i2cyxnvL5EdLDrZNcbodCRVaQzNriBdkH4wr801Ekf1iIsCQMUOQKkemM6gH5yXwlWuTvzd1USdjNYlrneeMbZCQw6E7EVNRI6VN8yKsM1KqpuRL3I7g0Ju41HCpeEwJwTtiuN90UICo90xt4j2eJw9HVOAWjDByr+XfpIBf3aM9y4dh/1jS2DV6bgN0jEkpEVSyOI6Xcm0fwWfzbnn6BKdcnr02r+6mxx5tlNjIKnrP4VMYym2f/6FONn6A6rCS/wdqCCO2oq6K0RxySGo7YPn90hN3MpencHHlhOf4YPo06VjyMh2DcCji9TKnqKw4ctcsEOA==
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HRvL0f56bcaJdBnJCx+pFMmgwMWGHRvn0h6U5zGZfo13i3pkVz4O9xYiIGfgrJmaZ6U79QNDcTzXWnVf5Ea9NdYIx/7A16jiaLg6MXtwR6ENO7CEuoOyAXT3OS3izMmKhhwlAEIPo59AqUeyMsJEfdE3+d9VbO2sIWnnhxZO5uxT98cpjuTCYNGztvYnV+kb35LfOerBG7AivHVe2/XO2B5X2tfTfrJWAWle3Qxoz2lwc0ujg/1N9+BbYSxr8OGkfd+Vv4GWZtcTRShoh2HfLyOF9gbyJFbIq2ZXSvssgLpITiVFfzBwy0FFQ5Meh3PhpYjcQHK+8X8ksiDQkLMvsgyWb2g3WxZU0GNiSJl+TaYiYhiNzTZ0sBk4MSdNf4m+4wucfFoZyLtyiDOejs+dqkZUjmVRFvXr6bkV7coatPvG/8Bf6NSsr+pf6X11i84yxr96su0C+MdWMExHa3Fa+bPQDsmTmmHvC8e2JtEuN4uMMeDqqFYCxgI5gl/sy1/I177QGVz04Wh6gnaYcQ/dH4w6NNdrcpzC0PbMPCko7ZrX/SU+wtMdK3tERrJeMyeMBogUZvo5HL+6hRfUtc85HuF/zbNPlV4BetmAMO+mQKZTlzFUAKwjECZT0ZoaGRw3
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T64VLjUMz1deyyVDqn1fcgmlyYyYc+tfueyDweFIvW9WLpfInWJnbpNvXiQ8?=
 =?us-ascii?Q?sK/i6lnpyU5UYDxMq/sXpvNd9qQuVFUKWyPwtPFZBKrWRw41m6WZev9YAav0?=
 =?us-ascii?Q?5JiXO9R3mVjWvZZ8GEq1yJPIFc1HtPY+GVFQ5vRMCQwB6i1Y5b6+mz7hTwFG?=
 =?us-ascii?Q?bwHY/eniPD92nEWNBm89lpu+ON5SIRAspeJ+MigdWZlDpFtnnil9JBFafD9U?=
 =?us-ascii?Q?1mU2xc+Jqu5XDtB86iB49/6hDFZkJqVmOTM6VYnjGLrQ4ip5C9iCyWJkN413?=
 =?us-ascii?Q?qQa1fl/Au9wAO3quVmOr7iOvZP5k0DESpvrivLqI+J4uD/CwMM5JWuc0UbZB?=
 =?us-ascii?Q?x3CAT58uUW39GaQ9gtAur7xDZ7nShr00wXzFfif69aR2lAG++145NHDLrj9N?=
 =?us-ascii?Q?oCHY/CQwNolJY3cVl0J5xb4Rlu6Ws9G+7y90lCoKIH0ATIf/7z7XOiaEcK7f?=
 =?us-ascii?Q?Mbf0Wx+BoozNeMEEuVPuyrk3vijdBLUsqxGAodhwdYV8k2VvULiWnC02BJy7?=
 =?us-ascii?Q?8ZlSUxaeoOE0SDnOysmynaj+NNpPi5cAAeGhqrYrlYJPXDQGNZp+7M8ic4CA?=
 =?us-ascii?Q?mjKSW18WXxQzd179ix3LiOlBcdv3+GihoLX2DJa4BS6oJqZDC7gtuZwly5YW?=
 =?us-ascii?Q?MoGTSg4n7otHodFkAe5e6z6b6mR3+aKWgJqeEbpSOuRglCvtAmIqrYiw/0jK?=
 =?us-ascii?Q?dccii2qwgrh5AcKk0E1qmrCGCC/lFSO5vkv/vCMAYlmxpfZf4YASCm4mKLvh?=
 =?us-ascii?Q?b/9NdpWXVZ7x/br4/ykOQrpyenzfV9v9/9pai3q5X76ye/cqNjG/NTNErKfv?=
 =?us-ascii?Q?0y5AVJLk7z4uZ0wrYwwiXzQ1EWNZY8tNRFGG4FZc3E6Pfr/ZU+E7AgGQx2fM?=
 =?us-ascii?Q?f0hZL5EwaLeFNXRUud/BkUjp1oeW22ox66ll2BXBTyC4BCj5UI7Kk3H9XLtD?=
 =?us-ascii?Q?4HP7rwWXnjIY9vY0WdqjbUM6rhYc4q1BdFT2a1dX6saEIEgwZmHhYZMqdHCS?=
 =?us-ascii?Q?3m8SXCKGQ9IjDveqpuO3RUbylWr3uObcY3McofndP0h/XBOEXB63ec1iynoK?=
 =?us-ascii?Q?jHEU3KHN0jmc2hag4I1xPHpf2Jo+ax5fbUAPPev6yP1aJeZ+jVeM9mw1rK7v?=
 =?us-ascii?Q?3wlqqAM5BDo7kBYyQKLUW92cgb0dtef1BDYXSVmS4a15AQxRNA8xQRaOUqCu?=
 =?us-ascii?Q?z+vNShcrRD+AOiC0gOd8RbIFHe3xHZY/xguTZA=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f346219-a653-4afe-10d7-08db89612b06
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3397.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 20:37:43.2976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4100
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Fan Ni <nifan@outlook.com>

With the change, when setting up memory for type3 memory device, we can
create DC regions
A property 'num-dc-regions' is added to ct3_props to allow users to pass the
number of DC regions to create. To make it easier, other region parameters
like region base, length, and block size are hard coded. If needed,
these parameters can be added easily.

With the change, we can create DC regions with proper kernel side
support as below:

region=$(cat /sys/bus/cxl/devices/decoder0.0/create_dc_region)
echo $region> /sys/bus/cxl/devices/decoder0.0/create_dc_region
echo 256 > /sys/bus/cxl/devices/$region/interleave_granularity
echo 1 > /sys/bus/cxl/devices/$region/interleave_ways

echo "dc0" >/sys/bus/cxl/devices/decoder2.0/mode
echo 0x40000000 >/sys/bus/cxl/devices/decoder2.0/dpa_size

echo 0x40000000 > /sys/bus/cxl/devices/$region/size
echo  "decoder2.0" > /sys/bus/cxl/devices/$region/target0
echo 1 > /sys/bus/cxl/devices/$region/commit
echo $region > /sys/bus/cxl/drivers/cxl_region/bind

Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/mem/cxl_type3.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 237b544b9c..27b5920f7d 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -707,6 +707,34 @@ static void ct3d_reg_write(void *opaque, hwaddr offset, uint64_t value,
     }
 }
 
+/*
+ * Create a dc region to test "Get Dynamic Capacity Configuration" command.
+ */
+static int cxl_create_dc_regions(CXLType3Dev *ct3d)
+{
+    int i;
+    uint64_t region_base = (ct3d->hostvmem ? ct3d->hostvmem->size : 0)
+        + (ct3d->hostpmem ? ct3d->hostpmem->size : 0);
+    uint64_t region_len = (uint64_t)2 * 1024 * 1024 * 1024;
+    uint64_t decode_len = 4; /* 4*256MB */
+    uint64_t blk_size = 2 * 1024 * 1024;
+    struct CXLDCD_Region *region;
+
+    for (i = 0; i < ct3d->dc.num_regions; i++) {
+        region = &ct3d->dc.regions[i];
+        region->base = region_base;
+        region->decode_len = decode_len;
+        region->len = region_len;
+        region->block_size = blk_size;
+        /* dsmad_handle is set when creating cdat table entries */
+        region->flags = 0;
+
+        region_base += region->len;
+    }
+
+    return 0;
+}
+
 static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
 {
     DeviceState *ds = DEVICE(ct3d);
@@ -775,6 +803,10 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
         g_free(p_name);
     }
 
+    if (cxl_create_dc_regions(ct3d)) {
+        return false;
+    }
+
     return true;
 }
 
@@ -1062,6 +1094,7 @@ static Property ct3_props[] = {
     DEFINE_PROP_UINT64("sn", CXLType3Dev, sn, UI64_NULL),
     DEFINE_PROP_STRING("cdat", CXLType3Dev, cxl_cstate.cdat.filename),
     DEFINE_PROP_UINT16("spdm", CXLType3Dev, spdm_port, 0),
+    DEFINE_PROP_UINT8("num-dc-regions", CXLType3Dev, dc.num_regions, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.39.2

