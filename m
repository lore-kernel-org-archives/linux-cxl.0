Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50307C7EE2A
	for <linux-cxl@archiver.kernel.org>; Mon, 22 May 2023 18:38:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232979AbjEVSiu (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 22 May 2023 14:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233683AbjEVSis (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 22 May 2023 14:38:48 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2089.outbound.protection.outlook.com [40.92.52.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17088C4
        for <linux-cxl@vger.kernel.org>; Mon, 22 May 2023 11:38:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ckPKZuqDh10SM7/9RD/jEdyXPy+F6N5LY1Ot654EOv6+kXv730G8qbaM592P5itdbPRJTT6Q/V1Q+gUiAUT9SZCO+5u4afxb6AhD+KWpWDXg+vOWQTjinN4DfSsN3lLMHznIViosxAp8cVlUSE+pNUmbL0/jLOg6zsD+sGSs9c9Jlhk5sgc4HOAaqTOdlZvepZDzWRNEUZJrXbTuqfGSDNbiQUay0HugbPldNo2/Yh3d1ed0B/jAsDJMwjmbS/dnYAkXCxOnu4RjqRmQWCVWnBrADe/l5C3Y3upjS1c+IHV2uFWjtS2S91a2c+0ndZn4M1UryfsYgEAQHwHGRHHrFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZPE9RAsue6m/PzJtUgIYpCG+kbVFxCmOD+l3YoQoc50=;
 b=e/Yo+mpGhG0MkgZam1mPdMjhJOOrv65uTt4Lbaif6P6GUQsNg5N98aGwWyc2c9FFdIa+jMxYn6A71ndH1WeZ//8/F36CJKLCS8Jt0wm+BH/2VKXa0NYoeAgdYJfFThvduzJiXnWj4386kgRhO9DNyBIwS+qQSchG6CRxK6dwwA/0x3dx4tU4TxMeKcBe78VDax4Et5qJITo15+BF5AhzUFgGufrpS4vFSWCVYaf5S9r9BfeLJ05Xj+s2kX97y9Jj/Zcd4iFi9ptlevL9FdHZdqWEBeH6BTbhhymkBAwdqpmashDa5/RIa2UI4aQZbeG1JgFrdIpKf3oaje14HqLjYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZPE9RAsue6m/PzJtUgIYpCG+kbVFxCmOD+l3YoQoc50=;
 b=hqb4GXLt0M26mfupzU9CDrHA2h8YjVAv7Ir6KdiQ/YD+9V30cmFdARGyMlzhOr/U3/GUtLXDu1C+xjQ9lhIr1oRQE/iKWGaxI/+UgpJ0mW98SEhMPiWILpGwksDy+QL/A2JwA0fqb3BSlGLllPwC7rTRjvf5RHkHjiHuZiShmOlZC2VN5brSemHJqDoFd3iIrGlOcVLBl2z8rwWJhav/ggQXPwP2VZmTrxjYd+n3JJVtv9OjtkM8Hd4OvfO10eQZyi9K9A8xfuZoudCP+xzA0M2n8RSqBWOSKOfZyZl/JiMCC/zpTN2iVsjCd2n1P3Bw9bPFQLXlJ1D4UdrxcH3oxw==
Received: from SG2PR06MB3397.apcprd06.prod.outlook.com (2603:1096:4:7a::17) by
 TYZPR06MB4016.apcprd06.prod.outlook.com (2603:1096:400:27::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.29; Mon, 22 May 2023 18:38:36 +0000
Received: from SG2PR06MB3397.apcprd06.prod.outlook.com
 ([fe80::248c:58fd:97db:5425]) by SG2PR06MB3397.apcprd06.prod.outlook.com
 ([fe80::248c:58fd:97db:5425%7]) with mapi id 15.20.6411.021; Mon, 22 May 2023
 18:38:36 +0000
Date:   Mon, 22 May 2023 11:38:25 -0700
From:   Fan Ni <nifan@outlook.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     qemu-devel@nongnu.org, Michael Tsirkin <mst@redhat.com>,
        Fan Ni <fan.ni@samsung.com>, linux-cxl@vger.kernel.org,
        linuxarm@huawei.com, Ira Weiny <ira.weiny@intel.com>,
        Michael Roth <michael.roth@amd.com>,
        Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Markus Armbruster <armbru@redhat.com>,
        Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
        Eric Blake <eblake@redhat.com>,
        Mike Maslenkin <mike.maslenkin@gmail.com>,
        =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
        Thomas Huth <thuth@redhat.com>, a.manzanares@samsung.com,
        dave@stgolabs.net, nmtadam.samsung@gmail.com, nifan@outlook.com
Subject: Re: [PATCH v7 2/7] hw/cxl: Move CXLRetCode definition to cxl_device.h
Message-ID: <SG2PR06MB339756E661E916C96CEBF608B2439@SG2PR06MB3397.apcprd06.prod.outlook.com>
References: <20230522150947.11546-1-Jonathan.Cameron@huawei.com>
 <CGME20230522151054uscas1p23a1c4644d8408621ea063d2b9f555e2e@uscas1p2.samsung.com>
 <20230522150947.11546-3-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230522150947.11546-3-Jonathan.Cameron@huawei.com>
X-TMN:  [dsJZe5kB1aCYHfpI2HIqbrRajAQVlBW8OkGJ/m8VDHQ=]
X-ClientProxiedBy: BY5PR13CA0033.namprd13.prod.outlook.com
 (2603:10b6:a03:180::46) To SG2PR06MB3397.apcprd06.prod.outlook.com
 (2603:1096:4:7a::17)
X-Microsoft-Original-Message-ID: <ZGu2oZ4/0zcL+N6K@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3397:EE_|TYZPR06MB4016:EE_
X-MS-Office365-Filtering-Correlation-Id: 3307d665-1204-4d3b-7885-08db5af3c066
X-MS-Exchange-SLBlob-MailProps: laRBL560oLTHCdvzxEAnOhyj7PIH+ZDVGuFbG5NvQSJN3GGQp202mRonY+Q4uT/PO7UxH0NpXwZCT/cWKmRPyIO+ob9CjE5I2BLQTt/r4YjeUDm3RKrCN3ZpOTprqwvDca+V2ZOVOuT2My9d/yrr10ysJqiZdlYSu79+7KzKkGKq7edB/ngyBFN9/J7zYYb7+kfMIzDx51P3ECBypfJcyeVrebqruUfkCouybQgWNpNuG6zoswTiJtGDOibiOzXovBhZ893C73CivIDWMm2VJLwCIJlbNdRr/k7NuFSmVOPU3f9CTE9phm0JHEgqr//wTEGVD7Ha/Z8lQ+Wo0NzvCnm2DPrNWvhqHI39EMGqtx1hqkbdpuq+XJBcz7ElmDm9MkHGD5s+NN97NKWH2D97HmeN2cOenKq2iWeaI0WvE6tr9YuEqqGd8/ODnCAsaZVC9l/sVA6aCuHsE9xZC5qpWzZFeYA0lNLO5qgCl+YFrjGgFZMRjc3pp1e3hbapXJPzM9vt9ldTDhm7bZ8JeiYEW+sw57BWWWvUNUn4BwNUgwFWyXam1MoqkPWDAZyWVxI+g18QSFczkLgnXGHV9dcmBuWbYm+YikJmOxfjF2MAWlc4nxXDXDbrC7asuK+AvuPd8Acn9TmVonah5EHMfZJRZPrFHxX+2i2rfejVLc2w7K/vbR0sQt6BAcIP8fr9q1NrxOM9HO1ZwRrs+3QNEDBci1VBqlX5lEq4H/bfTRcpa0KbcvwaF8ev9W5XB6N+V4bMcODhm2QSxj3CGHwNYyo/VKyEbi6jQHGq
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kat78DuMqeCSHCxDYgniXOExeZ8bjpgfeWtBCr1uRPQF2yUnwS/9K8qDPgiQAydjMae+p1mT+f84sUeg5bUv8YEk/mtGr6JBhObviwu1unGHtV8vDKnvTHIWqUUY9yee6u7PhKJp73pu3Q0J4U3Rti/vprhIxKRXJaK+VSaZAd+mVYYO4diGVYc9dETu8n3Bkd6ACMj3mWXXhjwBD5U4g2SzVVIDD9o2uTlFrBZmio2s80keWIdkLfLvEIgpwLF7aEWIxX6f3m0SpOFmw4b7EChq8yLxYEW8qLHVwm10Q+F1HJJRzVBRude7INj3ODaw6KL42Xlex6ZQm2kfIOb1OswZIfgciVOxLvf46hfRvnaNZs7dqAuxykWHIr453WqbgTuRQ8FRGz/S2rmfFOTgKGQcYLVOz870X3Xq6olktl5nOR14nGYjlRE8mBqdVNsy6QNuedAlJEtiBvMguisgFdQ1uz6UW86OzPKLCBcpWoCjQOQCAC61TzzT/lX+WhStMhiI0T/SuLQ1pjz3iF132Pfydg4/3/o0fcO24JaOFoS7ifoda28U4JAvhLzAxH+edUM1lDkc9FtdOvgvMIJICrpUTlE2snVMlgFl4Scu5zLzEThHX0R7H6pDoDnQWIy3EwqyEhsqk3fZvr2d+CCrOw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0Jqd2pUNng2WGlWVnVqajdTb0dGYXBEU1R0WUZLdzZKL3ZPMldVNE1NSWtG?=
 =?utf-8?B?VGFHSm5ZcEFJNGFPU2pUdklGMEkxRk83M2hxVHk4cUJRVkN5N0lDeUQwZWZx?=
 =?utf-8?B?K1l3YVFFTi9MajA3eHRxZ1NjVzdqbUpJK01EZFFOK295R3FLOHRRdjA5bXRN?=
 =?utf-8?B?dG1DbTJESE1nd01uK3NJR3dSWjJXcUlSdTJBbUlwYUk5K2tJckpqZzBFSnNW?=
 =?utf-8?B?VnZTV1BUMjhuTEJXeHJaZXJPZENyUmZlbEVwdElBMUJoWllhQzU0QldLTHg5?=
 =?utf-8?B?dUIyalYvY21DV3U0VkRTNUNBTldsRlZQWG83bW10VjBrTGw3V0hUQnUyNzNT?=
 =?utf-8?B?aTd5dklEMlk1Qk5NcWZGVlRnTllHNjhmVlNPUWJoczJCN3duczZHckEyalVM?=
 =?utf-8?B?eDFBZHdGMm16QzZuMEUvTlBFemFTbkNreW5ldisxM3Y3bmdDSnlhcUxsU2Qv?=
 =?utf-8?B?azRmb21rQ2pTam1sTEhqQldQRW40MnhoRHZHdExIT2RIK2I2dkxaenZUR2I5?=
 =?utf-8?B?dTdueGVXWmc1ck9yZnNQanM4dXF1SHdXcGxqZTV0TUJzYXhFRE1NYjc3bHF5?=
 =?utf-8?B?ZDRNM2tKSTNFS1gyZ2tMVnZSWGJnYnhEYmVmUGhxQUwrQnNYazFqRXpYWXJa?=
 =?utf-8?B?aUVSUkJabC9UYlM1RU9aakN2NTllNzdsT2I1dzFOU0czVnpwWWhsY1BMNkk1?=
 =?utf-8?B?T1RxdENGVnRKNzJnOGlWeVllSFE3MlJZMTVjUkpGRFp0cEpDMzZsdVdmNnNu?=
 =?utf-8?B?NTZ4Ni9GQ3hCcGlxMmk2dmlXSy9oREpMbjByd2F3Skp0bGlPKzlzblVjT0o4?=
 =?utf-8?B?TmlNWEovV0IrRjRZTzVyanVMRVV3Zm5FNWlWRTBrYXY0TFRaTVJUZlI0VHlo?=
 =?utf-8?B?RkxhRnJncFVmcStyUkN0b1dNKzEvQitMdWNic201SXppSDFveFptWWZ0eFQz?=
 =?utf-8?B?RFJIM0xMbmNRWEFvaDhvQXE2dkxxc0ZXamdENzRBdUxKbjJ6cVQ5V0NEMm1v?=
 =?utf-8?B?REkwV0pZTSt5bWpPRlZIN0hxeHVFWWRCL2J4dThuT01pdC9wc3VNSFhQOWFB?=
 =?utf-8?B?cmI4aTdnSlFXY0FZdm5nRGU0VmpFZUZuOEx4YnE2YUpndVR4dW52Tkw3NFRO?=
 =?utf-8?B?amJLVnBRZzlZbjFRVXhHZTlIcXgwRmhJNTBjOFFKNlZ6dVd4UDhqMUtFcFJZ?=
 =?utf-8?B?Si9YU1F0Q1hOMFFjZWpuWVk2RmtINXloUWlRck1NeVhoQ1krdld0ME5Gd1dK?=
 =?utf-8?B?Z0tQdlpmKzBXQjdFTEp1NlRqZ2JheENLYzJQdldHSU9RaG9STkNhMGV4NG44?=
 =?utf-8?B?c3lOajJ5SXNPTUFNSG5xeDFvZDlYbHJDaThnVTdqTkNCOHVIdUp1MDgwaXRS?=
 =?utf-8?B?aWhQZlVNT3VLbHdTRWtRM2pqL3JGeENIVEFvd2RLMSsvdThMUUFBUHdiQkR5?=
 =?utf-8?B?dkhXNEFkeW5rVDJST0pxdWlYVDdYSnY3TExVbXREQUMzTytML1FhdEtyc0xw?=
 =?utf-8?B?TFlsRmExMkltdWhTUE5qR2JZVWtBaml1aEZjYkJrQ1RnOHpQazZaOW1iVWlt?=
 =?utf-8?B?cmRWRUpSYTVFWktPRG8waVU0U0p6NmZnMVpYYWhUbXJPbkpkYk4zdTJubTBM?=
 =?utf-8?Q?NBroGxV4Fg0Q1R80AzFDjWigEdCzMbbldImaeuISZ14E=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3307d665-1204-4d3b-7885-08db5af3c066
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3397.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 18:38:35.9290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4016
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The 05/22/2023 16:09, Jonathan Cameron wrote:
> Following patches will need access to the mailbox return code
> type so move it to the header.
> 
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

>  include/hw/cxl/cxl_device.h | 28 ++++++++++++++++++++++++++++
>  hw/cxl/cxl-mailbox-utils.c  | 28 ----------------------------
>  2 files changed, 28 insertions(+), 28 deletions(-)
> 
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index 16993f7098..9f8ee85f8a 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -83,6 +83,34 @@
>      (CXL_DEVICE_CAP_REG_SIZE + CXL_DEVICE_STATUS_REGISTERS_LENGTH +     \
>       CXL_MAILBOX_REGISTERS_LENGTH + CXL_MEMORY_DEVICE_REGISTERS_LENGTH)
>  
> +/* 8.2.8.4.5.1 Command Return Codes */
> +typedef enum {
> +    CXL_MBOX_SUCCESS = 0x0,
> +    CXL_MBOX_BG_STARTED = 0x1,
> +    CXL_MBOX_INVALID_INPUT = 0x2,
> +    CXL_MBOX_UNSUPPORTED = 0x3,
> +    CXL_MBOX_INTERNAL_ERROR = 0x4,
> +    CXL_MBOX_RETRY_REQUIRED = 0x5,
> +    CXL_MBOX_BUSY = 0x6,
> +    CXL_MBOX_MEDIA_DISABLED = 0x7,
> +    CXL_MBOX_FW_XFER_IN_PROGRESS = 0x8,
> +    CXL_MBOX_FW_XFER_OUT_OF_ORDER = 0x9,
> +    CXL_MBOX_FW_AUTH_FAILED = 0xa,
> +    CXL_MBOX_FW_INVALID_SLOT = 0xb,
> +    CXL_MBOX_FW_ROLLEDBACK = 0xc,
> +    CXL_MBOX_FW_REST_REQD = 0xd,
> +    CXL_MBOX_INVALID_HANDLE = 0xe,
> +    CXL_MBOX_INVALID_PA = 0xf,
> +    CXL_MBOX_INJECT_POISON_LIMIT = 0x10,
> +    CXL_MBOX_PERMANENT_MEDIA_FAILURE = 0x11,
> +    CXL_MBOX_ABORTED = 0x12,
> +    CXL_MBOX_INVALID_SECURITY_STATE = 0x13,
> +    CXL_MBOX_INCORRECT_PASSPHRASE = 0x14,
> +    CXL_MBOX_UNSUPPORTED_MAILBOX = 0x15,
> +    CXL_MBOX_INVALID_PAYLOAD_LENGTH = 0x16,
> +    CXL_MBOX_MAX = 0x17
> +} CXLRetCode;
> +
>  typedef struct cxl_device_state {
>      MemoryRegion device_registers;
>  
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index e3401b6be8..d7e114aaae 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -68,34 +68,6 @@ enum {
>          #define CLEAR_POISON           0x2
>  };
>  
> -/* 8.2.8.4.5.1 Command Return Codes */
> -typedef enum {
> -    CXL_MBOX_SUCCESS = 0x0,
> -    CXL_MBOX_BG_STARTED = 0x1,
> -    CXL_MBOX_INVALID_INPUT = 0x2,
> -    CXL_MBOX_UNSUPPORTED = 0x3,
> -    CXL_MBOX_INTERNAL_ERROR = 0x4,
> -    CXL_MBOX_RETRY_REQUIRED = 0x5,
> -    CXL_MBOX_BUSY = 0x6,
> -    CXL_MBOX_MEDIA_DISABLED = 0x7,
> -    CXL_MBOX_FW_XFER_IN_PROGRESS = 0x8,
> -    CXL_MBOX_FW_XFER_OUT_OF_ORDER = 0x9,
> -    CXL_MBOX_FW_AUTH_FAILED = 0xa,
> -    CXL_MBOX_FW_INVALID_SLOT = 0xb,
> -    CXL_MBOX_FW_ROLLEDBACK = 0xc,
> -    CXL_MBOX_FW_REST_REQD = 0xd,
> -    CXL_MBOX_INVALID_HANDLE = 0xe,
> -    CXL_MBOX_INVALID_PA = 0xf,
> -    CXL_MBOX_INJECT_POISON_LIMIT = 0x10,
> -    CXL_MBOX_PERMANENT_MEDIA_FAILURE = 0x11,
> -    CXL_MBOX_ABORTED = 0x12,
> -    CXL_MBOX_INVALID_SECURITY_STATE = 0x13,
> -    CXL_MBOX_INCORRECT_PASSPHRASE = 0x14,
> -    CXL_MBOX_UNSUPPORTED_MAILBOX = 0x15,
> -    CXL_MBOX_INVALID_PAYLOAD_LENGTH = 0x16,
> -    CXL_MBOX_MAX = 0x17
> -} CXLRetCode;
> -
>  struct cxl_cmd;
>  typedef CXLRetCode (*opcode_handler)(struct cxl_cmd *cmd,
>                                     CXLDeviceState *cxl_dstate, uint16_t *len);
> -- 
> 2.39.2
> 

-- 
Fan Ni <nifan@outlook.com>
