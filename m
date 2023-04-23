Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7255C77B76
	for <linux-cxl@archiver.kernel.org>; Sun, 23 Apr 2023 02:37:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjDWChK (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sat, 22 Apr 2023 22:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjDWChK (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sat, 22 Apr 2023 22:37:10 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A431BF0
        for <linux-cxl@vger.kernel.org>; Sat, 22 Apr 2023 19:37:08 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 5BB6D920C15;
        Sun, 23 Apr 2023 02:37:08 +0000 (UTC)
Received: from pdx1-sub0-mail-a202.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 48EAA920D12;
        Sun, 23 Apr 2023 02:37:06 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1682217426; a=rsa-sha256;
        cv=none;
        b=LH4InGMc34ypGiod9dxwcL8PPi10hdtTyvRpaxi77yIukgV1Ceantt3MGr/+wqt+Dry9Mr
        UIGIFgwlM9n3nRpA540r8dJgJS8bPG1B37GGiRkPYzC6BrXALMgtfWeoWGnsEIMKcVjZFt
        c68MTnkek8ywz8KBGqznajaltyBSDOI0UqITBEhdcsND96zneu/RiFCBSxld4OUzs2S6sK
        cVViQ8eoknIjjbZzfgXC738Lfhg8zU1jMrK7GKglMi1f0BhI1DXDReibHsLruL2mewcCY0
        6Rbtqs3L3hJeyCaEaPJaHMogbzt7pRzgFZoM+FkZomgfSXc5zhmjqBq08DKmfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1682217426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=BKkm9rNn5hc+woofgJL5rmPoLiOxNoJEWgtThdbjg5Q=;
        b=O3uwubXeK6sthsXixFrnASRvXz+43AHnEPC7qbPwKZXiZxZGnOphgmNFnUboSYYOfcyJ78
        ZlT9LcYahFbMAjOno7oIJ1FRDW4ylrGNRNvDJw3hHRors1+MDXzOxKTM/GQAgW9cgtud4K
        9m9PKLl8kDmqMDKUkfivBJUtmKItvdhsiRcOVoOcXsfNmLzCvql1z8cj14baYHuX8+3Sar
        Vs4JzGoRKTN7AlsnRYPkwrEQyCntFGK1H4JZug4s7S8DIqpQ0DxehjR5m9PDro03ouyx1F
        34Ea8CoscRJ7lTZfOZdogoaPGEi+lpsJsVbAkJtwNcoVN4A1LyjPVBPpGcXkMQ==
ARC-Authentication-Results: i=1;
        rspamd-548d6c8f77-hk64m;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Reaction-Celery: 6d15f1207cc28bfe_1682217428179_2010837877
X-MC-Loop-Signature: 1682217428179:3040659810
X-MC-Ingress-Time: 1682217428178
Received: from pdx1-sub0-mail-a202.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.102.66.60 (trex/6.7.2);
        Sun, 23 Apr 2023 02:37:06 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a202.dreamhost.com (Postfix) with ESMTPSA id 4Q3sq536gjz85;
        Sat, 22 Apr 2023 19:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1682217426;
        bh=Ec6b6ZbruinG74QIF1jgPOgZ8lWguCIY9YT+KgzrN5Q=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=DlLChY+mLUJHSpvGOidE5dpO8Mx123e4H8MLYJa3EEh3HC3ojVsAwKtQx8J2iai0g
         5DER12j9gJPaVNreRyLBKg/Xew6np9rm66fUkfrg5Dx6qHvfT20xaRL5PKdK7fdmNU
         NvXCK8bpWO1iznV9yB9xf5zpf1yVwCW/jfNf5UQNdcUzFR4gxAVt2IrkOSQFhp3uHb
         BoKfRu2VS/KgKlMJ2MheDfXm0nW7KogZwXT9dGs3WCEV42Ao+UTTCFborbnsDZL76c
         MlaX8BlqFNKkQHhXGWQul3pUtWcaCgN2W2t+N1ZwC5rjGDvSmtp375x2Hpn0hRz54q
         AwnF/6oKqXy7Q==
Date:   Sat, 22 Apr 2023 19:05:28 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     dan.j.williams@intel.com
Cc:     Jonathan.Cameron@huawei.com, dave.jiang@intel.com,
        alison.schofield@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, fan.ni@samsung.com,
        a.manzanares@samsung.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v4 0/7] cxl: Background cmds and device sanitation
Message-ID: <5tikxwbjpfvadgnngk3e2oi4dnhboqmuikq6ado3lrezckaqol@6oultghng35v>
References: <20230421092321.12741-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230421092321.12741-1-dave@stgolabs.net>
User-Agent: NeoMutt/20230407
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 21 Apr 2023, Davidlohr Bueso wrote:

>Testing.
>========
>
>o There are the mock device tests for Sanitize and Secure Erase.
>
>o The latest (v2) qemu bg/sanitize support series is posted here:
>	https://lore.kernel.org/linux-cxl/20230418172337.19207-1-dave@stgolabs.net/

fyi here's the support for the cxl-tool cli
     https://github.com/davidlohr/ndctl/tree/cxl-memdev-sanitation-v1

... which is also posted on the list:
     https://lore.kernel.org/linux-cxl/20230423015920.11384-1-dave@stgolabs.net/

Thanks,
Davidlohr
