Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E8B2C77B60
	for <linux-cxl@archiver.kernel.org>; Fri, 28 Apr 2023 16:21:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239683AbjD1QVd (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 28 Apr 2023 12:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbjD1QVc (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 28 Apr 2023 12:21:32 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3468EF4
        for <linux-cxl@vger.kernel.org>; Fri, 28 Apr 2023 09:21:31 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 01DE85C1864;
        Fri, 28 Apr 2023 16:21:30 +0000 (UTC)
Received: from pdx1-sub0-mail-a209.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 6DB565C1236;
        Fri, 28 Apr 2023 16:21:29 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1682698889; a=rsa-sha256;
        cv=none;
        b=37YjMwWeD5o6CpOtglSrXKTtX9AVzoAiuM4wB3vcaAZ1KsD+i1ZLE9KMGjkLzmss95ZQxX
        nF5LH7pV5NObZttd0MlE8D4F4+YRHnwXXzrcyAhcDDRwldHyQlRzOdmEC17gBQJiiQYoy+
        w/JshENUdD9iyfvg/8iEDfX8fDid/BtpGeyGQs2c0SLn2evBXqp+hafNEtg1F5yDmaTcE9
        u9ZPwME0xGGSNJJjdKrAY2tnFHar6AM6D3w/pej+RSAPWxRjriHIfyV5yZ2uIz2BJRkwrr
        9ZOxPvWqeJCe5aLw9lI+6Ir8yWLF8QY8LuqIetR9obw0UH20Kp71E0PiDdpeew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1682698889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=bQ6XCVgoAnZcDP56B2S7EEgYfg7nfzPt0VS4JBhQITM=;
        b=ceLiQkUnEfG6A3zfJ2+UdLXmgLYy8Axu3Xw8sBNhfPhPf4mWl1mG7b88df7kXUtqAHFcyn
        o8+AI7SvDHOKCUBKcWFCfI/etsmDEKBGcbdOmbuS51JB43BPDNcyzmdOIWZPiLmwfQro7L
        oWptUYGAj7d9iEzhG6f3leshMTZUP6EMa2n4PdZ52NV2pmSE5XaKPUy/2Greh9xmSH7HuT
        oe2j8hORVg0N+W2LVPGTmNMy+KAwygx2YdWOykbJujeUyLq4yATnAK30XyXVupwsLz1A2z
        XVnTZULL4n0JWbh4UdZ8DuOLcCm1DP26SWnaYkcgUUouSu/gnHT7KWTKkpc5vA==
ARC-Authentication-Results: i=1;
        rspamd-7f66b7b68c-zn4rt;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Quick-Attack: 36c296ca5ff499ce_1682698889733_1238145786
X-MC-Loop-Signature: 1682698889733:537326438
X-MC-Ingress-Time: 1682698889733
Received: from pdx1-sub0-mail-a209.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.103.24.109 (trex/6.7.2);
        Fri, 28 Apr 2023 16:21:29 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a209.dreamhost.com (Postfix) with ESMTPSA id 4Q7Ht0578Cz6c;
        Fri, 28 Apr 2023 09:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1682698889;
        bh=bQ6XCVgoAnZcDP56B2S7EEgYfg7nfzPt0VS4JBhQITM=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=URpm/JtyXT8oMJZCVqG8dSv19rsncFpUJFtdBM/HFv2D5Uk8Keolaq8NtXY8l2xL7
         a9F65rUR/Y5enuRPtUAyyj2k5gt/DQi4XWXMVFvBwrcWVKlL6zif5x4Ulj1Q9oY1j4
         yF4M2QVijzRhvcvmZT6atQhYyLLL20+zx5SfaqtCm3a0hUrTmZYUnLUvs7q6H5swsL
         2O75Fo6aKHMipTX0HwgGbt2GKXRSV4zY9IaTB5Ddt9noiGK66bX0uyGmLrxeWEALlV
         oeJBhl6gLI5sSY2gX7eOcv/njMQSAisuaNArHQaNYZk+ysVWQGdhIjiLUo/CdMtYCb
         3GPc4ZtA9CdZw==
Date:   Fri, 28 Apr 2023 08:49:35 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Fan Ni <nifan@outlook.com>
Cc:     Jonathan.Cameron@huawei.com, alison.schofield@intel.com,
        ira.weiny@intel.com, dan.j.williams@intel.com, fan.ni@samsung.com,
        a.manzanares@samsung.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 1/3] hw/cxl: Add get scan media capabilities mailbox
 command support
Message-ID: <hs2cvj45rn3tk67xeacwqawasv2opoinlsmnopk56stbpehy3v@x6oh54bayhh3>
References: <20230426021418.10186-1-dave@stgolabs.net>
 <CGME20230426024613uscas1p2ace5025489d1d976a5e4860b0b06c42b@uscas1p2.samsung.com>
 <20230426021418.10186-2-dave@stgolabs.net>
 <SG2PR06MB3397E10EB741A22CC919C0FEB26B9@SG2PR06MB3397.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <SG2PR06MB3397E10EB741A22CC919C0FEB26B9@SG2PR06MB3397.apcprd06.prod.outlook.com>
User-Agent: NeoMutt/20230407
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 28 Apr 2023, Fan Ni wrote:

>> +static CXLRetCode
>> +cmd_media_get_scan_media_capabilities(struct cxl_cmd *cmd,
>> +                                      CXLDeviceState *cxl_dstate, uint16_t *len)
>> +{
>> +    struct get_scan_media_capabilities_pl {
>> +        uint64_t pa;
>> +        uint64_t length;
>> +    } QEMU_PACKED;
>> +    struct get_scan_media_capabilities_out_pl {
>> +        uint32_t estimated_runtime_ms;
>> +    } QEMU_PACKED;
>> +    struct get_scan_media_capabilities_pl *in = (void *)cmd->payload;
>> +    struct get_scan_media_capabilities_out_pl *out = (void *)cmd->payload;
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
>> +    if (query_start + query_length > cxl_dstate->mem_size) {
>> +        return CXL_MBOX_INVALID_PA;
>> +    }
>> +
>> +    /*
>> +     * Just use 400 nanosecond access/read latency + 100 ns for
>> +     * the cost of updating the poison list. For small enough
>> +     * chunks return at least 1 ms.
>> +     */
>> +    stq_le_p(&out->estimated_runtime_ms,
>> +             MAX(1, query_length * (0.0005L/64)));
>
>estimated_runtime_ms is uint32_t, use stl_le_p instead.

Yup, thanks.
