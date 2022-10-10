Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F51C4332F
	for <linux-cxl@archiver.kernel.org>; Mon, 10 Oct 2022 17:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbiJJRjz (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 10 Oct 2022 13:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiJJRjv (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 10 Oct 2022 13:39:51 -0400
Received: from crane.ash.relay.mailchannels.net (crane.ash.relay.mailchannels.net [23.83.222.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA4D25C2
        for <linux-cxl@vger.kernel.org>; Mon, 10 Oct 2022 10:39:45 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 2C799921FFD;
        Mon, 10 Oct 2022 17:39:41 +0000 (UTC)
Received: from pdx1-sub0-mail-a236.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 648F0921DD5;
        Mon, 10 Oct 2022 17:39:40 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1665423580; a=rsa-sha256;
        cv=none;
        b=ndKHUhRi9yKT0qQCaTNe3cbI8S90SV8aqU/PeCi3yjrQGj6Eln8962B0jB/rEZmTnjRQz/
        ibxNsCZeZGGXJaSuHl0PZsydHEBOjqvMVMCdewCU28v4Qrss5+ri7IVE89XOospfaQiFnf
        4gCKgFAO9PQjtML3FO2LYNXTG/KZAqXLlJ2Wcjk19reUzE8CcMDVX4aoxzdaWu3MrVOW8V
        /AkwGGBOPg2k8+MicO9jCcG3mGFSCpAio2lvGVISETaDxHnFKsfBAHTPzrhwDCO18jssUN
        eOWfmL9AJDpv7bflbLfynLXpgtbfHCOo2OIRvCPoHS3H3rUJZTDeJavKfhvE1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1665423580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=gGmlWW7IjW5I6T1Q1olP9QULCjSHVNP8cLU/WlKtH8o=;
        b=cIHwfvYJM6qQRFCsDjsaaAg1p62o3H03jIhFyRanriBjmBkcLyMf5D6ucvH69o6VZ6Uimm
        7IrhTSPWV3Vol/B46m8kDpCpwGeLkQKYeu79dvX14VZEpIlHVjrX95yFRodjyyDz6/7/OK
        cEBxTuCc1hbdEqAhSwUBM37Cd3IGb2g7uM7zVnHHSyi2Vk3Twra5lH+Fkb+0oGEdP3nnvp
        aWyy4B07PH15aRLsL/po5PfoRVlqshKV2LkCd6o5uWtkIsXp1PNklH8gkCff3Fhpn6TJ/K
        5HwRlWOTpsvFxgDARQVOPWXj1PZTrOhuivdk/Vt/APakTbsRMq/z80mTxSZ0rQ==
ARC-Authentication-Results: i=1;
        rspamd-7c485dd8cf-xj8f2;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Bitter-Continue: 027f11f70c9975ff_1665423580913_1980910223
X-MC-Loop-Signature: 1665423580913:2291040994
X-MC-Ingress-Time: 1665423580913
Received: from pdx1-sub0-mail-a236.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.116.63.144 (trex/6.7.1);
        Mon, 10 Oct 2022 17:39:40 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a236.dreamhost.com (Postfix) with ESMTPSA id 4MmR4W3Fv5z6s;
        Mon, 10 Oct 2022 10:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1665423580;
        bh=gGmlWW7IjW5I6T1Q1olP9QULCjSHVNP8cLU/WlKtH8o=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=UXEbqIuuyvY+3fP/kksMsIEIesqr+mNBngDDpJp+jrFJGFOn+97Bwnyj4Dy/f+OVs
         TZoMRErULyZDIGPcIhBeET+vV/r1mzjh9qourCPjHYzjp/PndXiememNpCE8ZOmbh/
         KeDVF7TtmdBi+wsAz1I5/PZdlqSJ+axGqsR9emplHa7JQmNweizIqDFn6qTVqDJs8y
         spuBSLOc05aNsUZ7e0rhBmFHueUyid/nRP8mhL/6nU28GicF50TcO8PoxNSJCk6//m
         AkrUtkkuWud41BhtRgK93cu/SolHViMULPeQHa2bGGXMxAsoAYtEhJacLQqgVCHwdK
         jEwQP13/8IWvw==
Date:   Mon, 10 Oct 2022 10:18:55 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Gregory Price <gourry.memverge@gmail.com>, qemu-devel@nongnu.org,
        linux-cxl@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        "a.manzanares@samsung.com" <a.manzanares@samsung.com>,
        Ben Widawsky <bwidawsk@kernel.org>
Subject: Re: [PATCH RFC] hw/cxl: type 3 devices can now present volatile or
 persistent memory
Message-ID: <20221010171855.mgpfwnz3ugq2jnrh@offworld>
References: <20221006000103.49542-1-gregory.price@memverge.com>
 <20221006094557.000035ab@huawei.com>
 <20221006095007.00001271@huawei.com>
 <Yz75ppPOwYCvNamy@fedora>
 <20221006174214.000059c7@huawei.com>
 <Yz8QlQ9yLFrWxWsN@fedora>
 <20221010154343.00007afd@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20221010154343.00007afd@huawei.com>
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 10 Oct 2022, Jonathan Cameron wrote:

>I wonder if we care to emulate beyond 1 volatile and 1 persistent.
>Sure devices might exist, but if we can exercise all the code paths
>with a simpler configuration, perhaps we don't need to handle the
>more complex ones?

Yes, I completely agree. 1 of each seems like the best balance between
exercising code paths vs complexity.

Thanks,
Davidlohr
