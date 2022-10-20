Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 875B1C433FE
	for <linux-cxl@archiver.kernel.org>; Thu, 20 Oct 2022 17:52:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiJTRwt (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 20 Oct 2022 13:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbiJTRws (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 20 Oct 2022 13:52:48 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C541AE28D
        for <linux-cxl@vger.kernel.org>; Thu, 20 Oct 2022 10:52:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ngcQ9MPGwqbbmoizL/00ajdVQD7S6rE+rejeKoJXim4K49JfFeNam2mWIRmI7lcd+haXFUAu0AnW9Iqsp6AbdssXcFv/4CU/L5yPUnj1L6gJGAwPbsulySCYjF1CpHdaiLeMYHnpWDWo9mIrBEPNrgh4BN5qPzA71TTV8Fy3lzJoRW622OlIMAG71WQpdbqm2Id4ENIFGgo5ErAqNWZb75XfBKv1eJSPh03NoDklX4d5G22d5+LZnAAa6M0mdeKGrNcK6n6fNOFq8i9AYOq1RXwp8UeQz6Nn9V2CQ8JNLJTDSLNA7bC8RngKso6tAC2UVQPepOHTjL4I5Q/uB63k3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LtMXtYOgmYRK8hunsVLS8xehsOfR5IOd/sH4unE7az4=;
 b=NhhnLj9/upnP+QGRby+A5Q+xoq82hSsxo2K68di7WpI1AFgnVLg2MohPXNssxu/NX1DJucUFuz6VypvYSDPUUkzvwJqYVoaAaPJs5ijMiIbNmB1Y4ft2IHDg/tl4jLxFbgfrfcmJi1xlf/1ujUqKHMkXA+vwds093LgmTtQfLJXgG5nDbyCFwVU7VcshAdeL/HWpAKJzH+YXndfrfTPel/EzY0zOMbrZ7EhZ+vrnAamzwxln87FZfYCpOywS49wWMIx9J9vj8ug6jtBvWjUdrd02Sd8nXWRMrLn9YjAapy+vp2u+v6QRkd/pmI/37C0q/g0jDeBME86du/FxDqVNmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LtMXtYOgmYRK8hunsVLS8xehsOfR5IOd/sH4unE7az4=;
 b=r+TVQjx4j29dx/gyoFHBawh/eQwTuyKWYqKVrIh9+XEb0cr8ABttWwk8I6Dsj2//bFkFa26emyU7Rb5rFGihGRUxD0de7LaYViN0lJQJNBpU8Yefmgnoy69XZySIivAIvJYBvkMrU4AVYaBnfXi2ryXhOES6UYFERQWi9fRD2ws=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3268.namprd12.prod.outlook.com (2603:10b6:408:6c::18)
 by CY5PR12MB6225.namprd12.prod.outlook.com (2603:10b6:930:23::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Thu, 20 Oct
 2022 17:52:45 +0000
Received: from BN8PR12MB3268.namprd12.prod.outlook.com
 ([fe80::4117:52ab:42a3:17b3]) by BN8PR12MB3268.namprd12.prod.outlook.com
 ([fe80::4117:52ab:42a3:17b3%6]) with mapi id 15.20.5723.034; Thu, 20 Oct 2022
 17:52:44 +0000
Message-ID: <723490fa-04de-ac22-2bcc-713cd77e6d3c@amd.com>
Date:   Thu, 20 Oct 2022 12:52:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: en-US
To:     linux-cxl@vger.kernel.org
Cc:     alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, dan.j.williams@intel.com,
        jonathan.cameron@huawei.com, bwidawsk@kernel.org
From:   Ben Cheatham <benjamin.cheatham@amd.com>
Subject: [PATCH] cxl: identify CXL3.0 cache/mem register capability IDs
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0073.namprd11.prod.outlook.com
 (2603:10b6:806:d2::18) To BN8PR12MB3268.namprd12.prod.outlook.com
 (2603:10b6:408:6c::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3268:EE_|CY5PR12MB6225:EE_
X-MS-Office365-Filtering-Correlation-Id: 47503b5e-b75f-418f-e8c8-08dab2c3e460
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZDDBP+X+ELlxHzIcRiBK61I9xMO3xs7hQFONhtfe2iL938ogIuER8SopqtasZDBVcTj9JJR97nhRBgN6fcGruB3HVEFTz5zUc9YFIR7f396ebnyR5NUFDY8uDfFX+/nQGOs8z7GCYwps2PzS8WpZIv73jpRY4GBUSfnIU8cj0OC/41R5pOCWm61iHa/VsirNJhcjfAZO6CglJ22VgQKJ7nuUkcjj+4yKyqfgPafUrKWMOw5ObgVwfYAb8gouCTsdLIAM6Y+9n+nRRov9qisQkGcX9Kc886kR2r/PuEVw+kqPt6FPOO+JvrAs9HepmASEwhCzhcLyabprScKy8dQEAWLINAasKZgMEiXFK2b2W1V//CjvQWI3esWpCcI2Z/NCYyTAfUF+cBj7HzAtpFt5PBpvRA18hZVvlZGP1V6g/p5NZap/jo+DXNxzmsoXpj8R1R7hrg4y2mK/sCtrRGlM2BtSA/6kNAg1mBQUwrkNDrT1+QgjtWV9Cq+vjq6wLqiRy8syTLJieAeuDTk6kJBxOGv/dys27gZkqV0Ne2KLQGsh2JxbY2dDKBra4ostIUMnTjW+o5IzEhv5TojC1sOp6PfclEjigyAFLxtI9Sk+E9pZOTSs7OOJ50HO5b3k989uzh0Jze1XKJENAZitIH7twdj+Qy6765zP/nGiFrJZFRAoBGS35uRCyrRziajhS/W3CL3hPvihazctMSjbFYATADjAmPCPfkUNdcxILCGpYmeBXzTBpUDnTraJ31hdvGkctg8DQxZHgIe7jDBDlvoAcJlXDjsi/T/L9fQjl4rSwuA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3268.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(376002)(39860400002)(366004)(136003)(451199015)(38100700002)(2906002)(186003)(2616005)(4326008)(31686004)(6486002)(478600001)(8676002)(83380400001)(66476007)(31696002)(6916009)(8936002)(316002)(6666004)(66556008)(6512007)(66946007)(5660300002)(41300700001)(36756003)(86362001)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Yk1WRDZGMTRaQkxhc0t6c1cvRWZaYUs3cWoxRDJldEJSbTB4a0llbmtNNFdB?=
 =?utf-8?B?NGt6eDd0czB6RnhhczBCWlM5Y2lYTHQ3QWIwcm9nY1ZpMVowcUE4L1BaeWlG?=
 =?utf-8?B?cDVIUDVzYUxPblJlMCtQYitrdHRvQTh4dzlwS29CRUdzSWlCM0JPQXM4SGli?=
 =?utf-8?B?MTFwUlU2S3ZuVC85UDlaVytTNkhSdVI4YUFPNnRtMnI2bmUxZFk2eGowYkNS?=
 =?utf-8?B?RmRwdTJCZWJrYmJrSjZ4VkdlMnF1YnEwR0RNaU9IUGZ3YXlHSHNrb0xYQllH?=
 =?utf-8?B?Tk54U2NTWUpYUmJwS2gvNXZKTGh1UkUrc29pTzhQWGdLRDRJV0ZMUHIxV2Iy?=
 =?utf-8?B?eDJZalRvUkZ6cW1SSDl0SlpEc3Z1MENwT3paNzJPM3hjVElqRnA1RmR1M2h4?=
 =?utf-8?B?OG1jVjBiS21lWThnaFJPQitjUkVONEJhcWdiajlmQ3dzWUxoUlRXbU9BMnov?=
 =?utf-8?B?M0tmSUFhcTRRYUVYWGNZcHhXeTFMSW5sK2lONkxTYk1lenJpc3N6eEhNM2NF?=
 =?utf-8?B?b1BrRVdOdEk2cmtZOFdIeVFHN1ZKd0E3bjI4T3B1VTlVLzVKdG9zVVF4dk1B?=
 =?utf-8?B?R2N5RnYrWWlaUGRaVWVhNEpiQUpWblUvMDhQRDdId3FzdVN6Skd4TGF1bXFy?=
 =?utf-8?B?ZkJvNkhwang1YndhbC9QWUFPaFFBbnhTRmhDNFdXQTgxdnRscHEzTjdSdGUr?=
 =?utf-8?B?NGRUNHFmaFhDNzQ0UnYrakgrSWNTWWZudVF0Znd0bWErUnRtU3JCOUFVbkxL?=
 =?utf-8?B?WkpSMjdIUXRHbWNkR2VUZmw5MjliZHhkNG01TDg2TjRsd2JGdFdHUjQ0ZXZO?=
 =?utf-8?B?WkJKbVlHcWN2ZFoxajRnSmRkM0hFSFBINllnNXRYM2ZoTUJhN05NZjUxM1hE?=
 =?utf-8?B?Sk9CeFdlT2dKa2NMbkdtVTZ4aXQrR21jT2k4OGtUOHdiUGJSVnZLd1hyTmJV?=
 =?utf-8?B?YVZKUnpIS01pRVltVXgwbFJMTDhabmFiY2xYQjVham5WUUl5bHIyZjdVV254?=
 =?utf-8?B?eGNwUTdyNU5jTlpOVHVUS0VZY2VBVzNFMDJHTEg3VmkweFdLT3ZQM0t1RURZ?=
 =?utf-8?B?bnRQSWtYc01mMFNDQUttUHNrQjEreGR4ZmZBN3VuekhvZjJYOE56TStBeGJD?=
 =?utf-8?B?ejM5K2JDLzZpc0I4ZFpkaHNBUkEraVdaK2ZnRXlhMXFFUjBPbmZVSUt1Y0tF?=
 =?utf-8?B?Wi9lRDBQMUZrNGNiWmV6TndKNWg1TUlVdE5BZlVJQjNRSkNjTGNJT2Q4K0xQ?=
 =?utf-8?B?REltUFFhZEo0YWoyU0lRYllsY2lsSGoxNXNrc0FKVVJvVXVEL1Z2eHQrZXAv?=
 =?utf-8?B?eG40cE9aMWJmeGdrMjRBZ0lMajU4ZWxyM1RwdkhvVHFqQVBIL0hPbkFaY2E2?=
 =?utf-8?B?Z1FBdzNLb1lIdkkrTkV5MHoxRWtDaGg2eU11WnNaMkF5T2orMStYVEdWSGhI?=
 =?utf-8?B?azNRdWhScHhyM1BrMXFRRzRkbm1DVUdYZTQzazNPcEYwNHo1dlJ3amEzdWJj?=
 =?utf-8?B?NlhSUG9qQ2lYSkpoWmhhajIwYmozYWtlVzBNbnlWcjBPN0hpMFJ0SmdWWWpD?=
 =?utf-8?B?Qi9oV2k3RjdPSi9hemFqRUJTRGIrR2lOMGNTeEtWWnNkcEJZOEZoR0FWVlJi?=
 =?utf-8?B?MWhCMzNmZkI4T3U4WjVSUXRKS2JYZ0p5ZjRSNHZ5eEFjcXYwMlFVQ3R4c1BT?=
 =?utf-8?B?c3h5QU1YNWZaYmRSamFwTnZmQ29MM2NGRDFlcGNFbEg4dDJsei9CTlMxOEZu?=
 =?utf-8?B?eWR5cVlQZHVZOXVkM0FrYVdoZ3ZMa2VBQVFKUnZXdnE4RmZIdy9DSlQzOWNo?=
 =?utf-8?B?cE5DN2lGd0l4L2tjWERvM2cyU0JaMlM3MmhXdWlNQkdFd1lnNUo5aGZxQUY5?=
 =?utf-8?B?M2dQcDZRWisyR3FDeDluNTRoRVlnbEEvcHRSMy9lV0l1ek4rZHdiSUxaVzBw?=
 =?utf-8?B?b01Lem1RUC9jc3NXLy9Uekd4SThXbXZ1bXpDQTlMY3lmaWJDRmIrSVJFNUJO?=
 =?utf-8?B?N2dKQjllUnVtSkRCUDJpbkFYK21KcFo4N0xRdGZNVzhJdm02bGxUSlIwSnhP?=
 =?utf-8?B?ckNsaERTYWJucUsrZjNibWZwV2lsWC9nVThlQmhmK2NmYmF4eDh6azlrRngx?=
 =?utf-8?B?aWFwT280U0ZoTVZiQU10ZkQ4Nmk0RjR2WFJjWVdRREl1K2JYcG1xUXMrSGJv?=
 =?utf-8?Q?M7ddG1mtZMHj2gcGSrVSwuHsQg/MHLg9imhuhQmVMzTk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47503b5e-b75f-418f-e8c8-08dab2c3e460
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3268.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 17:52:44.7832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ovnuu66Z1lpTsTxAKpeou6VfCT6zee1yG3vEay/0u4FYkRwq8ZjLsTD75zP0PWXffKiahyJQGpwK8qdk0LsyOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6225
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Add code to identify the non extended cache mem CXL register capabilities
based on capability ID.

As of now, nothing is done with this information except logging that the
capabilities were found. In the case of the NULL capability this is
probably all that should be done since the spec specifies software should
skip this capability. The other capabilities are added so that if any
additional setup/info is required, like for the HDM decoder capability, the
stub is already there.

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
  drivers/cxl/core/regs.c | 42 ++++++++++++++++++++++++++++++++++++++---
  drivers/cxl/cxl.h       | 13 ++++++++++++-
  2 files changed, 51 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 39a129c57d40..616d926de1e6 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -27,8 +27,8 @@
   * @base: Mapping containing the HDM Decoder Capability Header
   * @map: Map object describing the register block information found
   *
- * See CXL 2.0 8.2.4 Component Register Layout and Definition
- * See CXL 2.0 8.2.5.5 CXL Device Register Interface
+ * See CXL 3.0 8.2.3 Component Register Layout and Definition
+ * See CXL 3.0 8.2.8 CXL Device Register Interface
   *
   * Probe for component register information and return it in map object.
   */
@@ -42,7 +42,7 @@ void cxl_probe_component_regs(struct device *dev, void 
__iomem *base,

      /*
       * CXL.cache and CXL.mem registers are at offset 0x1000 as defined in
-     * CXL 2.0 8.2.4 Table 141.
+     * CXL 3.0 8.2.3 Table 8-21.
       */
      base += CXL_CM_OFFSET;

@@ -71,6 +71,26 @@ void cxl_probe_component_regs(struct device *dev, 
void __iomem *base,
          register_block = base + offset;

          switch (cap_id) {
+        case CXL_CM_CAP_CAP_ID_NULL:
+            dev_dbg(dev, "found NULL capability (0x%x)\n",
+                offset);
+            break;
+        case CXL_CM_CAP_CAP_ID_CXL:
+            dev_dbg(dev, "found CXL capability (0x%x)\n",
+                offset);
+            break;
+        case CXL_CM_CAP_CAP_ID_RAS:
+            dev_dbg(dev, "found RAS capability (0x%x)\n",
+                offset);
+            break;
+        case CXL_CM_CAP_CAP_ID_SECURITY:
+            dev_dbg(dev, "found Security capability (0x%x)\n",
+                offset);
+            break;
+        case CXL_CM_CAP_CAP_ID_LINK:
+            dev_dbg(dev, "found Link capability (0x%x)\n",
+                offset);
+            break;
          case CXL_CM_CAP_CAP_ID_HDM:
              dev_dbg(dev, "found HDM decoder capability (0x%x)\n",
                  offset);
@@ -84,6 +104,22 @@ void cxl_probe_component_regs(struct device *dev, 
void __iomem *base,
              map->hdm_decoder.offset = CXL_CM_OFFSET + offset;
              map->hdm_decoder.size = length;
              break;
+        case CXL_CM_CAP_CAP_ID_EXT_SEC:
+            dev_dbg(dev, "found Extended Security capability (0x%x)\n",
+                offset);
+            break;
+        case CXL_CM_CAP_CAP_ID_IDE:
+            dev_dbg(dev, "found IDE capability (0x%x)\n",
+                offset);
+            break;
+        case CXL_CM_CAP_CAP_ID_SNOOP:
+            dev_dbg(dev, "found Snoop Filter capability (0x%x)\n",
+                offset);
+            break;
+        case CXL_CM_CAP_CAP_ID_TIMEOUT:
+            dev_dbg(dev, "found Timeout and Isolation capability (0x%x)\n",
+                offset);
+            break;
          default:
              dev_dbg(dev, "Unknown CM cap ID: %d (0x%x)\n", cap_id,
                  offset);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index f680450f0b16..762e5243162a 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -33,9 +33,20 @@
  #define   CXL_CM_CAP_HDR_ARRAY_SIZE_MASK GENMASK(31, 24)
  #define CXL_CM_CAP_PTR_MASK GENMASK(31, 20)

-#define   CXL_CM_CAP_CAP_ID_HDM 0x5
  #define   CXL_CM_CAP_CAP_HDM_VERSION 1

+/* CXL 3.0 8.2.4 Table 8-22 CXL_Capability_ID Assignment*/
+#define CXL_CM_CAP_CAP_ID_NULL 0x0
+#define CXL_CM_CAP_CAP_ID_CXL 0x1
+#define CXL_CM_CAP_CAP_ID_RAS 0x2
+#define CXL_CM_CAP_CAP_ID_SECURITY 0x3
+#define CXL_CM_CAP_CAP_ID_LINK 0x4
+#define CXL_CM_CAP_CAP_ID_HDM 0x5
+#define CXL_CM_CAP_CAP_ID_EXT_SEC 0x6
+#define CXL_CM_CAP_CAP_ID_IDE 0x7
+#define CXL_CM_CAP_CAP_ID_SNOOP 0x8
+#define CXL_CM_CAP_CAP_ID_TIMEOUT 0x9
+
  /* HDM decoders CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure */
  #define CXL_HDM_DECODER_CAP_OFFSET 0x0
  #define   CXL_HDM_DECODER_COUNT_MASK GENMASK(3, 0)
-- 
2.34.1
