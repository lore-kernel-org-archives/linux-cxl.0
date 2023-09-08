Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 081FAEEB566
	for <linux-cxl@archiver.kernel.org>; Fri,  8 Sep 2023 19:47:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236298AbjIHTrB (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 8 Sep 2023 15:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237987AbjIHTrB (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 8 Sep 2023 15:47:01 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3743AB9
        for <linux-cxl@vger.kernel.org>; Fri,  8 Sep 2023 12:46:27 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id D6B0A9001E7;
        Fri,  8 Sep 2023 19:44:59 +0000 (UTC)
Received: from pdx1-sub0-mail-a204.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 53A10901B54;
        Fri,  8 Sep 2023 19:44:59 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1694202299; a=rsa-sha256;
        cv=none;
        b=S/6k8/myK9hPhfEMBZ9CNBPBR+IZn3dzlHRHbDQQOPelH6jVFX6697BOrMyq47pURUKWRR
        TGJahdoIjoBLv+kQphMGDLfuyN/1OY/BTLjVoQ0K/G34zo+hmaKQOd35wqtidd73JhsmKO
        3jILQACsDzEo/wMD+TH1+yzwubDdYUFYxcoIxiB8yebWLb5OZ94YL2mhWOoMJnSLL6P2LY
        VOh6sT1hnU4Fejyafq2ZUkKw5D0rJJuppRPvQUlgRPf01lnCK9IKZuQzNcIQclprRqBRFt
        pcnFLlD2LxMBjcYUvlcFjh5QI5EADTSW8nDuWLZ97rjrxbftKl8AHVdwuD6Z9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1694202299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=hysBIDxHlDrnGuRki1dzPZf5yXrmKtiWZhRRYCnziSc=;
        b=spkaLiwpSQJ+K3Y5h6H25P+ikRZDNuxDNeRL2q0b4TCFrNxCJW7JAExtdtNkmU0F7lZzJA
        wBBjqU8NI3L4hLLsiklkLRMRzcHzNfmrbGJS8M6THFWq31msIu+82n7q8N31cR/F7SPI7I
        w+pmEjXtb5Pzmkgh8/fNT971fcPOkOJcCKUD+49TOQZBBmbQZ82tV98B1xbbUL8/3lYxHD
        gp2Im9mdfi2RNRzSXNij+28qfVcsdNv2z/kys+A8yU2AkQp3UZ1Ad/D6KdwLbop92PNyq1
        S5mANZqUoOKLOSU3+ormJW40oHJkNe66YbxtPIc5uC/GWwoTx9eIfmc9AuOzQA==
ARC-Authentication-Results: i=1;
        rspamd-7d5dc8fd68-k86zj;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Obese-Unite: 08dcc49f2a2c7653_1694202299634_4177011034
X-MC-Loop-Signature: 1694202299634:153869726
X-MC-Ingress-Time: 1694202299634
Received: from pdx1-sub0-mail-a204.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.99.54.162 (trex/6.9.1);
        Fri, 08 Sep 2023 19:44:59 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a204.dreamhost.com (Postfix) with ESMTPSA id 4Rj65Q4WYbzLC;
        Fri,  8 Sep 2023 12:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1694202299;
        bh=hysBIDxHlDrnGuRki1dzPZf5yXrmKtiWZhRRYCnziSc=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=JZEtTSCWLelfYrZq6CeyW/EMy97PjhBH3EsEtTSj2mEE8otPHs6CV/XvFRPxD3FkQ
         w++JMrdKeMEDThgi83RS7LtB7BYtp2ML62IRGcCQE6Wj/X0HdPsyJ6litIy6+lw8hO
         92BiC+AEGb8fRNkLSVilxlGlpwJm8qlOC6+P5JAiqoLN/DHnbLYGYSarwc+1GdB75C
         n+KURmJVyUqSwhnGYEvhbKOsOmr1l41J1knSB/fqz+c5RdfVHJaR8Qg3ykHP4d48/X
         kW3Q6uN+X7RdRSR2i9A76zErwkgdPpGbvatVG/a1eSat85KNlrkD3z3jHJz+HcMLht
         zE7g+UkNU0kpQ==
Date:   Fri, 8 Sep 2023 12:44:50 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Fan Ni <fan.ni@gmx.us>
Cc:     Jonathan.Cameron@huawei.com, fan.ni@samsung.com,
        dan.j.williams@intel.com, alison.schofield@intel.com,
        ayush.m55@samsung.com, a.manzanares@samsung.com,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH 2/4] hw/cxl: Add get scan media capabilities cmd support
Message-ID: <q7tdmtymlfum4wialum74eukzselwupejvynyhxtzb5tbqhes4@wpyd5i74hgaf>
References: <20230908073152.4386-1-dave@stgolabs.net>
 <20230908073152.4386-3-dave@stgolabs.net>
 <ZPtsVWGFo+BwMVk2@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZPtsVWGFo+BwMVk2@debian>
User-Agent: NeoMutt/20230517
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 08 Sep 2023, Fan Ni wrote:

>On Fri, Sep 08, 2023 at 12:31:50AM -0700, Davidlohr Bueso wrote:
>> +static CXLRetCode
>> +cmd_media_get_scan_media_capabilities(const struct cxl_cmd *cmd,
>> +                                      uint8_t *payload_in,
>> +                                      size_t len_in,
>> +                                      uint8_t *payload_out,
>> +                                      size_t *len_out,
>> +                                      CXLCCI *cci)
>> +{
>> +    struct get_scan_media_capabilities_pl {
>> +        uint64_t pa;
>> +        uint64_t length;
>> +    } QEMU_PACKED;
>> +
>> +    struct get_scan_media_capabilities_out_pl {
>> +        uint32_t estimated_runtime_ms;
>> +    } QEMU_PACKED;
>> +
>> +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
>> +    CXLDeviceState *cxl_dstate = &ct3d->cxl_dstate;
>> +    struct get_scan_media_capabilities_pl *in = (void *)payload_in;
>> +    struct get_scan_media_capabilities_out_pl *out = (void *)payload_out;
>> +    uint64_t query_start;
>> +    uint64_t query_length;
>> +
>> +    query_start = ldq_le_p(&in->pa);
>> +    /* 64 byte alignment required */
>> +    if (query_start & 0x3f) {
>> +        return CXL_MBOX_INVALID_INPUT;
>
>From the spec, it is not clear to me whether we should return invalid
>input or invalid PA.

The way I interpret it, which is also what get poison list does, is
invalid input is better served as invalid pa mostly means that the
actual address is invalid to the dpa space in question.

Thanks,
Davidlohr
