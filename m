Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E852C77B75
	for <linux-cxl@archiver.kernel.org>; Mon, 22 May 2023 21:02:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234636AbjEVVCC (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 22 May 2023 17:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235145AbjEVVB4 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 22 May 2023 17:01:56 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33631BF
        for <linux-cxl@vger.kernel.org>; Mon, 22 May 2023 14:01:54 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 53BDA202743;
        Mon, 22 May 2023 21:01:53 +0000 (UTC)
Received: from pdx1-sub0-mail-a292.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id D3292202A92;
        Mon, 22 May 2023 21:01:52 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1684789312; a=rsa-sha256;
        cv=none;
        b=9FcuXIWr01EylFD9FnJyteHl2bJpDUSPz4ChC/xEnwbFDGzZIdMGw8wN6ujVniXwN+9xDy
        Ig2E08h/O9YI11sda8Q8zu/Eb6/P/w8zqJV04KmCfdxKay7IrU0Hj1Sac24eE4MOjnmcFo
        HhHt0IbFdZ0E9PuN9dcHEJ906e3DXb3NCVqg4fdquSEat5/CrOHB8ctBWds14EJh8a2uHD
        Ahr8e+OFkBM3jMDtToQwNvxFgWMj8MM4PuYWDwKxXWWY8XkGy0phB9ek3zein2fv99zyOY
        Zm+AEhdb72vv2bZLh8FhJvPJ9fJPVfUrE7vWwOf8di3S4zUUvLZWW5CiT5loKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1684789312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=OrIuP2fprz8nBx5mdZL/hAFL1K/TReUGQc3BhHqkIVE=;
        b=ba0nJ/uq+pVBf2nRwo4AOlgFONHSrGPLfYcqbb5RIhErb2U2TxnnjUN0qKZQ148KnE7OOb
        NOBxMi+v8ZtydQwTP2/8RocD0sQzkY5zLisIk/t0skudQit1xmcpaJzYLX4j4PLDhzhsMJ
        BOoXtyKhCcvTD7cnnfizl7JUYI/nhR0plLsyOz0wFWSJIJUETd3x0zdrMsWze1NG/joRkQ
        llj4+Kc/83jo0yMfq3HBIjzrcLYLMhG0e8W6UzJytR+IG0oT7cMWSm4GXk3ARd+4ggRJDD
        k5yfez+T5rFKuCTUXOQa4aZWRkwvsXCrWcDvkqdH3SoZy1KoUMx9x52QtwHAbg==
ARC-Authentication-Results: i=1;
        rspamd-79bb5575d7-6t2d6;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Wiry-Supply: 2f00481e20812dd0_1684789313157_4193633897
X-MC-Loop-Signature: 1684789313157:1827329023
X-MC-Ingress-Time: 1684789313156
Received: from pdx1-sub0-mail-a292.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.107.49.218 (trex/6.8.1);
        Mon, 22 May 2023 21:01:53 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a292.dreamhost.com (Postfix) with ESMTPSA id 4QQ8yS1WHtz1n;
        Mon, 22 May 2023 14:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1684789312;
        bh=OrIuP2fprz8nBx5mdZL/hAFL1K/TReUGQc3BhHqkIVE=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=Sydb2/ykb3B2vuxsAeWnxD+NY0+uJxyNBmQjUCESRviUMUCoqHUk8LTsDkSwYYUNx
         NuZKuKmWUXVJpY1x2tes0v0VPQSAyr6Egm1XgfHY+j1oBe859Y9gS9PYUuTLpQPbTe
         SlTAxK9vpNrVtyq6NujKh+61AI8sNKkqEIgwyBby9V6xcWcNWHVL0vakHtSzXe2Pod
         bBsfq+lttuaIsh70i4g1mhoJMgLsBJYW3UVowTk7N+x9HPcf1MObdaUwTEojl/6KBt
         AVuGyvFe+G4Ya01wBPHRvxGjEO+M07twYPVOF8pmmkRmNzpFhDRttJnPYBgm31jUcZ
         JewWRDM9AiL+w==
Date:   Mon, 22 May 2023 13:28:25 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     dave.jiang@intel.com, alison.schofield@intel.com,
        vishal.l.verma@intel.com, Jonathan.Cameron@huawei.com,
        fan.ni@samsung.com, a.manzanares@samsung.com,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2] cxl/mbox: Add background cmd handling machinery
Message-ID: <dbz7qo7rsbyc7r4vtcwc5lkpzpy2uz3q3cfd7qekhghp3amn3x@264xhf4swkda>
References: <20230502171841.21317-1-dave@stgolabs.net>
 <20230502171841.21317-4-dave@stgolabs.net>
 <gtvozgdx2ak7tekc3heczk5g7gj3cwuoptez6tjmkecader4lo@7t2em7rclcxn>
 <6468027e5d15b_682c12945b@dwillia2-xfh.jf.intel.com.notmuch>
 <64jusopypczmfmkeg5ulzw6gwbfv4mdnk2jilmja7iyr5dsukc@vkpwdjsjsbk5>
 <646bb221db164_33fb3294b3@dwillia2-xfh.jf.intel.com.notmuch>
 <ps5l5kclllyhjfaelf6p7cl4vsq6v3lp5uxoqt6u5m4ha7adw5@6q4gjq7hlxpp>
 <646bcda53c22c_33fb3294fa@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <646bcda53c22c_33fb3294fa@dwillia2-xfh.jf.intel.com.notmuch>
User-Agent: NeoMutt/20230407
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 22 May 2023, Dan Williams wrote:

>Davidlohr Bueso wrote:
>> It at least removes one point of potential disambiguity. This out of sync
>> issue with timeouts was one of the reasons I originally proposed dealing
>> with all bg commands asynchronously (which doesn't prevent users from still
>> time-slicing). This approach is supposed to make the code simpler, but leaves
>> this mess. Currently we state:
>>
>>	 * In the event of timeout, the mailbox state is
>>	 * indeterminate until the next successful command submission and the
>>	 * driver can get back in sync with the hardware state.
>
>Right, but my struggle is how to explain to userspace what to do next.
>Does userspace keep submitting until it gets a successful acceptance?

Yes. It would be the users' responsibility to deal with timeouts.

>How does userspace know that its failure is induced by background
>command collision?

Knowing about the apriori timeout, would the user care?

>
>That's why I think it is ok to block and wait on the previous background
>command completion when the next command is submitted. That seems to satisfy
>least surprise. The submitter asked for the last command to end in
>failure and is asking for the next one to queue up and complete.
>
>I think this means that cxl_mbox_background_complete() needs to be called
>before every submission and needs to check for "background operation"
>(mailbox status bit0) being cleared to manage potential collisions.

All this really defeats the "simpler" angle. Without accepting that it's
the user who needs to resubmit until in sync, it seems doing synchronously
is sw shooting itself in the foot.

Thanks,
Davidlohr
