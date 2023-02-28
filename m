Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C793C64EC7
	for <linux-cxl@archiver.kernel.org>; Tue, 28 Feb 2023 20:55:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjB1UzI (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 28 Feb 2023 15:55:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjB1UzH (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 28 Feb 2023 15:55:07 -0500
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394D317178
        for <linux-cxl@vger.kernel.org>; Tue, 28 Feb 2023 12:55:06 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 4D90A3E16D6;
        Tue, 28 Feb 2023 20:55:05 +0000 (UTC)
Received: from pdx1-sub0-mail-a231.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 9A49B3E16A8;
        Tue, 28 Feb 2023 20:55:04 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1677617704; a=rsa-sha256;
        cv=none;
        b=Zui8YE4IsGtnsrTQO9NGu34h1/KYVC7Ntb0/2N9PkKsopflo9odtKhZLtdpE47PNj+rrZc
        fX72GGhSwIAgRpGACY43OmjUPqv+3CT64KeWKIwi1jop/kmhv63xiBHUIh6XM+kWmMBPm8
        8ZYGifYgr4Ghkv6RoIOZttMndhkkBDir127Z2pmqTNHmPsn0YA7Xh+GpaupZ6h/pRTizcH
        c6vjMNcsZfCxJf0PbqHL1vKbtyS2y/8gkuRS2yD86cUZHnZNf2NPNn2uXcQeyNKsSDGYES
        U3eoydwIDLGtY9WnzZAK+leDrTep+sCtIZc8fXBoWdWjFwQssuIkIEy5D5XWPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1677617704;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=PNZ9JyRQKMZ1eJRVKkYvLsbJph+KbR72ZozjFQiezbM=;
        b=6hw2MX1QuwEgqvcJZwPGHDAyU1vIA1OdjNhl5U32inDaR9nEcEyujbJFjoIS3I9xbecU//
        GAe5aDCQ1w0JsJnZg9ul6EKv2mXcuHeKgFFy4CRHlZ4feqnzhWHciW5NsyTgDNqQvKS2yR
        ZznxGUjUJTsvhe6wUBWbzODLkJZDX3+dX6jOffjvcaQ05mO3HapjtVBzx8CYgKtAxV5daR
        UOGoqMxLNfMGZo4dSj4H0MKkR5FAdbuJN6WT9uamwj8mbGGtN4Mmvj/ti8hmrHHGaYkgj4
        h73j9p/TBqHf8PpnCsvlXtxt0wwfaBFrDKNDjjxhJHT/WOs8fCAzSdaOSL6kXQ==
ARC-Authentication-Results: i=1;
        rspamd-69778c65cd-j6wxb;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Quick-Trouble: 63b83f4179ad3617_1677617705008_1089767040
X-MC-Loop-Signature: 1677617705008:2893149312
X-MC-Ingress-Time: 1677617705008
Received: from pdx1-sub0-mail-a231.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.123.200.78 (trex/6.7.2);
        Tue, 28 Feb 2023 20:55:05 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a231.dreamhost.com (Postfix) with ESMTPSA id 4PR8kv5zDcz59;
        Tue, 28 Feb 2023 12:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1677617704;
        bh=PNZ9JyRQKMZ1eJRVKkYvLsbJph+KbR72ZozjFQiezbM=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=WM2svnLrB18naAtRObAvwC6c0B0Eg4QC2mGzkHZGytHjO+Pz945HAUsh4DMUYlBGZ
         WiE9DqgPJSn74JZHy4gs3c+yeV+8Vd/Wwt4TCU/7IaemHNIeVH9v3FcRwEBnn2nxhH
         wAIZMYjOPGaw/SPzd3T9G51xD9HDk4wQ3r44fmUBELHlveTTlwlaWpKZfkiUwAGgz2
         6M5My16M0Bn4b/AMbFByv/ESztlfwYKxdYUGhHk1nQ4TuGkbSAbgoQxZbUluHcxbAe
         kd+e9sRctH/O/mSGchjAcgx337apdsB7+OGOE1v3eD03+J4Eiyoyr9ymTIPRZko0u2
         KxbDQD8q35NYg==
Date:   Tue, 28 Feb 2023 12:26:23 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Alison Schofield <alison.schofield@intel.com>
Cc:     dan.j.williams@intel.com, jonathan.cameron@huawei.com,
        ira.weiny@intel.com, fan.ni@samsung.com, a.manzanares@samsung.com,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH 3/7] cxl/region: Add cxl_memdev_active_region()
Message-ID: <20230228202623.ceytv4ecryxcloxc@offworld>
References: <20230224194652.1990604-1-dave@stgolabs.net>
 <20230224194652.1990604-4-dave@stgolabs.net>
 <Y/wno8C4bK3XNoUD@aschofie-mobl2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Y/wno8C4bK3XNoUD@aschofie-mobl2>
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hi Alison,

On Sun, 26 Feb 2023, Alison Schofield wrote:

>I took a look here as I've been poked around in this space when looking
>for 'region' names to associate with memdev poison trace events. [1]

Thanks for the pointer.

>How does the list created get used?

It's used by the security commands, in the next patches in the series.
This came about because Dan requested some way of knowing wether the
memdev is being used (actively decoding HPA ranges).

>If we only need to know that this memdev is mapped in any region,
>so don't touch it, we can look at it's port->commit_end. If that
>commit_end >= 0, we can look at each endpoint to find the regions
>it's mapped to.

I think this is a lot better than using the list approach.

Thanks,
Davidlohr
