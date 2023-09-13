Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D73EEB58C
	for <linux-cxl@archiver.kernel.org>; Wed, 13 Sep 2023 03:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbjIMDrY (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 12 Sep 2023 23:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbjIMDrX (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 12 Sep 2023 23:47:23 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE141722
        for <linux-cxl@vger.kernel.org>; Tue, 12 Sep 2023 20:47:19 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 99A2036163A;
        Wed, 13 Sep 2023 03:47:18 +0000 (UTC)
Received: from pdx1-sub0-mail-a233.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 29B1F361A1C;
        Wed, 13 Sep 2023 03:47:18 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1694576838; a=rsa-sha256;
        cv=none;
        b=M6BxOtQ6O72wtHUymG+grgIsdK10n3GTVos0Qpw41sI4zf/U10i8kyTxLy+i0IXDcFbXAU
        1kI3d2W36zfmdle2tz0hiA1R3mjoC9dRjh/32HXn2Hqny9eDz4OnXsJ7K136y7g6gOVWta
        ObghzJldxktL5DvdJfZVW83yPsghdcm0RRUgB3SX+XrU+9mozxzGHq/ID6HADmMdpMMGrp
        gTdP0SpKXsIkpRqUD8nzHRA416QykVbAwhhwmUy7RBCeQOKtx1paJDZpz2zVShSM1wJQIK
        d+gKjynYf6SjoaJ4Sn20XRjFMtKYXHiY6Cck7pbz2Cr/l1HnLDe2PCaMa1rx0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1694576838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=QPWOVY000JSTA2XMNMZsjfnZL4G1Y3sKcaGkKgedcig=;
        b=peFtecOjOPfU5MKr0S0wuYzFCbEyWLGuB2DBNv8FuOmXgGraFLrLpXZGOjfSsMIuIqKGTK
        ByqLD9ODA2FOWdM3vr2geWD5n1z0RL4qwOwx3oe60jENNnBiot/qbX1EydGQuZhr0TIjCF
        FXxREWUGdCjmpx8vncbHmiOWjZ7frgl3fqjZ8Anvzh06RtxPtszvsWOtfe8nkvSKaZcT7u
        vdx0gXojAaXgoMlzxODQ1DfftVcdUYN3TOfA6BFj0xejYbxnBboYDQFTmdlGqqfIcOokT0
        X6E4h/2rNCWy5lxhGsUoZpYdVGWsIWEkOD6obcP4kA7A/3zBssp2PTULCOjr1g==
ARC-Authentication-Results: i=1;
        rspamd-7c449d4847-29vwk;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Blushing-Reign: 1f2b21e61516871b_1694576838442_538181131
X-MC-Loop-Signature: 1694576838442:3533100980
X-MC-Ingress-Time: 1694576838442
Received: from pdx1-sub0-mail-a233.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.116.67.79 (trex/6.9.1);
        Wed, 13 Sep 2023 03:47:18 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a233.dreamhost.com (Postfix) with ESMTPSA id 4Rlmc5429bzFM;
        Tue, 12 Sep 2023 20:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1694576837;
        bh=QPWOVY000JSTA2XMNMZsjfnZL4G1Y3sKcaGkKgedcig=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=bL7dKGnCrFTGi2wVj8xPlW2TQZBA/A4bGrDL1CJr4AezGaIAQX2/9FrGoZByoMmGJ
         FWMmkGQeoW2utPNGULkV/S4Pnt4+AwGHfhxEGTCnz8oUtthsZp8xmWsJDWxu1nj4dv
         eimYHxbhubNl9IBijMi67XWw27f2+9L+2u86VefOxnAbyqpbmEYSVbegnzADKe93HU
         Ipuch+aixdns6i7I3tWfuvknRHnRwUZBiT30MnWIbJfs0tUQXPPQq4eiIs1mT6a78J
         bR5s44+lm9ULR00xvAXzqUaZxAUle1w8ydcnnUo6tIqs/ewwjzgzFdXCaPvoCYjGyw
         u3cLCnZoSG7ZQ==
Date:   Tue, 12 Sep 2023 20:47:13 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     fan.ni@samsung.com, dan.j.williams@intel.com,
        alison.schofield@intel.com, ayush.m55@samsung.com,
        a.manzanares@samsung.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 3/4] hw/cxl: Add scan media cmd support
Message-ID: <tzhageoh63orf2yu3myusqofqhnr23vqufu3mdgijfqeq43hv6@5h3ywsc5ly6e>
References: <20230908073152.4386-1-dave@stgolabs.net>
 <20230908073152.4386-4-dave@stgolabs.net>
 <20230912125710.00001e7f@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230912125710.00001e7f@Huawei.com>
User-Agent: NeoMutt/20230517
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 12 Sep 2023, Jonathan Cameron wrote:

>On Fri,  8 Sep 2023 00:31:51 -0700
>> +    if (scan_media_running(cci)) {
>> +        /*
>> +         * XXX: Spec is ambiguous - is this case considered
>> +         * a successful return despite not removing from the list?
>> +         */
>
>I think we are in impdef territory here, though happy to join the conversation
>if you want to raise it in CXL consortium.  Would need an errata though so
>I suspect it will stay impdef with likely reasoning being.
>
>OS should only use scan_media if it know poison list is overflowed.
>It should know it issued scan media.
>It should not do anything so silly has hit the device with a poison clear
>in parallel to that.  Hence doesn't matter that this corner is impdef.

Right, this is very much along the lines of what I have the kernel currently
doing. That is, directly start the scan from get poison list if the overflow
bit returns set. This does not follow userspace policy once discussed and
hence no possibility of calling scan media under bogus conditions. Inject/clear
are also serialized vs this, so no funny business either.

>
>I'd like to see a comment to say it is though!
>
>> +        goto success;
>> +    }
>> +
>>      QLIST_FOREACH(ent, poison_list, node) {
>>          /*
>>           * Test for contained in entry. Simpler than general case
>> @@ -1133,7 +1160,7 @@ static CXLRetCode cmd_media_clear_poison(const struct cxl_cmd *cmd,
>>          }
>>      }
>>      if (!ent) {
>> -        return CXL_MBOX_SUCCESS;
>> +        goto success;
>
>Is this a bug fix?  I think the explicit setting of len_out came in somewhere but don't
>think it is necessary for commands that have no output payload.  If it is, then we should
>set it at the top of the function as they never have a payload.

Yeah it doesn't matter for this case.

Thanks,
Davidlohr
