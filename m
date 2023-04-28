Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8018C77B60
	for <linux-cxl@archiver.kernel.org>; Fri, 28 Apr 2023 16:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbjD1Qmv (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 28 Apr 2023 12:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346055AbjD1Qmu (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 28 Apr 2023 12:42:50 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2077.outbound.protection.outlook.com [40.92.107.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8DA1BE1
        for <linux-cxl@vger.kernel.org>; Fri, 28 Apr 2023 09:42:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eWrMlWqBNnZczlzWAtooCtF4KCWCrgi5+EWhdce6dtWLiD75v5NPomfxcQ7RTqAzCgTrFTW+9zE+l9BXgcF4HXppF2wJFXwpE4gq1eISdU6vPJPlU95HWpmXEaKShSdPWgvqcIbqmcnc8spCApajuNStqAogL8AGcGtYsYZg4lnLTMn97zbzx8B55IIMIlQ/O2X8niZDg9Bge3fXuRM6cOXOYwAWoRhh8BVlnkp1wc5O3mBTHCoQUNTeRfJx9ONy8hTtUhtlZr2YiZL5TkLLChOuY976uH5HRJcuYq7kEcqxvjmlgJ6Z9zhBZJHsJIqobbHuQlmbOkC4c04fbc4PIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pMY/CI1MlYtU+012q+eYmb/XvpavjAkYfNtk9SV6RHk=;
 b=g5RmIKydaTeLS7WzEITyXIxr+t5uuBIo/dvsPXnwvfDZMALS5/EO57ELvigNfBwaGBo6C67ufQTvWCfkgHhVCSd/KN2m08lDmKq5DTwQdvqMBkQd0s7PahW6SAyt/z3ybVaJR7+am7N5kfeH3hp2vxvL2R1W+cE5iEMPSxKKvdxS9ZjaK8oyZBSUVPVSoUWSPmrFFYIFoT1k5p0Gqw/sxCb48jF07zOJ4udxCThC8u1qWgULkC3c6Eg7EkUpKQiFOJFRWILPq09l8KpdDoRJ/drat5KiabtAf/505u77nxiHDIXs1/T7elBno8d8FC4BzSi8nP3QUuji6wP7PfmClA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pMY/CI1MlYtU+012q+eYmb/XvpavjAkYfNtk9SV6RHk=;
 b=Bbe+kNQlUuU/039dGhCiPzTtH9+YwyiQvLP5LVtVf+6v/uoFDh3EWqEHwBMvqDK3MyPEXNouDSz/e7BZGwCWDR2RD0HyXFT1fs8JCWyk4nljbZi7xOs0UR3t7J3h8YuffnY+WrZYskMGwv68hloawPq7JLKQkhaJ7HTUZZtM2shgiMZHZBak6dSjxLWR4PH5eZXWDKn5UuD1n50aK5Yx+e0TN+eE5iE1hiHlYSp5r9DncpYVY9sIbQUnQ9bEjsEjEcHWDlpwoR6biaS7Fy/lqYlheO0oKYgK2Hurjf0qbF1NdRWp5jW0uWmTI0Zb7TJhva62I6tjnwMGRa35n+xIBQ==
Received: from SG2PR06MB3397.apcprd06.prod.outlook.com (2603:1096:4:7a::17) by
 TYZPR06MB4579.apcprd06.prod.outlook.com (2603:1096:400:122::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.23; Fri, 28 Apr 2023 16:42:37 +0000
Received: from SG2PR06MB3397.apcprd06.prod.outlook.com
 ([fe80::93bc:25d1:6ff9:2b63]) by SG2PR06MB3397.apcprd06.prod.outlook.com
 ([fe80::93bc:25d1:6ff9:2b63%3]) with mapi id 15.20.6340.025; Fri, 28 Apr 2023
 16:42:37 +0000
Date:   Fri, 28 Apr 2023 09:42:28 -0700
From:   Fan Ni <nifan@outlook.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Jonathan.Cameron@huawei.com, alison.schofield@intel.com,
        ira.weiny@intel.com, dan.j.williams@intel.com, fan.ni@samsung.com,
        a.manzanares@samsung.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 2/3] hw/cxl: Add scan media mailbox command support
Message-ID: <SG2PR06MB3397DDBD852930E3717B5105B26B9@SG2PR06MB3397.apcprd06.prod.outlook.com>
References: <20230426021418.10186-1-dave@stgolabs.net>
 <CGME20230426024617uscas1p27794b487f509d3eed93fadab5de9bb01@uscas1p2.samsung.com>
 <20230426021418.10186-3-dave@stgolabs.net>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230426021418.10186-3-dave@stgolabs.net>
X-TMN:  [5U2QAA9leD96BMZl92OZ44nhwIwNPHBc]
X-ClientProxiedBy: PH0P220CA0019.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:d3::32) To SG2PR06MB3397.apcprd06.prod.outlook.com
 (2603:1096:4:7a::17)
X-Microsoft-Original-Message-ID: <ZEv3dFKAqfRKm2WN@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3397:EE_|TYZPR06MB4579:EE_
X-MS-Office365-Filtering-Correlation-Id: 00c3816e-ab43-4c50-282e-08db48079327
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ISLMosUMGIL1kguSY7xvr8QccjFOFa1N73ERv+QHNg+/rZwKgNQVN5LQC0OFizo/mn0mlAwluNRJHyXDAKXKv+lzG/sbs0VYp0GluHXbZMUnAstKfy1Nd3JbzHdfIxAlHfIyAVbml/pn/odnJHr7czpnl5Tz14w+4ylsQ2O9XeoqXuFm4xRpbaV7m6jFSmEOhohOe0kA+Wv1Vq/1fLRc508ZUFN0fdJPlv96HO7GDdlkJa06zBjcJwQ7Bei/TIVhEdm1+JTU2XwLTYL6SHULmY3NtTfcHPhkSqffSSJHRNaAk6OmoN+dt1CyxJFFTZmEhF0TZkB2VWndZVj5AVV8jdqIxcPH+6PU7TeYHRfKMriMi+Uwo44vfU4Y/8pI06sQ+h+J8mIFTUGiKxg/DSbhZq/XBqHnffUFREfmTmzOgTZGFwMT4Uuq6NpsPIXfgcKrjIkffY/eQmRyfeBr5jROcIBmUBN2C2/8ESnzC+75LxCyARZsi3i4yIz124RPQcq2kDTpIi42i+mqIlwb09xju/uB0czU8Z5gKZ1y9yYg6taXEcr6jgwabjHm/nyUV6Y/V10WnvGNNnTIP3IB/wivTTtmIn7nWCaQNwEZDmcZTHqKKDQoeEwA6J5ywnLyOQey
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDR1SVpBZmZBQWVQZDBRcHdyOU9BaWVuaFhqMmxmNDhselVGREUwOXlKT1pz?=
 =?utf-8?B?eUc1czdwUUhybEhySTZrTUh6T3FJVDArckc0TDlaTWR2ZDhhTWcrVkJBTmlt?=
 =?utf-8?B?cFp0WUpzRHJZZ1JCMCt4Y0duSWs4VmZ1RlhRRi9KK0wwU2lOK3ZjS29sUm9l?=
 =?utf-8?B?VCtDZFkrSUhoMEI2cUFBdjl0M2k5VE1wKzhIMWdJamRaZFZBd3BYQjFZY3hi?=
 =?utf-8?B?VWR4ckdPMklrQWt2Z3hEZzBVSUw2Zmt6aUt5Y1VvNlFNdGlaR0lrU1dFQUk4?=
 =?utf-8?B?L0lIQi9tVGQvMVNxdllwa01aQWFHYktvYjVjQVBwTmVKUFo1NkVpMmNWQkFw?=
 =?utf-8?B?ZEJ0RndwMnVhckZESTVUSHFHUWtQTzZtbHNGTk1wRWYyQmRkbkluSjBwTENU?=
 =?utf-8?B?TjN3Q0N5T3dyVHFmUFhCUzhNTXdXOXhuZlJOY1ZnZTU4S0NDckJ3dG4zL2Fz?=
 =?utf-8?B?SHlJRGs0eXhBeDNpOVVZK3NWN3Zmb01LR1lNYzh0RzdiQTRRUkppREZTdVls?=
 =?utf-8?B?ak1pMnZ0SVVsR0JpdTJ6bElwNnBybm1scnFMb0kvTHQyNVVoZlJKbnlITVRy?=
 =?utf-8?B?ak0xOU1mc3NhZndMZHFpdis1Rm1jcnZwdVBnRFFtNjFweDJxbHgyV1kzYXdR?=
 =?utf-8?B?Tm03UEdnRjlGOU5zbVlpUXQrRmlha010b01USzVpcy8zbnVVN0gxMEl0YWpK?=
 =?utf-8?B?eTBnb1I3a1dCQ2ZDcDV3dGsrdGJoaVlDTjJJUGM2allQK1dPSHZJUjg1V0p4?=
 =?utf-8?B?WEpWcnZpbEVsNk5JMGJCT2lTcVJjUmp2d1RYU1RCRzh0U3dWWFFtU013M2Fw?=
 =?utf-8?B?VEVxSFl1b2s3TkdNUXNsNTVtem41TDl3TE4xUnRLWDdCYXdjMjQ5QWU1M29q?=
 =?utf-8?B?S0ZEVzlqRmRxeENXaFMyaGk3NkhwcTBpWlpONldOR2hOY0NSdlFrQktCd0Zx?=
 =?utf-8?B?QnVBTGxyYVVUVWlFWFZiTmpyT2Z2ai8xN2Vqb0xCTWxzbUpFaXc3NDFFZTFG?=
 =?utf-8?B?U09UZlNvQXpsaTBvS3I0L3BhS2UxTk9KWTRtMUw2NWFXYWtPNkIrQmtxbjVB?=
 =?utf-8?B?TGtobzA3UE9aT1Z1UmxCQUxsak03KzVCaUNwSzVqcjZkcmd4Mm80V0dnajFr?=
 =?utf-8?B?VlI5NnY5a0tUYTZ1VUdvRDBIditVeWdDQUlaOGFVTTJScDRxcUY2RlY1UXkv?=
 =?utf-8?B?RDFpS3N2V01SbEJYUHFRSXNDVzF4dFNQTHZtVmVUTEo3WWhpZTQzME1xK0Nq?=
 =?utf-8?B?aUZQWlBpaGFOMitDRER5Y2VYaVd0MHM4L2VGYUlOVXNCUXNWZ1h6MmxWMG1J?=
 =?utf-8?B?QzM5TXY4dGhoV1plZjllZ0pGSW9jNGxpT2lwcUFBa2tjQ3pKQzMvYWloalZR?=
 =?utf-8?B?eHhkZm1zbnQycWtlN1VkR3d1eG5pTU9yRXYzZXhUOTdocDF0T0pvcHFEUldn?=
 =?utf-8?B?WW1pUmlKaE1RYlBaMHdxamtrRHZ6QUhOUkRnNFlhTzZoTjQrTm9haDR6aHBy?=
 =?utf-8?B?eW80akVoWWNoUXhkcEprZk53NkswWHU1cUYyS01XYkNLRWdUQ3UyTnphYkxp?=
 =?utf-8?B?NzRHK091SDlsK2J6bWFsWUQ5WW9IRXE4azZHQkwvajZKSndpdjlMRHNRM3I3?=
 =?utf-8?B?QXpienVLM2M1VE4xNHpVdjVXeXNTVnc9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00c3816e-ab43-4c50-282e-08db48079327
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3397.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2023 16:42:37.7233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4579
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The 04/25/2023 19:14, Davidlohr Bueso wrote:
> Trigger the background command and when done go about adding
> entries to the poison list, or not. Randonly decide how many
> random addresses to generate.
> 
> Currently never udpate DRAM Event Log.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  hw/cxl/cxl-mailbox-utils.c  | 127 +++++++++++++++++++++++++++++++++++-
>  hw/mem/cxl_type3.c          |   3 +
>  include/hw/cxl/cxl_device.h |   8 +++
>  3 files changed, 135 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index f346aa8ce3b2..7f29b840a2c9 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -80,6 +80,7 @@ enum {
>          #define INJECT_POISON          0x1
>          #define CLEAR_POISON           0x2
>          #define GET_SCAN_MEDIA_CAPABILITIES 0x3
> +        #define SCAN_MEDIA             0x4
>      PHYSICAL_SWITCH = 0x51
>          #define IDENTIFY_SWITCH_DEVICE      0x0
>  };
> @@ -852,6 +853,9 @@ static CXLRetCode cmd_media_inject_poison(struct cxl_cmd *cmd,
>       */
>      QLIST_INSERT_HEAD(poison_list, p, node);
>      ct3d->poison_list_cnt++;
> +    if (scan_media_running(cxl_dstate)) {
> +        ct3d->poison_list_dirty = true;
> +    }
>  
>      return CXL_MBOX_SUCCESS;
>  }
> @@ -932,6 +936,10 @@ static CXLRetCode cmd_media_clear_poison(struct cxl_cmd *cmd,
>      /* Any fragments have been added, free original entry */
>      g_free(ent);
>  
> +    if (scan_media_running(cxl_dstate)) {
> +        ct3d->poison_list_dirty = true;
> +    }
> +
>      return CXL_MBOX_SUCCESS;
>  }
>  
> @@ -974,6 +982,103 @@ cmd_media_get_scan_media_capabilities(struct cxl_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
>  
> +static void __do_scan_media(CXLDeviceState *cxl_dstate)
> +{
> +    CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
> +    CXLPoisonList *poison_list = &ct3d->poison_list;
> +    CXLPoison *ent, *p;
> +    uint64_t dpa = 0;
> +    int n_dpas;
> +    GRand *rand;
> +
> +    rand = g_rand_new();
> +
> +    /* how many dpas to "detect" and add to the poison list */
> +    n_dpas = g_random_int_range(0, CXL_MBOX_INJECT_POISON_LIMIT/4);
> +
> +    do {
> +        /*
> +         * TODO: limit it within the device dpa space (same for
> +         * inject poison). For now generate some random address.
> +         */
> +    retry_dpa:
> +        dpa = (uint64_t)g_rand_int(rand) << 32 |(uint64_t)g_rand_int(rand);
> +        /* 64 byte alignment required */
> +        if (dpa & 0x3f) {
> +            goto retry_dpa;
> +        }
This seems very inefficient. the possibility for dpa to pass the check
is 1/64. Why not just do something like below:
dpa = (uint64_t)g_rand_int(rand) << 6;
> +
> +        QLIST_FOREACH(ent, poison_list, node) {
> +            if (dpa >= ent->start &&
> +                dpa + 64 <= ent->start + ent->length) {
> +                goto retry_dpa;
> +            }
> +        }
> +
> +        p = g_new0(CXLPoison, 1);
> +
> +        p->length = 64;
> +        p->start = dpa;
> +        p->type = CXL_POISON_TYPE_SCANMEDIA;
> +
> +        QLIST_INSERT_HEAD(poison_list, p, node);
> +        ct3d->poison_list_cnt++;
> +    } while (--n_dpas);
> +
> +    g_rand_free(rand);
> +}
> +
> +static CXLRetCode
> +cmd_media_scan_media(struct cxl_cmd *cmd,
> +                     CXLDeviceState *cxl_dstate, uint16_t *len)
> +{
> +    struct scan_media_pl {
> +        uint64_t pa;
> +        uint64_t length;
> +        uint8_t flags;
> +    } QEMU_PACKED;
> +    struct scan_media_pl *in = (void *)cmd->payload;
> +    CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
> +    uint64_t query_start;
> +    uint64_t query_length;
> +
> +    query_start = ldq_le_p(&in->pa);
> +    /* 64 byte alignment required */
> +    if (query_start & 0x3f) {
> +        return CXL_MBOX_INVALID_INPUT;
> +    }
> +    query_length = ldq_le_p(&in->length) * 64;
> +
> +    /*
> +     * TODO: Any previous Scan Media results are discarded by
> +     * the device upon receiving a new Scan Media command.
> +     */
> +
> +    /*
> +     * The host should use this command only if the poison list
> +     * has overflowed and is no longer a complete list of the
> +     * memory errors that exist on the media.
> +     */
> +    if (ct3d->poison_list_cnt == CXL_POISON_LIST_LIMIT) {
> +        ct3d->poison_list_cnt = 0;
> +    }
> +
> +    if (query_start + query_length > cxl_dstate->mem_size) {
> +        return CXL_MBOX_INVALID_PA;
> +    }
> +
> +    if (in->flags == 0) { /* TODO */
> +        qemu_log_mask(LOG_UNIMP,
> +                      "Scan Media Event Log is unsupported\n");
> +    }
> +
> +    cxl_dstate->bg.runtime = MAX(1, query_length * (0.0005L/64));
> +    ct3d->poison_list_dirty = false;
> +
> +    *len = 0;
> +    return CXL_MBOX_BG_STARTED;
> +}
> +
>  #define IMMEDIATE_CONFIG_CHANGE (1 << 1)
>  #define IMMEDIATE_DATA_CHANGE (1 << 2)
>  #define IMMEDIATE_POLICY_CHANGE (1 << 3)
> @@ -1014,7 +1119,8 @@ static struct cxl_cmd cxl_cmd_set[256][256] = {
>          cmd_media_clear_poison, 72, 0 },
>      [MEDIA_AND_POISON][GET_SCAN_MEDIA_CAPABILITIES] = { "MEDIA_AND_POISON_GET_SCAN_MEDIA_CAPABILITIES",
>          cmd_media_get_scan_media_capabilities, 16, 0 },
should command effect be BACKGROUND_OPERATION instead of 0?
> -
> +    [MEDIA_AND_POISON][SCAN_MEDIA] = { "MEDIA_AND_POISON_SCAN_MEDIA",
> +        cmd_media_scan_media, 17, 0 },
>  };
>  
>  static struct cxl_cmd cxl_cmd_set_sw[256][256] = {
> @@ -1048,7 +1154,7 @@ void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
>      opcode_handler h;
>      uint8_t bg_started = 0;
>      uint64_t command_reg = cxl_dstate->mbox_reg_state64[R_CXL_DEV_MAILBOX_CMD];
> -
> +    CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
>      uint8_t set = FIELD_EX64(command_reg, CXL_DEV_MAILBOX_CMD, COMMAND_SET);
>      uint8_t cmd = FIELD_EX64(command_reg, CXL_DEV_MAILBOX_CMD, COMMAND);
>      uint16_t len = FIELD_EX64(command_reg, CXL_DEV_MAILBOX_CMD, LENGTH);
> @@ -1064,6 +1170,20 @@ void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
>                      ret = CXL_MBOX_BUSY;
>                      goto done;
>              }
> +
> +            /*
> +             * If the device updates its Poison List while the
> +             * Scan Media operation is executing, the device
> +             * shall indicate that a media scan is in progress
> +             * if Get Poison List is called during the scan.
> +             */
> +            if (ct3d->poison_list_dirty) {
> +                if (h == cmd_media_get_poison_list) {
> +                    ret = CXL_MBOX_BUSY;
> +                    goto done;
> +                }
> +            }
> +
>              /* forbid any selected commands while overwriting */
>              if (sanitize_running(cxl_dstate)) {
>                  if (h == cmd_events_get_records ||
> @@ -1157,7 +1277,8 @@ static void bg_timercb(void *opaque)
>                  __do_sanitization(cxl_dstate);
>                  cxl_dev_enable_media(cxl_dstate);
>                  break;
> -            case 0x4304: /* TODO: scan media */
> +            case 0x4304: /* scan media */
> +                __do_scan_media(cxl_dstate);
>                  break;
>              default:
>                  __builtin_unreachable();
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 3e63dbd83551..0bc017061f30 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -1213,6 +1213,9 @@ void qmp_cxl_inject_poison(const char *path, uint64_t start, uint64_t length,
>  
>      QLIST_INSERT_HEAD(&ct3d->poison_list, p, node);
>      ct3d->poison_list_cnt++;
> +    if (scan_media_running(&ct3d->cxl_dstate)) {
> +        ct3d->poison_list_dirty = true;
> +    }
>  }
>  
>  /* For uncorrectable errors include support for multiple header recording */
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index cd7f28dba884..8db63c1f7cd1 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -376,12 +376,18 @@ typedef struct CXLPoison {
>  #define CXL_POISON_TYPE_EXTERNAL 0x1
>  #define CXL_POISON_TYPE_INTERNAL 0x2
>  #define CXL_POISON_TYPE_INJECTED 0x3
> +#define CXL_POISON_TYPE_SCANMEDIA 0x4
>      QLIST_ENTRY(CXLPoison) node;
>  } CXLPoison;
>  
>  typedef QLIST_HEAD(, CXLPoison) CXLPoisonList;
>  #define CXL_POISON_LIST_LIMIT 256
>  
> +static inline bool scan_media_running(CXLDeviceState *cxl_dstate)
> +{
> +    return cxl_dstate->bg.runtime && cxl_dstate->bg.opcode == 0x4304;
> +}
> +
>  struct CXLType3Dev {
>      /* Private */
>      PCIDevice parent_obj;
> @@ -413,6 +419,8 @@ struct CXLType3Dev {
>      unsigned int poison_list_cnt;
>      bool poison_list_overflowed;
>      uint64_t poison_list_overflow_ts;
> +    /* list modified while doing scan media */
> +    bool poison_list_dirty;
>  };
>  
>  #define TYPE_CXL_TYPE3 "cxl-type3"
> -- 
> 2.40.0
> 

-- 
Fan Ni <nifan@outlook.com>
