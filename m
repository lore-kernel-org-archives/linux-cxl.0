Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE7A9C32771
	for <linux-cxl@archiver.kernel.org>; Wed, 21 Sep 2022 22:09:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbiIUWJR (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 21 Sep 2022 18:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiIUWJQ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 21 Sep 2022 18:09:16 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87432A7A85
        for <linux-cxl@vger.kernel.org>; Wed, 21 Sep 2022 15:09:13 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 8F3A56E1DFB;
        Wed, 21 Sep 2022 22:09:12 +0000 (UTC)
Received: from pdx1-sub0-mail-a289 (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id D53056E1DF6;
        Wed, 21 Sep 2022 22:09:11 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1663798152; a=rsa-sha256;
        cv=none;
        b=CGSHWCx7CCNESEV/LVL9Ptb41Uo4aK6rYZbTA7soMSZJArOM1FVDgKcnZRHMuTmlp0ZPD8
        fVzMRCMg8fjUcYtcPFhAbnhHCSoNdDdqyV892jXXvJ6qltnvIA0VPiAG0kgcbg322/3ciX
        5j7CzxfmmP6E2qhfmRExAcY0sjoKVGyhQGYi32e1c5TE5lDt8HUwETzlFqOAq+US2HxXEF
        +GTrVaJjBdS/CwyuOLLkB78avAAWo08mC69rX7WSDf2X4tqaxw2t5yLVOPl7/uZGjTSZ2g
        w2j4eZLhdXBREEqbqJv+J68I55V76VBNsT8C9KgMywVH6JgBF+QkgVJWhRmUrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1663798152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=JtTggid7JQonbp0T8/+SenAYkJ/aE36vGuOwqISTj64=;
        b=BR2NLVoyspG7WuRfLoqyL77UY0SffwLB5QyUxUEH9HgNLffgN/xeBYomjXZJP+cbB0TdYH
        a5OGADXA5lBe4i3kGdgV8Z1MJApY3/oIDhgKuDp8qXkvOE5ENkiI7mionbMEBTaumika3R
        luyg9e1N3SF9b573kOFL2aO3Fmc7sIxwiCttsnqRSS4CVmsczsyQV0jeoMkny7bnfuLaO5
        kDofP37mVnlwAWjRiODLx+04sdLfmIEv0+oLnprkcq4S7O6atFviQK0kAHXUybLULuRuHh
        mAYOtGKiHdYvSUjRsVcQD04iJfkAtvl/LfBqzufMYMowUVSsntS728LaTY/RRA==
ARC-Authentication-Results: i=1;
        rspamd-686945db84-cnhwx;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Trouble-Power: 58653b532f96b8ee_1663798152212_3412653648
X-MC-Loop-Signature: 1663798152212:3549851898
X-MC-Ingress-Time: 1663798152212
Received: from pdx1-sub0-mail-a289 (pop.dreamhost.com [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.120.38.177 (trex/6.7.1);
        Wed, 21 Sep 2022 22:09:12 +0000
Received: from offworld (ip-213-127-200-122.ip.prioritytelecom.net [213.127.200.122])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a289 (Postfix) with ESMTPSA id 4MXsyF1s75z82;
        Wed, 21 Sep 2022 15:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1663798151;
        bh=JtTggid7JQonbp0T8/+SenAYkJ/aE36vGuOwqISTj64=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=VTyItVBtdtYMptleQiuiPE6xF+2A4yAmtvcU8c3zLCFhK4HDY8hMh4zGYGUdfhRLq
         B/I+9YdT+FTKV0KaxUyC6UHC0qP3vr+3hOAfeFlPz/2Ixqh6OyXMDSylSdjL33IV/l
         9CCBgMVtSdKTXGTIeAk0byYoemRqAKtek8RSOWDepApEdlchxqeYigSpfq8GIixEcW
         Dh9/KmKL4SoMsCIT3eVFch0IMS4XlMJrXpmKltLBsg2zgWvKZ8FjppwecoTX/9ft5X
         7A8f38miz3RXyXrOim7H7LeAUcMSvXkCeANOyZQewdszGcPuGqPpSwp5URHaoLxSJg
         4xYZgJJzCt1CQ==
Date:   Wed, 21 Sep 2022 14:49:26 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
        dan.j.williams@intel.com, bwidawsk@kernel.org, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com
Subject: Re: [PATCH v2 10/19] cxl/pmem: Add "Unlock" security command support
Message-ID: <20220921214832.km2dkqdby2rk5kmh@offworld>
References: <166377414787.430546.3863229455285366312.stgit@djiang5-desk3.ch.intel.com>
 <166377434821.430546.18100037354899710663.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <166377434821.430546.18100037354899710663.stgit@djiang5-desk3.ch.intel.com>
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 21 Sep 2022, Dave Jiang wrote:

>Create callback function to support the nvdimm_security_ops() ->unlock()
>callback. Translate the operation to send "Unlock" security command for CXL
>mem device.
>
>When the mem device is unlocked, arch_invalidate_nvdimm_cache() is called
>in order to invalidate all CPU caches before attempting to access the mem
>device.

s/arch_invalidate_nvdimm_cache/cpu_cache_invalidate_memregion

>
>See CXL 2.0 spec section 8.2.9.5.6.4 for reference.
>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

>Signed-off-by: Dave Jiang <dave.jiang@intel.com>
