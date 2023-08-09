Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07CE6C0015E
	for <linux-cxl@archiver.kernel.org>; Wed,  9 Aug 2023 23:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjHIXwX (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 9 Aug 2023 19:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjHIXwW (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 9 Aug 2023 19:52:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A03F7
        for <linux-cxl@vger.kernel.org>; Wed,  9 Aug 2023 16:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691625141; x=1723161141;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BE1jjMCD8lROA9ZB/g9LoAF0JF5/sFnFyPnXZ+QiL8c=;
  b=ArtUBov4fyn06syMnX+ec/s1RLnGPsSQqfMEDlA+SqFgWwILkGr7oMPT
   w4rxtQTDGkHuVY0u5m3d+S8B+9F+3vEFibo6QMvYle/jAyRVoopYWMJp4
   GMrRFVcsL0l0f8nLbjgcqsZVCk3R09HwJpXnXHBtwQVrCtgNZWstoOFcg
   oECAwLBKLE5UricUM6mu9yADR6S84Cp7QLoWxYTvybVi2yPHaWqDg/qik
   raLRhq1ieV5bO3JAQMa8E4y8/5rZupA8feZDNdJAtN++hJvaNfggQMBH4
   9MA38x40QyvywcQVOLBSixiJpYCKD326oo4muWALx1zcpXXJsD/Yuzahl
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="368716514"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="368716514"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 16:52:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="1062682844"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="1062682844"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga005.fm.intel.com with ESMTP; 09 Aug 2023 16:52:17 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 9 Aug 2023 16:52:17 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 9 Aug 2023 16:52:17 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 9 Aug 2023 16:52:17 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 9 Aug 2023 16:52:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PXVzb9nBCn9Ep1XfPH8z41NOIGbe90vYdblFxzM70gqel9qw+43Y1ln0WltbyEmw5HQW+O2d3LmetJ6u4Ys3bqq4SHLlP4vtAj+LAQ4DS0WvuZBXK4p1J3vgeK3EoocVPPohNiX4MP6aR4JiN/qxMJ4Q3VJUObJzjZHnd+O5O/IWDiOGEiMYwct2kPbQ+mR1rP8cHOGw9yRXrSknieooKTwNaxucY8lPMHFiNe7Sy52ch6Ke1N1mpM/UTLPRDdFlbg1YyN77sDTgdpik3PS7tsMyUunfLe8QHUgOlqm525eNTKFwBTeBoAAFxNAawu2YkJDG40JCudUGfxW1mcpGvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w/MyLO57Vm/wEhsq6ny19osMYgay+l8S9r2zVwgYNbo=;
 b=IHG/5aIfyqGETMwaa7Sy64GLGfbvugIVtF1NzkyHO8nH2Rgtqq7vnAaRf+uBTyZC08N6Ldp3OzJ/8DRSxOhsbGJUH/ajn0Mxayck/JF5Z4BB2LdsFKr5xb+2gRiTug8ZESxu0CdaooKYGBnsNwznTtm0N5k9gtFrLgfL3g86xaSkJq62+8eR3s7Q5Osn0OWknS8nLOiboVH1wg6NCP6+d3CsusO6hYJkyxAAHZXPBzZbwhu+ukfNnovU+wU6quZZ90XklT/iLW2KFn9bQEk8Z3Qd4+xgO/NQ8gncJxuPw6+6UaKCc3hhSbdH4t40iLf8N5b1BCq8bm82wqRzciy7Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by SA2PR11MB4987.namprd11.prod.outlook.com (2603:10b6:806:113::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Wed, 9 Aug
 2023 23:52:11 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::406a:8bd7:8d67:7efb]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::406a:8bd7:8d67:7efb%6]) with mapi id 15.20.6652.026; Wed, 9 Aug 2023
 23:52:10 +0000
Message-ID: <7d538478-bb0e-5af7-1b6e-529e85d37f91@intel.com>
Date:   Wed, 9 Aug 2023 16:52:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.13.0
Subject: Re: [PATCH] cxl/memdev: Decouple security init from
 devm_cxl_add_memdev()
