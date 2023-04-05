Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E40EC7619A
	for <linux-cxl@archiver.kernel.org>; Wed,  5 Apr 2023 21:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbjDEVhO (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 5 Apr 2023 17:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233855AbjDEVhM (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 5 Apr 2023 17:37:12 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E797DB2
        for <linux-cxl@vger.kernel.org>; Wed,  5 Apr 2023 14:37:04 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id BD7287E268C;
        Wed,  5 Apr 2023 21:37:03 +0000 (UTC)
Received: from pdx1-sub0-mail-a273.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 3A2157E1B82;
        Wed,  5 Apr 2023 21:37:03 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1680730623; a=rsa-sha256;
        cv=none;
        b=IAadA6tgCoxGzFFy6pieRGXq8JHYfy/XEJfX3l/E9oXcHAPhW4MMB5W//YOmvEjtOH/jgJ
        J3utn3gZIHAR6P1h5Q5YKazX6mSC15Q+yFgmfh7TMgqV/y7ytm3GwjE/DZE+VCHvZEIOin
        PHuDXMNn8xUKOPlusMDAHnhXu/KWQ/Npvhrp0XTke4Iur+4E1wXAyzgLe/x98Fm15FQspG
        Ap+903DgtPYuhz0nIPKHAdFNq3rnzIwFPk6zGd6bpV6BIOjdJkkpeXDTCIAyIJsjeu0Fal
        dkj+zt/8IbOZ3MEV0R4vjP4+1sUEGhGuBQFLu6rGHX2NQD0HyiKKNCckANa27g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1680730623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=P7sh+RccgrkNomfnFYw0v6KiC5PulRu9qFqZmnY9iHE=;
        b=ILarua90fGK2XpnjNhGZttDAp2IKM6O5p3r0tqB0FsyfljKBuuxdHbB6YgLwdavxhyGfLy
        2fYwDOFBc1XisbErK96KOXnDxq7CXLkE0/ozPWJh1GlKYjlJVv5VF4F5UiMK3zUp/QzA3A
        +1sQQOUn/0vRPHAZtOl3MyLanomukXrIb8HbDlXztSRm3vWzoUuE9vWr0srvg6yJARLTiY
        NR5hWcH4KjdHfLQaToc8RRW013G7/B70PLEmjzsYQhX7vOp2ixwhYw3suYJlNZZNYAdYdu
        0V2dsFL1j8ThZuFvEGOUI1JHx6eVaXPy4JTnTvLZD86XL7crGEKkoE/4UfpwVg==
ARC-Authentication-Results: i=1;
        rspamd-5468d68f6d-pw7rc;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Tangy-Blushing: 64a8c5152721fe9b_1680730623582_901866885
X-MC-Loop-Signature: 1680730623582:3889146731
X-MC-Ingress-Time: 1680730623582
Received: from pdx1-sub0-mail-a273.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.107.49.249 (trex/6.7.2);
        Wed, 05 Apr 2023 21:37:03 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a273.dreamhost.com (Postfix) with ESMTPSA id 4PsHyk4MM6z3J;
        Wed,  5 Apr 2023 14:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1680730623;
        bh=P7sh+RccgrkNomfnFYw0v6KiC5PulRu9qFqZmnY9iHE=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=ncJgxxU1ljcMxqS3IpAI3Ua8LMRlZaCHanR8jCw1fufIKvMnGDK8+MzXoJXUD14Ej
         BYPihixMcVWfrynnateqkWHVgNQMYzg/41GN+rL/ddV23tCzyrYo7elD4P7I1h21KR
         gk6Uqp/MSpF2jUmhGmr4/Idjx4XrV/f5pJqNPxU0JSDwtcYw3/gM2FGtxdCFsGnI9B
         KnFS5cOWGfx6NkQ3BGC+absJfAGSLBwJ9AwgspyrDOwU5JJzYuOjLYgROdt7oSZe6F
         D2fP1OZE1XyRaafDeGXoJGT+RGNykKcZlEMEY1tEOiITi4XuYBvWu5sqZrLOEsmlzS
         5MuMji05iLPpw==
Date:   Wed, 5 Apr 2023 14:06:22 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     jonathan.cameron@huawei.com, ira.weiny@intel.com,
        fan.ni@samsung.com, a.manzanares@samsung.com,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH 4/7] cxl/mem: Support Sanitation
Message-ID: <20230405210622.cxujzoaceuxpfopm@offworld>
References: <20230224194652.1990604-1-dave@stgolabs.net>
 <20230224194652.1990604-5-dave@stgolabs.net>
 <6422888b688fd_21a8294a3@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <6422888b688fd_21a8294a3@dwillia2-xfh.jf.intel.com.notmuch>
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 27 Mar 2023, Dan Williams wrote:

>Per the feedback on 1 this changes to be a facility that returns
>immediately and signals completion via sysfs_notify_dirent() because if
>it takes seconds and is hardware uninterruptible then that warrants
>userspace being able to poll for completion if it wants.

Perhaps I'm missing something here, but how can we signal completion
for sanitation if we return immediately (after timing out) and loose
context of the background command? Or are you referring to use the
Background Operation Status command (0002h), which afaict would be
the only way to do this, as nvdimm's overwrite_query. But as we've
discussed in the past, this also means that another bg command could
occur in between when the command finished and the query is done.

Thanks,
Davidlohr
