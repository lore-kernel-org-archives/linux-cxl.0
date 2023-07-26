Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF28C0015E
	for <linux-cxl@archiver.kernel.org>; Wed, 26 Jul 2023 12:53:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbjGZMxb (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 26 Jul 2023 08:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbjGZMxa (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 26 Jul 2023 08:53:30 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297AB1BD6
        for <linux-cxl@vger.kernel.org>; Wed, 26 Jul 2023 05:53:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AR+AAFzpqnYsjsWLPHk2/tgHVv37TSCx9FK936hclDwi2JE1CHgII1t7ob0ikBvMeIDfuRN7QjTSyiRWQGg81gpv0rCHt92QMG6If1w60eRPtT9AcPuzGz7oc7HleIzkOarzIQA/pKNGt1VUlTApmb9w2FoSXFKWM+lmkj+hEArxU3IDOjsZJvKIyLsFWyRS9QRLc+Dka8I4mPt0d+BbConR2pNBmkXTQBQzyA8IFNSJqhAC1QSjyz+W8xDJII8FBf+SUqJCMPEH1GrQcauRMd3Y78tudmbM8h0hGnIiS1lEr5VE6ygw55P1tYxki6Ft9sDJp3ZaVEhyFUFk0+BJ0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UxeO7gdwMIubkFpzqQO7K+RrLubfF+UM9xIxwzZrppM=;
 b=J+PihbtbgYnEtLudSJHW4VplMtYsG03JkJ+uuWBe/T+VcF8xxI3iaS+vuXF8OgZBlEsbfVeO0RloyPizEcr2YiR/6FK4hsKOUQ03V/yC8uJpN5mTeMBUvLa8uck62xqQTsrO805XrX+pJTVbAWPH1+xrhyfgueEO/U23qzq3KJT8xZyOBKptxmHMYJ5i6fHtbVsytpKXm/GJ3XXclm/wXeBzklje7qvSRRXM/I9Wo/+2CVvA2P+AawOXRgl/x1VXFmlVUceMnXOKY7eV14H/iG3L+AbzGbP5qUpZaujqcNILhgbSbcGshOXMUhuyPp/DAJHMCV6YL1bpd8sCM/d4wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UxeO7gdwMIubkFpzqQO7K+RrLubfF+UM9xIxwzZrppM=;
 b=paeQKHt1DW980Lc0/3GqeTMKryftNP1lYgb12bbzeMELJoRra0e7EF5qwBr93LYtDrVBuW0YosADWVmrlJIOX+SGvEYHn5J7u0pQskEMngjWD/etuF/rbZY2yZaeLjH+FmM3/LOpQyBh6tchujlVXLK923XdIQ3g2TCymGmfMGY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6222.namprd12.prod.outlook.com (2603:10b6:208:3c2::19)
 by DM4PR12MB5914.namprd12.prod.outlook.com (2603:10b6:8:67::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Wed, 26 Jul
 2023 12:53:23 +0000
Received: from MN0PR12MB6222.namprd12.prod.outlook.com
 ([fe80::9b81:467f:8267:9891]) by MN0PR12MB6222.namprd12.prod.outlook.com
 ([fe80::9b81:467f:8267:9891%6]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 12:53:23 +0000
Message-ID: <1773a964-3597-434e-ca15-5ca1afdc116a@amd.com>
Date:   Wed, 26 Jul 2023 07:53:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [Qemu PATCH v2 5/9] hw/mem/cxl_type3: Add host backend and
 address space handling for DC regions
Content-Language: en-US
To:     Fan Ni <fan.ni@samsung.com>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc:     "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "gregory.price@memverge.com" <gregory.price@memverge.com>,
        "hchkuo@avery-design.com.tw" <hchkuo@avery-design.com.tw>,
        "cbrowy@avery-design.com" <cbrowy@avery-design.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "nmtadam.samsung@gmail.com" <nmtadam.samsung@gmail.com>,
        "nifan@outlook.com" <nifan@outlook.com>
References: <20230725183939.2741025-1-fan.ni@samsung.com>
 <CGME20230725183957uscas1p1eeb8e8eccc6c00b460d183027642374b@uscas1p1.samsung.com>
 <20230725183939.2741025-6-fan.ni@samsung.com>
From:   Nathan Fontenot <nafonten@amd.com>
In-Reply-To: <20230725183939.2741025-6-fan.ni@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR05CA0001.namprd05.prod.outlook.com
 (2603:10b6:805:de::14) To MN0PR12MB6222.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6222:EE_|DM4PR12MB5914:EE_
X-MS-Office365-Filtering-Correlation-Id: 7238f7cf-cba5-4b1c-b842-08db8dd74c0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KQ7bNmOauME+y21zcp5qjjxvNMKyROilPG3uKXChwlyuYjtlh2AwpqhZoyBLS+fb1VUKBl3e6Y6w7iXxiClbdj6SnWPYB0gJ/Pmqx1FuLcF+vvEugOX2jzE6+HRHm5u48uujtedT3JhT//5tmxSMvaVPQ3/vp0P7YMku0E0hnT+vVAjjLJOhFyi5ku66Q3Wo32qLf5XiblvLRep25Dsvsh7siApKJipHH4Jy0vjX2dzggnu911XcOdO0k/GXBZHpMVT6eoLptMWeW+9/rb8v1tDvOVH/1DXqyNsZ2vCWy+fuBExX7iQLk/8dtMAASM/6aitLkAUttPqJAbyiYdAA7RAOquYJYWm+oTwYqNIMt+vkwnOD6DSEc23kYDPFRz9oZF11qbSTbSvqWmBGEcuz2kl2bq0JWSN1ckxXV0cIuy3mz+CxXsMgcx4ciVmdwvB7brhgRYAVU0cTS3CrtV2wBV1Yif3w7kOZSQxmBhmD5Kl3/e//90WpoEgyiLEHQPzbosa/R/vTn6pVELyoo9xBI9PxdOXcZEyem/PD0fd+T7hOfNCtCWNLHVnR0ESz61CrurySkGElXVOwNzJMzqi3w5PJwv80r6cGfhzOVasFup7mFaHy+oWPo5HuOjk5nJ6Q912OWseQPvAi4pS2te6K8A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6222.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(39860400002)(346002)(366004)(136003)(451199021)(6506007)(26005)(186003)(2616005)(53546011)(66556008)(316002)(4326008)(36756003)(30864003)(66476007)(54906003)(2906002)(8936002)(5660300002)(66946007)(45080400002)(478600001)(6512007)(41300700001)(7416002)(8676002)(6486002)(110136005)(83380400001)(38100700002)(31696002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3JsbU15clVzU3hWVnl5K3hKa0JpOE5lMGtHWVkrZUtRQU1NaUQzZEtqTjNM?=
 =?utf-8?B?cWlIL0h5YThmdEVCcU1PZ252UTVmSWdONHNPYjBORmhsZ1FQdm8wcTRhRGc3?=
 =?utf-8?B?OEoySGJic0pmWWd4Q3pDWUlZWnFtY1E0WFQrWXdHSkNIQk9YRUh2YVpBMElY?=
 =?utf-8?B?WUxUcDE2NTV0Rjg1dnJOQ1c1NHBML1VLS2hacEZlK3Rub1VIQlFhdmkyUS92?=
 =?utf-8?B?WmhHZ1VMbFFNSkdudS9hcUV4M2Y0YVg4MDdEMHhpT0ZZUXQzU2Z0WTlXSncx?=
 =?utf-8?B?QUV5K2N0bEJqZ2FpYW9zRllmeTRPSzVTOWsyTXE2SjJnYSt2V25mK2RuTTl3?=
 =?utf-8?B?R0QvQ1Mxb25wTkZETVBJczRQRG5CK2pBRUxuR0pEbW5DY05VSUVPTXY3ck51?=
 =?utf-8?B?RHJ5YmFJbUZSdkhzTVFFR3cra0tBaThQZ3FpaThPUFpQMmxWYUk2R0pWMnhq?=
 =?utf-8?B?N1pZeVJwMGRBZEcxZy8xbTJ4VXdjc0FHYmNoOUhRR2xlZWV2QXhWcDZtUmtQ?=
 =?utf-8?B?TEwwQUlqS3VkZFpEdG9DVXNCTzQraWZWNUlaTGNCUUsvSi82aldRYnlEVEFI?=
 =?utf-8?B?Y3lsMzdKZXE1RzJYZUU2Um4rTXBnK0RvRHBWT2laOGlDSGFvajNlTDVNTjRD?=
 =?utf-8?B?dkczTmZYWFN5M2hMUE1CeFFXNTd4UmtPUHYyMVhZSGVqT1V5MEJUQnR3L3RO?=
 =?utf-8?B?MHdBQTRHRU9CcVFpenNpbkFTdVA2U3Z4YTMreHBiYnE2VXZRajFhWW5yZmJj?=
 =?utf-8?B?dGs2clYzNjVrdnJGdFJucGNHU2tXblpNRE1mZlFFa1krS0J0SUVFUUI0Lytj?=
 =?utf-8?B?NFdHaDA2WFplU0R4Qk1GWmJYTEY2WkI5OVViYkpIT1BBb0JQZHpPcFY2REEv?=
 =?utf-8?B?Nmhjb0JDbnByeHJkejdyTDk4eEVJY1lLcUNhNVBGU09oUm5EbUtUSGpZZnVP?=
 =?utf-8?B?bzk1Z1ZzNVJwU1NsYzJBZzN0ckVKRVJFa1FCZzJERk90QXFRMm4xNCt5N0t4?=
 =?utf-8?B?VVFBWlgwU2h6WHcrV2g1dWw1amVENndudi9HVWV1bWNUZWt1bkpYZk92L2Zr?=
 =?utf-8?B?Tkcra1NXcnpFSUFmc3NXM2VhN2pKcTM2bjRtV1NuZTNYdjVoc1dpOVQ2VkVr?=
 =?utf-8?B?amhiRnUvQmRFSnBtaTdaZk1GSTJiR1U2SURRdnRndlJZUk4vaWkwTGpYcUFV?=
 =?utf-8?B?NHQ4ekVDTWNvSDNVL0hqcTlWZmJ0TjRzL2x4UVFPWDZLOFp6SGI0SS9Zakhx?=
 =?utf-8?B?TXgrODdFMlpRTkJ4dkVGWGpPZDY4VTJYUm1Dd2NMc0dRRHdwdldMV1FxY0Z0?=
 =?utf-8?B?RjAyY25zMGVicUpWNTF3SjJDSWNLRkFNSkdTWEdDTWFCTVlBRHpFd09NYlNT?=
 =?utf-8?B?VjRnMHgzSS9yNnJOQld1OXJ2NFh3YXk3N1Q3THpxNmh3WUJ1ZlRTNzMxVmsx?=
 =?utf-8?B?bFhLUTZKWGx6Q1FXcUxQeVZVNm9Lb0s2b05ySmNzWU9BdUN2K2RyZ3hBcitt?=
 =?utf-8?B?TU1Md1hHb3IwYzR0NFZLT2NKSlY1Vk1uWVRGL2VEdExxMzN2Z2xZQVpackMv?=
 =?utf-8?B?TGZuVEFEVnJ4bUd4VWhBbXBmZFRjVDY5N1RHTWs2R0Zza1B4TVJFWDZYUys3?=
 =?utf-8?B?bWNGOVBlcHg5TlJEbDl2cVFSOGNhcHBwU01hQkFyazVxSmlBbU0xMzFwRGhp?=
 =?utf-8?B?SHh5aHkxYStHUlNSYlFTbVdOZGJxVzl1cWdTSlFZVUdwZmRZRVdLdFRpTS9U?=
 =?utf-8?B?Uy9nNEJFcmdBdDlqdU9iVnpSY05RaU51TDNkcE43THB0VlVOYjYrMytQNGFv?=
 =?utf-8?B?eGVMQXFyTkJSOThDUllvQlJWL2VhWk1SK2J0RW9VSnc3YkN6SWpJc0grL2d6?=
 =?utf-8?B?dWYrZ2NjbkpSbzQxM2pWR3pySnFsYjZudXZheDJxTXZGL2QraG56UU1jc1Jr?=
 =?utf-8?B?NWNzK2tJWGFBNWh3N0NCeDJ1a2lGTEZSUnFHb1JCRFNLRGJvLzdEYUkySHg1?=
 =?utf-8?B?UFhNOWRnNEpjeUpIcU15b2p1UFNRTERPVWFMem5DdS9vQnhmQityK20zaWJ6?=
 =?utf-8?B?SDVXQTJ0UkpvMWhuRFl2ajJkVjd2TEpGNVQyQTFIQS9tTDN0TUpoYnNxNTBq?=
 =?utf-8?Q?YZMO8iaEEDu562hPDyYSlQaSV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7238f7cf-cba5-4b1c-b842-08db8dd74c0a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6222.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 12:53:23.7848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j0mos/lnRDJ67OHQI6yZ1cfqHquuNVx3SFZRDx5T/LcQgTdCWomPAmF/BhgfXj11bU6CFfJdwVGQJ+4s3CYFeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5914
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 7/25/23 13:39, Fan Ni wrote:
> From: Fan Ni <nifan@outlook.com>
> 
> Add (file/memory backed) host backend, all the dynamic capacity regions
> will share a single, large enough host backend. Set up address space for
> DC regions to support read/write operations to dynamic capacity for DCD.
> 
> With the change, following supports are added:
> 1. add a new property to type3 device "nonvolatile-dc-memdev" to point to host
>    memory backend for dynamic capacity;
> 2. add namespace for dynamic capacity for read/write support;
> 3. create cdat entries for each dynamic capacity region;
> 4. fix dvsec range registers to include DC regions.
> 
> Signed-off-by: Fan Ni <fan.ni@samsung.com>
> ---
>  hw/cxl/cxl-mailbox-utils.c  |  19 +++-
>  hw/mem/cxl_type3.c          | 203 +++++++++++++++++++++++++++++-------
>  include/hw/cxl/cxl_device.h |   4 +
>  3 files changed, 185 insertions(+), 41 deletions(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index dd5ea95af8..0511b8e6f7 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -388,9 +388,11 @@ static CXLRetCode cmd_firmware_update_get_info(struct cxl_cmd *cmd,
>          char fw_rev4[0x10];
>      } QEMU_PACKED *fw_info;
>      QEMU_BUILD_BUG_ON(sizeof(*fw_info) != 0x50);
> +    CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
>  
>      if ((cxl_dstate->vmem_size < CXL_CAPACITY_MULTIPLIER) ||
> -        (cxl_dstate->pmem_size < CXL_CAPACITY_MULTIPLIER)) {
> +        (cxl_dstate->pmem_size < CXL_CAPACITY_MULTIPLIER) ||
> +        (ct3d->dc.total_capacity < CXL_CAPACITY_MULTIPLIER)) {
>          return CXL_MBOX_INTERNAL_ERROR;
>      }
>  
> @@ -531,7 +533,8 @@ static CXLRetCode cmd_identify_memory_device(struct cxl_cmd *cmd,
>      CXLType3Class *cvc = CXL_TYPE3_GET_CLASS(ct3d);
>  
>      if ((!QEMU_IS_ALIGNED(cxl_dstate->vmem_size, CXL_CAPACITY_MULTIPLIER)) ||
> -        (!QEMU_IS_ALIGNED(cxl_dstate->pmem_size, CXL_CAPACITY_MULTIPLIER))) {
> +        (!QEMU_IS_ALIGNED(cxl_dstate->pmem_size, CXL_CAPACITY_MULTIPLIER)) ||
> +        (!QEMU_IS_ALIGNED(ct3d->dc.total_capacity, CXL_CAPACITY_MULTIPLIER))) {
>          return CXL_MBOX_INTERNAL_ERROR;
>      }
>  
> @@ -566,9 +569,11 @@ static CXLRetCode cmd_ccls_get_partition_info(struct cxl_cmd *cmd,
>          uint64_t next_pmem;
>      } QEMU_PACKED *part_info = (void *)cmd->payload;
>      QEMU_BUILD_BUG_ON(sizeof(*part_info) != 0x20);
> +    CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
>  
>      if ((!QEMU_IS_ALIGNED(cxl_dstate->vmem_size, CXL_CAPACITY_MULTIPLIER)) ||
> -        (!QEMU_IS_ALIGNED(cxl_dstate->pmem_size, CXL_CAPACITY_MULTIPLIER))) {
> +        (!QEMU_IS_ALIGNED(cxl_dstate->pmem_size, CXL_CAPACITY_MULTIPLIER)) ||
> +        (!QEMU_IS_ALIGNED(ct3d->dc.total_capacity, CXL_CAPACITY_MULTIPLIER))) {
>          return CXL_MBOX_INTERNAL_ERROR;
>      }
>  
> @@ -880,7 +885,13 @@ static CXLRetCode cmd_media_clear_poison(struct cxl_cmd *cmd,
>      struct clear_poison_pl *in = (void *)cmd->payload;
>  
>      dpa = ldq_le_p(&in->dpa);
> -    if (dpa + CXL_CACHE_LINE_SIZE > cxl_dstate->static_mem_size) {
> +    if (dpa + CXL_CACHE_LINE_SIZE >= cxl_dstate->static_mem_size
> +            && ct3d->dc.num_regions == 0) {
> +        return CXL_MBOX_INVALID_PA;
> +    }
> +
> +    if (ct3d->dc.num_regions && dpa + CXL_CACHE_LINE_SIZE >=
> +            cxl_dstate->static_mem_size + ct3d->dc.total_capacity) {
>          return CXL_MBOX_INVALID_PA;
>      }
>  
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index b29bb2309a..76bbd9f785 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -20,6 +20,7 @@
>  #include "hw/pci/spdm.h"
>  
>  #define DWORD_BYTE 4
> +#define CXL_CAPACITY_MULTIPLIER   (256 * MiB)
>  
>  /* Default CDAT entries for a memory region */
>  enum {
> @@ -33,8 +34,8 @@ enum {
>  };
>  
>  static int ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
> -                                         int dsmad_handle, MemoryRegion *mr,
> -                                         bool is_pmem, uint64_t dpa_base)
> +        int dsmad_handle, uint8_t flags,
> +        uint64_t dpa_base, uint64_t size)
>  {
>      g_autofree CDATDsmas *dsmas = NULL;
>      g_autofree CDATDslbis *dslbis0 = NULL;
> @@ -53,9 +54,9 @@ static int ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
>              .length = sizeof(*dsmas),
>          },
>          .DSMADhandle = dsmad_handle,
> -        .flags = is_pmem ? CDAT_DSMAS_FLAG_NV : 0,
> +        .flags = flags,
>          .DPA_base = dpa_base,
> -        .DPA_length = memory_region_size(mr),
> +        .DPA_length = size,
>      };
>  
>      /* For now, no memory side cache, plausiblish numbers */
> @@ -137,9 +138,9 @@ static int ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
>           * NV: Reserved - the non volatile from DSMAS matters
>           * V: EFI_MEMORY_SP
>           */
> -        .EFI_memory_type_attr = is_pmem ? 2 : 1,
> +        .EFI_memory_type_attr = flags ? 2 : 1,
>          .DPA_offset = 0,
> -        .DPA_length = memory_region_size(mr),
> +        .DPA_length = size,
>      };
>  
>      /* Header always at start of structure */
> @@ -158,21 +159,28 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
>      g_autofree CDATSubHeader **table = NULL;
>      CXLType3Dev *ct3d = priv;
>      MemoryRegion *volatile_mr = NULL, *nonvolatile_mr = NULL;
> +    MemoryRegion *dc_mr = NULL;
>      int dsmad_handle = 0;
>      int cur_ent = 0;
>      int len = 0;
>      int rc, i;
> +    uint64_t vmr_size = 0, pmr_size = 0;
>  
> -    if (!ct3d->hostpmem && !ct3d->hostvmem) {
> +    if (!ct3d->hostpmem && !ct3d->hostvmem && !ct3d->dc.num_regions) {
>          return 0;
>      }
>  
> +    if (ct3d->hostpmem && ct3d->hostvmem && ct3d->dc.host_dc) {
> +        warn_report("The device has static ram and pmem and dynamic capacity");
> +    }
> +
>      if (ct3d->hostvmem) {
>          volatile_mr = host_memory_backend_get_memory(ct3d->hostvmem);
>          if (!volatile_mr) {
>              return -EINVAL;
>          }
>          len += CT3_CDAT_NUM_ENTRIES;
> +        vmr_size = volatile_mr->size;
>      }
>  
>      if (ct3d->hostpmem) {
> @@ -181,6 +189,19 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
>              return -EINVAL;
>          }
>          len += CT3_CDAT_NUM_ENTRIES;
> +        pmr_size = nonvolatile_mr->size;
> +    }
> +
> +    if (ct3d->dc.num_regions) {
> +        if (ct3d->dc.host_dc) {
> +            dc_mr = host_memory_backend_get_memory(ct3d->dc.host_dc);
> +            if (!dc_mr) {
> +                return -EINVAL;
> +            }
> +            len += CT3_CDAT_NUM_ENTRIES * ct3d->dc.num_regions;
> +        } else {
> +            return -EINVAL;
> +        }
>      }
>  
>      table = g_malloc0(len * sizeof(*table));
> @@ -190,8 +211,8 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
>  
>      /* Now fill them in */
>      if (volatile_mr) {
> -        rc = ct3_build_cdat_entries_for_mr(table, dsmad_handle++, volatile_mr,
> -                                           false, 0);
> +        rc = ct3_build_cdat_entries_for_mr(table, dsmad_handle++,
> +                0, 0, vmr_size);
>          if (rc < 0) {
>              return rc;
>          }
> @@ -200,14 +221,37 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
>  
>      if (nonvolatile_mr) {
>          rc = ct3_build_cdat_entries_for_mr(&(table[cur_ent]), dsmad_handle++,
> -                                           nonvolatile_mr, true,
> -                                           (volatile_mr ?
> -                                            memory_region_size(volatile_mr) : 0));
> +                CDAT_DSMAS_FLAG_NV, vmr_size, pmr_size);
>          if (rc < 0) {
>              goto error_cleanup;
>          }
>          cur_ent += CT3_CDAT_NUM_ENTRIES;
>      }
> +
> +    if (dc_mr) {
> +        uint64_t region_base = vmr_size + pmr_size;
> +
> +        /*
> +         * Currently we create cdat entries for each region, should we only
> +         * create dsmas table instead??
> +         * We assume all dc regions are non-volatile for now.
> +         *
> +         */
> +        for (i = 0; i < ct3d->dc.num_regions; i++) {
> +            rc = ct3_build_cdat_entries_for_mr(&(table[cur_ent])
> +                    , dsmad_handle++
> +                    , CDAT_DSMAS_FLAG_NV | CDAT_DSMAS_FLAG_DYNAMIC_CAP
> +                    , region_base, ct3d->dc.regions[i].len);
> +            if (rc < 0) {
> +                goto error_cleanup;
> +            }
> +            ct3d->dc.regions[i].dsmadhandle = dsmad_handle - 1;
> +
> +            cur_ent += CT3_CDAT_NUM_ENTRIES;
> +            region_base += ct3d->dc.regions[i].len;
> +        }
> +    }
> +
>      assert(len == cur_ent);
>  
>      *cdat_table = g_steal_pointer(&table);
> @@ -435,11 +479,24 @@ static void build_dvsecs(CXLType3Dev *ct3d)
>              range2_size_hi = ct3d->hostpmem->size >> 32;
>              range2_size_lo = (2 << 5) | (2 << 2) | 0x3 |
>                               (ct3d->hostpmem->size & 0xF0000000);
> +        } else if (ct3d->dc.host_dc) {
> +            range2_size_hi = ct3d->dc.host_dc->size >> 32;
> +            range2_size_lo = (2 << 5) | (2 << 2) | 0x3 |
> +                             (ct3d->dc.host_dc->size & 0xF0000000);
>          }
> -    } else {
> +    } else if (ct3d->hostpmem) {
>          range1_size_hi = ct3d->hostpmem->size >> 32;
>          range1_size_lo = (2 << 5) | (2 << 2) | 0x3 |
>                           (ct3d->hostpmem->size & 0xF0000000);
> +        if (ct3d->dc.host_dc) {
> +            range2_size_hi = ct3d->dc.host_dc->size >> 32;
> +            range2_size_lo = (2 << 5) | (2 << 2) | 0x3 |
> +                             (ct3d->dc.host_dc->size & 0xF0000000);
> +        }
> +    } else {
> +        range1_size_hi = ct3d->dc.host_dc->size >> 32;
> +        range1_size_lo = (2 << 5) | (2 << 2) | 0x3 |
> +            (ct3d->dc.host_dc->size & 0xF0000000);
>      }
>  
>      dvsec = (uint8_t *)&(CXLDVSECDevice){
> @@ -708,7 +765,8 @@ static void ct3d_reg_write(void *opaque, hwaddr offset, uint64_t value,
>  }
>  
>  /*
> - * Create a dc region to test "Get Dynamic Capacity Configuration" command.
> + * Create dc regions.
> + * TODO: region parameters are hard coded, may need to change in the future.
>   */
>  static int cxl_create_dc_regions(CXLType3Dev *ct3d)
>  {
> @@ -739,7 +797,8 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
>  {
>      DeviceState *ds = DEVICE(ct3d);
>  
> -    if (!ct3d->hostmem && !ct3d->hostvmem && !ct3d->hostpmem) {
> +    if (!ct3d->hostmem && !ct3d->hostvmem && !ct3d->hostpmem
> +            && !ct3d->dc.num_regions) {
>          error_setg(errp, "at least one memdev property must be set");
>          return false;
>      } else if (ct3d->hostmem && ct3d->hostpmem) {
> @@ -807,6 +866,50 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
>          return false;
>      }
>  
> +    ct3d->dc.total_capacity = 0;
> +    if (ct3d->dc.host_dc) {
> +        MemoryRegion *dc_mr;
> +        char *dc_name;
> +        uint64_t total_region_size = 0;
> +        int i;
> +
> +        dc_mr = host_memory_backend_get_memory(ct3d->dc.host_dc);
> +        if (!dc_mr) {
> +            error_setg(errp, "dynamic capacity must have backing device");
> +            return false;
> +        }
> +        /* FIXME: set dc as nonvolatile for now */
> +        memory_region_set_nonvolatile(dc_mr, true);
> +        memory_region_set_enabled(dc_mr, true);
> +        host_memory_backend_set_mapped(ct3d->dc.host_dc, true);
> +        if (ds->id) {
> +            dc_name = g_strdup_printf("cxl-dcd-dpa-dc-space:%s", ds->id);
> +        } else {
> +            dc_name = g_strdup("cxl-dcd-dpa-dc-space");
> +        }
> +        address_space_init(&ct3d->dc.host_dc_as, dc_mr, dc_name);
> +
> +        for (i = 0; i < ct3d->dc.num_regions; i++) {
> +            total_region_size += ct3d->dc.regions[i].len;
> +        }
> +        /* Make sure the host backend is large enough to cover all dc range */
> +        if (total_region_size > memory_region_size(dc_mr)) {
> +            error_setg(errp,
> +                "too small host backend size, increase to %lu MiB or more",
> +                total_region_size / 1024 / 1024);
> +            return false;
> +        }
> +
> +        if (dc_mr->size % CXL_CAPACITY_MULTIPLIER != 0) {
> +            error_setg(errp, "DC region size is unaligned to %lx",
> +                    CXL_CAPACITY_MULTIPLIER);
> +            return false;
> +        }
> +
> +        ct3d->dc.total_capacity = total_region_size;
> +        g_free(dc_name);

Shouldn't dc_name also be free'ed in the two places above where you return 
false?

I think you could just free it after the call address_space_init().

-Nathan

> +    }
> +
>      return true;
>  }
>  
> @@ -916,6 +1019,9 @@ err_release_cdat:
>  err_free_special_ops:
>      g_free(regs->special_ops);
>  err_address_space_free:
> +    if (ct3d->dc.host_dc) {
> +        address_space_destroy(&ct3d->dc.host_dc_as);
> +    }
>      if (ct3d->hostpmem) {
>          address_space_destroy(&ct3d->hostpmem_as);
>      }
> @@ -935,6 +1041,9 @@ static void ct3_exit(PCIDevice *pci_dev)
>      cxl_doe_cdat_release(cxl_cstate);
>      spdm_sock_fini(ct3d->doe_spdm.socket);
>      g_free(regs->special_ops);
> +    if (ct3d->dc.host_dc) {
> +        address_space_destroy(&ct3d->dc.host_dc_as);
> +    }
>      if (ct3d->hostpmem) {
>          address_space_destroy(&ct3d->hostpmem_as);
>      }
> @@ -999,16 +1108,24 @@ static int cxl_type3_hpa_to_as_and_dpa(CXLType3Dev *ct3d,
>                                         AddressSpace **as,
>                                         uint64_t *dpa_offset)
>  {
> -    MemoryRegion *vmr = NULL, *pmr = NULL;
> +    MemoryRegion *vmr = NULL, *pmr = NULL, *dc_mr = NULL;
> +    uint64_t vmr_size = 0, pmr_size = 0, dc_size = 0;
>  
>      if (ct3d->hostvmem) {
>          vmr = host_memory_backend_get_memory(ct3d->hostvmem);
> +        vmr_size = memory_region_size(vmr);
>      }
>      if (ct3d->hostpmem) {
>          pmr = host_memory_backend_get_memory(ct3d->hostpmem);
> +        pmr_size = memory_region_size(pmr);
> +    }
> +    if (ct3d->dc.host_dc) {
> +        dc_mr = host_memory_backend_get_memory(ct3d->dc.host_dc);
> +        /* Do we want dc_size to be dc_mr->size or not?? */
> +        dc_size = ct3d->dc.total_capacity;
>      }
>  
> -    if (!vmr && !pmr) {
> +    if (!vmr && !pmr && !dc_mr) {
>          return -ENODEV;
>      }
>  
> @@ -1016,19 +1133,19 @@ static int cxl_type3_hpa_to_as_and_dpa(CXLType3Dev *ct3d,
>          return -EINVAL;
>      }
>  
> -    if (*dpa_offset > ct3d->cxl_dstate.static_mem_size) {
> +    if ((*dpa_offset >= vmr_size + pmr_size + dc_size) ||
> +       (*dpa_offset >= vmr_size + pmr_size && ct3d->dc.num_regions == 0)) {
>          return -EINVAL;
>      }
>  
> -    if (vmr) {
> -        if (*dpa_offset < memory_region_size(vmr)) {
> -            *as = &ct3d->hostvmem_as;
> -        } else {
> -            *as = &ct3d->hostpmem_as;
> -            *dpa_offset -= memory_region_size(vmr);
> -        }
> -    } else {
> +    if (*dpa_offset < vmr_size) {
> +        *as = &ct3d->hostvmem_as;
> +    } else if (*dpa_offset < vmr_size + pmr_size) {
>          *as = &ct3d->hostpmem_as;
> +        *dpa_offset -= vmr_size;
> +    } else {
> +        *as = &ct3d->dc.host_dc_as;
> +        *dpa_offset -= (vmr_size + pmr_size);
>      }
>  
>      return 0;
> @@ -1101,6 +1218,8 @@ static Property ct3_props[] = {
>      DEFINE_PROP_STRING("cdat", CXLType3Dev, cxl_cstate.cdat.filename),
>      DEFINE_PROP_UINT16("spdm", CXLType3Dev, spdm_port, 0),
>      DEFINE_PROP_UINT8("num-dc-regions", CXLType3Dev, dc.num_regions, 0),
> +    DEFINE_PROP_LINK("nonvolatile-dc-memdev", CXLType3Dev, dc.host_dc,
> +                    TYPE_MEMORY_BACKEND, HostMemoryBackend *),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> @@ -1167,33 +1286,43 @@ static void set_lsa(CXLType3Dev *ct3d, const void *buf, uint64_t size,
>  
>  static bool set_cacheline(CXLType3Dev *ct3d, uint64_t dpa_offset, uint8_t *data)
>  {
> -    MemoryRegion *vmr = NULL, *pmr = NULL;
> +    MemoryRegion *vmr = NULL, *pmr = NULL, *dc_mr = NULL;
>      AddressSpace *as;
> +    uint64_t vmr_size = 0, pmr_size = 0, dc_size = 0;
>  
>      if (ct3d->hostvmem) {
>          vmr = host_memory_backend_get_memory(ct3d->hostvmem);
> +        vmr_size = memory_region_size(vmr);
>      }
>      if (ct3d->hostpmem) {
>          pmr = host_memory_backend_get_memory(ct3d->hostpmem);
> +        pmr_size = memory_region_size(pmr);
>      }
> +    if (ct3d->dc.host_dc) {
> +        dc_mr = host_memory_backend_get_memory(ct3d->dc.host_dc);
> +        dc_size = ct3d->dc.total_capacity;
> +     }
>  
> -    if (!vmr && !pmr) {
> +    if (!vmr && !pmr && !dc_mr) {
>          return false;
>      }
>  
> -    if (dpa_offset + CXL_CACHE_LINE_SIZE > ct3d->cxl_dstate.static_mem_size) {
> +    if (dpa_offset >= vmr_size + pmr_size + dc_size) {
> +        return false;
> +    }
> +    if (dpa_offset + CXL_CACHE_LINE_SIZE >= vmr_size + pmr_size
> +            && ct3d->dc.num_regions == 0) {
>          return false;
>      }
>  
> -    if (vmr) {
> -        if (dpa_offset < memory_region_size(vmr)) {
> -            as = &ct3d->hostvmem_as;
> -        } else {
> -            as = &ct3d->hostpmem_as;
> -            dpa_offset -= memory_region_size(vmr);
> -        }
> -    } else {
> +    if (dpa_offset < vmr_size) {
> +        as = &ct3d->hostvmem_as;
> +    } else if (dpa_offset < vmr_size + pmr_size) {
>          as = &ct3d->hostpmem_as;
> +        dpa_offset -= vmr->size;
> +    } else {
> +        as = &ct3d->dc.host_dc_as;
> +        dpa_offset -= (vmr_size + pmr_size);
>      }
>  
>      address_space_write(as, dpa_offset, MEMTXATTRS_UNSPECIFIED, &data,
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index 503c344326..1c99b05a66 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -427,6 +427,10 @@ struct CXLType3Dev {
>      uint64_t poison_list_overflow_ts;
>  
>      struct dynamic_capacity {
> +        HostMemoryBackend *host_dc;
> +        AddressSpace host_dc_as;
> +        uint64_t total_capacity; /* 256M aligned */
> +
>          uint8_t num_regions; /* 0-8 regions */
>          struct CXLDCD_Region regions[DCD_MAX_REGION_NUM];
>      } dc;
