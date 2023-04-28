Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8409FC77B61
	for <linux-cxl@archiver.kernel.org>; Fri, 28 Apr 2023 20:02:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345685AbjD1UCj (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 28 Apr 2023 16:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbjD1UCi (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 28 Apr 2023 16:02:38 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B3B212B
        for <linux-cxl@vger.kernel.org>; Fri, 28 Apr 2023 13:02:37 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 0BE90542598;
        Fri, 28 Apr 2023 20:02:36 +0000 (UTC)
Received: from pdx1-sub0-mail-a312.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 77E90542681;
        Fri, 28 Apr 2023 20:02:35 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1682712155; a=rsa-sha256;
        cv=none;
        b=oockjB2vK6ZHGryeW0bNY48zCWrhXCuMrmCjHOHT0+tR0KQ8mqoTNME+h3rvhMu+ODHrPr
        ahfqbr0gQz8xZhiuvdI8YFphng3dY1UHIt0c8ZGDtZvGZ2W2GoQHHcOYpIarBdWVYCuJDb
        Cxckzr3iJOacrriVoksLJvhy8Y5Am5ndHIeot2hh/IE6od1kJLPfASPjxyDsndACBy5U1P
        RUIflYSw6j3tA3j3nQpj+A83Cf0q5h6ZbMX4+15md5uEuo9q/wn/a+qDPgJnLfV+hNjzuW
        JUcN4g/5CEbaSc4vchrYxKz97p6cFdLHhZER2gnofVvbm2+OCAAzjvRnpIr5Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1682712155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=Nj+ZE5fiOvFMyxg0ayvc14YG5LKKtShKdaEQhAUwb1s=;
        b=NPYq0ILICV27odPNo9uv+r0IdgbDOGxjgOrbBJj2FUqhBqoBTnJpKhIbba4+wTXVS6Jexl
        CZ50WLtXqJ+2TXtSEm8u8yDolFI8XQNkwJm4XLu7+cXaJ8qUTRdc6iHDghkjVouYcEoE3U
        mjwPT9bi3vud8/5gm5KJB+9fq70URbQvDolmowW3XW7zOmk23xvD7jUlFH8FyPA9+6z9c6
        fVUMHPW2kt2wNrWZHSr6Zq2Xx8CG3H1wq8U9SgOqrfwaT2M+574w2GNgIGEosq6igf55j7
        xdbOxvw80naqAGu56fwLYJrf3pLZKczCYjqMli5Wd98Rai8FyjLBStlCBwZyfA==
ARC-Authentication-Results: i=1;
        rspamd-7f66b7b68c-csrhh;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Chemical-Imminent: 5fb5e53720686fde_1682712155795_2525660157
X-MC-Loop-Signature: 1682712155794:3376222830
X-MC-Ingress-Time: 1682712155794
Received: from pdx1-sub0-mail-a312.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.101.8.80 (trex/6.7.2);
        Fri, 28 Apr 2023 20:02:35 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a312.dreamhost.com (Postfix) with ESMTPSA id 4Q7Nn65Gysz6m;
        Fri, 28 Apr 2023 13:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1682712155;
        bh=Nj+ZE5fiOvFMyxg0ayvc14YG5LKKtShKdaEQhAUwb1s=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=qci8owyWbeReTQo9Zc3eEK7mLly12ZeveTt5bCImme4hB0h5MffMIOSGNky8o+ml8
         weJOZKQG5PjLdwGWaAwhYmUKSskxsMRVcjGsq+njT0dy3fcEJ10N3MQ6/OgR+/dzxu
         a3X/F6zGhVKMeL+9PLTucjH3F1QGwY7ribKnCFyuVURyx99i/uNBUIjoEzvpe3vjA/
         PLnYz8wu9TjZxaO3KQMBvmoOjxyZY3ql7J6pjZ4g01ZZHApHhxhcWfV+IpB6OIFd8H
         1KJIciJGNESfuQZVPin/yH0RbegeM0YNsCOGQSTKf9Uzldrn3x4OfirLJVEiwC9Ub6
         YlNt2hcFcWnhA==
Date:   Fri, 28 Apr 2023 12:30:34 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Fan Ni <nifan@outlook.com>
Cc:     Jonathan.Cameron@huawei.com, alison.schofield@intel.com,
        ira.weiny@intel.com, dan.j.williams@intel.com, fan.ni@samsung.com,
        a.manzanares@samsung.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 3/3] hw/cxl: Add scan media mailbox command support
Message-ID: <z3h4udhpgvvogv4gyfkal7auquj2wy36pcgrxntf2hwosdxz5y@cyvx5m2qdsja>
References: <20230426021418.10186-1-dave@stgolabs.net>
 <CGME20230426024613uscas1p163d380501d4e11fc7d2cd6f8c6e5b198@uscas1p1.samsung.com>
 <20230426021418.10186-4-dave@stgolabs.net>
 <SG2PR06MB33977713A088C0F8C1320D69B26B9@SG2PR06MB3397.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <SG2PR06MB33977713A088C0F8C1320D69B26B9@SG2PR06MB3397.apcprd06.prod.outlook.com>
User-Agent: NeoMutt/20230407
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 28 Apr 2023, Fan Ni wrote:

>The 04/25/2023 19:14, Davidlohr Bueso wrote:
>> +static CXLRetCode cmd_media_get_scan_media_results(struct cxl_cmd *cmd,
>> +                                                   CXLDeviceState *cxl_dstate,
>> +                                                   uint16_t *len)
>> +{
>> +    struct get_scan_media_results_out_pl {
>> +        uint64_t dpa_restart;
>> +        uint64_t length;
>> +        uint8_t flags;
>> +        uint8_t rsvd1;
>> +        uint16_t count;
>> +        uint8_t rsvd2[20];
>20-->0xc
>> +        struct {
>> +            uint64_t addr;
>> +            uint32_t length;
>> +            uint32_t resv;
>> +        } QEMU_PACKED records[];
>> +    } QEMU_PACKED;
>> +    struct get_scan_media_results_out_pl *out = (void *)cmd->payload;
>> +    CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
>> +    uint16_t record_count = 0, i = 0;
>> +    CXLPoisonList *poison_list = &ct3d->poison_list;
>> +    CXLPoison *ent;
>> +    uint16_t out_pl_len;
>> +
>> +    QLIST_FOREACH(ent, poison_list, node) {
>> +        if (ent->type == CXL_POISON_TYPE_SCANMEDIA) {
>> +            record_count++;
>> +        }
>> +    }
>> +
>> +    out_pl_len = sizeof(*out) + record_count * sizeof(out->records[0]);
>> +    assert(out_pl_len <= CXL_MAILBOX_MAX_PAYLOAD_SIZE);
>Add TODO to cover the case when eror list is larger than output payload
>size??

Sure, but this is why I referenced this limitation in the cover letter.

>> +
>> +    memset(out, 0, out_pl_len);
>> +    QLIST_FOREACH(ent, poison_list, node) {
>> +        if (ent->type == CXL_POISON_TYPE_SCANMEDIA) {
>> +            uint64_t start, stop;
>> +
>> +            start = ent->start & 0xffffffffffffffc0;
>> +            stop = ent->start & 0xffffffffffffffc0;
>so start == stop??? missing ent->length for stop???

duh yes should be ent->start + ent->length. I did say all this was untested :)

Thanks,
Davidlor
