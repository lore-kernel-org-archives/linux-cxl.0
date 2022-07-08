Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF29C43334
	for <linux-cxl@archiver.kernel.org>; Fri,  8 Jul 2022 17:40:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238564AbiGHRkc (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 8 Jul 2022 13:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238052AbiGHRkc (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 8 Jul 2022 13:40:32 -0400
Received: from crane.ash.relay.mailchannels.net (crane.ash.relay.mailchannels.net [23.83.222.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49BCA5C9FF
        for <linux-cxl@vger.kernel.org>; Fri,  8 Jul 2022 10:40:29 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 54979802B76;
        Fri,  8 Jul 2022 17:40:26 +0000 (UTC)
Received: from pdx1-sub0-mail-a296.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id B80EC802B6B;
        Fri,  8 Jul 2022 17:40:25 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1657302025; a=rsa-sha256;
        cv=none;
        b=QgEo44W+mfmejHC3q4hcEVYHSU05howPDoXZH6+LCo5F3JHowoDvT6IzYyXX/mVaRwVTks
        R0+9PBtKd5NSar6MAl3CHFlBrdtuETEn9tOnieI2cE+XhGPVA3+byk9dE+sw2YHEO07Kom
        OigpvWe91wvbi8PIWgoM9OC7aTyQ+YQPKwsf7Epr07JUwAHCcUNdVjWe9Xi68r0WzrgJNa
        w0SQx5+De9YrYbpAM5L+JjkgbalkDpqcCmDu64qgme3BujBd2w3mi4fnL2SrHcIFmJcTYC
        AzCLcBYA7ItClaoLS+hRK9s+mUgtcyUXjiQLPCMF0fb90B90mpg0dGTzwzAHVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1657302025;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=tB+uKIPMMWdqAifLekQsTLE4thr5pyl2cfzmekGPJBY=;
        b=1EwoXZHbcX8FrmA2AxqnO0dj6CouUeGeB2l7qktd575cxXEa+BKEvRmrnQJhJBBg6f6EZb
        iuYpKtY365cMJ//bTm5h3M0l57+5q0rGjOBtNsZm6bNe17+ptSgl7aiMq4dAFKQedvvvwB
        FdENUaIzO0QgV3lhzjH02FFOLZd9DoTjS7eAx/3Q9oFVV+XCEkjnMVz4EfcGs+CFM4OPBZ
        B8Zyfh5BCadlKvpgKQkl07/oyhVRrNyDOJ+FZNDf6rsd4zGcUA2Malj1MmknslNfw2Vylc
        4CRUcapSNH2Qm8M75Gzsz4WSyXcv9YV0J+JaQx5a2e1sqb76lr0zpZSOpzQSRw==
ARC-Authentication-Results: i=1;
        rspamd-674ffb986c-xff54;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Spill-Share: 28a098ea10db2a0e_1657302026085_357701815
X-MC-Loop-Signature: 1657302026085:3600511971
X-MC-Ingress-Time: 1657302026084
Received: from pdx1-sub0-mail-a296.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.124.238.94 (trex/6.7.1);
        Fri, 08 Jul 2022 17:40:26 +0000
Received: from offworld (unknown [104.36.25.13])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a296.dreamhost.com (Postfix) with ESMTPSA id 4LfgXm40FPzFM;
        Fri,  8 Jul 2022 10:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1657302025;
        bh=tB+uKIPMMWdqAifLekQsTLE4thr5pyl2cfzmekGPJBY=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=aqRBTuLGPjsdhqp/7NBY2itW4rN6uETvIRJZ4iTidsfymzdz6AzqM5NONZUR3tqtK
         XSJQtaejuFM76sRFh6a0ozzwXDRQC2wa6ckyJY26+S1ItCwiA0sxIunp3Whl4BGVSz
         GtpEpgkoqNa4I5HNujP74HEOR4kVFTKo9yL72DzpsiNKe2P9klhiY40r6N5UJKdFgx
         8nGqMMf/F/eB0TlWF09um84Alvjrd8ZN5/42gwYm7oULdErDp0pDulA5Thl/Sh4dDV
         d7mK6fBsQnq6Ip18Ll8QzWmWp9ie3yYIwi/ccehk6/rHs57aODo8T+CEARAk6nvqjQ
         5U+bBNlVGpjVA==
Date:   Fri, 8 Jul 2022 10:24:55 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
        Jonathan.Cameron@huawei.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, a.manzanares@samsung.com
Subject: Re: CXL device sanitation and pmem security questions
Message-ID: <20220708172455.gi37dh3od4w5lqrd@offworld>
References: <20220707190524.i2fxgk5ez6c35vw6@offworld>
 <375b39c8-ee8b-96ec-8842-b3de1b3a0634@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <375b39c8-ee8b-96ec-8842-b3de1b3a0634@intel.com>
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 07 Jul 2022, Dave Jiang wrote:

>Hi Davidlohr, I'm actually looking at the implementation of this right
>now. I think initially if we provide a CXL secruity_ops to nvdimm
>similar to EFI NFIT provider, we should theoretically be able to do
>all the security bits through ndctl via nvdimm. I think I'll probably
>have better answers to your questions once I get some code going and
>see how things work.

I assume you mean only the pmem security part #2, right? This makes sense,
but of course for sanitize this would not work, which might also need to
consult security state regardless of security_ops::get_flags().

Thanks,
Davidlohr
