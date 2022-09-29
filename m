Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81ABDC4332F
	for <linux-cxl@archiver.kernel.org>; Thu, 29 Sep 2022 17:16:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235480AbiI2RQm (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 29 Sep 2022 13:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236075AbiI2RQj (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 29 Sep 2022 13:16:39 -0400
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D842F147F3E
        for <linux-cxl@vger.kernel.org>; Thu, 29 Sep 2022 10:16:31 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 9D1F8821567;
        Thu, 29 Sep 2022 17:16:29 +0000 (UTC)
Received: from pdx1-sub0-mail-a202.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id A9EE882083E;
        Thu, 29 Sep 2022 17:16:28 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1664471788; a=rsa-sha256;
        cv=none;
        b=Ma8PXaKAGieOErgKXi/tYuT+OIXLaVITOMi0yHWTsxGkYh+BiSXfuRY2/FS3uLnwx/zOl/
        ZsQ5YedvU2G9mAAc08Bjnrxd5+AyyPnRDB0PpWmGg76cQeUrrVUMvnGZF3hmqGui+S03IZ
        Xk90fvORfFO0PK1CN3IAjJd7sU6SpnCCtTB1xAHxznCqEukh1cVBUJB/1XPEwrmQ7qqYF6
        jPeDzEQYpfZJuVjXxLjcaov1fFNj5xf2ypM9APxOYFcgRWikhijJrzCsq/uxQLXqhrgPMy
        dCPst9nzy+XhkFtPY71lfx75uzT9xr1iWxUxtshoQHLkyzCZBL/rFHygEkjbrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1664471788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=HvArGIg1PbqFZMoIgq48Gq8pVNIqMcXaujdBY2cZV0g=;
        b=tf3bQZ3LkZOxWohX+kLAhC6F2Q1eA+gr0YEl48XEa5jjuJRe1wDZoSWU0clPDEc/nu7PbX
        ocaRY5ChXk/pZM5PEdfTr/P/JvTKag1fnThVQADHxzPwYxkAbJtQzZXydNKsMlIrKw5H4k
        +qLJIJsi7NSpL31ARkEJAtV1Kjc+UMh21VV3+LJaDtypyRHJQ9f4SKPKhHUejnckhxahY6
        XIextlfkgGrOoYIj9/wz5wnMztUQN5FGvVZbjjU4fysEjnTkuNqCJbrkzNP+bXNIAZ4R1T
        ZyPTM5Oy8WrIYVkGlZER+JCZlm5zibA11Y+gSwymQlbB41PGmCUEvbVjsXAnVg==
ARC-Authentication-Results: i=1;
        rspamd-7c485dd8cf-q66sz;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Share-Madly: 1b0a7d552c22672a_1664471789009_1047149183
X-MC-Loop-Signature: 1664471789009:952599117
X-MC-Ingress-Time: 1664471789008
Received: from pdx1-sub0-mail-a202.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.126.129.213 (trex/6.7.1);
        Thu, 29 Sep 2022 17:16:29 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a202.dreamhost.com (Postfix) with ESMTPSA id 4Mdg4q4F1kz99;
        Thu, 29 Sep 2022 10:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1664471788;
        bh=HvArGIg1PbqFZMoIgq48Gq8pVNIqMcXaujdBY2cZV0g=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=qZ9nPek2IsUl/IpWme1swCFU4xBGQhOanAdcCgRnE9p4mPcxYjmi/nby/ZgTMODZk
         8xxtHI+Su4BSHZeGaeeGB6Kc8XiOONL/CWJy40q2GjaIOE+5MJjVZin98wchuTH2ai
         QXmxkW6b58ZSntNLmj0tg2BJMC7tQO7S7lgvR1s6uzs+iWwCHFaPEdd+08Bfr8LfA5
         Aq5/tb5UeiQ/+aGqY804C1zBiJprJwO5Ittl95ulka3a7A/eEbNntvwBLDo8O9KoR/
         t26ZtC2IC27MbzYXMeZkY8gXhVudGg5f0eSw9INTZCDIkoldcCO3MJr5d4Bw+jSM4f
         959gDDaYBP58A==
Date:   Thu, 29 Sep 2022 09:56:20 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
        dan.j.williams@intel.com, bwidawsk@kernel.org, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com
Subject: Re: [PATCH v2 12/19] cxl/pmem: Add "Passphrase Secure Erase"
 security command support
Message-ID: <20220929165620.dqfzha4uua4rcscf@offworld>
References: <166377414787.430546.3863229455285366312.stgit@djiang5-desk3.ch.intel.com>
 <166377436014.430546.12077333298585882653.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <166377436014.430546.12077333298585882653.stgit@djiang5-desk3.ch.intel.com>
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 21 Sep 2022, Dave Jiang wrote:

>Create callback function to support the nvdimm_security_ops() ->erase()
>callback. Translate the operation to send "Passphrase Secure Erase"
>security command for CXL memory device.
>
>When the mem device is secure erased, arch_invalidate_nvdimm_cache() is
>called in order to invalidate all CPU caches before attempting to access
>the mem device again.
>
>See CXL 2.0 spec section 8.2.9.5.6.6 for reference.
>
>Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
