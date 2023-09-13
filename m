Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8105CA0ED1
	for <linux-cxl@archiver.kernel.org>; Wed, 13 Sep 2023 03:34:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbjIMDeI (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 12 Sep 2023 23:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236470AbjIMDeH (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 12 Sep 2023 23:34:07 -0400
Received: from weasel.tulip.relay.mailchannels.net (weasel.tulip.relay.mailchannels.net [23.83.218.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8123125
        for <linux-cxl@vger.kernel.org>; Tue, 12 Sep 2023 20:34:00 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id F18B5821EE;
        Wed, 13 Sep 2023 03:33:56 +0000 (UTC)
Received: from pdx1-sub0-mail-a233.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 7C0AE8201D;
        Wed, 13 Sep 2023 03:33:56 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1694576036; a=rsa-sha256;
        cv=none;
        b=oyYbgtTBVrbV2vzNka5DKibPemGQ3wiMH4+5EUxAHhJORh1X1i5TRJ25/fXyFtHZIERWPI
        WfIYoZkNt/A4306MdDpFHjejpEQ/Z5eP1WaHfnRRJfbgcB9k7a3g0VgpgjbJofniEa/uX5
        OcBzxwmVpppHQYi77FyYIzDdvakYZHv0y452sV/LVtxKQQuIPI70TU/knup+4uvX0kJfF8
        JLWGnWlx7R+H4OYMVdFziy6L+ae7yw6O9cebI+mj9yCZPEYKErlal7mXCiNYiAjt4AAvhU
        9qDW3CAnhaXpMuWFQ89vIwcW6ZRNCB5VjxInG3/U/mJBZD0u+u9aTwEuH4uYTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1694576036;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=7Kz+qnyWGmf9KaCvpfNnnRX+OUiR51//Xt7ZDqsA6Gw=;
        b=Y2vdvV1vYNWV8kb4Z+vu2s7UfCCqOzQSSOjNncigJt+rPZrkuYjq3c7ojBXrtDZj8MAbJg
        /pbNFN5J/rbafbzfJa3l6vt5AclJYR/DVigM8Du61zHaPtAvLforKbZHfrPbURp16CrfYr
        4v3T1MNGXJ6GABBk+G/N5Nj4gBz6HiFmyjvrWu4RVLvJPh9CdIxlrkV1agyF4GN7YER2/X
        S9ybkqB+uqSqNbPOKm1bQqV6O7hCFlfONv5XWpTzovfRn+2fhPJI7tEiT1PhKLqLCaA/WV
        BG1M9kYZ8gi26mRrJ8YdnOo94io1rhDmnsOLWTUlw/88O2OerZN1ohvBME6lww==
ARC-Authentication-Results: i=1;
        rspamd-7d5dc8fd68-2xsnv;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Bitter-Shrill: 368fdcd4383edf40_1694576036769_3759951324
X-MC-Loop-Signature: 1694576036769:833824588
X-MC-Ingress-Time: 1694576036769
Received: from pdx1-sub0-mail-a233.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.119.184.206 (trex/6.9.1);
        Wed, 13 Sep 2023 03:33:56 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a233.dreamhost.com (Postfix) with ESMTPSA id 4RlmJg65wXzDd;
        Tue, 12 Sep 2023 20:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1694576036;
        bh=7Kz+qnyWGmf9KaCvpfNnnRX+OUiR51//Xt7ZDqsA6Gw=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=o0h978vGBVROwhqbicbVmMTpUKjp4p4CEtYQsSTESRaH2POuvImuUJuc31M5QhH3R
         b+9Y8bXEro/Et3mXPNKiY9dc/aZHZDtmjcStMRv6pk3267Uv/CGgnvz8Y/uk2hy/MO
         oR4WPLiQQCvzZvTl4lZvaoo1cL8aG8uwqjP59VehUj4G1s9YOCe21hBw0TmIqQsvP1
         aTFgQTm9u/KjbjyKWsdLVAnDNgqM5x6AjrA7Xv08vOlnSGKdFOMsAwCfvhXELl2ToS
         ywpq8QD3XC8KwbFF/oUQtjWohlPH1Awc4Uc4wRpolaL4A27ls30AdWJqPo3swVKHyy
         dzXNGf09SlrNw==
Date:   Tue, 12 Sep 2023 20:33:52 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     fan.ni@samsung.com, dan.j.williams@intel.com,
        alison.schofield@intel.com, ayush.m55@samsung.com,
        a.manzanares@samsung.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 4/4] hw/cxl: Add get scan media results cmd support
Message-ID: <kbznhylcg6qqltagnwrsidsvyetsdvmg4dftbsm2btjlwhqx2c@yy245lt2z6zd>
References: <20230908073152.4386-1-dave@stgolabs.net>
 <20230908073152.4386-5-dave@stgolabs.net>
 <20230912130425.0000569b@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230912130425.0000569b@Huawei.com>
User-Agent: NeoMutt/20230517
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 12 Sep 2023, Jonathan Cameron wrote:

>On Fri,  8 Sep 2023 00:31:52 -0700
>Davidlohr Bueso <dave@stgolabs.net> wrote:
>
>> Iterate over the list keeping the output payload size into account,
>> returning the results from a previous scan media operation. The
>> scan media operation does not fail prematurely due to device being
>> out of storage, so this implementation does not deal with the
>> retry/restart functionality.
>>
>> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
>A few comments inline but nothing to stop me carrying this on my
>staging tree. (gitlab.com/jic23/qemu cxl-*latestdate*
>
>So I'll apply it there.  Updates welcome or I'll act on comments when
>this gets to the top of our queue for upstreaming.

I'll send follow up patches for this series once your new latest
branch is published.

Thanks,
Davidlohr
