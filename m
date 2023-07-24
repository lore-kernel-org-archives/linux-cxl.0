Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4722C0015E
	for <linux-cxl@archiver.kernel.org>; Mon, 24 Jul 2023 16:29:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbjGXQ3g (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 24 Jul 2023 12:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbjGXQ3Z (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 24 Jul 2023 12:29:25 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2085.outbound.protection.outlook.com [40.107.100.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8931725
        for <linux-cxl@vger.kernel.org>; Mon, 24 Jul 2023 09:29:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m+DSVuS6a/8VgPTuVJcFHEtsTGJkhrTmJw9XJeAbpkyBGXkizBedmId8/lUzwnocdEvwz+bQW63cuaSnwm3dtPUkq6YTiGpZG2a6VqZaYEjpZ8u4SHJDtd1jrn5eOBRpqdx8CwN9V2ioAohWvaBYuFsFnjM8q0GehbDIjV4qi8rFS9tzx9BfpzbtQnkbFaNG2Ug+A5a9+dVdAH6aCdACZzKQYwTLtWoPhFZR43i6qFn1yMvagA6NOlD+Gbzxw5ucMYXGhfwKNecfDr//EAqZVrAV0Jnkv+JoAVyKClYPhSSsfrNk3w7KVP7T8BLZivb451+J174aXkclH5oL2ef0xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IMfrGP5Zvlco2Ov3wkCCPLjMoX4J0VRYjuWkNsFQ7IM=;
 b=gk3U7wqPP/R/wDn3m9zVC8MuhYBkpH1+Uc7KqYfXDf7oIektXciWkwMDMo26qI70Ct5m6rBC4EtyIHqGssxBo2pOGdsLoWChrpCMF9gdB6iXpPWEf/MkMGcnhnMy8/cLazap6aqbWZNKh1Qwtilwoe2hNjKiAmxS5ZXO0DP3gHGF0l4GECBUfNtmUh7pwHSH84bVLVoxdyPNL/R9GWBsy4zCFRbx0dyiv3yx88xh+mTlOvdyXd57Jn2FOaVqigtdQAUghlIQvG//cv5GKKKBJxuI95fkKb0jlj+cmDlCX1s4ZDrfzGUlcDYGBNRIk8uoYsz1f8J76uoSh2lyApGRng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IMfrGP5Zvlco2Ov3wkCCPLjMoX4J0VRYjuWkNsFQ7IM=;
 b=1pXXU+fv8qq0XHfawGhWzvdm9W1L63ZG0bKJlYQD7b7AeyOOJCFzk1gz9LJ2QRoj2qS2TxFQAFUGR2WDRNPIJeEneX9zGSBxsKKqI4AOdJ0S43s8cq0M2yIhE7eizT8MIzwPvOIRA1kqJB4jGMpqkXugdDhmMm57AKIcrbryVhE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6222.namprd12.prod.outlook.com (2603:10b6:208:3c2::19)
 by DS0PR12MB8247.namprd12.prod.outlook.com (2603:10b6:8:f5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Mon, 24 Jul
 2023 16:29:14 +0000
Received: from MN0PR12MB6222.namprd12.prod.outlook.com
 ([fe80::9b81:467f:8267:9891]) by MN0PR12MB6222.namprd12.prod.outlook.com
 ([fe80::9b81:467f:8267:9891%6]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 16:29:13 +0000
Message-ID: <8d52b2bd-358f-4687-881b-e88c436538c8@amd.com>
Date:   Mon, 24 Jul 2023 11:29:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 5/9] hw/mem/cxl_type3: Add host backend and address space
 handling for DC regions
Content-Language: en-US
To:     nifan@outlook.com, qemu-devel@nongnu.org
Cc:     jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
        gregory.price@memverge.com, hchkuo@avery-design.com.tw,
        cbrowy@avery-design.com, ira.weiny@intel.com,
        dan.j.williams@intel.com, a.manzanares@samsung.com,
        dave@stgolabs.net, nmtadam.samsung@gmail.com,
        Fan Ni <fan.ni@samsung.com>
References: <20230720203708.25825-1-nifan@outlook.com>
 <SG2PR06MB33975BC8BD669EE2CE3880B0B23EA@SG2PR06MB3397.apcprd06.prod.outlook.com>
From:   Nathan Fontenot <nafonten@amd.com>
In-Reply-To: <SG2PR06MB33975BC8BD669EE2CE3880B0B23EA@SG2PR06MB3397.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0028.namprd05.prod.outlook.com
 (2603:10b6:803:40::41) To MN0PR12MB6222.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6222:EE_|DS0PR12MB8247:EE_
X-MS-Office365-Filtering-Correlation-Id: f8445797-0a35-4e46-c583-08db8c631e1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ndoEEa2cjkgU4Uos7n112LY2lHvy6Fn0GvAvMSPcf+tNROwikkJsZHD+kvyf7unT8YqVU4FcOwyg3RfneNKAtZ/cUuy0ye/jyGR9LH/C3iU4sYYp5FSSlrPH448zpysY4ynJLDvx/oeUGSDNkrIkYLnEmti/yHetSyh5mhQrCAsgTmD2lC5rkLuE0JeLjEEJnXJje122SriLO4w/jRTQBLKRN/ldCHrYcrTUnD+hnGg6wsbXNkvBUJfY2AxOwhrcUxTrgyBC5jU5Z5fOFCbnos9z/zq3Zpz59pir4u23CAqGF9URrEKEMcOz13m/l9/IT8hoXjy8rtb4C9wUKc64zM1pJVaAnq2ifZsrSO2zLq/0dHAqMaAzHsHMGglkSURewQclghELjhV5pCyPoUbGIhSYkWFB2u68RgDDumu/xhGDqYYJ8h3dnFUzYhP7mdpiSTvm1kfkJA80IKaLmLmM7NqhAYSzn65Yijz4Cb54K5cpGVIWkdyMNaLX29a1bDsEI8VckzRPjVkRqAZQrF0N85/ykn+1wP5/+s2SX02zbVQaHMknR040UzxoiFFeja7f1CdXJfLUzZhDXGvyq0jnqydqDireCEIyP5bQQ834wIYZwQ+/K2TPgBpxfXOmgDevRaC2Ys7fKuUSJPxKQVYRnYRz1PZydttFRBHEIwF4egLA3ERi6OOHlLAyPf/7kd0AzFyKUD261cc9DKEruyxnmQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6222.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(366004)(136003)(396003)(39860400002)(451199021)(53546011)(30864003)(41300700001)(6506007)(186003)(83380400001)(478600001)(26005)(2616005)(6512007)(2906002)(6486002)(36756003)(31696002)(45080400002)(7416002)(5660300002)(66556008)(66476007)(66946007)(4326008)(8936002)(8676002)(316002)(31686004)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1d5WUdLNVdSZ3RyZng3M09WODg0aUhST2FUNGFoT2FadTBtWmdrNytPdG5a?=
 =?utf-8?B?TGcraThrVXhMVi92bzNOM2ZMbGNwWDQrWEt6em9rYUg1WGxpQlRXbWNqdy9Q?=
 =?utf-8?B?TlMwKzRBeW9wOXQ1K1FRc3llTXJtbk1sdXVLWWFyWnMyRWl5dTZiQ3B3dmRh?=
 =?utf-8?B?Q2h6MjM2QjBUVlNuRFQ4dlJuTnFCdk4rTVVOOVlhWnM0SklPZ1BaenpWTnY1?=
 =?utf-8?B?d2IvSlA2SjdmQmdiYWltWEhHbzk3Y1FwR0VtRHNWV1dXVnNmLytRanFrM1ZX?=
 =?utf-8?B?clBWZFhhbHAvKzhOTzJZSms5d2lkMmJzQnBzdUFHMStEU0lRNkRuRWFRZk43?=
 =?utf-8?B?K0FZR1czcVBPSUsyaTB6T3JEQTNtMGNQL3lFazBrTTFyK3Bta0R1V3YwMkJC?=
 =?utf-8?B?UzdBQVNVMEtZaGNybm9JbG5KUHBpNUJocll1bjdrcytCKzdLRHpWaVBzdFdV?=
 =?utf-8?B?YTZVcm5FcjRiYUNBOFpqd2tiVTJDWHhoaDEzQitYWEI4Q2pvZldoUEpqNmE2?=
 =?utf-8?B?UHVpOUtVYVdvT2RQUU83cFNvVFlxdXpwS3RkZUM4RExMTTl1K1B5eGZ0K3F0?=
 =?utf-8?B?b3VsdHNSS1ZubENGRWt4Z3lybThUTUtMaUhybGhLcVJSUXpkeWN3Rkczd05H?=
 =?utf-8?B?NTFlWG0rQjIvbjZLRG0rM1VLWUEveHVGbE9qWFdpa1M4M0pLUzhhU3JwMlhn?=
 =?utf-8?B?YzYyNFlreGp0dXZFeUgvbm5ncE14ZWs5SGd3SnpDVkxmY3NONm9hQ0dqN0ND?=
 =?utf-8?B?MEE5QjMvQTB4aTZZK1VSUUVrVFlUNVo2bEpVVXphUXFwdnEvVEpLN1UrSFF6?=
 =?utf-8?B?ZmZvRm5lUWx3Q01rcGtBbU1Rd1lPMDA2TlI5SDMrYXVYR3NLKzZrV25saXkw?=
 =?utf-8?B?U0VXMUV1RmIvbEZmOFF3SGcxNGJ2S0sxTitQZktkV0FwdUdDTmpOTUVWOEtU?=
 =?utf-8?B?ZzJrTHNtbHdBVmY4aEU4UXhoQU9uVTFPZXZEOFhPbVlHSnhFdG92eFNlVnF1?=
 =?utf-8?B?TTgwQXNHcHJxamN0VlYrTSsyNllyUW0yY1BqMGRJT2pIUnZsNFk0bzNweU04?=
 =?utf-8?B?NXUvNkRHVFB5UTBwUXpnR05FcEZDRmFzcUw0T1cveXlST0s0Um1BMFh3Ym5o?=
 =?utf-8?B?U3VzZjFJRWZka2pQTS9MR3RIa3oreHRqd1MvYVhXazZjTEtPVEdxZXJFTmgz?=
 =?utf-8?B?Tlptc1FqMGNwSGlHTmIrdDcwODc2S0h2RlJJYTV6d3BqNXJwTkRQOWFFQVVn?=
 =?utf-8?B?KytCVG5vcVF5SG1BUVhONVVCaDdPUmtkUGNQYXFMUi9iN1NCd3FIMktDQjUy?=
 =?utf-8?B?S3NiQjdFYU1rZEJzRUNHbWRDVkFzSHV4eVlkbWY1VWxoY3ZaRlZoaXRFMVhm?=
 =?utf-8?B?YzVKSHhkV2ZFTW9uY0tkMTZiY0hrbTFOSDB2KzlGM0s3K0prTmZNMVk0YnBC?=
 =?utf-8?B?VE5sSmRqZVRaTm9KV2dFSGdzTnhJU3pHUDJjdU9UbnNWSUw0ZE43cGRkUkg5?=
 =?utf-8?B?WTZucmw4SkNSSnRKcmtOSHM2MEZ2bjh5cGVXSmxUUkxUTjNuUDRhQmZzNFRR?=
 =?utf-8?B?TmR0WStIeHdPc2NqWmoxWnBpYTVvYW5rci8xWlJxa3BESXdBZ0VBOEdDT2lR?=
 =?utf-8?B?Nm1JN0NteW15bTZOTzk3YTVNai9WNjJ5VHk3blhwOG1NZXNKazBuL2QrOEVs?=
 =?utf-8?B?eVNBNDZGVTJIVy9KNUZkTGw4N2kxOVFZVlRRU2RRbW4wS0tZNnFwME90UnUw?=
 =?utf-8?B?QURubG1DRUxCaVpuV3prSkFPRDQ5ODc5UUJKZngrTjB1TE1iWTBVN0FaL2lL?=
 =?utf-8?B?U1FOaTltUVFjSUQzTUFaV1Z2RUtla1FhR3Nadm80VWVmME8vQ3lJVjF0L3hW?=
 =?utf-8?B?eTR0Z3lhaFRyY3FpVjNHRTZNRy9KQ0tnLzJCWlhtSzI3LzF2QUFVaWljVGxK?=
 =?utf-8?B?bWNZSDdRNUdmbFFjNFdNajdmc3pVKzhaNXc4b3NUR1RVNlY4OWZPck9mMlBx?=
 =?utf-8?B?ckRuMmt6bU44WHVGcFM5WmRMMENVNE0zM0VkdDh4VmxRU0xOdndyQnZiRnNX?=
 =?utf-8?B?YXZiV0tYbXIzQ1BnVC8wWjVjbkRFaDhvWlJZMlBsVGpST1U1WVkvWEhTeVU4?=
 =?utf-8?Q?0mTTihgmtM0FVQuRYbRGVZqJB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8445797-0a35-4e46-c583-08db8c631e1b
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6222.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 16:29:13.8813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LkwVGzKGkiDGzPejWpAd7olxmglVClNevncaTgMrOEe5J67YF4C4Wlofxf5hUWijgrvVVJQxxwZagp3LR47+Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8247
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 7/20/23 15:37, nifan@outlook.com wrote:
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
> index 59d57ae245..c497298a1d 100644
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
> index 27b5920f7d..af1d919be3 100644
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

Shouldn't this be free'ed in the cases where we return false also?

Looks like you could put the gfree() call right after the address_space_init()
call.

-Nathan Fontenot

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
> @@ -1095,6 +1212,8 @@ static Property ct3_props[] = {
>      DEFINE_PROP_STRING("cdat", CXLType3Dev, cxl_cstate.cdat.filename),
>      DEFINE_PROP_UINT16("spdm", CXLType3Dev, spdm_port, 0),
>      DEFINE_PROP_UINT8("num-dc-regions", CXLType3Dev, dc.num_regions, 0),
> +    DEFINE_PROP_LINK("nonvolatile-dc-memdev", CXLType3Dev, dc.host_dc,
> +                    TYPE_MEMORY_BACKEND, HostMemoryBackend *),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> @@ -1161,33 +1280,43 @@ static void set_lsa(CXLType3Dev *ct3d, const void *buf, uint64_t size,
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
> index a32ee6d6ba..ddb24271a8 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -426,6 +426,10 @@ struct CXLType3Dev {
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
