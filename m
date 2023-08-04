Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9511DC04A6A
	for <linux-cxl@archiver.kernel.org>; Sat,  5 Aug 2023 00:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjHEAgB (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 4 Aug 2023 20:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHEAf7 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 4 Aug 2023 20:35:59 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13684EDE
        for <linux-cxl@vger.kernel.org>; Fri,  4 Aug 2023 17:35:57 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id D7CCE80830;
        Sat,  5 Aug 2023 00:28:06 +0000 (UTC)
Received: from pdx1-sub0-mail-a202.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 642578122A;
        Sat,  5 Aug 2023 00:28:06 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1691195286; a=rsa-sha256;
        cv=none;
        b=BROaUglZFjj8bLV7T26EmdZP4XbFayQSrukvYOIkbeFT+4H3OTGbQeArKDhLe4pKdmEPyE
        QiHNh5pSRdi3onPbqJwfPXzW2NbtaAQ+0ARjyMslckcBsOGkm9s94d4oNEX9kKvTkUPgCY
        nur0150lpM/2d/I/XgyWMwuzVAEmAhcRUWXap2Tz9Houli4vibZNWm7UeFd/a2bLBEBuIq
        MC02W5Nb2b5DIKCaagS/O4Notefw1znRHn18T0nMvqWVx1EiHvv8dR6kDtGSlw6m+1+y9G
        1gBTMUEI2Tiq/FBTMQBOTZBm8bOFpZRt0ZopHquhLTRwQkenYpOeCVKv4P9zYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1691195286;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=0xoVEnSLxpaCzmXMzTeYot2YZ62NSLeKyxDufltPtOg=;
        b=kykfkU6UrOCZpmREAHnZlGPFYNclUCT6psaNVUXtYMoh9CK/HJg/YGgVS5qHN+epAIjiCK
        D8U3kHMg6rLOFF2dgChqXXyW0wYHizESUY2mA9HuX9oL6Lvd4IW4+QBvmdI5YYt6tk+Uz2
        ef9MGjEybiSREoPofJqmQaaECIFGR6IeZVJWI9fA9thQRjeqX2o0ubb3fKBI3NJwykh2IP
        JJrTH9e+1cD+pucWH50Td13dUwlliUrXGFguqLvLKRVokPlnurUXdZtBNdGdDzs8hVj0Zh
        DcRDzMHB0LhR0AjHKCezJVsCZZK1KM1u4KoyfDyoR2MjGlO0ULbIWoL4fn8Sng==
ARC-Authentication-Results: i=1;
        rspamd-849d547c58-t6msn;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Whimsical-Chief: 2ca4d1bd2978990b_1691195286685_1857406697
X-MC-Loop-Signature: 1691195286685:2777194971
X-MC-Ingress-Time: 1691195286685
Received: from pdx1-sub0-mail-a202.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.122.193.216 (trex/6.9.1);
        Sat, 05 Aug 2023 00:28:06 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a202.dreamhost.com (Postfix) with ESMTPSA id 4RHk2F1Pxqz19;
        Fri,  4 Aug 2023 17:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1691195286;
        bh=0xoVEnSLxpaCzmXMzTeYot2YZ62NSLeKyxDufltPtOg=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=kyFsdhPV8NlfUt3snQhcwiFQyOe88mzuYlqELToqm8wLy31LBWxO4L+abafwQcuzo
         5eHqmiPbwHHgS+E9pX2BhbudqD4HaPWCgTTdKqYHs+26o3XCF8siqlpM8Cl4PkNd4O
         QfORbK1QKkLXiSL3UNw2I7D7StHMAVFQxiSzSNdoFFMp6GVXJHsxCvzO3B42gs2vme
         5m94JlrtpypZQMik+xVh1un3UTtyAHF3TOVZuDPj1PvMCjZeg19shJvWwjDlSYqD6+
         2uLrMISohEwOFMon183TVqN94sxDyk0TFVc3V+4k1Njw3a6gHM0UkQfu9frPpDvkY2
         cI702VaJXne9A==
Date:   Fri, 4 Aug 2023 16:50:15 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        fan.ni@samsung.com, dave.jiang@intel.com, a.manzanares@samsung.com,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH 3/3] cxl/memdev: Only show sanitize sysfs files when
 supported
Message-ID: <emvsx2ugpmxexkk6sic2mv3xb55h4avr23grsltisxxb77osi2@gt34rlkmcnhj>
References: <20230726051940.3570-1-dave@stgolabs.net>
 <20230726051940.3570-4-dave@stgolabs.net>
 <20230804151612.000066cf@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230804151612.000066cf@Huawei.com>
User-Agent: NeoMutt/20230517
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 04 Aug 2023, Jonathan Cameron wrote:

>On Tue, 25 Jul 2023 22:19:40 -0700
>Davidlohr Bueso <dave@stgolabs.net> wrote:
>
>> If the device does not support Sanitize or Secure Erase commands,
>> hide the respective sysfs interfaces such that the operation can
>> never be attempted.
>>
>> In order to be generic, keep track of the enabled security commands
>> found in the CEL - the driver does not support Security Passthrough.
>>
>> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
>
>Ah just realized I was too late on this one as it's upstream. Ah well I'll
>comment anyway (I'd already reviewed most of it :)

Yes, this has already been picked up by Linus. Regardless, thanks for
having a look at the series.

>
>> ---
>>  Documentation/ABI/testing/sysfs-bus-cxl |  6 ++--
>>  drivers/cxl/core/mbox.c                 | 45 ++++++++++++++++++++++++-
>>  drivers/cxl/core/memdev.c               | 19 +++++++++++
>>  drivers/cxl/cxlmem.h                    | 15 +++++++++
>>  4 files changed, 82 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
>> index c4c4acb1f3b3..087f762ebfd5 100644
>> --- a/Documentation/ABI/testing/sysfs-bus-cxl
>> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
>> @@ -86,7 +86,8 @@ Description:
>>		HPA ranges. This permits avoiding explicit global CPU cache
>>		management, relying instead for it to be done when a region
>>		transitions between software programmed and hardware committed
>> -		states.
>> +		states. If this file is not present, then there is no hardware
>> +		support for the operation.
>
>Or older kernel....
>
>I don't think we need to talk about when they aren't present as it just complicates
>the ABI docs.  The similar case for the DOE is there to explain the weird corner
>of it's there, but broken.
>An example were it's not documented (I think) is the poison commands so I think
>we should keep that absence as meaning the obvious (you can't use the interface).

*nod* - I'll have that present for the future.

Thanks,
Davidlohr