To:     Davidlohr Bueso <dave@stgolabs.net>, <dan.j.williams@intel.com>
CC:     <ira.weiny@intel.com>, <alison.schofield@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
References: <20230809163733.32008-1-dave@stgolabs.net>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230809163733.32008-1-dave@stgolabs.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0223.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::18) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|SA2PR11MB4987:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d0fb6ef-3e2a-42ad-de40-08db9933a555
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f4LzASJXv7crVmJi8XNGOb48z1U6hFO8U/ICjJhkSoaZavjPY6ZgzFakv1UlBZIt4ZcPyVrjObar6aMGSvCWJ00IlFgzkcZWy0ekTjjr2/pXAwzuqKovStMYDCbzg3pF5adIpGf41t9IKJ7pjtb2wc/XLlbLltXlaxHvFuems76BZQ24fjKWQ6m0OL7Y+I+FscN3O8EMGtZZFTztZfzjgvyEt7WV+Q3ZBS8FrcNQYU39KFRZwgCU5cbZ4XUOQI31GqtqIgE7iOQv4jM0UN3SUD+diAMr4WYs6RYW3Wpg+86UhobMdnD/IbJdxkGS1k47ORxYM+D57OcRNJ3B4iwQSa7DTXQ0/o08HLfuT6VxwSPP6VwYHl1Lb89fVXYtPr5ZHoKCIVzo5chxhN2+hb97khNEWPb9NpK8zepoKAUdPAiK0288nflAayZ9hS9Sxep28OBSrm3BmEihKzVWi6MDbdcinovCZ8LSWuUTUF5TsxrT44AMt8L+p5mRUWWz4OQfenRN+GOW7wBNGFoviHFtp8bGN926oK9zJN8e1Qkcs8kF/SlceylvLj3WXNB18s3XhNpfuGKj+E9PSFfYfJJo1BW+PXXuXEbEiz6PNNieqaUF/ZLXo4DmPj4eUYcAS4V4A9nW1Jjz7dNA8wIkkRCGEQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(366004)(346002)(396003)(39860400002)(186006)(1800799006)(451199021)(478600001)(2616005)(26005)(6506007)(53546011)(82960400001)(38100700002)(31686004)(6666004)(83380400001)(66556008)(66946007)(66476007)(6512007)(966005)(6636002)(4326008)(6486002)(44832011)(316002)(5660300002)(8676002)(8936002)(15650500001)(41300700001)(2906002)(86362001)(31696002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlZ1OWdCU3ZrQnNpbjI2OHUrUVN5NGk2MnQrTnRuQzlWL0tqZ1pGNEJZZ3Qr?=
 =?utf-8?B?NGh3NVdSdzZnRksvZmIzMW4za0pST3kyRzZPc24xc3dEak5OYlpvbFdZL3JS?=
 =?utf-8?B?dWZHbVhtZlY5MXpmb0czNE8wUU1nT2RJc0lray82TWRqR3Bjb0k5NU4yazZn?=
 =?utf-8?B?WmFXT2VoVVFObWNKYWtFNWxOa3dhYllOU0x1UUpCYmZFVy92NW1sSkd1TERs?=
 =?utf-8?B?OHBIc0tEYWFvbmVwOU96UUg2R2pIQnYwak9ROUovbm5ERVptdHpFdXRJVVAv?=
 =?utf-8?B?RDVZVUFOYjgzOXhPVFMvZVJ6Yy9Jc2JrTDNVMFN2SVdZMHAyRTR3WXBYWE5P?=
 =?utf-8?B?am5qQzgrTU5IcFFDbTUyd0czOHNvRktLK3dEUU1Ya3MyaVRRMWhPVHU1YWo3?=
 =?utf-8?B?UXh6cWM2L3dVSEx6a0NxaExIWFZKVFZCZm8vVWdaR0VoSjVwMHpIKzFiRW5q?=
 =?utf-8?B?dWJiTGZweldJS3FLNFNNZ1dwV0FMR3ZranhXK0RtbC9zaWF2UUk5RDQ4U3J3?=
 =?utf-8?B?OHEwazk4TXVBMncrMExLN1I1eEZscmNHL2h2RUROVHgzVmNZZ2pHem96UVcw?=
 =?utf-8?B?REdyQ1NRbU1WaUtIMUFTbHZ1ZWZQTVd1WWVGNHdHcEJJVFF2MmhHcU1HYTN4?=
 =?utf-8?B?MDd5M3dLVUdqVk5xTzVBUmxMVFQxUlA0VWlyYlBaRUdkcU9rdlRzU3hzMG9i?=
 =?utf-8?B?MjcreDRUZklickJoczRrMUNhMXQ1MEwycmtTeEx6K0d6dU5EWEIxY2xUUmxK?=
 =?utf-8?B?SkZ5UmIxYlhMV3EzQnk0dUZpdzZKZkExUGJETUR1TkFHTmlqS3FCSHZWYWpL?=
 =?utf-8?B?L3pmK2lxZnhvU29qcXN6eEpWelhCeG80R2VlSllKdW1MQmcvdmVEWWQrWHFu?=
 =?utf-8?B?S0w1QmExVzYxNCtJdjJXSThKZ29IdGhwRzErb3MyaHdPSEd4Y3RqdlJHK2lx?=
 =?utf-8?B?WnZnZzg2VXc3Q08wNzFxWnJTLzBKS3NyaVFsL0hMdit0RlZxVVMyYjRPSXk2?=
 =?utf-8?B?bE1OUlZjNmptZmRKRm1QazVyUTk3ajhJUWFHc0VYN01MV1EvTitvdGNZZ0pJ?=
 =?utf-8?B?Ulp3ZlpIUW80NlB4ZHhZQmRqajlkc1FMTkJZWERVWk9LUHdlelRpL2Q2VGIv?=
 =?utf-8?B?cG9FSHZvR1VzV2FVc20vNFVhUzRTYVU1cStCSVo0akdveWFXdDZZOHYwN0VO?=
 =?utf-8?B?S0hRa2ZSM0g3K1g4RWxYSDNIVGs4ZjRvYjM1WTdFWmpsb0NRWDNRdXFmNHQx?=
 =?utf-8?B?SFFJTFMzZUhJNUlwMW5VYk1PTXQ5ZjN4K1VFQ0ZjWkJSY2VMMlVFckptcjhm?=
 =?utf-8?B?NUdOSkphL0czbDROWHdPVDA0eGZaMU1iOUZ4N3V4VExKUFZrZWdJMnJZcGRR?=
 =?utf-8?B?MUlrRXVLQ1p5ZGF0Y2FRRjZJMy9zbWMzZXdrNGFlbEk4MWdGVEhJWTYrNFF1?=
 =?utf-8?B?bjcvUG5NZjJmSkZlUm52NWdMdTJTNUlPTXNnd1Y0dFdMaDlaTlJjUTRieWcr?=
 =?utf-8?B?TTdQZSttaHRHK3FPTVBNbkJ4ZXU2QnFTZHdTQXRBWEJQYW9nZjVTZU9oK0ww?=
 =?utf-8?B?ZnBjMDBGVzMyWnNhZGZiVVJQZmdvc2grQkZ3N0ZSUm5uN0dFL0VVODNGeVND?=
 =?utf-8?B?VDF1OEhpQkhRRzFTaU4vWUc4YlIvdzRlZGNjc1crd1hMWUtLeHlqalI4cVdC?=
 =?utf-8?B?M0l0aW5vMXpOZk1PU3RTUUhiRmtqOGVkY0M0NysrWmdSaUJta3NYZjIyaDdO?=
 =?utf-8?B?aGdCbW0zWnRvb2g3S2lRUzZXTkJhcjd1bWJrNEViMGZkRHdKeEZYdzM3TzZH?=
 =?utf-8?B?bzFJdmlVRm45RUx0N0haV2x1cXQvdHFCM1N2eEJZZU1Xbk1Zc1BCNk02RGhn?=
 =?utf-8?B?UmdobUNIZmh1M3oxLzdMTHhTRDI4WVMwZTMzdFFUT3hCemp2b2htSWFzWCt5?=
 =?utf-8?B?MVl3cXh2YitVZmNETWJvUll1U2xnMDhxeVl2SnBBRmtaV1RDalUyY1pwMXFE?=
 =?utf-8?B?V2ZpU1kvS1d6WlZxTGp4TjNpNnZncjNzZnNiYytKZGhpQTgwa05QQUNscVBY?=
 =?utf-8?B?dW92RXd1NldOWG1CenZJZkFENCtmVmxzM0svVHRvQVV2TUxPdkNKeUNtNFlh?=
 =?utf-8?Q?0ick9gkmJNsjg6gaZIVmgD/eG?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d0fb6ef-3e2a-42ad-de40-08db9933a555
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 23:52:10.5124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yof5vqlSIVPzC/irTrqhryHjovdktKdHU8FACDIKvzyFHqMKdzFBCpYve9z4bsm3eK9S3xAPpl9JZXzmWEpBEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4987
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 8/9/23 09:37, Davidlohr Bueso wrote:
> A crash was reported during type2 device entablement[0] which called
> devm_cxl_add_memdev() without an mds, causing the security state
> init steps to be bogus.
> 
>    BUG: kernel NULL pointer dereference, address: 0000000000000278
>    [...]
>    RIP: 0010:devm_cxl_add_memdev+0x1de/0x2c0 [cxl_core]
>    [...]
>    Call Trace:
>     <TASK>
>     ? __die+0x1f/0x70
>     ? page_fault_oops+0x149/0x420
>     ? fixup_exception+0x22/0x310
>     ? kernelmode_fixup_or_oops+0x84/0x110
>     ? exc_page_fault+0x6d/0x150
>     ? asm_exc_page_fault+0x22/0x30
>     ? devm_cxl_add_memdev+0x1de/0x2c0 [cxl_core]
>     cxl_mock_mem_probe+0x632/0x870 [cxl_mock_mem]
>     platform_probe+0x40/0x90
>     really_probe+0x19e/0x3e0
>     ? __pfx___driver_attach+0x10/0x10
>     __driver_probe_device+0x78/0x160
>     driver_probe_device+0x1f/0x90
>     __driver_attach+0xce/0x1c0
>     bus_for_each_dev+0x63/0xa0
>     bus_add_driver+0x112/0x210
>     driver_register+0x55/0x100
>     ? __pfx_cxl_mock_mem_driver_init+0x10/0x10 [cxl_mock_mem]
>     [...]
> 
> Move out cxl_memdev_security_init() and allow the pci probing to call
> it directly.
> 
> The cxl_memdev_security_shutdown() counterpart will still be called
> by the unregistering scenario, but is removed, however, from the
> devm_cxl_add_memdev() cleanup path - as this is about ioctls and
> there is no way for the sanitation to become active during that time.
> 
> [0] https://lore.kernel.org/all/168592160379.1948938.12863272903570476312.stgit@dwillia2-xfh.jf.intel.com/
> 
> Reported-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>   drivers/cxl/core/memdev.c | 17 ++++++-----------
>   drivers/cxl/cxlmem.h      |  1 +
>   drivers/cxl/pci.c         |  4 ++++
>   3 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 14b547c07f54..628d9d1fb795 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -561,7 +561,7 @@ static void cxl_memdev_security_shutdown(struct device *dev)
>   	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>   	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
>   
> -	if (mds->security.poll)
> +	if (mds && mds->security.poll)
>   		cancel_delayed_work_sync(&mds->security.poll_dwork);
>   }
>   
> @@ -570,7 +570,6 @@ static void cxl_memdev_shutdown(struct device *dev)
>   	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>   
>   	down_write(&cxl_memdev_rwsem);
> -	cxl_memdev_security_shutdown(dev);
>   	cxlmd->cxlds = NULL;
>   	up_write(&cxl_memdev_rwsem);
>   }
> @@ -580,6 +579,7 @@ static void cxl_memdev_unregister(void *_cxlmd)
>   	struct cxl_memdev *cxlmd = _cxlmd;
>   	struct device *dev = &cxlmd->dev;
>   
> +	cxl_memdev_security_shutdown(dev);
>   	cxl_memdev_shutdown(dev);
>   	cdev_device_del(&cxlmd->cdev, dev);
>   	put_device(dev);
> @@ -1009,11 +1009,10 @@ static void put_sanitize(void *data)
>   	sysfs_put(mds->security.sanitize_node);
>   }
>   
> -static int cxl_memdev_security_init(struct cxl_memdev *cxlmd)
> +int cxl_memdev_security_state_init(struct cxl_memdev_state *mds)
>   {
> -	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> -	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
> -	struct device *dev = &cxlmd->dev;
> +	struct cxl_dev_state *cxlds = &mds->cxlds;
> +	struct device *dev = &cxlds->cxlmd->dev;
>   	struct kernfs_node *sec;
>   
>   	sec = sysfs_get_dirent(dev->kobj.sd, "security");
> @@ -1029,7 +1028,7 @@ static int cxl_memdev_security_init(struct cxl_memdev *cxlmd)
>   	}
>   
>   	return devm_add_action_or_reset(cxlds->dev, put_sanitize, mds);
> - }
> +}
>   
>   struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
>   {
> @@ -1059,10 +1058,6 @@ struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
>   	if (rc)
>   		goto err;
>   
> -	rc = cxl_memdev_security_init(cxlmd);
> -	if (rc)
> -		goto err;
> -
>   	rc = devm_add_action_or_reset(cxlds->dev, cxl_memdev_unregister, cxlmd);
>   	if (rc)
>   		return ERR_PTR(rc);
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 706f8a6d1ef4..b99099eb2402 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -884,6 +884,7 @@ static inline void cxl_mem_active_dec(void)
>   #endif
>   
>   int cxl_mem_sanitize(struct cxl_memdev_state *mds, u16 cmd);
> +int cxl_memdev_security_state_init(struct cxl_memdev_state *mds);
>   
>   struct cxl_hdm {
>   	struct cxl_component_regs regs;
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 1cb1494c28fe..5242dbf0044d 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -887,6 +887,10 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   	if (IS_ERR(cxlmd))
>   		return PTR_ERR(cxlmd);
>   
> +	rc = cxl_memdev_security_state_init(mds);
> +	if (rc)
> +		return rc;
> +
>   	rc = cxl_memdev_setup_fw_upload(mds);
>   	if (rc)
>   		return rc;
