Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E7FC7EE26
	for <linux-cxl@archiver.kernel.org>; Tue, 23 May 2023 19:11:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbjEWTLJ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 23 May 2023 15:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjEWTLJ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 23 May 2023 15:11:09 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008AC119
        for <linux-cxl@vger.kernel.org>; Tue, 23 May 2023 12:11:07 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 27EF7261838;
        Tue, 23 May 2023 19:11:06 +0000 (UTC)
Received: from pdx1-sub0-mail-a295.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id E9B6E262B19;
        Tue, 23 May 2023 19:11:04 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1684869065; a=rsa-sha256;
        cv=none;
        b=lCP3oi7Gi1yljgr8jjMiX6orlm+LvdVf/UYWlTuU1jhAtmpuggPkTt6ABzde9uixpPupXv
        JMtdS7f4pkgwDnZFfqwIHMx4kPHvJTEoAmrKWxPmV8wittqmPkcvxBGLekN3RP5Brdxp/o
        FcTaquKr9H3XrLSvNQQpvR9LwZVqb4FBqhCbi//5SDXC7485+FsAqmH7/rvNxXnk80N5M0
        uDxX3uWaAqh7Q1pzjgRKnGJ5lUGMekWoE4MkOrMwt95m1r9hzLT7iRP02GoKSSsoRfshn6
        SbEoJf7ZAr4tvczeZDSDFo81mCmNuZ+dNIk1jqnm1c1jTxBEbnnscSTiqIukRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1684869065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=Op8r1Kc3+GN8sY1mN+sFkqchh2eaHPJVaK96mVRfgNQ=;
        b=z8p6z3FyXxCEaGPpNgWBOwaUyQAJBI1BkosAIm/OpsGSLj6Uhy09dk4QqfE89B/3uomgsU
        7Gx0FWjXmzIe2DOP7pz8OPRM2kDJ9FQcrJC+dDUEktow/r7a7i+3TquanAlUMWOhelvBFA
        2qcYzu8MQvTKlkEnE1xobrz9vfQXWsBTEVkiThvuXEe4nrlq6XxjA/ZG9nQAtrV0x4CPhu
        usQvig8zjbUpzvDOjkH8Im7BEDAcOOM57Uz9e+zlpxl+8IQAI/Pu75rJHBcuzb9WGfDcVm
        UAyMaJMskhezDtqNEU6D3KwQTmsnyLkb/Ru9E933/fPuc+NFhplmmZiXIRi6ag==
ARC-Authentication-Results: i=1;
        rspamd-5cdf8fd7d9-r57sl;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Celery-Spicy: 4c0b55e26b54d1bd_1684869065885_3790490718
X-MC-Loop-Signature: 1684869065885:3836037249
X-MC-Ingress-Time: 1684869065884
Received: from pdx1-sub0-mail-a295.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.103.24.74 (trex/6.8.1);
        Tue, 23 May 2023 19:11:05 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a295.dreamhost.com (Postfix) with ESMTPSA id 4QQkS75cVBz66;
        Tue, 23 May 2023 12:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1684869064;
        bh=Op8r1Kc3+GN8sY1mN+sFkqchh2eaHPJVaK96mVRfgNQ=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=N0EBlW/ljqL/9F0vyi3ZznA4Lkkx+pF4hKUZHanE3V5KgHMVRE8XR0wle+PBMCbDn
         9AbVkoOZjo3IKo9TSY91BBOlZWw2zRMYtgmW346dXdlYHkghO28R/EsvqjN5xFores
         tLDL5icNsPb3k0gQofWVNEt5sCs2aFUQRHssyrH7vCucWv+jhfwOFmXsd2u5k70sL6
         WJa67zLshUV3EYX5WZD44ImhwgiJLW+thSI15SWqMaSI/mMNrT7XgGbuY4JZPhCsxg
         ywKaVqKg7D8xPPNEwS5S5S53FnkFQM92tyVrds1/YwO0I8kQPf3HlK9FuMsoB4gU//
         v4FOIRPt0z7ng==
Date:   Tue, 23 May 2023 11:37:33 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     qemu-devel@nongnu.org, Michael Tsirkin <mst@redhat.com>,
        Fan Ni <fan.ni@samsung.com>, linux-cxl@vger.kernel.org,
        linuxarm@huawei.com, Ira Weiny <ira.weiny@intel.com>,
        Michael Roth <michael.roth@amd.com>,
        Philippe =?utf-8?B?TWF0aGlldS1EYXVkw6/Cv8K9?= <philmd@linaro.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Markus Armbruster <armbru@redhat.com>,
        Daniel P =?utf-8?B?LiBCZXJyYW5nw6/Cv8K9?= <berrange@redhat.com>,
        Eric Blake <eblake@redhat.com>,
        Mike Maslenkin <mike.maslenkin@gmail.com>,
        =?utf-8?B?TWFyYy1BbmRyw6/Cv8K9?= Lureau 
        <marcandre.lureau@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v7 4/7] hw/cxl/events: Add event interrupt support
Message-ID: <7ibf47asbwszonm2xvdajv2lmyand7geesaz2fu2cyrp6erwey@g4l6dkjpkija>
References: <20230522150947.11546-1-Jonathan.Cameron@huawei.com>
 <20230522150947.11546-5-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230522150947.11546-5-Jonathan.Cameron@huawei.com>
User-Agent: NeoMutt/20230407
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 22 May 2023, Jonathan Cameron wrote:

>From: Ira Weiny <ira.weiny@intel.com>
>
>Replace the stubbed out CXL Get/Set Event interrupt policy mailbox
>commands.  Enable those commands to control interrupts for each of the
>event log types.
>
>Skip the standard input mailbox length on the Set command due to DCD
>being optional.  Perform the checks separately.
>
>Signed-off-by: Ira Weiny <ira.weiny@intel.com>
>Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

I had done this long ago, but I guess I never sent a proper tag.

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
