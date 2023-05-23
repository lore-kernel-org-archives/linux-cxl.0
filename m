Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC026C77B75
	for <linux-cxl@archiver.kernel.org>; Tue, 23 May 2023 22:32:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbjEWWcv (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 23 May 2023 18:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjEWWcn (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 23 May 2023 18:32:43 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C255A83;
        Tue, 23 May 2023 15:32:37 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id E95AE2625B4;
        Tue, 23 May 2023 22:32:36 +0000 (UTC)
Received: from pdx1-sub0-mail-a231.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 57F6826299D;
        Tue, 23 May 2023 22:32:36 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1684881156; a=rsa-sha256;
        cv=none;
        b=mvLLQuieURznLNtWzGkSDH9GdPHzda9U0jkhDnk500jtS2kc1t9yi2QSMdexBq9yiE+Nml
        4hg9VZ5XuL3kkzuLkn3aZ9l87DVcqixtx7gVG8QaQhlzjU7tvp7A31zAwnCSnjx5SbhlRG
        PJ7hBDnvVI4ua8vxF5MQOWRB4/Lw2WjBn2nEavAuAAVltN00dD0hYZ0Kc08EIbWp4bMmK6
        ovlbCJ5T6ZPQ6UEym2FdX+HciuIgr7a0nTZxYCwcRzBFoUWEtVSrJLV+aSrDGjLqPinFFl
        L9xzbeYsEkPtEG86JLAGuZvrZRgnPrbnhB9GiXQFATC7aXTqaVaFlFeLc1vy/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1684881156;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=HPpUvUlKVgkRykdkxhgx4qqYUkE2Qav7c/IvvoWZhI4=;
        b=oH1HF70sFCxv0mKY8pLhL2iQV3P97PP+qq6jQvnaX+/oS1IDOM8auq4snp7TFzIwUrd49M
        FgRnu+t8GX7kziufj+NLX+tbJYtG6ejf9qpb8AbNpb9ZS7/E+raiIIYKYByMgsXuFcddx2
        Rghf0IOdIiAeRNbAvKTF1MEzN3OzTD9fdVIzdYwzjTd6300D/NFq52iXN2xffmx9pjB/Yh
        CezkZxG7z8xPtRHZe4LOmItj36AObZC9xcb1akscidNGr+Zn+1RzySChpYbGcc8SaeYFPF
        bsWeJMrfNTadtMzDEd6/Ev2LyjFm0kgl8F4xSAWIUNLSNjY4YItFRrgXKDokFQ==
ARC-Authentication-Results: i=1;
        rspamd-5cdf8fd7d9-qfmcz;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Print-Relation: 63fb7ecb3aa40227_1684881156699_1266590105
X-MC-Loop-Signature: 1684881156699:2324547449
X-MC-Ingress-Time: 1684881156699
Received: from pdx1-sub0-mail-a231.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.126.30.61 (trex/6.8.1);
        Tue, 23 May 2023 22:32:36 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a231.dreamhost.com (Postfix) with ESMTPSA id 4QQpwg3hpxz6X;
        Tue, 23 May 2023 15:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1684881156;
        bh=HPpUvUlKVgkRykdkxhgx4qqYUkE2Qav7c/IvvoWZhI4=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=oVWh+FtL0zPUdLFwEYMFPi5msxNhCtDaGfWdpLxtRNAy12/QH2P9QtvtVmF1+Cing
         4d/SNBtHfxXohP5vXdzrX1gLuVWo+OAbBFmkGMS0+tFSUJKTrj33N6cgF+5PPNhvtr
         639EQl0ZpdLNLi1Dz3I/uNIJ5ScZZz5PZ2+esyUXkoqxWAQ2J4eP8Oeiu90Kz+w3mF
         XRrhzc+Kpgk4L/a6Qsm38B9UapD6fNSV4huPt6xGJqIPaeRQkAxTVREUGIlemXZObd
         Ptt6qDBKfajaa6oSpetGF5cIQ1SegyUDEN9Ox42LaBXi7JINyuuBLZyu/Epn0bMl44
         RADrfX3Rky4Uw==
Date:   Tue, 23 May 2023 14:59:04 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     dave.jiang@intel.com, alison.schofield@intel.com,
        vishal.l.verma@intel.com, ira.weiny@intel.com,
        Jonathan.Cameron@huawei.com, fan.ni@samsung.com,
        a.manzanares@samsung.com, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] cxl: Handle background commands
Message-ID: <ho6fq5f6dd3bj25kidhsnwlqj2xgd5rmjkh7t33lmaqclh3a5f@5udgwp4nvsfe>
References: <20230523170927.20685-1-dave@stgolabs.net>
 <646d2a394342c_33fb3294bf@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <646d2a394342c_33fb3294bf@dwillia2-xfh.jf.intel.com.notmuch>
User-Agent: NeoMutt/20230407
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 23 May 2023, Dan Williams wrote:

>Like Linus I want to see the conflicts. Whenever possible base on latest
>Linus tag like v6.4-rc3.

So I'm clear, do you want me to resend this series based on -rc3?

Frankly I'm always confused as to what is the correct/preferred branch to
do development on.

>In this case I will add this to a
>for-6.5/cxl-background topic branch based on 'fixes' for now, but once
>'fixes' hits v6.4-rc4 I will move the topic baseline just to have it not
>be based on a random point in the history.

Ok, thanks for picking this up.
