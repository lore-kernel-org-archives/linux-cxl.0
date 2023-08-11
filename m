Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC92EB64DD
	for <linux-cxl@archiver.kernel.org>; Fri, 11 Aug 2023 15:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235737AbjHKPhT (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 11 Aug 2023 11:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbjHKPhT (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 11 Aug 2023 11:37:19 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D3010E4
        for <linux-cxl@vger.kernel.org>; Fri, 11 Aug 2023 08:37:18 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 462A7C1159;
        Fri, 11 Aug 2023 15:37:18 +0000 (UTC)
Received: from pdx1-sub0-mail-a237.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 85607C0978;
        Fri, 11 Aug 2023 15:37:16 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1691768236; a=rsa-sha256;
        cv=none;
        b=eoyNF2rXFtg6Sj47ZBIiFIWmYh7o1+hWoJMkTLz+jzjZ6upGuwWysAB/dW1aydbLw7bpTT
        WMp9Hr1LqRG18566AHYB0sNS/BWoSonfLWKdsTKwGd5442YCt2PAZ7B2F7KwdR8QSqjhoZ
        bmcU4E2ki7Lv3EgrYy4jX+P/k1kqCUKxOmQ+LWgT8WoRVLmnE+BDYQM3aaDR3fel6nRNB6
        phHZW1JFlacAEmA9BO2vrwtVxvE4erR5RDnnSjLcT9dO5xWqD/dZZ9dL//gnQBx8Fha7Sm
        i5HRuTwNf3I+pgLSb08hD87t1w85zfCoAwAL1gLqZpdo+yOzj6xmX8yjQrF2xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1691768236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=OsAuu6Ebx4RoWdLj3CJYRj729mIOrHeeebRein8MPmg=;
        b=dD2a7/XzzUSWaTOmXJ4HBUsTBXxDk9z6tUMCYJPXtpB9ce1PDoSwBuP7Ziw8ziGESHa0ja
        ugO14qcPTPt6t2Q+7iPRlqBRZiMXdMJxSY0icDJidWeDarl57OPC3jk97mZZwkrHA1qg33
        Ok05ewD2e0xk67MTUTemhwrMXHdra+9NNJlpMpG42lQ0wRgooJd/8uALo6t/HKP1Cg3yKo
        p7Mbs6108fgEKxZmvCei5tsAQTZXQbzmyTIrHzYBj1VdAN+adEoj8KmkaA5JiO19Ru3Wkz
        9/5OEkrN0pKrCEKRPeqLhTXB+1X2mLThpgDQAKblKIqQKsjTdp7AglzXqj8jmQ==
ARC-Authentication-Results: i=1;
        rspamd-849d547c58-cvljt;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Harbor-Scare: 5a5e702b18da45c8_1691768238020_3528326660
X-MC-Loop-Signature: 1691768238019:604148469
X-MC-Ingress-Time: 1691768238019
Received: from pdx1-sub0-mail-a237.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.109.205.135 (trex/6.9.1);
        Fri, 11 Aug 2023 15:37:18 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a237.dreamhost.com (Postfix) with ESMTPSA id 4RMnwW6Mqcz3J;
        Fri, 11 Aug 2023 08:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1691768236;
        bh=OsAuu6Ebx4RoWdLj3CJYRj729mIOrHeeebRein8MPmg=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=c0odIp+q9qFVCsDg02o0neE2IjUjYURk8a5wQGO5JQEYE2PZ/qqzu9mQzWhLSGBMA
         giVdfjZdi1y9jDZsIQICnv7j6rpG6XP8agN2Kr+cusnefP1gXquJ5xvqAnejbSY8bW
         7oJ8HcIONSga3m/trKkwOXL0+wzH3pfE2ZKSn8ytm1h3RWieWYTFHxJjUMQPyRRz0X
         w2n/q2cJ6K2fb4+Rx7wXJu+BhzC7ouQajuk8YhJM8gRc9w7cwS3Gf+i9VKgPBVrwsh
         OKDgow/ciNsO7UZ0jdagBJUX2ZtmI+sxRhx7X8sHDXMubMQTOmrFLIfV1SkCuOrIrp
         uBCrOGX9pli0w==
Date:   Fri, 11 Aug 2023 07:58:59 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        fan.ni@samsung.com, dave.jiang@intel.com, a.manzanares@samsung.com,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH 1/3] cxl/memdev: Improve sanitize ABI descriptions
Message-ID: <xeuejntym6mzsfviba5wvbovrolohsz32dvuoonulsc7pymwr6@nb6vxlalanog>
References: <20230726051940.3570-1-dave@stgolabs.net>
 <20230726051940.3570-2-dave@stgolabs.net>
 <20230804150238.00005c89@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230804150238.00005c89@Huawei.com>
User-Agent: NeoMutt/20230517
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 04 Aug 2023, Jonathan Cameron wrote:

>On Tue, 25 Jul 2023 22:19:38 -0700
>Davidlohr Bueso <dave@stgolabs.net> wrote:
>
>> Be more detailed about the CPU cache management situation. The same
>> goes for both sanitize and secure erase.
>>
>> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
>> ---
>>  Documentation/ABI/testing/sysfs-bus-cxl | 13 +++++++++++--
>>  1 file changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
>> index 6350dd82b9a9..c4c4acb1f3b3 100644
>> --- a/Documentation/ABI/testing/sysfs-bus-cxl
>> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
>> @@ -82,7 +82,11 @@ Description:
>>		whether it resides in persistent capacity, volatile capacity,
>>		or the LSA, is made permanently unavailable by whatever means
>>		is appropriate for the media type. This functionality requires
>> -		the device to be not be actively decoding any HPA ranges.
>> +		the device to be disabled, that is, not actively decoding any
>> +		HPA ranges. This permits avoiding explicit global CPU cache
>> +		management, relying instead for it to be done when a region
>> +		transitions between software programmed and hardware committed
>> +		states.
>
>That worries me a bit.  Sounds like we are leaving a possible attack vector
>after a user will assume that all data is definitely gone and their secrets secure.
>
>I'm not sure what the attack would be, but I'd be happier if we didn't forgo
>the cache evictions.  This is not exactly a fast path at any time.
>However I though region tear down (and resulting HDM decoder disables) were followed
>by a flush anyway so there should be nothing there...

I had similar concerns, but ultimately could not come up with a potential
attack scenario by not doing the flushing explicitly, which is before+after the
operation, per the spec.

https://lore.kernel.org/linux-cxl/6422888b688fd_21a8294a3@dwillia2-xfh.jf.intel.com.notmuch/

The main motivation for avoiding these calls is not really that this is a fast
path, but it's that the global CPU flushing affects system-wide. That said, it's hard
to argue on defaulting on the safe side and just doing the flushes - exactly because
of reasons we don't know until too late. Dan?

Thanks,
Davidlohr
