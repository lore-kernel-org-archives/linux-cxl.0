Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80837ECAAD8
	for <linux-cxl@archiver.kernel.org>; Wed, 21 Sep 2022 20:29:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiIUU3M (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 21 Sep 2022 16:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiIUU3K (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 21 Sep 2022 16:29:10 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CFC6A4B29
        for <linux-cxl@vger.kernel.org>; Wed, 21 Sep 2022 13:29:09 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 87F67121D14;
        Wed, 21 Sep 2022 20:29:08 +0000 (UTC)
Received: from pdx1-sub0-mail-a310.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id D82FE121C4D;
        Wed, 21 Sep 2022 20:29:07 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1663792148; a=rsa-sha256;
        cv=none;
        b=rTF5VVyf3lHQ7q62r8OuGoqX3BVQi1YqiJLIWsNlWHvf1O5vRZq+/EqBE9tX7SZnbbQdwJ
        zlWq/f8QGtPHz+vcItZpRNNeZVkjChR9mFZrKXqgRjRwk2ClfUy3WZ0bVqtYjwKmD0ReB3
        o925S8UPV5b/qWbrXScCxf92OBAVTHJ36M30ZV1kS1oK6eyCKQaQRzyX2WQu7Gb+w9lgDs
        2WTRdXJYtF4BbS3I2tXhtP0kRTvSfBx1N0TrO0Cu4Taokpv0Cvjbpl3dEMBw1Xt6JCgeGh
        Mi8sJi7NqSkVvbYtp1tWjfrPesDyXMX6dRqVm3XHZqDYBjYsKg63G1koHU8fpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1663792148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=bx2KGBzPxDjPMw8nZeM1Q7GJHOCeelxY38COTqebuYU=;
        b=UIL1eDWeNTNJaW8Z6edeKJFf7LgBJP6vZocfIYmVKH9oxYjNQcay8Nw2q9l6c771I2NeGu
        N12zr+Vm77WVkOoR/8DN10H/X+LuQxLAHezqT0d9j5fQC/Y6UxG35cVPXnJYHI1tAH+0kn
        xjFHm26T9zdlcEKlW42QUvEjEk0cndTSMEUPzNRkTZ6G1KIueZ69POeo3d+NK9GV7iy9GO
        6sqgCUj+kcwVSBeWqHBaMi+yNF/Hw9lXN/Z1O1IEaZAji0F6NLzUtfxs/hgdqzTrtE1Pqc
        UG7PQlskwQsZmIqgqoaaMMuzV6nnkF9A5/BQp5VfC0saUBMyneE++OqyHb1NXQ==
ARC-Authentication-Results: i=1;
        rspamd-686945db84-74jrb;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Bored-Duck: 650f2ec622c91ec5_1663792148362_2229214385
X-MC-Loop-Signature: 1663792148362:3518724697
X-MC-Ingress-Time: 1663792148362
Received: from pdx1-sub0-mail-a310.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.121.28.250 (trex/6.7.1);
        Wed, 21 Sep 2022 20:29:08 +0000
Received: from offworld (ip-213-127-200-122.ip.prioritytelecom.net [213.127.200.122])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a310.dreamhost.com (Postfix) with ESMTPSA id 4MXqkm48pCzkh;
        Wed, 21 Sep 2022 13:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1663792147;
        bh=bx2KGBzPxDjPMw8nZeM1Q7GJHOCeelxY38COTqebuYU=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=TeeP01eU9sHE4ig8tyxgpbdnHylK6eaJYiKTphrHbJ9rG6+O9cB11nUXqOaIkp2L0
         VBd/P45mhmM8WmlGUQ/7FHUJnIJl6wnjUTn6xTjTJOWWA6Mw04shuI+vUuVJXC5zw+
         1nijH7tjaiG/adx340TM7M7puVknoxqDRKOhV8IxbdR5dJxoDwTMTiRHO0Sibt2d8v
         wukDKpLGwLCYcqWFOen5L4lk8UX6+Vf6HYkSQfIK/XMls2wDGGSEnYJDmonCmQ9BJb
         EQeDp+apBh1cBhT1n4sEsMRZdB+nGiksvMbd7Grz7SNVG7l99NZgk6qlT30lmh2bDP
         7E+UXiEsU8NqA==
Date:   Wed, 21 Sep 2022 13:09:21 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
        dan.j.williams@intel.com, bwidawsk@kernel.org, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com
Subject: Re: [PATCH v2 06/19] cxl/pmem: Add Disable Passphrase security
 command support
Message-ID: <20220921200921.acdi46sx267wkcfp@offworld>
References: <166377414787.430546.3863229455285366312.stgit@djiang5-desk3.ch.intel.com>
 <166377432466.430546.6473491783703443307.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <166377432466.430546.6473491783703443307.stgit@djiang5-desk3.ch.intel.com>
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 21 Sep 2022, Dave Jiang wrote:

>Create callback function to support the nvdimm_security_ops ->disable()
>callback. Translate the operation to send "Disable Passphrase" security
>command for CXL memory device. The operation supports disabling a
>passphrase for the CXL persistent memory device. In the original
>implementation of nvdimm_security_ops, this operation only supports
>disabling of the user passphrase. This is due to the NFIT version of
>disable passphrase only supported disabling of user passphrase. The CXL
>spec allows disabling of the master passphrase as well which
>nvidmm_security_ops does not support yet. In this commit, the callback
>function will only support user passphrase.
>
>See CXL 2.0 spec section 8.2.9.5.6.3 for reference.
>
>Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
