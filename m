Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9575C0015E
	for <linux-cxl@archiver.kernel.org>; Wed, 12 Jul 2023 18:38:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbjGLSij (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 12 Jul 2023 14:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232071AbjGLSii (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 12 Jul 2023 14:38:38 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93FE71BF8
        for <linux-cxl@vger.kernel.org>; Wed, 12 Jul 2023 11:38:36 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 8CD20680222;
        Wed, 12 Jul 2023 18:38:35 +0000 (UTC)
Received: from pdx1-sub0-mail-a292.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id B4A9668030A;
        Wed, 12 Jul 2023 18:38:34 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1689187114; a=rsa-sha256;
        cv=none;
        b=rQGi3ecGKNLPMcM52F4EkaZTRuGKzcAdSo9C2UFYLpiYdDrGKhxzkx1fGHfi9WZXFFrgf7
        OPZOaE8OZGmdW0iEWrdhWGjjHt6qhLfqBCYc8yLZNszmHYNKoUyjwZupxZ154IQdvV3hyx
        YZEr4Py6zhNsk96ekP3nWm1+nURgODGnaXSgSV7chVVO9hFFZf7LIxZafgsVno5LTY/F9B
        e1mEU6akeLpR8y557Rz4mbnprSk803o7shUCV7oymUeRvTsORW752/1LvtJil668mo9VSO
        2ajNJfRKaipn0lg6OexLLOz01KcWNk5ypkvFvjCc9mNQvgzv+rwY/rISr14G1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1689187114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=cMUqZ0YBcH7k9bYBAgDcQOVUZtTxoOloEvG13AcEJJw=;
        b=AVW1E5BiVLs4jM2Ffhvu+dM/DnaiKVM3cVbtfTpd8Rk14rySe2IqoRv82E2q1GDJt1501B
        1d3VXHa75FriHbr8D9EHAP43Lxt84iMerN96IN81lzUBo+TpOoENG26tJGuHy4lXweDLLX
        J2dfwgzYPMBzcpM2uStcxJe8XHSMgF+KJhIqp/w5LuilDFV9LM+RTU1H+/YD4iksOFW8UB
        svVFm3gMvwut9Glm0V/q6Gdbz1D+ftrsCtrebZB1ym6JYKGbOKqlCI7H7exK5Mzyf5gMKf
        FY06s2HUx4vO5E71zVgeiu6BbIP1JkIhZ51bsW0ikitZCr6gb24YUIlPchOUnA==
ARC-Authentication-Results: i=1;
        rspamd-5595f87fc9-6pl7b;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Desert-Dime: 37c2cacd2466eb29_1689187115080_4062885920
X-MC-Loop-Signature: 1689187115080:1498384527
X-MC-Ingress-Time: 1689187115080
Received: from pdx1-sub0-mail-a292.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.110.146.72 (trex/6.9.1);
        Wed, 12 Jul 2023 18:38:35 +0000
Received: from offworld (unknown [104.36.30.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a292.dreamhost.com (Postfix) with ESMTPSA id 4R1RMY6kGtzMG;
        Wed, 12 Jul 2023 11:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1689187114;
        bh=cMUqZ0YBcH7k9bYBAgDcQOVUZtTxoOloEvG13AcEJJw=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=mTY2R8Ia0rXLiereaUFAh4UJpVsVJg8kn3eBA7XRt3IwTd+gxsGPlQZdZCpDb6lXF
         fbbBatpLLFxUDmdf9d+yItlGQvUJNIcWPN8BCxjdgLFKpGgWdMqyc2dkkpDEpE7mfj
         XsZtd/hlUJuIPJPla8GW7tFtjhTwSr1rQ6WsjRQ8kiQYqACdsBRT7HZB5eut8+TkQ8
         hMAK1cUhfNCWW23rO+bcM3/jyXl9bWzo1r5IfgAIRAz8bWLcfwWmqtBWjukjSdweB8
         J1GgmNLkt6iPzP0dX7bG6fhUCGXJf3RGX4EFQz8CPO8aHH2CeJXH7z8uiXWM32T30h
         czJlz4rxSiqpA==
Date:   Wed, 12 Jul 2023 11:02:09 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     "Verma, Vishal L" <vishal.l.verma@intel.com>
Cc:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
        "fan.ni@samsung.com" <fan.ni@samsung.com>,
        "a.manzanares@samsung.com" <a.manzanares@samsung.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] cxl: Fix double shift of CXL_FW_CANCEL
Message-ID: <hvhzxc2cvessqnsxsnkvr3rspvwplttryz5zj4n3m7dg2pse7i@x2hhysn3buw4>
References: <20230712164224.31891-1-dave@stgolabs.net>
 <e3e0c38c3efaa59be3b39a90727454b15d785ed4.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <e3e0c38c3efaa59be3b39a90727454b15d785ed4.camel@intel.com>
User-Agent: NeoMutt/20230517
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 12 Jul 2023, Verma, Vishal L wrote:

>On Wed, 2023-07-12 at 09:42 -0700, Davidlohr Bueso wrote:
>> Directly use the bit number for bitops, which already has a shift
>> built in. This bug is benign as its done consistently and it doesn't
>> clash with any other flags.
>
>Ah good catch!

Actually this is a duplicate. I just noticed, scrolling the list, that Dan
Carpenter has already sent a fix for this. His patch should be picked up.
Sorry for the noise.

Thanks,
Davidlohr
