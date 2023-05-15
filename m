Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2123EC77B75
	for <linux-cxl@archiver.kernel.org>; Mon, 15 May 2023 16:13:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242254AbjEOQNf (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 15 May 2023 12:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242347AbjEOQNe (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 15 May 2023 12:13:34 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFDC95
        for <linux-cxl@vger.kernel.org>; Mon, 15 May 2023 09:13:32 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 6B3972623D4;
        Mon, 15 May 2023 16:13:29 +0000 (UTC)
Received: from pdx1-sub0-mail-a254.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id D32ED26196E;
        Mon, 15 May 2023 16:13:28 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1684167208; a=rsa-sha256;
        cv=none;
        b=8GbgjU1mGq0DpY8A0GLbseLWQlEomHU+VJa1KNOVXlQjqkOwNR/9bRXwSLCAnk/4DtQYAy
        85/d81LriDEROlxo5GEqHMFwToyWw2EHaodzGKqZmrGiZPfQLneb6hx32jfEpUhfKRMQfP
        HD10DAlltfNCUzUF8/3bg3e+OYZ6BWrltbwcugD+xbfPgqgT3Eg+iuHHt95Kk5MEmnPETR
        f3cT6U+mFVq4Iy+u4VD6GS2YjuPwGi2c8DozWjt1IBZ56aBklkMeAnPLbwrVy+TD7DAA6O
        UooCt0i7CVDxNlXCrzJuQtOnYg6O5nHMh2e+EdqAtEwqJwivc/PESfmWi2ba/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1684167208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=Yoexj5hEofz8YADHb5ik4Af64DspwAyvFzd1P/J3Ksg=;
        b=tSB28Kfh7MokaumbpJ7cf0mQiBY0IHrbIQdR9QEnhlvGBoEBLt3hSZiNUuY1SgS3cj8/C+
        eAb52mQIsNd6hfYQ14ZmtwE8SgjhBlgzuIWMFUevpG+RseyajDWNxZTPwZtDUMFUi2EG1Q
        x58VOt4ShczD1jzPY5Tm4Fu/BAmqYMlzGZ7aPUSmScwdKr/9u9ByxAnxgVikbW2NCh9qgB
        ox9RTuAzh1n61ex/j1ifqEeVikzq6spKIxgCPsArxRTNoPK7n3XLe5Uocvw0PbwgIg3JZj
        ZoogxPeeLf/LlrqxxLJbx3H1wBUhtxWck7ndRXIslTnGKDvbry36YNjVRxZWww==
ARC-Authentication-Results: i=1;
        rspamd-5cdf8fd7d9-7wjvd;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Shelf-Illustrious: 55fa8e645ae55727_1684167209193_2375432974
X-MC-Loop-Signature: 1684167209192:1960513348
X-MC-Ingress-Time: 1684167209192
Received: from pdx1-sub0-mail-a254.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.103.24.74 (trex/6.8.1);
        Mon, 15 May 2023 16:13:29 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a254.dreamhost.com (Postfix) with ESMTPSA id 4QKktw01RRz33;
        Mon, 15 May 2023 09:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1684167208;
        bh=Yoexj5hEofz8YADHb5ik4Af64DspwAyvFzd1P/J3Ksg=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=hDBoknxDUV2/5z/gNqAkci7L834oNw+r6vJxoD4GW8rzCm6Vl7ab0tZXuqtqfOFPu
         uBTPzSMKx5v6nwWsnyICjjq4SPgseUT0s/3y+QESDYc+5kLUtH+9Eg+DhuYQIRrq5y
         VRUPLWmZmh47yNblc9Hai7AhG6ZhQrXXcUjuETasQsIHZhELQ+mNz2eORROTq83kJv
         lewr3yStGcpYTC6OiHnNBvwwD44jZ+gYbtgwm0aYCY59WQSLA6Gw17b1pkctGNq/H3
         A48DyPH+QW7fb4rQ78oAnKKxJu1huI47yvejYIECqC7DoPC+wL7/edvm83LqsQETy7
         wX6ZlPN+cq0Iw==
Date:   Mon, 15 May 2023 08:40:30 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     dan.j.williams@intel.com, dave.jiang@intel.com,
        alison.schofield@intel.com, vishal.l.verma@intel.com,
        fan.ni@samsung.com, a.manzanares@samsung.com,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2] cxl/mbox: Add background cmd handling machinery
Message-ID: <lhpw35lii4cfrmvebphvhaivjgp2l3ajhnelmtilj5vbvqaxmn@o2ajzugaxbcc>
References: <20230502171841.21317-1-dave@stgolabs.net>
 <20230502171841.21317-4-dave@stgolabs.net>
 <gtvozgdx2ak7tekc3heczk5g7gj3cwuoptez6tjmkecader4lo@7t2em7rclcxn>
 <20230515113027.00001825@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230515113027.00001825@Huawei.com>
User-Agent: NeoMutt/20230407
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 15 May 2023, Jonathan Cameron wrote:

>On Wed, 3 May 2023 07:57:56 -0700
>Davidlohr Bueso <dave@stgolabs.net> wrote:
>
>> This adds support for handling background operations, as defined in
>> the CXL 3.0 spec. Commands that can take too long (over ~2 seconds)
>> can run in the background asynchronously (to the hardware).
>>
>> The driver will deal with such commands synchronously, blocking all
>> other incoming commands for a specified period of time, allowing
>> time-slicing the command such that the caller can send incremental
>> requests to avoid monopolizing the driver/device. This approach
>> makes the code simpler, where any out of sync (timeout) between the
>> driver and hardware is just disregarded as an invalid state until
>> the next successful submission.
>>
>> On devices where mbox interrupts are supported, this will still use
>> a poller that will wakeup in the specified wait intervals. The irq
>> handler will simply awake the blocked cmd, which is also safe vs a
>> task that is either waking (timing out) or already awoken. Similarly
>> any irq setup error during the probing falls back to polling, thus
>> avoids unnecessarily erroring out.
>
>This raises the question of why we don't support Doorbell Interrupts.
>2 seconds is rather a long time to poll for.  I can't really remember the
>reasoning but maybe it's that we don't expect anyone to every produce
>hardware that takes that long.
>
>Ah well, job for another day perhaps.
>
>I'm not following why the rcuwait is needed versus other options.
>Perhaps some minimal text here for those of us not familiar with that
>particular mechanism vs a completion of similar.

As mentioned before, rcuwait gives us the single wait/wake semantics we
need (we are serialized by the mbox_mutex) - completions use queued wait,
which is an overkill for this case.

>> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
>Otherwise just a comment inline on dev_warn for unexpected interrupt
>on an interrupt that you've marked as IRQF_SHARED which pretty much
>guarantees you need to handle unexpected interrupts as 'normal'.

Per your feedback in the the previous series, I will remove this dev_warn
altogether.

Thanks,
Davidlohr
