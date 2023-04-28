Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F34D4C77B61
	for <linux-cxl@archiver.kernel.org>; Fri, 28 Apr 2023 20:17:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbjD1URH (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 28 Apr 2023 16:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjD1URG (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 28 Apr 2023 16:17:06 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 988BE26B1
        for <linux-cxl@vger.kernel.org>; Fri, 28 Apr 2023 13:17:04 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 6D0B282107D;
        Fri, 28 Apr 2023 20:17:03 +0000 (UTC)
Received: from pdx1-sub0-mail-a312.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id D3399822120;
        Fri, 28 Apr 2023 20:17:02 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1682713022; a=rsa-sha256;
        cv=none;
        b=ARYezzsHpPOfqQ0kiQGxpzjwy+5+GCqbYoetcEZbh09h05NaTzJA3S4bE2oxEIsnFAAx+x
        aT6RB/9ZZAkcvbm4Pofv/6vMc1tE9MnjWtxfEakA9u5J+LuBjzqCRtvZymWW2qT1vne/F1
        6efQtu3hfGZN5wY060TaQZ9a7ExHxd/r3qy9oE2vhYcR13hk2bYQL7v6G6W+nLf5DiAzEh
        zXsLCggkkPKaUOkijp20TdCUiTC1U9CERig+RAkY8fbPivLrxsgwN913LEYyWGq/9qh9Dj
        JTrB1Ft0Zi8T7BH/DxD2jNDbiU+jbWy6BQyYb8cWxSWiuAmhbZhuuHl2VOdydg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1682713022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=OGWfqZFx4s1tZMEO4Gg5Et0UsBshUfJiCe0oHtI4u0w=;
        b=WQ32UveQT/mlDyArS9pZ5Odpur8cRu2isf8QGkD51NX29/uszhxkBkICzB4rzfqzHNmILq
        XsSo6poS1CRFQYq76ZFKBpIIOYLAJTq95wsMSMLwD9oA0K/M/BHNaGFzv+KsBv3B/KMMaX
        4nOrqfPIodFSz6le//hTbotRo6iM5AZ05Gbk0JmzEf7XVqB37IjShWs0MbXaFueUATcfE9
        hZW0djfitgAjdajJ6rHmVQFi+P/CuAAflXDWXQUnZfU8xqS4gbBOE5Qi4g6jPWR3Sh4MNX
        lP/TrLuE9rdMSgvApYXQJ4f9gF5yheOQoy3rbHLdzBBcFlbOCnpcHb77i2DbDQ==
ARC-Authentication-Results: i=1;
        rspamd-548d6c8f77-hk64m;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Continue-Reign: 56c9277c3dbe113e_1682713023260_2171961212
X-MC-Loop-Signature: 1682713023260:3913425379
X-MC-Ingress-Time: 1682713023260
Received: from pdx1-sub0-mail-a312.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.104.253.244 (trex/6.7.2);
        Fri, 28 Apr 2023 20:17:03 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a312.dreamhost.com (Postfix) with ESMTPSA id 4Q7P5p1ZjMz6m;
        Fri, 28 Apr 2023 13:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1682713022;
        bh=OGWfqZFx4s1tZMEO4Gg5Et0UsBshUfJiCe0oHtI4u0w=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=YNPA+gufAn3CX0YnahNohtZIgPVaKHNIsUIbeJsHz+zehyvyzJU+EJ3xUPqvHwkVo
         mK0OBKQch0VSpFClYbpJrCxynLTustykyAAirYPV2YCo1NEKjDGit0EtE81k2ugjRt
         bYp9UQR8V02kcD5GgwLh/uicImWtIlvF5bLlb+n84cNECE+KdFBUfKHLgElnEfWCZP
         ojvdk28AlQsOlFuZPFMQgnoPue9hATuYLA2NRfbTniLknPk/oO6BL5nlGxd5gJBONu
         RMthfMlSSaWkotKHKHn8HOrmIMfQaj+5tK66UiBuUOlRB8ES1OZcai3mZkqGT3BSY9
         MuSLNpd4T8zRw==
Date:   Fri, 28 Apr 2023 12:45:02 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Fan Ni <nifan@outlook.com>
Cc:     Jonathan.Cameron@huawei.com, alison.schofield@intel.com,
        ira.weiny@intel.com, dan.j.williams@intel.com, fan.ni@samsung.com,
        a.manzanares@samsung.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 2/3] hw/cxl: Add scan media mailbox command support
Message-ID: <lxylc5u26eix3w5whmf6udnt4iipcaomv4fbbdqqibooelw42r@ttind6rbtpdm>
References: <20230426021418.10186-1-dave@stgolabs.net>
 <CGME20230426024617uscas1p27794b487f509d3eed93fadab5de9bb01@uscas1p2.samsung.com>
 <20230426021418.10186-3-dave@stgolabs.net>
 <SG2PR06MB3397DDBD852930E3717B5105B26B9@SG2PR06MB3397.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <SG2PR06MB3397DDBD852930E3717B5105B26B9@SG2PR06MB3397.apcprd06.prod.outlook.com>
User-Agent: NeoMutt/20230407
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 28 Apr 2023, Fan Ni wrote:

>The 04/25/2023 19:14, Davidlohr Bueso wrote:
>> Trigger the background command and when done go about adding
>> entries to the poison list, or not. Randonly decide how many
>> random addresses to generate.
>>
>> Currently never udpate DRAM Event Log.
>>
>> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
>> ---
>>  hw/cxl/cxl-mailbox-utils.c  | 127 +++++++++++++++++++++++++++++++++++-
>>  hw/mem/cxl_type3.c          |   3 +
>>  include/hw/cxl/cxl_device.h |   8 +++
>>  3 files changed, 135 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
>> index f346aa8ce3b2..7f29b840a2c9 100644
>> --- a/hw/cxl/cxl-mailbox-utils.c
>> +++ b/hw/cxl/cxl-mailbox-utils.c
>> @@ -80,6 +80,7 @@ enum {
>>          #define INJECT_POISON          0x1
>>          #define CLEAR_POISON           0x2
>>          #define GET_SCAN_MEDIA_CAPABILITIES 0x3
>> +        #define SCAN_MEDIA             0x4
>>      PHYSICAL_SWITCH = 0x51
>>          #define IDENTIFY_SWITCH_DEVICE      0x0
>>  };
>> @@ -852,6 +853,9 @@ static CXLRetCode cmd_media_inject_poison(struct cxl_cmd *cmd,
>>       */
>>      QLIST_INSERT_HEAD(poison_list, p, node);
>>      ct3d->poison_list_cnt++;
>> +    if (scan_media_running(cxl_dstate)) {
>> +        ct3d->poison_list_dirty = true;
>> +    }
>>
>>      return CXL_MBOX_SUCCESS;
>>  }
>> @@ -932,6 +936,10 @@ static CXLRetCode cmd_media_clear_poison(struct cxl_cmd *cmd,
>>      /* Any fragments have been added, free original entry */
>>      g_free(ent);
>>
>> +    if (scan_media_running(cxl_dstate)) {
>> +        ct3d->poison_list_dirty = true;
>> +    }
>> +
>>      return CXL_MBOX_SUCCESS;
>>  }
>>
>> @@ -974,6 +982,103 @@ cmd_media_get_scan_media_capabilities(struct cxl_cmd *cmd,
>>      return CXL_MBOX_SUCCESS;
>>  }
>>
>> +static void __do_scan_media(CXLDeviceState *cxl_dstate)
>> +{
>> +    CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
>> +    CXLPoisonList *poison_list = &ct3d->poison_list;
>> +    CXLPoison *ent, *p;
>> +    uint64_t dpa = 0;
>> +    int n_dpas;
>> +    GRand *rand;
>> +
>> +    rand = g_rand_new();
>> +
>> +    /* how many dpas to "detect" and add to the poison list */
>> +    n_dpas = g_random_int_range(0, CXL_MBOX_INJECT_POISON_LIMIT/4);
>> +
>> +    do {
>> +        /*
>> +         * TODO: limit it within the device dpa space (same for
>> +         * inject poison). For now generate some random address.
>> +         */
>> +    retry_dpa:
>> +        dpa = (uint64_t)g_rand_int(rand) << 32 |(uint64_t)g_rand_int(rand);
>> +        /* 64 byte alignment required */
>> +        if (dpa & 0x3f) {
>> +            goto retry_dpa;
>> +        }
>This seems very inefficient. the possibility for dpa to pass the check
>is 1/64. Why not just do something like below:
>dpa = (uint64_t)g_rand_int(rand) << 6;
>> +
>> +        QLIST_FOREACH(ent, poison_list, node) {
>> +            if (dpa >= ent->start &&
>> +                dpa + 64 <= ent->start + ent->length) {
>> +                goto retry_dpa;
>> +            }
>> +        }
>> +
>> +        p = g_new0(CXLPoison, 1);
>> +
>> +        p->length = 64;
>> +        p->start = dpa;
>> +        p->type = CXL_POISON_TYPE_SCANMEDIA;
>> +
>> +        QLIST_INSERT_HEAD(poison_list, p, node);
>> +        ct3d->poison_list_cnt++;
>> +    } while (--n_dpas);
>> +
>> +    g_rand_free(rand);
>> +}
>> +
>> +static CXLRetCode
>> +cmd_media_scan_media(struct cxl_cmd *cmd,
>> +                     CXLDeviceState *cxl_dstate, uint16_t *len)
>> +{
>> +    struct scan_media_pl {
>> +        uint64_t pa;
>> +        uint64_t length;
>> +        uint8_t flags;
>> +    } QEMU_PACKED;
>> +    struct scan_media_pl *in = (void *)cmd->payload;
>> +    CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
>> +    uint64_t query_start;
>> +    uint64_t query_length;
>> +
>> +    query_start = ldq_le_p(&in->pa);
>> +    /* 64 byte alignment required */
>> +    if (query_start & 0x3f) {
>> +        return CXL_MBOX_INVALID_INPUT;
>> +    }
>> +    query_length = ldq_le_p(&in->length) * 64;
>> +
>> +    /*
>> +     * TODO: Any previous Scan Media results are discarded by
>> +     * the device upon receiving a new Scan Media command.
>> +     */
>> +
>> +    /*
>> +     * The host should use this command only if the poison list
>> +     * has overflowed and is no longer a complete list of the
>> +     * memory errors that exist on the media.
>> +     */
>> +    if (ct3d->poison_list_cnt == CXL_POISON_LIST_LIMIT) {
>> +        ct3d->poison_list_cnt = 0;
>> +    }
>> +
>> +    if (query_start + query_length > cxl_dstate->mem_size) {
>> +        return CXL_MBOX_INVALID_PA;
>> +    }
>> +
>> +    if (in->flags == 0) { /* TODO */
>> +        qemu_log_mask(LOG_UNIMP,
>> +                      "Scan Media Event Log is unsupported\n");
>> +    }
>> +
>> +    cxl_dstate->bg.runtime = MAX(1, query_length * (0.0005L/64));
>> +    ct3d->poison_list_dirty = false;
>> +
>> +    *len = 0;
>> +    return CXL_MBOX_BG_STARTED;
>> +}
>> +
>>  #define IMMEDIATE_CONFIG_CHANGE (1 << 1)
>>  #define IMMEDIATE_DATA_CHANGE (1 << 2)
>>  #define IMMEDIATE_POLICY_CHANGE (1 << 3)
>> @@ -1014,7 +1119,8 @@ static struct cxl_cmd cxl_cmd_set[256][256] = {
>>          cmd_media_clear_poison, 72, 0 },
>>      [MEDIA_AND_POISON][GET_SCAN_MEDIA_CAPABILITIES] = { "MEDIA_AND_POISON_GET_SCAN_MEDIA_CAPABILITIES",
>>          cmd_media_get_scan_media_capabilities, 16, 0 },
>should command effect be BACKGROUND_OPERATION instead of 0?

Yes...

>> -
>> +    [MEDIA_AND_POISON][SCAN_MEDIA] = { "MEDIA_AND_POISON_SCAN_MEDIA",
>> +        cmd_media_scan_media, 17, 0 },

but for this one.

>>  };

I'll incorporate your feedback in a next v1 - probably after the kernel
changes are posted, for actual testing.

Thanks for going through the rfc!
