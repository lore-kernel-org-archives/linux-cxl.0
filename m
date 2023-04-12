Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B30F9C7619A
	for <linux-cxl@archiver.kernel.org>; Wed, 12 Apr 2023 02:53:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbjDLCxy (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 11 Apr 2023 22:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjDLCxx (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 11 Apr 2023 22:53:53 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0CF24EDC
        for <linux-cxl@vger.kernel.org>; Tue, 11 Apr 2023 19:53:45 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id A661A880EFF;
        Wed, 12 Apr 2023 02:53:44 +0000 (UTC)
Received: from pdx1-sub0-mail-a273.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 245B2881A06;
        Wed, 12 Apr 2023 02:53:44 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1681268024; a=rsa-sha256;
        cv=none;
        b=cTVm/7zrV7UCRBrgHlEtjUR/CDf15U7F7rstpOffBUSAnhqF6IUrYQIWaXQjRL83aB+PiR
        DRNDO+QmhwScaR26rDV+Tv68CLbv66+c+gELgc6VpFJjEpszI8cB3lbhwFexwRpcA+0BlA
        P7gg/jegQfFCZD6Fi/qIwlQ+j/ACpe/NdYx3YwvCw6t1VZy6LqnlMBGs9PjPRMNIWjofvM
        96AgjvWJ/iCD601Iymh2zj/Yy7Qqk5OVbHwuhdp7MdfhIFQKZyIHc3sgABVinPcmOJ6phy
        uyDRh2BgsvUOrKRw9aNbvaQ5CTiuohYSYbf28PP01vHu8T4FnwWwdDXrrS4qFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1681268024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=vZ3DYmY6bwWbbXABjXh6/iZsX6WibWB0WGTwGoAClhM=;
        b=HMH4KX9xyK10qajFbm0lu4zbimUlYy3XBZMM9qTnHwkCLpRnVy9AVTCcGr3VAZPvHo9aKq
        AdHYgu2RRgIYgrn+0HlHCPWlDrgCO2JlA1m4GAjZkdiDUo/J9V/ol04RclTJ6Hfz8lAEdX
        MXKLftLbFC0u3Ufkl+whrDInlS5OM7BhzCMxbkGp40H9bC9f7MkV8UF+ByS4aVzpWOOJcC
        UVpEoK994EZCnGW18Hl45Q9/yBHIolCSlDSrbE399s7fBvk8/lf5v/cSeLhvYD7VsO21la
        I2gc9p57sACWn1bIJutXRVLt5kNEe8f+hiMJMfCJIbom74+9/2lTmOq81m1sgg==
ARC-Authentication-Results: i=1;
        rspamd-786cb55f77-wrprc;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Belong-Industry: 5d2add557ec3439d_1681268024453_1667642593
X-MC-Loop-Signature: 1681268024453:368924121
X-MC-Ingress-Time: 1681268024453
Received: from pdx1-sub0-mail-a273.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.103.24.77 (trex/6.7.2);
        Wed, 12 Apr 2023 02:53:44 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a273.dreamhost.com (Postfix) with ESMTPSA id 4Px6jM3dqPz55;
        Tue, 11 Apr 2023 19:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1681268023;
        bh=vZ3DYmY6bwWbbXABjXh6/iZsX6WibWB0WGTwGoAClhM=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=WAF9KhAq9QUiD2wVOhKDNStiIVtq7doZGYul4Ondvzt+SnsNbneJKHUbv+Z8aG3ph
         o24DjucyEKLQ5MYpGFE9pJavwfvSgwVDEwR2Jlz+yk/d4uwpyXtxex5iZYpbybnV0a
         4MjRrh95QhI0eeT5yK3kdpum8DvktFzJYGtGz8QdPLkmDd7wSWHM+1QxVf6f4mFLNi
         eECQWb634hxGOMCQxV8uBNBSzF8YT2lhZZ909lY7udh/0GZo95E+n8A7qKTjOd9cFD
         TNDqs3KnA+i1BTtJMN8DxanCOFB4vvx2kgphgAQfpzxSyH4h6tmfpbnoTyHdD3JgOM
         Fu3Zj0vFu7HVA==
Date:   Tue, 11 Apr 2023 19:22:44 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com, fan.ni@samsung.com,
        a.manzanares@samsung.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 2/3] cxl/mbox: Wire up interrupts for background
 completion
Message-ID: <b3d67b5ygaxstcge2lzajrueqrddj6hjlx42s2qdxuksfdzify@wtgmzbpavzdv>
References: <20230224194443.1990440-1-dave@stgolabs.net>
 <20230224194443.1990440-3-dave@stgolabs.net>
 <20230403175224.00004c3f@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230403175224.00004c3f@Huawei.com>
User-Agent: NeoMutt/20230322
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 03 Apr 2023, Jonathan Cameron wrote:

>Also, the interrupt setup for the PCI cap is missing I think.
>See handling in ct3_realize()

Hmm how is this any different that what is already there
for events and cpmu? Once msi is initialized for the device,
I didn't expect any other setup necessary - and I'm also
receiving irqs fine with this patch at the driver side.

Thanks,
Davidlohr
