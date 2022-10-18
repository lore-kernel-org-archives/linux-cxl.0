Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20FABC4332F
	for <linux-cxl@archiver.kernel.org>; Tue, 18 Oct 2022 02:58:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiJRC6r (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 17 Oct 2022 22:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbiJRC6o (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 17 Oct 2022 22:58:44 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D0998CA6
        for <linux-cxl@vger.kernel.org>; Mon, 17 Oct 2022 19:58:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CiMQxq80SWVM0a7l2Wpqa6BNbLYEkJaZEJwAsBWn0IacBQKBg45zROafye1F0IJl7SPiNkvzCR0Egvo4CbImHLud6ox9LXpayWDiPiyDMr1HYk8bar1SSPqDFNQ/9OYbgf2q/5b2OzxjjITjrAhfbE7GaU+DoEi9a/NN9yGLy70ovXiINwxf59rXsmzNO9WeJenRq7dE5QViqWBNfIP+PqHmzlbvURf2Qdu6HpU/kwvZDxZsDtW3Z3pDpfWyn7bnQyAmj3sYINukHtF/3q1kY5oFOby7OEWGp9U3wolecBtyPLIFEj0OSZ2WnewfWwCEW9MxwQjlzcydlKZls3C/hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ARZYS7UHtaY9d6WUIWk3zCs54SOWei8NhWofP0u5xU=;
 b=d7TooudvIefsXLtiMzL1FsHcWPTllwY6g9W7+prI7qoTdUby/vM1NZkqrcgGkmGAtASw0JUjxM1OwmimWwfQ9i1fAcRZ/+TOJdRT2p7SLb0eJQjC28KrPeC9cRMXztyoZ++8D/c/BVReY1hZx6kAs8e84xkFTAkFaeTza7Dlh500rWwzKnxi3bwy8F0HlCPZL5VIBvImDqleNHsGuuKwldMNWZacdSucaTJ2HFIp/6gVHlT2YODx76ad0GXR/iWfqIeHsDFpckvncXN7e5koPd6qYL+R7A5ujDcWH+4UT4nS8WyqfQNGvmwkLLAJm6eqjbbxgnMVFAbFcd9Gx79vZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ARZYS7UHtaY9d6WUIWk3zCs54SOWei8NhWofP0u5xU=;
 b=sOgVJH6B4N7kP2af16c18QsnjNRIxBpEDFmKkzsetXYoDpoQzdx5Ft1gQl2f6X0jlWk4ZqBt0qNmYM3fgbyhQhDKYb8NIBxg43x9mLhhGia2eVK8ZRDrwZ583D1rQ9KW3FiQ0VrsBY9g3WeihSkvWMaYwpmkKVVfyhuGp8XJFW0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY4PR1201MB0181.namprd12.prod.outlook.com
 (2603:10b6:910:1f::11) by CH0PR12MB5156.namprd12.prod.outlook.com
 (2603:10b6:610:bb::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Tue, 18 Oct
 2022 02:58:23 +0000
Received: from CY4PR1201MB0181.namprd12.prod.outlook.com
 ([fe80::dd6a:ad02:bcf4:6758]) by CY4PR1201MB0181.namprd12.prod.outlook.com
 ([fe80::dd6a:ad02:bcf4:6758%11]) with mapi id 15.20.5723.033; Tue, 18 Oct
 2022 02:58:23 +0000
Message-ID: <a8d79f08-9891-395f-54fd-d5f00b67a521@amd.com>
Date:   Tue, 18 Oct 2022 04:58:13 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [BUG] hw/i386/pc.c: CXL Fixed Memory Window should not reserve
 e820 in bios
Content-Language: en-US
To:     Gregory Price <gourry.memverge@gmail.com>, qemu-devel@nongnu.org
Cc:     mst@redhat.com, marcel.apfelbaum@gmail.com, imammedo@redhat.com,
        ani@anisinha.ca, jonathan.cameron@huawei.com,
        linux-cxl@vger.kernel.org, alison.schofield@intel.com,
        dave@stgolabs.net, a.manzanares@samsung.com, bwidawsk@kernel.org,
        gregory.price@memverge.com, hchkuo@avery-design.com.tw,
        cbrowy@avery-design.com, ira.weiny@intel.com
References: <20221017234001.53297-1-gregory.price@memverge.com>
From:   "Gupta, Pankaj" <pankaj.gupta@amd.com>
In-Reply-To: <20221017234001.53297-1-gregory.price@memverge.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6PR02CA0032.eurprd02.prod.outlook.com
 (2603:10a6:20b:6e::45) To CY4PR1201MB0181.namprd12.prod.outlook.com
 (2603:10b6:910:1f::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0181:EE_|CH0PR12MB5156:EE_
X-MS-Office365-Filtering-Correlation-Id: af9d72a1-5ee1-47f5-7cd3-08dab0b49e67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8bOyPeU+DkWBDC3E1bKIWcWUa+1Ss9ATtRiNwJNeD/dC0rZAILMWlAxrjzit+N2IWgNtF6YuufCH31/hdlszw3jNMYDfIoiacDptSfHjJ4jeK53SwV35kHdK3Tk4/3PKImYOFSq/RqQPKrzMteqEPZqmtMdH4TYOLhsNc4fBbQkFA3iCstafqnru8GCfU0C9Cc2oKC/sKMEmDShbdFnjpwoz4Aa8aCMSTwYlsVMBZ6vFLgrftHDMc4eWqk7xGWk2RMY9ndc0gl68ccH8T7lgZDQhR0JmxYlmGheGaL4VQT2O2FYKhL7YfPQmdlDk918h/QtlZOQlaBiwOASnrZwT0Leiqs25O+JxZsFSIWRZ/e/oIk3vMlk5hTCN3MKuIlszJHSYgMEyCN9s7C1o8OuaNj83H/ISrQ2meKwaGRBg4VW18DOxM7VY0mxtGpIRGrh+UEiiqnnOYrtDG4Bw74MddKbBrTO6kzoU6qK3mCpHet8AdMTdjOBceo+vellwTHEthaeEr5fWbU3FEp78228+KnCoMfn8Jyupr8ZnL96zsTCRzE6TdDs57oA+jcWm/f7iGX14g3+/j7qOqnUyasBrgM2GV3ho6tVeS96eysK2GX+h9WhLvpznZ4DvO/FWQVe/MRMtzPsWVfeiUSK2fgJDJqtREyfmhOyjF7ZoB6gGfftyBxZdgfyLtyoOtgjEVRcS66XvLsQYoXAr19+x8T/NU6LLVyEpU9lUGJwlU2B8bnkFZMbU81bPCpWfe/MUkuaSRH6rE8oaXFT86EEBSosX44s0+5+CCjRNF9YK0y7rS1Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1201MB0181.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(396003)(39860400002)(366004)(346002)(451199015)(31696002)(7416002)(5660300002)(8936002)(66476007)(41300700001)(4326008)(38100700002)(66946007)(66556008)(8676002)(86362001)(36756003)(186003)(2906002)(2616005)(6666004)(6506007)(478600001)(6512007)(26005)(6486002)(83380400001)(316002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3cveHZmRWJabTRTVmVmckdRclFBNWtrREk1UEJRZzFXOTVmMzdWVHhqa2ZD?=
 =?utf-8?B?czM2QjloQ0UxTytOQlR3VlRKREZ5a2lBc1BOUmpsNW1VS1YrT1Y0TTEydmNU?=
 =?utf-8?B?UE1sTVlNQmJma3RqU2hIcjN6a2JYb2Z4YVV6NTVLV3p4R3NPK0lpWHJvdDMy?=
 =?utf-8?B?eUZGckNra0VFMk5sZm14WTRmUTYyWHRWQTltTThZblZ0YmxHQ0dqSEtIeEg4?=
 =?utf-8?B?QkFXNjQxbkFST3lMUGxUVWtLQ0RFWDVnZ0hmeWsvek9jT09YMHJ3dDVxRml0?=
 =?utf-8?B?WEovK1hZSGpvK2VPdEk3NzU4RWtKMGN4cTBUcnUwb1podjF5cFgvampvMHVJ?=
 =?utf-8?B?Y09ackhyM2phcy90QjZGM2FRb1JIZ0tqSE8zQStJdGNIRUs2SE10TVYzSGYy?=
 =?utf-8?B?WTgzWi9XcmJTZW1nQytONWJPR0FRamNyV0xVT3pMd01ibjg5aWI5QmxpUVJE?=
 =?utf-8?B?cDhmQ0tpTVRlVEd2OHJsbkwxWmJRcXBPdElzUVY1bXpBMmtLVElUbEdzaXhU?=
 =?utf-8?B?K25MejkrTU5VRExLd0h5d2V5bGhOQ2h0NVNRcXk0VU93NExFZ0Nsa2h4bkFZ?=
 =?utf-8?B?eEI4OXhMZmYrdnVNYjFOdXZkcEg0aXZuaER5UEpGbmM3T1A1bVpSeXYyZXQv?=
 =?utf-8?B?ZjBETlZudjhiWGlRN21qVTdNQVdnRFlKWGo4TUhiRlpxRUZnd2c5b2J2S0FC?=
 =?utf-8?B?c05XMkh0SFdSNFV5WU52SmNwMHhSd3J5Z0RTTXFGWlVuZU9wVTlUVk4rSHM0?=
 =?utf-8?B?UkpyQW5RQkQ1bzI2Y085U01CaTRYcE1kMzFEYm9uTzJNanhLVlBqbHNRQk04?=
 =?utf-8?B?Y3ZtQnVmVTYwYlZIdHhaY1VEckFjQkxqZE1NdTZjUk8rb251eHRPRHlZbTI1?=
 =?utf-8?B?dENMc0JEUVdOT3JPZ1NVYkZyQXVGYUVrMkcxckNZQUJyZmFGeUJvRVFiUmNu?=
 =?utf-8?B?ZTNnUG1wckRwQmhTeXJLQjB4dDl3K2hYcDFkS2tJclRMQzB2M3lsemNKTmJw?=
 =?utf-8?B?VVBLek51Y1RWcldYdXJOKy9mWENEOWpraHRKR3RhSFdjaEQzaVRwdVBqOUtk?=
 =?utf-8?B?S3VTUjhrdGhpWGtKT085Z0k2Tm11ZUdiS3FOSFJSbllMT3F6NVl6eUlhdEZU?=
 =?utf-8?B?bFYwcVJibmQzSHU4OUZUTE9TV3c1dFA0T09CcVdLanhoWHdvWDI0aDlJRVh2?=
 =?utf-8?B?WVZDdGNNN1ZTeEJnamFFL3EzSDdIQ2d2YUYyTkpWZHB4TmgwQjI3QzZRekNw?=
 =?utf-8?B?Vlo2VUdsaTJMS01UVjNVUFFaNG9nLy9ScytTZGtMbFZyQXNrOWROQTBvZXMr?=
 =?utf-8?B?QzlzbTlXQUgyUUg1R0owMG4yZnlUUkQ2YjdCMHJvTmlxclpyMUtLaERZMkFD?=
 =?utf-8?B?anZwUG9zRXV3UlV2NUxlNWVPa01KV3N4SUJvQld5SkhFV0Y1dk0vbHFzbEpN?=
 =?utf-8?B?K3VhdnZoRWNnT1lJNFhhWklOR0ZGNVQ1YWt6bnBZak1jQlZhb0pJWDZmL1dW?=
 =?utf-8?B?NkxoN0FSd2ZiYkVvV05KNFhFUnk3dGdrZllocElOaS9VeHBhY1BkaFBqanlN?=
 =?utf-8?B?RUR2a010dmh5QVE1Mk5TNEgwK3dieDJxZWtaQndmQm5lQVZ3ckxvSVFLd1Nm?=
 =?utf-8?B?dTlTQnpEZURlM1FDTUcvNmNHazAvUDFRZlhiN0RqcDc5ckFnOWpmajJ0Qits?=
 =?utf-8?B?TUhIQ3lpdllrVFdCbVpjbC9LRVVWWHJEczdPZFVUTmwrU0t3eHdQL2N1R3RT?=
 =?utf-8?B?UW9PMVl4TkJLN0dkZXd2T0NOZGtvYmI1SkhISS9peEtHVzlkRWlvL25EYWVp?=
 =?utf-8?B?SzUxSDN0ZGJQcjRTUjlVMjR0RnRMU1FOekdiOU1nWnVueG5EL1FqYWpDRGdB?=
 =?utf-8?B?Qlo5cUtUVjlGVUUwemdGNFJIZFU4M0h0MTY1TUlEZVcwQjhZUDNJb0p1cmVq?=
 =?utf-8?B?OTFzZUExbUg5cnFRY3dXMmhqYzc0VjlMZTRuMUlnZnhkaFBnb2R6d1VaLzNw?=
 =?utf-8?B?aUMwb294TWRYWllwc04vTG91TXlIQkhzY2RIMUlJeXpCOGxJd1BIYUkxZFBJ?=
 =?utf-8?B?LzhxeEVNYk0xVko0OFJBVDhKN2UwWWV4dTlnVUNnMzd2bVBtYi9nRHM3dWZi?=
 =?utf-8?Q?t/3mi3oxgs61JsCuuhR1OsFQb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af9d72a1-5ee1-47f5-7cd3-08dab0b49e67
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB0181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 02:58:22.9373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LtV7U8VK+vXK99w/yZdzEZDVApkcGM1ZItSQlkrKsAIOOow0y1cqgRkoR3Cg7IWbCcY+KHcW1hpNVhystbXZVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5156
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


> Early-boot e820 records will be inserted by the bios/efi/early boot
> software and be reported to the kernel via insert_resource.  Later, when
> CXL drivers iterate through the regions again, they will insert another
> resource and make the RESERVED memory area a child.
> 
> This RESERVED memory area causes the memory region to become unusable,
> and as a result attempting to create memory regions with
> 
>      `cxl create-region ...`
> 
> Will fail due to the RESERVED area intersecting with the CXL window.
> 
> 
> During boot the following traceback is observed:
> 
> 0xffffffff81101650 in insert_resource_expand_to_fit ()
> 0xffffffff83d964c5 in e820__reserve_resources_late ()
> 0xffffffff83e03210 in pcibios_resource_survey ()
> 0xffffffff83e04f4a in pcibios_init ()
> 
> Which produces a call to reserve the CFMWS area:
> 
> (gdb) p *new
> $54 = {start = 0x290000000, end = 0x2cfffffff, name = "Reserved",
>         flags = 0x200, desc = 0x7, parent = 0x0, sibling = 0x0,
>         child = 0x0}
> 
> Later the Kernel parses ACPI tables and reserves the exact same area as
> the CXL Fixed Memory Window.  The use of `insert_resource_conflict`
> retains the RESERVED region and makes it a child of the new region.
> 
> 0xffffffff811016a4 in insert_resource_conflict ()
>                        insert_resource ()
> 0xffffffff81a81389 in cxl_parse_cfmws ()
> 0xffffffff818c4a81 in call_handler ()
>                        acpi_parse_entries_array ()
> 
> (gdb) p/x *new
> $59 = {start = 0x290000000, end = 0x2cfffffff, name = "CXL Window 0",
>         flags = 0x200, desc = 0x0, parent = 0x0, sibling = 0x0,
>         child = 0x0}
> 
> This produces the following output in /proc/iomem:
> 
> 590000000-68fffffff : CXL Window 0
>    590000000-68fffffff : Reserved
> 
> This reserved area causes `get_free_mem_region()` to fail due to a check
> against `__region_intersects()`.  Due to this reserved area, the
> intersect check will only ever return REGION_INTERSECTS, which causes
> `cxl create-region` to always fail.
> 
> Signed-off-by: Gregory Price <gregory.price@memverge.com>
> ---
>   hw/i386/pc.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 566accf7e6..5bf5465a21 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1061,7 +1061,6 @@ void pc_memory_init(PCMachineState *pcms,
>           hwaddr cxl_size = MiB;
>   
>           cxl_base = pc_get_cxl_range_start(pcms);
> -        e820_add_entry(cxl_base, cxl_size, E820_RESERVED);
>           memory_region_init(mr, OBJECT(machine), "cxl_host_reg", cxl_size);
>           memory_region_add_subregion(system_memory, cxl_base, mr);
>           cxl_resv_end = cxl_base + cxl_size;
> @@ -1077,7 +1076,6 @@ void pc_memory_init(PCMachineState *pcms,
>                   memory_region_init_io(&fw->mr, OBJECT(machine), &cfmws_ops, fw,
>                                         "cxl-fixed-memory-region", fw->size);
>                   memory_region_add_subregion(system_memory, fw->base, &fw->mr);

Or will this be subregion of cxl_base?

Thanks,
Pankaj
> -                e820_add_entry(fw->base, fw->size, E820_RESERVED);
>                   cxl_fmw_base += fw->size;
>                   cxl_resv_end = cxl_fmw_base;
>               }

