Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DDBAC74A44
	for <linux-cxl@archiver.kernel.org>; Tue, 14 Mar 2023 05:23:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjCNFXD (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 14 Mar 2023 01:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjCNFXC (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 14 Mar 2023 01:23:02 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2098.outbound.protection.outlook.com [40.92.107.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C4D1E2BD
        for <linux-cxl@vger.kernel.org>; Mon, 13 Mar 2023 22:23:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aaIP58WaPW30mimGyJJhkJUg3M3PH8FN3hnFNIEQQ55TRtj2r+6tFBWbO92vpqqUthwped791rN1dz0JDAzlT4xmscv9fkwxzbjjSCBk8P9qjIkmESuOnqHjADEKuAif8v4VQ7EOOA0w5jW4yISev0NB8ErL+sfqeyShVY2QirShmN1x4YtciTQuKgOLF61PbW8sO3xLXuRIKXoQGdFLMjalh1Yw+voGH6jW2SG0fqnOrR95vqJRFLnT0oxoG/qKsMj0p63zncco2nOsdrI9wzcpayZT+gpLPgDULNCA+FX6W5MwxGVVDBev8vfenK+S2Lp5YleCSMnSbjdUJ/mn9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2nmr3swh5T2pGPLuEwRxp6xK/HuAkyLgqLOcVG+xmUA=;
 b=hKSdIvCbCKmUT8YWV1MIMxtjFNeeDB6Oi7jT2hbeFwlohawwWcKbTGAd+MYcOa6cPSRU5+Aa1ViVvy1VvC4uFI08upwrXC42eAnaZEhwq7kTcYKnijkS0CSMefzqNI94UlyxPX696FfUxahIDAY588KA66P3sqRJGTDpQmBRbczRZ095jaAKnyNEUmZtnEsrUV14GGehgfS/a+MOnbO2HhJ9StZVHFDt0HJ795yB6NGhR412LfXwNsFblNv+aoNU5ksj2QqcGW9H7jBAVHH5SHkvL46uyB/Upw9U89n/0T2N3TZcQ0Na7R24nUpPHb4US6zx2w512UHojI4ZdIeWzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2nmr3swh5T2pGPLuEwRxp6xK/HuAkyLgqLOcVG+xmUA=;
 b=Hb5cPeAxVEdOz3cJlUfIbc7nY8GaDBZ6HqpYSZrmYerb8JERb7cp2xHzuq+fVp8G0pbWsiUJREHYNfO8vHVWTQ5yR/n0ynRRTXkhe8SI8xKZzD+0BaqoqOX4zUE9mRbVnMIARdhypIwiKagLnHsTVbmERszq6L0OdBeEw/6aoW+Rp3E8ngHoCOYFwNa3moW7aAZvvHF1NoQNGwxJKic0ORmX7GSI/BAoUcu7RrRV3ESfOB8mi1g3TvSUgNADMKm8I8KWEraBYVhz+O6OpFdOQ70FCSrK7LiZdcdGq02PpUrvwn7LFOcHF/E6BoIxRsammOg4OfnV99A4bOzCeRuwug==
Received: from SG2PR06MB3397.apcprd06.prod.outlook.com (2603:1096:4:7a::17) by
 SEZPR06MB5667.apcprd06.prod.outlook.com (2603:1096:101:9f::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.24; Tue, 14 Mar 2023 05:22:54 +0000
Received: from SG2PR06MB3397.apcprd06.prod.outlook.com
 ([fe80::822f:761f:a577:c76e]) by SG2PR06MB3397.apcprd06.prod.outlook.com
 ([fe80::822f:761f:a577:c76e%4]) with mapi id 15.20.6178.024; Tue, 14 Mar 2023
 05:22:54 +0000
Date:   Mon, 13 Mar 2023 22:22:42 -0700
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
Subject: Re: [PATCH v4 5/6] hw/cxl: Add poison injection via the mailbox.
Message-ID: <SG2PR06MB33977B0F4B017F5CCEA963FBB2BE9@SG2PR06MB3397.apcprd06.prod.outlook.com>
References: <20230303150908.27889-1-Jonathan.Cameron@huawei.com>
 <20230303150908.27889-6-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230303150908.27889-6-Jonathan.Cameron@huawei.com>
X-TMN:  [Eg6KaNQFJRjNq5s/eeKBQv3i9JBdT1M0]
X-ClientProxiedBy: SJ0PR03CA0003.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::8) To SG2PR06MB3397.apcprd06.prod.outlook.com
 (2603:1096:4:7a::17)
X-Microsoft-Original-Message-ID: <ZBAEorroTIUsNX5s@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3397:EE_|SEZPR06MB5667:EE_
X-MS-Office365-Filtering-Correlation-Id: cab36aee-4b27-4d21-d932-08db244c29c0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HnUmcGxkAXp4eZtCupK0hBtJ23i41DWuYFj6Hi3AIAO5Xqt8tfrEHnQd/62kzsAG3f3OyebpJEO0Jd6QONoET61CVnL/3E1e2+DAkVgJ0XypFS3CDCWSV482IacP5hL1Did8plwmCn3OPq81a7ljFCbCZsr1bZ9WxCPP1Ja9Z/Xt99FGdMqFq95GZZ3yEuYCbY+JxHEis3p5nEjXCQcLhiqkkJ0z+acwZg+8LrMi3yGmXaQ2Ill+d9oEUYKzRrFdQjC+pK/Hyn0hUN6zIryf+gmx4Mg3QSDrfvTeovmC0o6H/UvGYfUiKEt0te1U6wYoOAza5I1rOS/zgDom2FBpP1XzHMuLWigVayhXgys45Qq96gvfnng5AuGVk2cXaTIDpsq/H7foHcoo3Zj7Qfy7daqHW7saFxHdYU5joiM7JGfqV3D+pseBpim78Y5eQVI9DCdLt4/ZvGH7QqOQeEJnjfaPQKPppoQi8u3Q1ylgkK6eWC/Lk5BwBLonO6ExuT3h202X7Yahxy1ff6057WrTbj3C28ScpQb3Dr0Vb1aYVHQK6VgNej4BmjqTM+DmDbpgQFOA2XithqnVmzn5nmwgzWR9N9FUKInIyoRfnx2M03qZSYRheWpfPxhvyXj8kvBrCMu5qwbzmxsRlhP5cASoOQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXVmb1JSaG5TSmRHZ1U1NHM3dHdBNkVwOWxiUEZqRkpRbmJ5Qk9rN0NqMFkx?=
 =?utf-8?B?b21pcHVJaEZMa203ZERabGRiUWhtbGxGMVE4YWlmTFgwcFFWd0NUZDVYQjdy?=
 =?utf-8?B?bFo1b2IzeGhRVkhkUlRNZDNvTmoxZDNyZXdnWmZyOFVKVkJCeWhlZE5RVWdG?=
 =?utf-8?B?WDhLcVJyWU53bEwvZTYwZU1NcGtEK2tVZlR1ZVl5aUxDUTN1ZWdvYzZnQWhB?=
 =?utf-8?B?WFhkbVU3SHBtNlRySGlFQVpISFlSZFhUcm4xME9ndHhYVDNVZDRVbDZod3RZ?=
 =?utf-8?B?NjNIeGg5SXM2RURzUUVFY3pkL1l2SmN2UnZ3Nm1vTlA3TEtvNEFUeEptbGJH?=
 =?utf-8?B?bUk1ZWl4bFZDZ29DT2VFa3FyRTRXMUZGVHRaYXhwbEVJamtlREJaRFU4Z0tN?=
 =?utf-8?B?eEoxL29NVktQa21nVjYvTDhyS2hDTGNRei9PTFNvY254ejJRSDF0ZWVrZTMy?=
 =?utf-8?B?aWF3UFBZcjNtTytHdFBPQUdSQ1lYeGVWN0M0ejRiNXdlcFhLNVNnOTh6cUZR?=
 =?utf-8?B?ZnltalJJZGs3ZXVrWFN3akRJdjVNaVplLzAwRmYyVzd5WDV6V2dGKzhKdDBo?=
 =?utf-8?B?dElPQ0xqaFArNGxmYS9FWm9tVXh2dExsWVpZaUFoc3dzTXd5a1NuR1BDVjZj?=
 =?utf-8?B?bkw2Q0t6WEhOdFEvZzNGYXd4Yzdna1pqS0J0d0pJWTlBRzR4bk9EZnZiaTR3?=
 =?utf-8?B?WjlhSHdEcEJSaUlUc2w3UERPYURqRGdZUVc0K0ZtNnpXTzFxRW4xVUM0cDdJ?=
 =?utf-8?B?R2xoa21jN0NGbGRoeEdBZDBNTFJ6VG5KU0ora09PNGhnNjVldWRMNVk1UDVl?=
 =?utf-8?B?YlpRYWN1ZVZWSjNmS2FlN1Z1V0dFdmNVN09KTzdtY2RJUUtESk91UlNGQWtk?=
 =?utf-8?B?THY4dEIwNjBSYnUvdkZNNXhXUHo2U2VkQkdhV2VVcHhYVG5OczRCMGwvQmNl?=
 =?utf-8?B?aDRicTFKTi8vM2hoeVNERGVEQ3Z0YXpkQlFmMTFEMkZxenpmL2szVklaYlU1?=
 =?utf-8?B?UjdkMzQrT3g3TWxKdFpSZWpxaDA0K2swRXo5UWFVTC8rOVRWRGwxUnJHbTVP?=
 =?utf-8?B?aG15RFVxVUI0WW9EQktISC9Jc1ZYY2d4L0wwV3ArT1NuaGZ3Ny9helJpdm9y?=
 =?utf-8?B?aVExU3Z1T2p5TGc1c1dYRXBwNjZsQ1JrWTVCeWx6ZTVXTzFLNHdleHBqdVpR?=
 =?utf-8?B?RVUrc0hkTGEvVW1WR2tqc1lhQ1d6ZFZjRTFzS3dCSFg4MXordHVreno4QTZB?=
 =?utf-8?B?L2w4ejVpQjljbVBqRXE4UlZJR0NzS3k1LzZVUDU5NWwwSXhLRnNDcnRvRG5y?=
 =?utf-8?B?bHl4NXhxb01KV3hIUTB4S0QvUVIwWFFXNUNQVVNST1daeVZYUVNnUHBSV25v?=
 =?utf-8?B?Szg2eEozd3dwbldtWHNBZ2VwWkJ1ZE5aSkF6dnhLSnRHaWF1NEd3cnVwYmpv?=
 =?utf-8?B?aWRNVFBBd0l0YnBvd3lxcTM4V1diSDhSWGZ4YVhCY00vK1ZSMGp2SnNnd0lF?=
 =?utf-8?B?aytrWFoyWUtram4xaGZaNSswREl6N2FIL0J0Znl3MXNIbnQ3NGZYbmRQVng1?=
 =?utf-8?B?aVFvdW12dnlSNFlrRWtkd0hocEN4SXdSZStUcW1jQ2NRbFZZWUtBSHQ1T0Fn?=
 =?utf-8?B?NHQxaVhoMFlrLzhzM2pKQ2JqUlVlbno0Q2NwOTJDaFUySDhmOXlQeFpGTmZy?=
 =?utf-8?Q?o8y8iQl/a6x+XpVBN1lQ?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cab36aee-4b27-4d21-d932-08db244c29c0
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3397.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2023 05:22:54.3425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5667
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The 03/03/2023 15:09, Jonathan Cameron wrote:
> Very simple implementation to allow testing of corresponding
> kernel code. Note that for now we track each 64 byte section
> independently.  Whilst a valid implementation choice, it may
> make sense to fuse entries so as to prove out more complex
> corners of the kernel code.
> 
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

> v4: No change
> ---
>  hw/cxl/cxl-mailbox-utils.c | 41 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 25933cf62c..64a3f3c1bf 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -64,6 +64,7 @@ enum {
>          #define SET_LSA       0x3
>      MEDIA_AND_POISON = 0x43,
>          #define GET_POISON_LIST        0x0
> +        #define INJECT_POISON          0x1
>  };
>  
>  /* 8.2.8.4.5.1 Command Return Codes */
> @@ -472,6 +473,44 @@ static CXLRetCode cmd_media_get_poison_list(struct cxl_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
>  
> +static CXLRetCode cmd_media_inject_poison(struct cxl_cmd *cmd,
> +                                          CXLDeviceState *cxl_dstate,
> +                                          uint16_t *len)
> +{
> +    CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
> +    CXLPoisonList *poison_list = &ct3d->poison_list;
> +    CXLPoison *ent;
> +    struct inject_poison_pl {
> +        uint64_t dpa;
> +    };
> +    struct inject_poison_pl *in = (void *)cmd->payload;
> +    uint64_t dpa = ldq_le_p(&in->dpa);
> +    CXLPoison *p;
> +
> +    QLIST_FOREACH(ent, poison_list, node) {
> +        if (dpa >= ent->start && dpa + 64 <= ent->start + ent->length) {
> +            return CXL_MBOX_SUCCESS;
> +        }
> +    }
> +
> +    if (ct3d->poison_list_cnt == CXL_POISON_LIST_LIMIT) {
> +        return CXL_MBOX_INJECT_POISON_LIMIT;
> +    }
> +    p = g_new0(CXLPoison, 1);
> +
> +    p->length = 64;
> +    p->start = dpa;
> +    p->type = CXL_POISON_TYPE_INJECTED;
> +
> +    /*
> +     * Possible todo: Merge with existing entry if next to it and if same type
> +     */
> +    QLIST_INSERT_HEAD(poison_list, p, node);
> +    ct3d->poison_list_cnt++;
> +
> +    return CXL_MBOX_SUCCESS;
> +}
> +
>  #define IMMEDIATE_CONFIG_CHANGE (1 << 1)
>  #define IMMEDIATE_DATA_CHANGE (1 << 2)
>  #define IMMEDIATE_POLICY_CHANGE (1 << 3)
> @@ -501,6 +540,8 @@ static struct cxl_cmd cxl_cmd_set[256][256] = {
>          ~0, IMMEDIATE_CONFIG_CHANGE | IMMEDIATE_DATA_CHANGE },
>      [MEDIA_AND_POISON][GET_POISON_LIST] = { "MEDIA_AND_POISON_GET_POISON_LIST",
>          cmd_media_get_poison_list, 16, 0 },
> +    [MEDIA_AND_POISON][INJECT_POISON] = { "MEDIA_AND_POISON_INJECT_POISON",
> +        cmd_media_inject_poison, 8, 0 },
>  };
>  
>  void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
> -- 
> 2.37.2
> 

-- 
John Smith
My name is not generic at all.
