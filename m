Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3896C77B61
	for <linux-cxl@archiver.kernel.org>; Wed, 26 Apr 2023 03:10:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234015AbjDZDKH (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 25 Apr 2023 23:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239024AbjDZDKG (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 25 Apr 2023 23:10:06 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0C226B8
        for <linux-cxl@vger.kernel.org>; Tue, 25 Apr 2023 20:09:58 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 2C030341F12;
        Wed, 26 Apr 2023 03:09:57 +0000 (UTC)
Received: from pdx1-sub0-mail-a207.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id A2A81341EA4;
        Wed, 26 Apr 2023 03:09:56 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1682478596; a=rsa-sha256;
        cv=none;
        b=nZ1roajkWMsbEBcXHEVcRabldjrAqUM/pmRSGxH2B/ckM8/TsZM9QOx0LBaTaHCFRDjQXR
        s/EVUq8IVh2Vxo9YPhS7Q6/gJbd10x9M8k7H0BKWtnO3+VpRwMsdTY/TUGqNu/KKyHKeuk
        tEOstHEZTtVgSiodxnw6kcuGHu1kz8msRYUF4yG3m4Fo3aIsaUbWjtvDpecmUx1mglod/t
        w8HSlEVgS184m2/thI8nCL9mZ46SmjlAPiN7GdGOgES/Y5b/7qwMz/8T1+X9iH3/TPBlI+
        +u/6WRsRey5QXJ4EwfEs+RCgATw7eTyRqoKJjBGDOwSddskPwI30UtcD5Yqn+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1682478596;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=/sO4n1vqloYGXEbpA7t/T7dNRsV37rKOM8Tftq31E44=;
        b=KJJzzPCAeN7bDzSM/BmcRIjJAQnltMTgBU2vWJOn5Fbt+SXnqZ6pQRlClWj1r315QMRTzM
        /NRImJ71TEaD3cdJpTEhP87C8EyAhe0c9hGIF81XPJa1uVSl1Zoas3DKWyfZ09DmXt4iy6
        y/nZrZ0P+ywtCfVF5tDbfl+5G9jNxf1cuqFsVDi/KmmkGwbvvKZgegan9cixF2OiXUPjaX
        O8PvFQsF8RyPY+hQqITLX7bL2RQV/lJlnWUNgWjPUTrtTBI17ZWKiHlUNQV1/YdLbB5mS0
        EBQssbJYuLUkoeegWXt054bbOtX0if4qfwKjDHJuujDQ70A0V5fjHTwUgVYARQ==
ARC-Authentication-Results: i=1;
        rspamd-7f66b7b68c-8ll48;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Blushing-Stupid: 38fb8cbb2e7a4ab4_1682478596958_2572014739
X-MC-Loop-Signature: 1682478596958:3818743108
X-MC-Ingress-Time: 1682478596958
Received: from pdx1-sub0-mail-a207.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.109.138.52 (trex/6.7.2);
        Wed, 26 Apr 2023 03:09:56 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a207.dreamhost.com (Postfix) with ESMTPSA id 4Q5kPb5YC0z9s;
        Tue, 25 Apr 2023 20:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1682478596;
        bh=/sO4n1vqloYGXEbpA7t/T7dNRsV37rKOM8Tftq31E44=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=KmnGyxNkkbjyxYd7vIvIVybgKFVXrLNjdZcHcjM9YdJv5jTyT9lTvI1Mphsn7HQba
         xie6LWFYH/78cQz9GYrx4bREX9BFHX33CXIwvfWUT4uwTxOR+j/CgMH+NfQSC9jwJX
         uvVJ6uEkOgODFxrtGqIQ1pB9rMAdo417dmc6mSiw556IZN/V98HdvRxwdVLaSZpOXw
         pndGZf2ktZlHaDor5ANlRsAjr/fL/lYvjn0MDWG8ga6phiTMRI5lt2+wzm6VUK6rhC
         eoRKTvADxxgFZB49ovzvXfwetTawQPXKDGbkKXCb4Xs4UPCyzYIaDNHYbrEUgWfU6U
         YBe74H6IFznpQ==
Date:   Tue, 25 Apr 2023 19:38:11 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     alison.schofield@intel.com
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-cxl@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v13 6/9] cxl/memdev: Add trigger_poison_list sysfs
 attribute
Message-ID: <rjgz474mou55qufxwwmy3vpxftagdys6ge3iqs3guqukkw3jlv@ho7vuf7bmjsp>
References: <cover.1681838291.git.alison.schofield@intel.com>
 <1081cfdc8a349dc754779642d584707e56db26ba.1681838291.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1081cfdc8a349dc754779642d584707e56db26ba.1681838291.git.alison.schofield@intel.com>
User-Agent: NeoMutt/20230407
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 18 Apr 2023, alison.schofield@intel.com wrote:

>From: Alison Schofield <alison.schofield@intel.com>
>
>When a boolean 'true' is written to this attribute the memdev driver
>retrieves the poison list from the device. The list consists of
>addresses that are poisoned, or would result in poison if accessed,
>and the source of the poison. This attribute is only visible for
>devices supporting the capability. The retrieved errors are logged
>as kernel events when cxl_poison event tracing is enabled.

btw thinking of scan media, is there some interface you already
have in mind?

Afaict we could have a new 'trigger_poison_list_nocache' attribute,
or write "scan_overflow" or whatever to this very file.

Thanks,
Davidlohr
