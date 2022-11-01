Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E400CFA373D
	for <linux-cxl@archiver.kernel.org>; Tue,  1 Nov 2022 05:23:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbiKAFXn (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 1 Nov 2022 01:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbiKAFXk (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 1 Nov 2022 01:23:40 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C4DC12
        for <linux-cxl@vger.kernel.org>; Mon, 31 Oct 2022 22:23:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kbGLKIvMXntctdSlUPg3XYPtvoAEnrwuXWstVtACjrF3X/j743RE/LmGAn2xaJDm5p6hZjqOf0OUQ9xLOmzDkLwvKe+dYnLmhh+R7k/9HpGFq8jM5DIRbY0nsMi+vYeIXnqCeU/1rQy2KBpXDepL+w6wgp4gEjenzQM7jDCLVX+yyNsfeRewsfv2dC7nf16cFC1I6884AyrUb5XJd20uHFEo6oAyP3pg4Vmbrkj0n2kBbJ6CuxeGgkdGEwAR1BeMHK2eP70eoHF3T5cyB94tDm0Odd0wOwQLrCiNja3MG9n+DgVUFKsT4EDhnqavu9F1UieQ4kPWleCmg6jvuJLtjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d5v8bSnfihPNBAuiU4Tm9vakTo6kNzTYLLRRvxiXIcU=;
 b=ezuqEtqHOiw+f9FOYq8tiPFQh+TQixe2Ya+I8WKpzX/B5i+D7v+l62k6MkCRpZf724qK/dQp3d9HPU13YOEjRQZnWzROKeeaWvp7GAjZ1cNQF3J8NX/QEmPSVC06IeYci4zGtLKaG7kwJerhf0dARVmPJs3sCGf2GnccSg7Or2yCCgAJZ+09Nqrx+tjtJ4Lsy4xF+H3qyEAgj/7QS7JIi4Gy3EGQlU1LrcgRcq1/iQgNXXQvobU+0cdxeEEggINN3XJuvPQNSasmMg6BtIbz0ZuHJ0YrdQXXFi98PycrWtdndgGE55yIRTAWZaqbDdEyaKJBy06/DRghFSmmk2lD/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d5v8bSnfihPNBAuiU4Tm9vakTo6kNzTYLLRRvxiXIcU=;
 b=ykmWkmKtCHR+GpiiAdUQupf2NJOBEGJHK+Zwj6tPNAvwAANVl5nCzab3FNia2h1Y4wmvUxdDJge9BgNiWtdUTDqqHhVmzleCebjvGUaYd1H4y/iNnOSZipdWoORkNOtU7Ywa0F4GhJGqlaymTIGkkLgDnol0Sqh8D5QUopMqoNw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY4PR1201MB0181.namprd12.prod.outlook.com
 (2603:10b6:910:1f::11) by IA1PR12MB6282.namprd12.prod.outlook.com
 (2603:10b6:208:3e6::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Tue, 1 Nov
 2022 05:23:29 +0000
Received: from CY4PR1201MB0181.namprd12.prod.outlook.com
 ([fe80::a035:7550:7327:3d10]) by CY4PR1201MB0181.namprd12.prod.outlook.com
 ([fe80::a035:7550:7327:3d10%3]) with mapi id 15.20.5769.019; Tue, 1 Nov 2022
 05:23:29 +0000
Message-ID: <5e023420-eaee-d623-9375-ffc6594db084@amd.com>
Date:   Tue, 1 Nov 2022 06:23:22 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [ndctl PATCH] cxl: Fix some naming typos
Content-Language: en-US
To:     Fan Ni <fan.ni@samsung.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>
Cc:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Davidlohr Bueso <d.bueso@samsung.com>
References: <CGME20221028175929uscas1p1c78e5cd1b684f0b9a79302b8bc769a4f@uscas1p1.samsung.com>
 <20221028175752.27879-1-fan.ni@samsung.com>
From:   "Gupta, Pankaj" <pankaj.gupta@amd.com>
In-Reply-To: <20221028175752.27879-1-fan.ni@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS8P189CA0005.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:31f::18) To CY4PR1201MB0181.namprd12.prod.outlook.com
 (2603:10b6:910:1f::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0181:EE_|IA1PR12MB6282:EE_
X-MS-Office365-Filtering-Correlation-Id: d47708a5-ecdd-45e8-f759-08dabbc935a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zxh29oufqRxx3dLskwlBLaA/85UWNOkWw+MoV0xaufghhcsbYNs/7zHt9056kEoh3FttoQPBdmv6mcrBsqkj0n6N86c5iY9mNTbDY1VULIxSKGOh/+BPFfy5IIFwezq0p4QiKeYUEDcQ7pGeBbRTU6KRwG/TUw3JpEWu0kP5KplVge0IwRljl3xQptsfpUwAU2DG4QtkpjBWtpVaSjl6jZxit1lbRsDMg6JhnvOvW2db82NvRQwKeTmmETtDnyqG4LH8rwlWuSAXWpFmhdi5oPw8s93rJYUYYS64RqNVQZp3b2Qa7nO3eGlgg55a/Gsf77Gl4zyb6e2o2QXbyfuJLmbB1W9jrUyGfrKn2mS+9reKq625KW41EBHvExfQuV1S/27soTG95xem6l0wr8ZKakb0xg9USFKJI0WRBCucTW4OVcak+h1BcWN0F4f41PAMwMpfSs20ZeknH+Z+zLLymyoU1R1P5yWzGJuXHZkb3UXDNWcbWqTuVCiNUypn9CM/nPYyZYGtPILvsRZ5x/Pc/HHQJCRPB2ZRcOEW73ryZdV+88WYVR2+9Q0e0gArDXGaTvcoWwNTJE7mlMrCWHOXAxvSAQKpCRG3XDM7lTSUNkEst7fgPz50Q6bdtF0xpM1prYabNBb0qwKFxTkfUDS3RTTOrnY3b/wSHFqeVVgfpoKUU9XErHJF12cGvapMI7lPD3/d8Qfi2rCHoHxkiHRj90Yrb3UKlBHaXf4X310/n3vFINfoevtQPsd7gvA8TcNknn8gnWCg6JC6kWz2GcegjdJJdkxVftCb1YXIBNt5fdA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1201MB0181.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(39860400002)(136003)(366004)(396003)(451199015)(66556008)(36756003)(5660300002)(66476007)(110136005)(66946007)(4326008)(54906003)(2616005)(186003)(316002)(8676002)(8936002)(6486002)(38100700002)(41300700001)(2906002)(31686004)(6666004)(6512007)(6506007)(26005)(83380400001)(86362001)(31696002)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzdmLzVmZHU2MFhlQnNEODJGV2VST2tQRU9JYmlMcm1Gdmc5Z0V1dm1kdC9v?=
 =?utf-8?B?UlpBOThxczBvL2VLN2xhM21CTjNZV0M4bm95azVFSkpIV21oaVBXSmRBZDN0?=
 =?utf-8?B?WmhuYXRhVysxRHlFa0hMUWQvMXV5ODVqeWFqNEhmbldGbW9hVzhzSnFpNDNY?=
 =?utf-8?B?aG5uUTAya01abEcwNVVsMkJrbVVWcFM0eVgyTHZ0NjVTRzdkeThGT0lFNkhl?=
 =?utf-8?B?TDZnTTlCbVZpUVpSdFVjeHVtMnVrYWNmaFpHUWkwY0U0cVRneDlVaW5BdVc1?=
 =?utf-8?B?emZWL0xLZFd6NU9Dam4xcWVlZjFvVmsvbVdYT05rK3VUWkhGbm1rSWFIOUFm?=
 =?utf-8?B?TmdaV2poQkdSYndEUG52YkR1ZlBoZTJJL0xOMmQwVjhDaWNIbUlmaVU0VFRR?=
 =?utf-8?B?c2VvMGpHT251YVFPc0pkUnRwQWRqeHdIK21VbjJwZkphczNQd2J6eFBEQ3RO?=
 =?utf-8?B?eUtLZk9WejhFOTR4VHJlR2JXTVRnTEtuUnZCZlN6MndFOTgvYm45eXBqeHNT?=
 =?utf-8?B?MUdvY01NOWgvK1dJelhPUEU3QUk3clRjd3BRTm1hRnd1WnlMSHRBZnlZSXVO?=
 =?utf-8?B?UUpmYXR5dmVMUjlDenBtQ0xvYlo4MGtlOU1rVmVOUjM0eGgva1N1ZWlqZk9C?=
 =?utf-8?B?MXRpQ0FvWW1sUjJKYnFiaVh1bHhzeXJQK3c1Tnk4eE1YNFdNL0pObnVjS0d2?=
 =?utf-8?B?RW5CU3M3Mi92Ui9pb1BtQnZaM3pEamUwQVdGUWFEak9MUmZCdjJMVFBBVzBj?=
 =?utf-8?B?RHA4UU5mdjFsUldlVGVyNm9ua003azNPck9NWFRxQlU2NjdTVXRUcGVtQ050?=
 =?utf-8?B?R2xzK2NNWE9SQm9JcTNaOEVuYmF4ZjVZSVl0Q2ZkYVVjcFhHemxWY1JrYjNs?=
 =?utf-8?B?RXZGOXMwdlZxd2JhamtTaXJBajY0N0lCWVorY001SDZ5RE1xeFlzelcwMENu?=
 =?utf-8?B?dHZPbzc1ZW9FNzZZOTMwaUhqQnVlaThqVmZWQVB3TEtDUTNrdVlRczMxQ1g2?=
 =?utf-8?B?Q2FkTWdxYlRpaktKL2llK1FYQXJ0MU84OFRyVUJ2WmpNMFRST0JuMENWa0pC?=
 =?utf-8?B?aDM4OUw0V1BqdEVXd2NZVVIva0lvS1Iwb1VTajdaTUdRci93UWw4NkVxOWMx?=
 =?utf-8?B?ZElmNUxOaklOcWtBOW5SeEZzdU9oLy9FVDZPS1BRRzZQckFBdzA5b3pUMzhz?=
 =?utf-8?B?eERYUUMyTURrUTVKTUQ1WGN2QWR5aUdWVEM0Vnc5RjI3OFN6ZVU4MnU1WE9x?=
 =?utf-8?B?MXlwd0I4QkxRcWc2VXFLQVB5ekxyMVNBV25BSG5sd09pWUlsZzZpYjloUjBi?=
 =?utf-8?B?U0RjbVdJUE5CNmxBQk1ZNHg0elU1dHg3em5EaFIvcDRJV2ZHUTJyaUU2QmdV?=
 =?utf-8?B?cG9oaEpFNTBEdFJZZkdhbE9qWndKenpZNkZUSXUyRFhMdmZjTEIrVGFOUGNv?=
 =?utf-8?B?UTJ4Z0JpcmUzK1pHTDg1UmhPM3VzZmtjVURKMGNsRHNPMEJuT2tzOGZkY3FU?=
 =?utf-8?B?WkVpSkZZc081VFRsMTJ5Y3Q3SG5pMnRndW16cXZENktxYThjY1JXZm1QVUd1?=
 =?utf-8?B?OGExak5Qamx5azhCSlB6K09VM2xPbm9zMEkzS0lSUGNaaVhRczI0KytDeXJi?=
 =?utf-8?B?ZWs4TzdvNG81cFl0MnpHVkgrdlRrQWpSaVpRUlRvUGY0bkRkTDk1WEx0MlI3?=
 =?utf-8?B?cnVUY1VaRmc3eWJpa0JyZW8wcmVScEVKUmlHUjBZWDQ5VDBmd3JjR2NPbHFl?=
 =?utf-8?B?V04wdC8rRldnNVIyR1J3d0JBQkV0bTVTbkhsbjRtaVdGMTlyOGZQUy9pNk5O?=
 =?utf-8?B?U2lwMlRvTFhzYjJvRGpwMFJ5T1NCbUdYbjQwSUsySnBNbTJDRE14T285RGUr?=
 =?utf-8?B?L0krOVA2M2d0OHRHWFQwNEFNZ1dVbEhBd2diaERzN28xVVBEMk1RTTA2VDNC?=
 =?utf-8?B?VEVMNm4za05HTzgyVWN0dlQrZ0xhWnM0RHovMlV6T0pJWkxxOHp3Mkp6QXFj?=
 =?utf-8?B?MVdGYWxBMGU3elZOVlY1WU9nWXhsR2gzRUhjREs2UUZUOXF0RHgweUlVd2Er?=
 =?utf-8?B?eXFmWWFLWVNlR3B4bVNqd0JycHN4VTVMSVFaMHpBcWlsUVFLREI5cCs5NENi?=
 =?utf-8?Q?ZAfWVEFDVV4GgSRpTLZvg+RIA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d47708a5-ecdd-45e8-f759-08dabbc935a0
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB0181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 05:23:29.6095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WEqhpneFlPmyIja3T0nX27Vjiu3v8rvTgnelfoWa6sqjaBDsAAuZpCPCvTLu/Z/fCYLg8bB1xgRcoAeyy25kdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6282
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


> The function for retrieving firmware version is named
> `cxl_memdev_get_firmware_verison`, updated to `cxl_memdev_get_firmware_version'.
> 
> Signed-off-by: Fan Ni <fan.ni@samsung.com>
> ---
>   Documentation/cxl/lib/libcxl.txt | 2 +-
>   cxl/lib/libcxl.c                 | 2 +-
>   cxl/lib/libcxl.sym               | 2 +-
>   cxl/libcxl.h                     | 2 +-
>   4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/cxl/lib/libcxl.txt b/Documentation/cxl/lib/libcxl.txt
> index fd2962a..edc852d 100644
> --- a/Documentation/cxl/lib/libcxl.txt
> +++ b/Documentation/cxl/lib/libcxl.txt
> @@ -68,7 +68,7 @@ int cxl_memdev_get_major(struct cxl_memdev *memdev);
>   int cxl_memdev_get_minor(struct cxl_memdev *memdev);
>   unsigned long long cxl_memdev_get_pmem_size(struct cxl_memdev *memdev);
>   unsigned long long cxl_memdev_get_ram_size(struct cxl_memdev *memdev);
> -const char *cxl_memdev_get_firmware_verison(struct cxl_memdev *memdev);
> +const char *cxl_memdev_get_firmware_version(struct cxl_memdev *memdev);
>   size_t cxl_memdev_get_label_size(struct cxl_memdev *memdev);
>   int cxl_memdev_nvdimm_bridge_active(struct cxl_memdev *memdev);
>   int cxl_memdev_get_numa_node(struct cxl_memdev *memdev);
> diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
> index e8c5d44..b7ad263 100644
> --- a/cxl/lib/libcxl.c
> +++ b/cxl/lib/libcxl.c
> @@ -1262,7 +1262,7 @@ CXL_EXPORT unsigned long long cxl_memdev_get_ram_size(struct cxl_memdev *memdev)
>   	return memdev->ram_size;
>   }
>   
> -CXL_EXPORT const char *cxl_memdev_get_firmware_verison(struct cxl_memdev *memdev)
> +CXL_EXPORT const char *cxl_memdev_get_firmware_version(struct cxl_memdev *memdev)
>   {
>   	return memdev->firmware_version;
>   }
> diff --git a/cxl/lib/libcxl.sym b/cxl/lib/libcxl.sym
> index 8bb91e0..febbca6 100644
> --- a/cxl/lib/libcxl.sym
> +++ b/cxl/lib/libcxl.sym
> @@ -19,7 +19,7 @@ global:
>   	cxl_memdev_get_ctx;
>   	cxl_memdev_get_pmem_size;
>   	cxl_memdev_get_ram_size;
> -	cxl_memdev_get_firmware_verison;
> +	cxl_memdev_get_firmware_version;
>   	cxl_cmd_get_devname;
>   	cxl_cmd_new_raw;
>   	cxl_cmd_set_input_payload;
> diff --git a/cxl/libcxl.h b/cxl/libcxl.h
> index 9fe4e99..c3c99b8 100644
> --- a/cxl/libcxl.h
> +++ b/cxl/libcxl.h
> @@ -47,7 +47,7 @@ int cxl_memdev_get_minor(struct cxl_memdev *memdev);
>   struct cxl_ctx *cxl_memdev_get_ctx(struct cxl_memdev *memdev);
>   unsigned long long cxl_memdev_get_pmem_size(struct cxl_memdev *memdev);
>   unsigned long long cxl_memdev_get_ram_size(struct cxl_memdev *memdev);
> -const char *cxl_memdev_get_firmware_verison(struct cxl_memdev *memdev);
> +const char *cxl_memdev_get_firmware_version(struct cxl_memdev *memdev);
>   size_t cxl_memdev_get_label_size(struct cxl_memdev *memdev);
>   int cxl_memdev_disable_invalidate(struct cxl_memdev *memdev);
>   int cxl_memdev_enable(struct cxl_memdev *memdev);

Hard to find typo with naked eyes.

Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>

