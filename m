Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB86FC678D4
	for <linux-cxl@archiver.kernel.org>; Fri,  3 Mar 2023 02:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbjCCCuf (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 2 Mar 2023 21:50:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCCCue (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 2 Mar 2023 21:50:34 -0500
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C3F4ECDB
        for <linux-cxl@vger.kernel.org>; Thu,  2 Mar 2023 18:50:33 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dragan@stancevic.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 79F328C0C25;
        Fri,  3 Mar 2023 02:50:32 +0000 (UTC)
Received: from pdx1-sub0-mail-a202.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 0DF358C0C03;
        Fri,  3 Mar 2023 02:50:32 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1677811832; a=rsa-sha256;
        cv=none;
        b=LFEn6wk+w5rBXbb2buVpc5K4GlF51Ls+ioYDjdSZsB25ZgYCKm+LOxIawYVyf0sAkCBQPQ
        8dxPCh62WTDiJ3yKQuB72R3H5cK+uIdvC1U9lESUd8ladxNrNw9dvJqDljPQpqtQRsOUJi
        IAVj4WmFftnjAGf5Ow6CaGN6D7xseETX1UO6hJ4Nrc4fw8sCddI+x/n2rV6D14zvPk4nj5
        FGCdzFYKFPpos04N8wIxVzUhAJY3aBnEysVNBE3qcBfcIVdEM03iU/iaN8qYy7DtsB3vPr
        6BPuvXc9QOxNJDUFjuuHEBn1rpjqMvc+gpzOcZ98/s+Sf2vBDrDxCbfCXujLfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1677811832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:dkim-signature;
        bh=I/jP5Fvp/Spbm2MgYnjEqta3gDFhsde2uJZtxkuWYes=;
        b=rkatmqe4ShFzCBVn7ujbf7Ej72+ak7cdyYdMFA5H5/p8+/8fQG/+CqsYy/yW954ya2pV/s
        MHfdb+OkUS1lmutUriTNMFhrwJubFHE6Qsy+P7jY4rO7q6zn6g52VW6nyEFFII3EgOieDZ
        vL7sjmloZA0mCX1t+r58WNFzoxAmbqwuDK1+HSBI9I1Tzxku24s9h1YJe4heSNg5l6ZRrg
        eP2oXRm/tVcgq64wEP4vDtrxr/YXnSl1BVR92L7W2/9nWEguXXxmXyE8wcRxCxLHxdp4YL
        Gdkn3NI6B8/A8lAyhjyvBlbypKkNjBR7WuWtzU/StdUTqz5DSNIXjDdDhkvyYA==
ARC-Authentication-Results: i=1;
        rspamd-69778c65cd-7khj9;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dragan@stancevic.com
X-Sender-Id: dreamhost|x-authsender|dragan@stancevic.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dragan@stancevic.com
X-MailChannels-Auth-Id: dreamhost
X-Scare-Blushing: 133623385e6006bd_1677811832284_1385204117
X-MC-Loop-Signature: 1677811832284:2868207408
X-MC-Ingress-Time: 1677811832284
Received: from pdx1-sub0-mail-a202.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.99.229.33 (trex/6.7.2);
        Fri, 03 Mar 2023 02:50:32 +0000
Received: from [192.168.1.31] (99-160-136-52.lightspeed.nsvltn.sbcglobal.net [99.160.136.52])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dragan@stancevic.com)
        by pdx1-sub0-mail-a202.dreamhost.com (Postfix) with ESMTPSA id 4PSXX748FFzBV;
        Thu,  2 Mar 2023 18:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stancevic.com;
        s=dreamhost; t=1677811831;
        bh=I/jP5Fvp/Spbm2MgYnjEqta3gDFhsde2uJZtxkuWYes=;
        h=Date:From:Subject:To:Content-Type:Content-Transfer-Encoding;
        b=3ErEI+rMi9ZAPk06PRn6R+AeOAHWWbIhIjmBS0nnmDDTmtzO5gP2V6NgyLFkr+xN4
         ZOaebgkF+Bc70uuEzIfq6Y3yDA/1EmyKAJvtJZuP8tgxIAL2RCLh0n9f+4vPQsB9Jm
         dg+QN2D60tb7WSUGECVAgGtUsp2mEWopjso56RzUkiwhe1cmXfERQgyHJkoKqpFxcE
         tR7b3Ql/T9niGazB6ftwC+93oTkn/1VMks+9m6jpBOTptox3WHjQwogLY0Arc6tbqb
         0Ee+YK3/1UvB1PspsZ3IvhWjn2B+zebF4SeCJ8OyM4XpVOAxhN9W6XI3Yfbyq+y8t9
         oboBT7RAg/b0A==
Message-ID: <f60afd35-f8ea-73ac-afc3-926eca633237@stancevic.com>
Date:   Thu, 2 Mar 2023 20:50:30 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
From:   Dragan Stancevic <dragan@stancevic.com>
Subject: using CXL for VM migration
To:     nil-migration@lists.linux.dev, linux-cxl@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hey everyone-

I attended Jonathan Cameron's talk at LPC 2022 back in September and got 
this idea to use CXL.mem to migrate VMs across physical hosts. Jonathan 
and myself have had a couple of lengthy talks about this and then I got 
buried under a ton of other work for months (Sorry Jonathan).

But anyhow, last chat we had there were several things still missing in 
CXL code, both in qemu and the kernel.

Jonathan had suggested opening this thread on the CXL mailing list, so 
we could figure out and enumerate the missing parts in CXL code to 
enable this type of VM migration. I'd like to collect a "TODO" list of 
sorts, and help out with the missing components/features. So if you 
don't mind, I am asking for help from CXL folks to help me identify the 
missing features

Jonathan's talk:
https://lpc.events/event/16/contributions/1248/

Intro to nil-migration
http://nil-migration.org/


--
Peace can only come as a natural consequence
of universal enlightenment -Dr. Nikola Tesla
