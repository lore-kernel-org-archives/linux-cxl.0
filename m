Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB0DC4332F
	for <linux-cxl@archiver.kernel.org>; Thu, 15 Dec 2022 19:14:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbiLOTO4 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 15 Dec 2022 14:14:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiLOTOy (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 15 Dec 2022 14:14:54 -0500
X-Greylist: delayed 1068 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 15 Dec 2022 11:14:53 PST
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090DE2C65F;
        Thu, 15 Dec 2022 11:14:52 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id B56143C1F69;
        Thu, 15 Dec 2022 18:57:00 +0000 (UTC)
Received: from pdx1-sub0-mail-a228.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 268903C1F50;
        Thu, 15 Dec 2022 18:57:00 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1671130620; a=rsa-sha256;
        cv=none;
        b=Zu95JO8kYnjIS7o3cYOs9NXpUYPeZyB3p8gSlHXTXLBYiwuR6OJeYB316GjdWsRjaZd0xc
        PSNzb4cjSS5XLVRjb071/VysiISPpGgjHiZgl50pdBLvngv5Y2zYxW0xvubLtll9BFQH+t
        tAi/30fkqms7Pjl17aMT/BqHWO8BDIgH0qtpt0q6o2TXuD5XQ4eKBLc8+sVQ/9WeAdx4LF
        AfujlmBlNEJoMza6Wtus2rcbOF+itld/qe8wdcXs/R1H27hZc+xsQLN+0YWEGYhOHJUxGY
        1VrXzOPr6xWFRsfqNw1JYiHw5cnvey5u8fzortBZ5tBALqWi7LORJBEu7fFeNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1671130620;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=pB5nxsEfrP8qPKjWc6t0G0+7wvacVCgVmTPM39QulFg=;
        b=1qWo6A4V8mAwemJndwRmEfGsA0DoVhQkIlPqrVTK2wEVb7SKfGhajImB1GeXk+Wnc4wYOb
        jxMaPc0hJlXEgAEXxqvjBQyHbaxD4YcbWYI/Xldw/43mbxcj/Q8ow8cPot2qMYq9LeYrUx
        eMULEmKlclSinF8umM6RvhfvDO7Bm4q7PvV4ve07zhHAaucTzww4wCArv9uxUgqGHTh5G5
        fr1cCGdk8xykjSe3YA/upFT2Njzjvm4aePkUQIMkPl7ByIqKyU8hLzvpNRnSdiTdGvwG5Y
        Pq2bXO4+5Ot+5RCIxoBHcjNX7VCHlqx4fQQ0SDco+LYH5LoYgjwjHRtdZE5+xg==
ARC-Authentication-Results: i=1;
        rspamd-747d4f8b9f-kgg9h;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Battle-Belong: 511832d1486bb74c_1671130620501_672171423
X-MC-Loop-Signature: 1671130620501:2016065834
X-MC-Ingress-Time: 1671130620501
Received: from pdx1-sub0-mail-a228.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.116.179.68 (trex/6.7.1);
        Thu, 15 Dec 2022 18:57:00 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a228.dreamhost.com (Postfix) with ESMTPSA id 4NY1gH0bmMz5y;
        Thu, 15 Dec 2022 10:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1671130619;
        bh=pB5nxsEfrP8qPKjWc6t0G0+7wvacVCgVmTPM39QulFg=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=U60iz7XqFpvs3HfbO6vCWddVzrlcgOOeeV/4UlHDr0RJEp5A1Of4UUSSzDQ9Gz8Kt
         9wawq+ez2S59JmfUflsYYwJqO54XZiHy//YBU79ctzeKSgL9I/IcXc1tiDrzjqyzil
         Xx4AKnsIX/8D8Ejq9I9zO+5jXP3i7O4JakGGdiL2LAzyRtLoDXM9D7wyOA0XiiPRlh
         gbXnG+K5e52v0k2xyRwih6UCrOgh9/hhIwo9Jp1IuklN8Lp591PLz1OQMiq2deEhGi
         o2q9e2dIM6YfFtcfEv5ie6YCIVFsJ3QEfR+6icAUdU9F6zRlawJELBucivMARyYC7M
         xJbOzWSlAALKA==
Date:   Thu, 15 Dec 2022 10:32:27 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, bwidawsk@kernel.org, a.manzanares@samsung.com,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cxl/acpi: fix null dereference on probe for missing
 ACPI_COMPANION()
Message-ID: <20221215183227.gqjiafhedsp2cwkk@offworld>
References: <20221209062919.1096779-1-mcgrof@kernel.org>
 <63937afd72956_579c1294eb@dwillia2-xfh.jf.intel.com.notmuch>
 <6393a3a9d2882_579c1294b3@dwillia2-xfh.jf.intel.com.notmuch>
 <Y5kAt3WRgncTj26x@bombadil.infradead.org>
 <63991ec886e85_b05d1294a6@dwillia2-xfh.jf.intel.com.notmuch>
 <Y5pU4XTchSKVqkjx@bombadil.infradead.org>
 <20221215060410.2p653tgqw35q6wbz@offworld>
 <639b5adada2e6_b05d1294e4@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <639b5adada2e6_b05d1294e4@dwillia2-xfh.jf.intel.com.notmuch>
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 15 Dec 2022, Dan Williams wrote:

>This will end up failing the unit tests because those want to have a
>clean kernel log from a "Call Trace" perspective. So either
>dev_warn_once() or just live with the noise since the message is more
>for awareness in production environments and test environments can
>ignore it.

Yeah I quickly realized that dev_warn_once() is what I wanted. I'll send
a v2.
