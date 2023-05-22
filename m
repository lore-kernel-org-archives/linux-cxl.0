Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5106C7EE23
	for <linux-cxl@archiver.kernel.org>; Mon, 22 May 2023 18:33:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjEVSds (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 22 May 2023 14:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbjEVSdr (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 22 May 2023 14:33:47 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2080.outbound.protection.outlook.com [40.92.53.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8E21A8
        for <linux-cxl@vger.kernel.org>; Mon, 22 May 2023 11:33:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TMbQn8PC1wLrNd0diPedXw7Umh6B0l/VMI/WGaaeW+K9kzMpaJDxDPX2zMjeE+fCqLVuYvwxQE2qtBKEIhfM0uCkdPHceF9/nkMifgjn7iUtrcDy8Mpon6GxqQpfisUPmDRpOgbbMzSxJyAn6BFJBP+hFD/RHThqA3InlmAu05f4sFq/DewCXW0I+ANm4pqdjvXAZ9PywdtLRusm/644jOCLDegnG7pb3nSbgDQzD62LXD1qtwRlvKiWHchdQj0ycBHS9vY/nlbr9QJ8r369OU7e54b9K5dcozXMSlegFPPG18kh+Yv3WXkw73xGTulWed5ptRtfsqImXikM1WduBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r/MEP9aa1YEO1mM92IIdqPGTqe4IHLMbq7pq9upcUSA=;
 b=oI4P7TWiojwQgKQZo+6nMmjY/xjwKGYqYH0PouwKFviZCczW5iQhDrTQHDECvU/F26Q/yBBmH39eUHVmJNQ+G6KFcOQIOD/yeU7Bxi8DFMeRNeEIH8u1vxxkBdHIPW3um3PPxjlxY67pbo3J3PUMLVJfxV+0QoJGFMgCpKr73cQQEXv+4F+XHbrDn3t5458kLui+gvpM4bDw4a9Q3Rp8fP9p7CoDY4rrUe4xaasaTpNKhJ3jEAngTqlHPFM12HbWK4IFg9gGWe0XtrmNGulgOwLpW+JxOWbZx6LW8AJkp1UjEOv65FZL5KJipm0/DpiT4/i1/ijHTt2fcMsWsLOryQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/MEP9aa1YEO1mM92IIdqPGTqe4IHLMbq7pq9upcUSA=;
 b=MTQUq9Fa8lt6dq5Bm1bNWjWTlsEflQHyf+0sZNUlJziYqGWVOS9xdxrvM+7WYhzNznn3kn70l2Ub750Up9B8cVh8MrDQ7Q7BdSdy2fHZtloZMjKOFMDVvZ47+f3kfrwrtrsLQVnGFvVIIQJaiUL09Sa3Gn+92hqh/oMLUpwN6pxITV5spp/uPjHTZQZyVhPdKx7vQNnExO1mMnMPVHztkGCH9FgYhE4h6BPub8mnSoMkbwLAxQfhIsfYrgTvVvsQUzDh6hh4RabPYxzJNatiR1QEtA7HJKxunq9GZiJAiHgF6RpYu/eCsmR8uzd/BoEU19GA315BBAh/vGRx/ME9Lg==
Received: from SG2PR06MB3397.apcprd06.prod.outlook.com (2603:1096:4:7a::17) by
 PSAPR06MB3992.apcprd06.prod.outlook.com (2603:1096:301:37::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.28; Mon, 22 May 2023 18:33:21 +0000
Received: from SG2PR06MB3397.apcprd06.prod.outlook.com
 ([fe80::248c:58fd:97db:5425]) by SG2PR06MB3397.apcprd06.prod.outlook.com
 ([fe80::248c:58fd:97db:5425%7]) with mapi id 15.20.6411.021; Mon, 22 May 2023
 18:33:21 +0000
Date:   Mon, 22 May 2023 11:33:05 -0700
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
Subject: Re: [PATCH v7 1/7] hw/cxl/events: Add event status register
Message-ID: <SG2PR06MB33971AD7DA5711AF8A4F9B1CB2439@SG2PR06MB3397.apcprd06.prod.outlook.com>
References: <20230522150947.11546-1-Jonathan.Cameron@huawei.com>
 <CGME20230522151023uscas1p119a14fe18b74417d4af283a434975ecb@uscas1p1.samsung.com>
 <20230522150947.11546-2-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230522150947.11546-2-Jonathan.Cameron@huawei.com>
X-TMN:  [pQcymTSrrJrhDmgyJ9Czk20guPfqAtr6qaImAhWXig4=]
X-ClientProxiedBy: SJ0PR03CA0231.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::26) To SG2PR06MB3397.apcprd06.prod.outlook.com
 (2603:1096:4:7a::17)
X-Microsoft-Original-Message-ID: <ZGu1YcgmmxzYk71D@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3397:EE_|PSAPR06MB3992:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e5a8336-ace6-4298-3443-08db5af3043b
X-MS-Exchange-SLBlob-MailProps: WaIXnCbdHrOmxl4Xu8/rO1vrJTkCOH92wV2sm1b7SzKw/K+U4cC3T+GCKKDfVhrBpidpy4Q4XhcsH4rkhYWzSgDQRNTMe5neVycRMlFaK+IWdlHu0W416WFNiJWyq/YIstVjGIsT6d69RYT+wzfWARH98FAxBQh42uL3iHyA9499AGi3Yk9YRSNpPcPkA8T3Oea85t+eGhSgeYBHhR+rm2Qzzy9DZtxiW8NloqSp5WCbedxVwJWLSkkdLp8v8wNnIgqTr+mH7Sk9DZbPE3qu38DuZ9dVQQD2J7F2j5BxYMknuG+cEWwLiER01bhyMiYx8xD/n1FJCKAzQvSrCVKdAKZ9kmkKjeeo/ZmqBN/rEiT0kP2Cip0v+aU+EEBnrwtONymiERFi0z1nFQvehLtjR3v/ClnLlJuSZCRiZGXlbi5cjHnjYkEfJE1cjaUr2Ze1PesokwmV0p6ttRI/t55OtHMMXL+aXF/WA79oi6Ws4iOu7zQTbrLWI58Ge5b7xsec+yTvp3W5MisU13z4IllWDXIg07Epb2rsb+29/2BVQUCia7sRh5roiBYI2JOGr0G2bCRrFPoDHPP6RamUILTnGFhiiDdVc+6RNVnRfMEo1Qnt2pjDw77f1OeVYTMU5/K7EzlY50VQkJoKLcs+VyCSzEwWGhnYiezCvYuwoJqt5/PdeiOB9zgIUIXmAd5yyj/mbZWq2r3SPr1MlTQpwFb6uI4052hOwP7W45YB08ajj4atmyxHzA4rU6z7vsCOLnSmMaK7+n8JCFY=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bYgPHobiv7RRDBfxkpGuVVcsPbraq1N97HYGzT+fuMh2MFmOHq2MseKypSEDgmezj8vj/pkO32mgpyrbk+zhETzURyF84tQ2eN+wyOpRZ8V98ti0LslpNgkR7wi+ZwP97EbSEn/KMMfDvLs3WjkFiF8jc4WFdO40k/jEHiXYC/Wy7CechvscPFMoZSVQU4Y41F/2U8+iHdVR+KS8rmbcHJPEoONRe1kgfb5QX8h8KYz5R6jnlAP52Xyt9pvFaQrQcKWbVO/7XXdiIBt/50gxJ+72RMMyYfmUXxVe4+ArAikma8oDV0wanLuhe1leaiyPCnTK9reqtYfMMUB/neMBZIw47/LlRTJQY4CYxKyEqgqg9+1uwZXEW+4PG1KNTPdu99qZt6iAMZUieEeXf2XAa+lRIeQPQN6Ofa5c4nJo0f+JUMOhLxtRErGZ6ktKhMeSU+pPCOj7gcor4IttRI1T716PcvGhZbSCNs0IroXmUCLIXsuZ8fojzvA1vgTK1i2H4aDl5koO7bVPbWUZsrWPbz7AitctTltKsxEaf8d9JZlKmAfCMHueKcmiiPNB5+lxQFs7Nwfdw5SUvR11Ub9W/cwtzDMoI9J6dY70x2XcYopaJWxECbA4OlsPIb0c2pysVPI5rSzgwfXIkAOnSp6avw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUd4MzVGOG91MG16VFg3VGxka0xpbFVnWlhQV2RQUFlLVXVudTNUcVIyRTBV?=
 =?utf-8?B?amt1akZDTloybXNqS0g1WWNYbU1iQTBlY2hGc2lxTzR2Z2h1ZjFTODV4cFNH?=
 =?utf-8?B?VUZYQjV2ZlV1NUZhZVFCck1kUUEvckJnRjUzWXZjZ01wM3ZHelZPcUNHbGdy?=
 =?utf-8?B?TU5hVlNKZFJaK2QwcG0ydGczMVFubUlCTDJhY3Z5a0h5MGt0Z0NtVm9vMTQz?=
 =?utf-8?B?dy9BSWlyWGcxRXAydnhTbkhJT2JVaGo4bjlsZ2U5c3hmL1lqNjVjVi9TcVJO?=
 =?utf-8?B?N3oxQjJhenRFamF6WnhvMUpGQzdSaVZ1Sk5DS3JmbFJFVXJOQXcwZjAxVEpH?=
 =?utf-8?B?OVJJT01JVnJ0YjdnMW4vOUdndzdtalJUaGg2dFRqK3pRSVJwM0FDUWpjQkhj?=
 =?utf-8?B?dk15MTVoWllFWFZLS2tQaDVKK0hwQlpEd2pOczZhdWZrdllJU1JLZ1hWWlRJ?=
 =?utf-8?B?US8xSlhueUE2VGZta1MyTllnOXA4OWRySWRuOUszSVZ5Y1pNK2FEOHdkb0Nx?=
 =?utf-8?B?MmhPWS9uREN0b285c3NnNjdhYlF5c1JiWlZWbGZHMFk3UE1raEQxcXkyRVgv?=
 =?utf-8?B?VDlYSCt6SURIVktJUDBQTWRSdGM0VG9qeVNHV2U5cHg0YlRLc2U1SUxoVG81?=
 =?utf-8?B?UzU3RTBMZ0NWbXM2M2YwNThFMWNEWitMTlpscHByTlZlRTRXSmkrcFpTMXFJ?=
 =?utf-8?B?UmlmYkYyVFBUUnZra2VDbThPUWRRaEw4ajhoczNlaUMwaUcwbjV4YWRiSlZx?=
 =?utf-8?B?R01tVHA1b3VnTGdiT3B3WlVvR1hlT2NpQWZ5WXpZdDFpQUZ1b2NXb3F5eW51?=
 =?utf-8?B?MEtDb2x0Q0k1djdyRFNHajhqcm0yTlJ0d3lSckprRkFaZDVQRjArdzB5d0tP?=
 =?utf-8?B?K3E0SmVRRkhlVkxVdGpVaDFiLzAvc01BQmphTHIyckFzYjVEMVZkWTgrcVVX?=
 =?utf-8?B?TnBreTVnN2ZNcjQvTHZOT3pPc0ROMDQ0MiszRHNRblBXM3ZxQkljd1ExbjFY?=
 =?utf-8?B?NXhzbUpLZXZPcEJtT1hCU2p3Ly8xT3JyUzVUQ1JFcWMyM2IyN2NDV0JYQ3FF?=
 =?utf-8?B?Q1prVzgxWi9CZFQwME9NaXpQR2Y1OVU0ZTFaaFpWMlFKZ29HUFhHVysxSnl2?=
 =?utf-8?B?MCtlU3JSVjV3STlma2cwZEVQSk1JTDBSRitzTGNZVU5HVDJQa25nUWlDL2ZO?=
 =?utf-8?B?KzVRWkxJM3VoWjhGNStGdFlBRVV4M1dtMkhoK0JNNWdXR0hRbGhtVmFMdkVa?=
 =?utf-8?B?dC9pbXdaWmYxbjMzeXRab2ZRcFNrMm5LaS9YWitjMFVXRG1mOWpkUWRzejZJ?=
 =?utf-8?B?TUcyeFdRSkl0d3VteFRORmNId3NaeWx3RkRxRVEyazk2QmxXUVpRSzRFMlJY?=
 =?utf-8?B?QjZ2VlFmTTMvUzdraDdwOWc2cVJZYnV1NDhsK3NnTW5ybWtpZkNFZXZyVitn?=
 =?utf-8?B?Z1J3WS9aZWxxdXR4dGlyclc3SUF1ZDlTbDYwTW9PTUVxcExyYlZqbkY0czJM?=
 =?utf-8?B?OEE3cVUrUEUrUStWczlTTmNoMUhMMG9uWkpRUCthZ3hFbGVCNWtpQ2grVWYv?=
 =?utf-8?B?VGNvcnVJYXZONjF2MWlKb1E3aUdsbmtSWllHUnRZZ0lSelA2aVNzSlBoY2do?=
 =?utf-8?Q?V/PIyb3aHJIG69XBpxQ8E3s9zyW2NUnJGx2TmIG8cYTM=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e5a8336-ace6-4298-3443-08db5af3043b
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3397.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 18:33:21.0222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR06MB3992
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The 05/22/2023 16:09, Jonathan Cameron wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> The device status register block was defined.  However, there were no
> individual registers nor any data wired up.
> 
> Define the event status register [CXL 3.0; 8.2.8.3.1] as part of the
> device status register block.  Wire up the register and initialize the
> event status for each log.
> 
> To support CXL 3.0 the version of the device status register block needs
> to be 2.  Change the macro to allow for setting the version.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Fan Ni <fan.ni@samsung.com>

> ---
>  include/hw/cxl/cxl_device.h | 23 +++++++++++++++++---
>  include/hw/cxl/cxl_events.h | 28 ++++++++++++++++++++++++
>  hw/cxl/cxl-device-utils.c   | 43 ++++++++++++++++++++++++++++++++-----
>  3 files changed, 86 insertions(+), 8 deletions(-)
> 
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index 73328a52cf..16993f7098 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -13,6 +13,7 @@
>  #include "hw/cxl/cxl_component.h"
>  #include "hw/pci/pci_device.h"
>  #include "hw/register.h"
> +#include "hw/cxl/cxl_events.h"
>  
>  /*
>   * The following is how a CXL device's Memory Device registers are laid out.
> @@ -86,7 +87,16 @@ typedef struct cxl_device_state {
>      MemoryRegion device_registers;
>  
>      /* mmio for device capabilities array - 8.2.8.2 */
> -    MemoryRegion device;
> +    struct {
> +        MemoryRegion device;
> +        union {
> +            uint8_t dev_reg_state[CXL_DEVICE_STATUS_REGISTERS_LENGTH];
> +            uint16_t dev_reg_state16[CXL_DEVICE_STATUS_REGISTERS_LENGTH / 2];
> +            uint32_t dev_reg_state32[CXL_DEVICE_STATUS_REGISTERS_LENGTH / 4];
> +            uint64_t dev_reg_state64[CXL_DEVICE_STATUS_REGISTERS_LENGTH / 8];
> +        };
> +        uint64_t event_status;
> +    };
>      MemoryRegion memory_device;
>      struct {
>          MemoryRegion caps;
> @@ -141,6 +151,9 @@ REG64(CXL_DEV_CAP_ARRAY, 0) /* Documented as 128 bit register but 64 byte access
>      FIELD(CXL_DEV_CAP_ARRAY, CAP_VERSION, 16, 8)
>      FIELD(CXL_DEV_CAP_ARRAY, CAP_COUNT, 32, 16)
>  
> +void cxl_event_set_status(CXLDeviceState *cxl_dstate, CXLEventLogType log_type,
> +                          bool available);
> +
>  /*
>   * Helper macro to initialize capability headers for CXL devices.
>   *
> @@ -175,7 +188,7 @@ CXL_DEVICE_CAPABILITY_HEADER_REGISTER(MEMORY_DEVICE,
>  void cxl_initialize_mailbox(CXLDeviceState *cxl_dstate);
>  void cxl_process_mailbox(CXLDeviceState *cxl_dstate);
>  
> -#define cxl_device_cap_init(dstate, reg, cap_id)                           \
> +#define cxl_device_cap_init(dstate, reg, cap_id, ver)                      \
>      do {                                                                   \
>          uint32_t *cap_hdrs = dstate->caps_reg_state32;                     \
>          int which = R_CXL_DEV_##reg##_CAP_HDR0;                            \
> @@ -183,7 +196,7 @@ void cxl_process_mailbox(CXLDeviceState *cxl_dstate);
>              FIELD_DP32(cap_hdrs[which], CXL_DEV_##reg##_CAP_HDR0,          \
>                         CAP_ID, cap_id);                                    \
>          cap_hdrs[which] = FIELD_DP32(                                      \
> -            cap_hdrs[which], CXL_DEV_##reg##_CAP_HDR0, CAP_VERSION, 1);    \
> +            cap_hdrs[which], CXL_DEV_##reg##_CAP_HDR0, CAP_VERSION, ver);  \
>          cap_hdrs[which + 1] =                                              \
>              FIELD_DP32(cap_hdrs[which + 1], CXL_DEV_##reg##_CAP_HDR1,      \
>                         CAP_OFFSET, CXL_##reg##_REGISTERS_OFFSET);          \
> @@ -192,6 +205,10 @@ void cxl_process_mailbox(CXLDeviceState *cxl_dstate);
>                         CAP_LENGTH, CXL_##reg##_REGISTERS_LENGTH);          \
>      } while (0)
>  
> +/* CXL 3.0 8.2.8.3.1 Event Status Register */
> +REG64(CXL_DEV_EVENT_STATUS, 0)
> +    FIELD(CXL_DEV_EVENT_STATUS, EVENT_STATUS, 0, 32)
> +
>  /* CXL 2.0 8.2.8.4.3 Mailbox Capabilities Register */
>  REG32(CXL_DEV_MAILBOX_CAP, 0)
>      FIELD(CXL_DEV_MAILBOX_CAP, PAYLOAD_SIZE, 0, 5)
> diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
> new file mode 100644
> index 0000000000..aeb3b0590e
> --- /dev/null
> +++ b/include/hw/cxl/cxl_events.h
> @@ -0,0 +1,28 @@
> +/*
> + * QEMU CXL Events
> + *
> + * Copyright (c) 2022 Intel
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2. See the
> + * COPYING file in the top-level directory.
> + */
> +
> +#ifndef CXL_EVENTS_H
> +#define CXL_EVENTS_H
> +
> +/*
> + * CXL rev 3.0 section 8.2.9.2.2; Table 8-49
> + *
> + * Define these as the bit position for the event status register for ease of
> + * setting the status.
> + */
> +typedef enum CXLEventLogType {
> +    CXL_EVENT_TYPE_INFO          = 0,
> +    CXL_EVENT_TYPE_WARN          = 1,
> +    CXL_EVENT_TYPE_FAIL          = 2,
> +    CXL_EVENT_TYPE_FATAL         = 3,
> +    CXL_EVENT_TYPE_DYNAMIC_CAP   = 4,
> +    CXL_EVENT_TYPE_MAX
> +} CXLEventLogType;
> +
> +#endif /* CXL_EVENTS_H */
> diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
> index 86e1cea8ce..517f06d869 100644
> --- a/hw/cxl/cxl-device-utils.c
> +++ b/hw/cxl/cxl-device-utils.c
> @@ -41,7 +41,20 @@ static uint64_t caps_reg_read(void *opaque, hwaddr offset, unsigned size)
>  
>  static uint64_t dev_reg_read(void *opaque, hwaddr offset, unsigned size)
>  {
> -    return 0;
> +    CXLDeviceState *cxl_dstate = opaque;
> +
> +    switch (size) {
> +    case 1:
> +        return cxl_dstate->dev_reg_state[offset];
> +    case 2:
> +        return cxl_dstate->dev_reg_state16[offset / size];
> +    case 4:
> +        return cxl_dstate->dev_reg_state32[offset / size];
> +    case 8:
> +        return cxl_dstate->dev_reg_state64[offset / size];
> +    default:
> +        g_assert_not_reached();
> +    }
>  }
>  
>  static uint64_t mailbox_reg_read(void *opaque, hwaddr offset, unsigned size)
> @@ -236,7 +249,27 @@ void cxl_device_register_block_init(Object *obj, CXLDeviceState *cxl_dstate)
>                                  &cxl_dstate->memory_device);
>  }
>  
> -static void device_reg_init_common(CXLDeviceState *cxl_dstate) { }
> +void cxl_event_set_status(CXLDeviceState *cxl_dstate, CXLEventLogType log_type,
> +                          bool available)
> +{
> +    if (available) {
> +        cxl_dstate->event_status |= (1 << log_type);
> +    } else {
> +        cxl_dstate->event_status &= ~(1 << log_type);
> +    }
> +
> +    ARRAY_FIELD_DP64(cxl_dstate->dev_reg_state64, CXL_DEV_EVENT_STATUS,
> +                     EVENT_STATUS, cxl_dstate->event_status);
> +}
> +
> +static void device_reg_init_common(CXLDeviceState *cxl_dstate)
> +{
> +    CXLEventLogType log;
> +
> +    for (log = 0; log < CXL_EVENT_TYPE_MAX; log++) {
> +        cxl_event_set_status(cxl_dstate, log, false);
> +    }
> +}
>  
>  static void mailbox_reg_init_common(CXLDeviceState *cxl_dstate)
>  {
> @@ -258,13 +291,13 @@ void cxl_device_register_init_common(CXLDeviceState *cxl_dstate)
>      ARRAY_FIELD_DP64(cap_hdrs, CXL_DEV_CAP_ARRAY, CAP_VERSION, 1);
>      ARRAY_FIELD_DP64(cap_hdrs, CXL_DEV_CAP_ARRAY, CAP_COUNT, cap_count);
>  
> -    cxl_device_cap_init(cxl_dstate, DEVICE_STATUS, 1);
> +    cxl_device_cap_init(cxl_dstate, DEVICE_STATUS, 1, 2);
>      device_reg_init_common(cxl_dstate);
>  
> -    cxl_device_cap_init(cxl_dstate, MAILBOX, 2);
> +    cxl_device_cap_init(cxl_dstate, MAILBOX, 2, 1);
>      mailbox_reg_init_common(cxl_dstate);
>  
> -    cxl_device_cap_init(cxl_dstate, MEMORY_DEVICE, 0x4000);
> +    cxl_device_cap_init(cxl_dstate, MEMORY_DEVICE, 0x4000, 1);
>      memdev_reg_init_common(cxl_dstate);
>  
>      cxl_initialize_mailbox(cxl_dstate);
> -- 
> 2.39.2
> 

-- 
Fan Ni <nifan@outlook.com>
