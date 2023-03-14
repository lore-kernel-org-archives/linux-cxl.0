Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB25C6FD1F
	for <linux-cxl@archiver.kernel.org>; Tue, 14 Mar 2023 05:29:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjCNF3x (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 14 Mar 2023 01:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjCNF3w (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 14 Mar 2023 01:29:52 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2055.outbound.protection.outlook.com [40.92.52.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9F74FF0E
        for <linux-cxl@vger.kernel.org>; Mon, 13 Mar 2023 22:29:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rz/cGubfD6JrgO6ZjcI14dXaXyUvc7LzMRJuXHsVzgXvVoAeGhSFOSKrX0fowK56aAnpRR2siZB0CdFlErwd+ngCVExmMZ20f7rf6GtsaLnPUyTQteG+pCEbNZlchovYuAZvri5/t4+7ZarLxhCrp7JYPUtMpY0rFubKxNkotE75TcKfx2bFwwX35hLIsDX1EWF2qyq6VocAhAmhW7bRVXR+7o54b6b5/peJRbUv/4XOWXxfom7tRKRB2Ys4Wp7AnghShYz5uGZZtoSS6Mvm1uVe2ERmelQes/itS6UrLnnG5bAYDMJ7xOCoVSce22KWxn7BBNcpWc3hkyR0A7B2qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DmhQLwAB21jpmWCRdK39W9gK/fujSSvx4+EQ5QF+5bo=;
 b=CkumViTlayfCYJnR5uh46ikhayfqrvx8MPcpWJO/zJTRr6Dp3dZpT6d5POk/Ne8EebY5SCBpMI0Hhw+5dwP0U63GaiAvCpbz18lJDvbUB+6sqmwcDaEQYnMdPWLWUeWXbq3XdkTINfCraPqLBPeMlwY2zGBMSrJGYNpgv9KYgTs8R1NkdlmzXYSWXfmvxhuC8xGWlSDqSwR7YUiAIEzP7vWxPGUULLycvrZ+g6YdPVmMY2IGlqnNvC89OvCHGnx2byINkaBrFxYSFO1nDyna0MqG1JDeDZiR5d+OkV5cQfAAmnR3GoLf/Zq+6NYm7QFZXgknkomfc2mluPujn/p5yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DmhQLwAB21jpmWCRdK39W9gK/fujSSvx4+EQ5QF+5bo=;
 b=OTsluuE9MwC1EvVORmceHNAm5qxpBVPYPh+EFnFgYFdQPZ1klOGq5O+IF/KKTKqwlTK1Tf87W0X+lq8oYzeAxTWfRPIGFMMs8mB8XV+AeIpS2BU0QkaU9xUL3eJMa8B+YEKxaQploy0GrKW6Egz1963wbPzpSzSb5t9HBVD4yHfaAXKLuurSjgYIQ+Huyi3jzuNKHkKiMDx623XOvRGWqFk8RCY9ZQ1ycrfGhOSTYuov3GdojiQLy3LzFCLyE+zKWSHEv/+Y+t87EAqkD3iMDCakMbyGXdP+EWQr7w5DeRNvJPtKFVUkZ3s3B2bkYq09W5LSGJQjuZUI3Byxyf5fCw==
Received: from SG2PR06MB3397.apcprd06.prod.outlook.com (2603:1096:4:7a::17) by
 SEYPR06MB5513.apcprd06.prod.outlook.com (2603:1096:101:b4::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.24; Tue, 14 Mar 2023 05:29:31 +0000
Received: from SG2PR06MB3397.apcprd06.prod.outlook.com
 ([fe80::822f:761f:a577:c76e]) by SG2PR06MB3397.apcprd06.prod.outlook.com
 ([fe80::822f:761f:a577:c76e%4]) with mapi id 15.20.6178.024; Tue, 14 Mar 2023
 05:29:31 +0000
Date:   Mon, 13 Mar 2023 22:29:18 -0700
From:   Fan Ni <nifan@outlook.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     qemu-devel@nongnu.org, Michael Tsirkin <mst@redhat.com>,
        Fan Ni <fan.ni@samsung.com>, linux-cxl@vger.kernel.org,
        linuxarm@huawei.com, Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Michael Roth <michael.roth@amd.com>,
        Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Markus Armbruster <armbru@redhat.com>,
        Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
        Eric Blake <eblake@redhat.com>,
        Mike Maslenkin <mike.maslenkin@gmail.com>,
        =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
        Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v4 6/6] hw/cxl: Add clear poison mailbox command support.
Message-ID: <SG2PR06MB33977C429538FEF0D4153D8AB2BE9@SG2PR06MB3397.apcprd06.prod.outlook.com>
References: <20230303150908.27889-1-Jonathan.Cameron@huawei.com>
 <20230303150908.27889-7-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230303150908.27889-7-Jonathan.Cameron@huawei.com>
X-TMN:  [oN+hrHyZ3k35dUs+Twmx08DYGgXwRlp/]
X-ClientProxiedBy: BYAPR07CA0006.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::19) To SG2PR06MB3397.apcprd06.prod.outlook.com
 (2603:1096:4:7a::17)
X-Microsoft-Original-Message-ID: <ZBAGLgdJFiEwqchG@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3397:EE_|SEYPR06MB5513:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c68eaf2-e165-4524-41ed-08db244d1635
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JZEH2YvouS/OhcV31eIZAN4RE4hwKBLjGANY1aszsJpIpRlSFzR/nwkTPp459acj7WsiGmrKl7IyeJSqbwar1Y7of+TZYC3WX0yHwk2s0XJ+28+MsYG9QLjZTB0E5DZ1xGxlPaxqgV3nN7h4G/Evi5Oe7fvaxTuUXR674v32H5GNPiYz4EpGNERCLxaX+j4/RDu88O1XdGk1Q2VLF4LxYh9RA1m9n+VB2+va0Nj4lT6Odd2Kk/jx8q/rVnXgbIdGKGT3J1XFguzMwzuwj+mep89Q9g+QZnWQug18qg2ZvrBOAcBbdbbWQzJfHuRE0SC1B7ZyEAwwPu8HWxbWdBBR3CfVTrQQ2hGgM8H1B5xMgjZoISirn3Ik3urx65M93psPNrXOUnC221LhCZrSsjWF3Pu+PzWGHdKuHxObBh0KTXW1qme+Z69vbfxPYKdnPp+ADbTe8RthuhEcRQwq2fpiCXuNa+o3XkkHVQe5pMGFvtLlqLITXuQNqxxhfUuk7DpFh4oO914rAd1NMqd8GucfOy+OjJ2b9AyiN4KqniEr+NtKVKZDsP40ckxqITdwIh0KFZaOt8jc4oziU2RXpOCKmVoLttipBuCSiIu+88EnoUnVadNoUP5gE7Y66bSsNl6aDF95KA2G28qcsn+4yzdcJw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ME5nNnZSb3lZR1k0OWF2SElDN0lvRXQ0WVF5czFEbmlxTVBCdHJ4RWxjR2Fj?=
 =?utf-8?B?V1JBWk8wc3FEb2ZoWGFTM3AyV0VFY3BKdUNNWWFMMjloR2FXUUtUYm8yNmF0?=
 =?utf-8?B?WmdYRVRheWUyQXh2NWRCVUNNQ2pMS2RwdThDMjgxemVuK0ltU1VyZ2hoTEJp?=
 =?utf-8?B?bGRaalZOQ3RNZC9TclNPTUZnbE5VQVI5bVhlWis4dG0wVng0eGF2Q3RMTTdn?=
 =?utf-8?B?ZGc0T3FYLzdzK2xmSStpSEZxd0V0YTJMbGdBb3MrYW51OHBIZjJDS1djb3cr?=
 =?utf-8?B?dVpORGNhYTVtZWpHdVBVMXhPU1hGT1FuMzVVUnV3dGJtVHErZ09CMkNOWkhY?=
 =?utf-8?B?YXJLT3NvL1ljZFQ1aU9yME5QcFNab1V3WHM3Q1hpeE4wUTJ3c0FFVEo4amgv?=
 =?utf-8?B?NDZSM3BUV2hoUmxNUmNoVGxneXdTZSttalhCV2xJMmlsTUJRckgybnhaWm9G?=
 =?utf-8?B?aDZHTkVmT3piNVJwMmRBaUMwQThLZW41R2JLRi82Um1ud09SV3hkbkp3Sk1P?=
 =?utf-8?B?VHBpaGlUK00xODR3SzQ0cExIeFpXa040dGNpeGQxRUVRYktDVmJ1M0lZcHk3?=
 =?utf-8?B?UXFaMnZsM2VSaXM1Z1hGQTRQTW5yK3phd1J0bFllTytVNS9IeUkzTWxNdWxu?=
 =?utf-8?B?ek9uUG43UVpqQkMzWTNyU1BabzFyOTBCbTJyYlo0UE4rZVRvb0tpOFBBVGU1?=
 =?utf-8?B?SHdjSDVkNzZFTzFiVm8yQytUeGJKRGhvU3JxZnNxdEhUeWpMVUJiNkFKL0tu?=
 =?utf-8?B?eEVKbm5zWEhMZ3pZSmVnQzgxQ0ZCZmRTa2svOGlremxtVWE0T0FiZVMxN0Zk?=
 =?utf-8?B?aEdJRTBsTGFHcXNZWHFJeXZhV0JGN2cxYzNGL1BCQWd6V1hoQUNudFBQWlV2?=
 =?utf-8?B?UUovbUlRVEcreU5heHZHMEFxNUhwaE5QOFQ4MTdObEV3eWhKUkdycWxiV0RH?=
 =?utf-8?B?QXM1aFA5VWsrRElTajRlanBQSitITFNXNm5mSU9oN2plOTJTRUxnSWlDZldo?=
 =?utf-8?B?aFZna2t3MDMreGJ5S3dneFF6U1Q0K2ZiYUltN0hjdXVYVDBkbGZmUTR6REx1?=
 =?utf-8?B?VUJUUWlOLzBST1NIcmNuUGFOVHp1WmNYUWNBTzBTbmR6QzNucFY3R1FHd2RN?=
 =?utf-8?B?L3gvYzcva3orMFpaT3RIZFUwTHd0dndsRUV5UjJ1cTU5TnZTOEVIZThMWmlt?=
 =?utf-8?B?YzhlS3hPR28vcjFEYU9IVmpmNUZjNG5BVllmV3NHMEY0NTBvRWdEb0JtWVY1?=
 =?utf-8?B?WG0wWlZmQzFVQ3FFcmhvSnJiQktlYWQ5ZnhTQkFOWXZPSmNqbHBPVXNyOFQ1?=
 =?utf-8?B?dHcvUEJuRVJhK002SHllc1RlbVYyajFucVhHVjBla0Y5bDdXTTFYR2JhTk9Q?=
 =?utf-8?B?eVJrc0o0K0RRRlhzRWd6MHFIenozWjk1Um0xWFplYi9uNkkzTlZyNVhyME12?=
 =?utf-8?B?R09tdWoreE9MZ3dQSC9vcjlVQ3JIaCtqR1IxS3NjZUx5YXBnV1VvWFQ1RGpU?=
 =?utf-8?B?WDlZdXJpaFFtbTVnVDVvVGljWjlGYTZheGhTV202eUd6UGVNVWhzdno5U1Iv?=
 =?utf-8?B?ZG9ENTVST3VURDhZN0NYeThRMEZSOTBGV0RHalRoR3Fnbm0zR2U3ZERUMU44?=
 =?utf-8?B?bXp4VUk1Y2Rnd2dES2J3NWtzRXdzNEEzeGxTOUdEWWlwTmE2N2xSUldxVlI0?=
 =?utf-8?B?ZlpHZHBydlh1YWIvZm1sSnBmS1lNOGw4YTJjQmVodGYxRFR3S0IzUTRRPT0=?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c68eaf2-e165-4524-41ed-08db244d1635
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3397.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2023 05:29:31.0790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5513
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The 03/03/2023 15:09, Jonathan Cameron wrote:
> Current implementation is very simple so many of the corner
> cases do not exist (e.g. fragmenting larger poison list entries)
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

One minor thing as mentioned below.
> v4:
> - Fix off by one on check of edge of vmr (cut and paste from similar
>   but long fixed in the volatile memory series)
> - Drop unnecessary overflow check.
> - Ensure that even in case of overflow we still delete the element
>   replaced (in the hole punching case)
> ---
>  hw/cxl/cxl-mailbox-utils.c  | 77 +++++++++++++++++++++++++++++++++++++
>  hw/mem/cxl_type3.c          | 36 +++++++++++++++++
>  include/hw/cxl/cxl_device.h |  1 +
>  3 files changed, 114 insertions(+)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 64a3f3c1bf..0b30307fa3 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -65,6 +65,7 @@ enum {
>      MEDIA_AND_POISON = 0x43,
>          #define GET_POISON_LIST        0x0
>          #define INJECT_POISON          0x1
> +        #define CLEAR_POISON           0x2
>  };
>  
>  /* 8.2.8.4.5.1 Command Return Codes */
> @@ -511,6 +512,80 @@ static CXLRetCode cmd_media_inject_poison(struct cxl_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
>  
> +static CXLRetCode cmd_media_clear_poison(struct cxl_cmd *cmd,
> +                                         CXLDeviceState *cxl_dstate,
> +                                         uint16_t *len)


Since 'len' is never used in the function, I am wondering whether it
would be better to rename it to makes that more obvious like "len_unused".

> +{
> +    CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
> +    CXLPoisonList *poison_list = &ct3d->poison_list;
> +    CXLType3Class *cvc = CXL_TYPE3_GET_CLASS(ct3d);
> +    struct clear_poison_pl {
> +        uint64_t dpa;
> +        uint8_t data[64];
> +    };
> +    CXLPoison *ent;
> +    uint64_t dpa;
> +
> +    struct clear_poison_pl *in = (void *)cmd->payload;
> +
> +    dpa = ldq_le_p(&in->dpa);
> +    if (dpa + 64 > cxl_dstate->mem_size) {
> +        return CXL_MBOX_INVALID_PA;
> +    }
> +
> +    /* Always exit loop on entry removal so no need for safe variant */
> +    QLIST_FOREACH(ent, poison_list, node) {
> +        /*
> +         * Test for contained in entry. Simpler than general case
> +         * as clearing 64 bytes and entries 64 byte aligned
> +         */
> +        if ((dpa < ent->start) || (dpa >= ent->start + ent->length)) {
> +            continue;
> +        }
> +        /* Do accounting early as we know one will go away */
> +        ct3d->poison_list_cnt--;
> +        if (dpa > ent->start) {
> +            CXLPoison *frag;
> +            /* Cannot overflow as replacing existing entry */
> +
> +            frag = g_new0(CXLPoison, 1);
> +
> +            frag->start = ent->start;
> +            frag->length = dpa - ent->start;
> +            frag->type = ent->type;
> +
> +            QLIST_INSERT_HEAD(poison_list, frag, node);
> +            ct3d->poison_list_cnt++;
> +        }
> +        if (dpa + 64 < ent->start + ent->length) {
> +            CXLPoison *frag;
> +
> +            if (ct3d->poison_list_cnt == CXL_POISON_LIST_LIMIT) {
> +                cxl_set_poison_list_overflowed(ct3d);
> +            } else {
> +                frag = g_new0(CXLPoison, 1);
> +
> +                frag->start = dpa + 64;
> +                frag->length = ent->start + ent->length - frag->start;
> +                frag->type = ent->type;
> +                QLIST_INSERT_HEAD(poison_list, frag, node);
> +                ct3d->poison_list_cnt++;
> +            }
> +        }
> +        /* Any fragments have been added, free original entry */
> +        QLIST_REMOVE(ent, node);
> +        g_free(ent);
> +        break;
> +    }
> +    /* Clearing a region with no poison is not an error so always do so */
> +    if (cvc->set_cacheline)
> +        if (!cvc->set_cacheline(ct3d, dpa, in->data)) {
> +            return CXL_MBOX_INTERNAL_ERROR;
> +        }
> +
> +    return CXL_MBOX_SUCCESS;
> +}
> +
>  #define IMMEDIATE_CONFIG_CHANGE (1 << 1)
>  #define IMMEDIATE_DATA_CHANGE (1 << 2)
>  #define IMMEDIATE_POLICY_CHANGE (1 << 3)
> @@ -542,6 +617,8 @@ static struct cxl_cmd cxl_cmd_set[256][256] = {
>          cmd_media_get_poison_list, 16, 0 },
>      [MEDIA_AND_POISON][INJECT_POISON] = { "MEDIA_AND_POISON_INJECT_POISON",
>          cmd_media_inject_poison, 8, 0 },
> +    [MEDIA_AND_POISON][CLEAR_POISON] = { "MEDIA_AND_POISON_CLEAR_POISON",
> +        cmd_media_clear_poison, 72, 0 },
>  };
>  
>  void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 21e3a84785..0d9de0ee03 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -919,6 +919,41 @@ static void set_lsa(CXLType3Dev *ct3d, const void *buf, uint64_t size,
>       */
>  }
>  
> +static bool set_cacheline(CXLType3Dev *ct3d, uint64_t dpa_offset, uint8_t *data)
> +{
> +    MemoryRegion *vmr = NULL, *pmr = NULL;
> +    AddressSpace *as;
> +
> +    if (ct3d->hostvmem) {
> +        vmr = host_memory_backend_get_memory(ct3d->hostvmem);
> +    }
> +    if (ct3d->hostpmem) {
> +        pmr = host_memory_backend_get_memory(ct3d->hostpmem);
> +    }
> +
> +    if (!vmr && !pmr) {
> +        return false;
> +    }
> +
> +    if (dpa_offset + 64 > int128_get64(ct3d->cxl_dstate.mem_size)) {
> +        return false;
> +    }
> +
> +    if (vmr) {
> +        if (dpa_offset < int128_get64(vmr->size)) {
> +            as = &ct3d->hostvmem_as;
> +        } else {
> +            as = &ct3d->hostpmem_as;
> +            dpa_offset -= vmr->size;
> +        }
> +    } else {
> +        as = &ct3d->hostpmem_as;
> +    }
> +
> +    address_space_write(as, dpa_offset, MEMTXATTRS_UNSPECIFIED, &data, 64);
> +    return true;
> +}
> +
>  void cxl_set_poison_list_overflowed(CXLType3Dev *ct3d)
>  {
>          ct3d->poison_list_overflowed = true;
> @@ -1140,6 +1175,7 @@ static void ct3_class_init(ObjectClass *oc, void *data)
>      cvc->get_lsa_size = get_lsa_size;
>      cvc->get_lsa = get_lsa;
>      cvc->set_lsa = set_lsa;
> +    cvc->set_cacheline = set_cacheline;
>  }
>  
>  static const TypeInfo ct3d_info = {
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index 32c234ea91..73328a52cf 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -298,6 +298,7 @@ struct CXLType3Class {
>                          uint64_t offset);
>      void (*set_lsa)(CXLType3Dev *ct3d, const void *buf, uint64_t size,
>                      uint64_t offset);
> +    bool (*set_cacheline)(CXLType3Dev *ct3d, uint64_t dpa_offset, uint8_t *data);
>  };
>  
>  MemTxResult cxl_type3_read(PCIDevice *d, hwaddr host_addr, uint64_t *data,
> -- 
> 2.37.2
> 

-- 
John Smith
My name is not generic at all.
