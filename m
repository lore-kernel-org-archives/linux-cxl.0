Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D48BC7EE30
	for <linux-cxl@archiver.kernel.org>; Tue, 28 Feb 2023 20:50:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjB1Uuu (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 28 Feb 2023 15:50:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjB1Uuu (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 28 Feb 2023 15:50:50 -0500
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005844680
        for <linux-cxl@vger.kernel.org>; Tue, 28 Feb 2023 12:50:48 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 3F6077611C5;
        Tue, 28 Feb 2023 20:50:48 +0000 (UTC)
Received: from pdx1-sub0-mail-a231.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id C35427612CE;
        Tue, 28 Feb 2023 20:50:47 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1677617447; a=rsa-sha256;
        cv=none;
        b=OnG0r6w8YtxnIfQhAsR9gQVbK01yhyi/29WISAmhJ/Z5TaOJr8qYIv+t3DjKNN8kJbyBi4
        h/KiSma2fTTstKh/fAl5j7K6+yu+1yIqhLT02E3NxSYz9OHJaf4XuQ1cKEQmscUvGsVKbR
        2foP1ws2I4ve+uz7zyjNmHYaQH0l019ZEurzIBUxHWURGx0m7X6EF0ePq26O9zCCc2vQCn
        fGZhW3Qd3yP8uOdjC5tB7i/ZQVt3noDsg24xvyzjgH6oV8woYulv1WTGXIHnmp2GViAeLa
        X7FZNUR2p/OPAFKvc/dGLydFPfh4jq75ssZtzO8qm7EYGF8Ae/0T3dhE8VkpGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1677617447;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=zTGFhyIcRc3oF28Liejqsyf39cIJCQygKCRMhjLNIWo=;
        b=cXHd8CIPs7TrHR4IqKeWUvpEKj+Khp/J0E+Tg4ZAPopQk1sLr0DAgUISLe5wtfjG413ZAg
        NkYLgBLdmaHLBujhfAHw0he1mQ69STQCA+YI2tapczjGIsEDjfXVz0Jxnp6Hhm4EaGihaK
        XlQAW8JeD9G6d4X68zgCnqDCHAajOlxSJ9cflya5knGMDSCH+0L+zCc4u8cOj0HA/ZHBbp
        aKlJlBiGc0mp2AAHSkj2lS7E518K9hzW8k2yFRwkWhdX6SnbdzYTdTfJgkdP2BuzlN4/0L
        IYbQi+v1fZpQTF7oshfT6AforJoYUFAu+XZ4yuSsK312Y+Joa6QOdaeDuoBa2w==
ARC-Authentication-Results: i=1;
        rspamd-fd4f5fb8c-lqvb9;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Shoe-Desert: 36e622082742d736_1677617448075_323462457
X-MC-Loop-Signature: 1677617448075:2788358357
X-MC-Ingress-Time: 1677617448075
Received: from pdx1-sub0-mail-a231.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.107.134.65 (trex/6.7.2);
        Tue, 28 Feb 2023 20:50:48 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a231.dreamhost.com (Postfix) with ESMTPSA id 4PR8dz1123z59;
        Tue, 28 Feb 2023 12:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1677617447;
        bh=zTGFhyIcRc3oF28Liejqsyf39cIJCQygKCRMhjLNIWo=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=djt7KLYGGkDkfK7yexL3nyft9DAOYHtDcvN6qwhVEef/R/CDYM/SqtMK0TDAy8xu8
         AKq8Cm4s+UeSF2ZsD3qwvghecSP4HjKRpZ/jHBHvx8elu+tUieuFtS2znkHW10Z5jD
         7aKsE/uLXsTWjTc+uVgLtXreBW5iqfdT8sUTNjNzPD9Nc4+Oq4kpZIqe4hy9eBbcMB
         b3AQKqEtePja6xYEg4kkRKlpUnyAHcHQRvLKJc4UvHp99N7dWRu6o7kyThaASNbw4w
         CxpmLCmnLK3jg+qCWshEzygivQwkgju2Gd4Xobahw2YN+B50uA10G1kCkO8ts0xz9h
         jqQ64P+xp153g==
Date:   Tue, 28 Feb 2023 12:22:05 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dan.j.williams@intel.com, jonathan.cameron@huawei.com,
        ira.weiny@intel.com, fan.ni@samsung.com, a.manzanares@samsung.com,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH 4/7] cxl/mem: Support Sanitation
Message-ID: <20230228202205.hit6u33ptbsb3jw4@offworld>
References: <20230224194652.1990604-1-dave@stgolabs.net>
 <20230224194652.1990604-5-dave@stgolabs.net>
 <7333903c-4ef9-6f1f-9767-e32f228149b3@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <7333903c-4ef9-6f1f-9767-e32f228149b3@intel.com>
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 28 Feb 2023, Dave Jiang wrote:

>On 2/24/23 12:46 PM, Davidlohr Bueso wrote:
>>Implement support for the non-pmem exclusive sanitize (aka overwrite),
>>per CXL specs. This is the baseline for the sanitize-on-release
>>functionality.
>>
>>To properly support this feature, create a 'security/sanitize' sysfs
>>file that when read will list the current pmem security state and
>>when written to, perform the requested operation.
>
>I think this segment needs to be updated? The attrib is write only
>from the code below.

Bleh, indeed both commands need the changelog updated, these are
intended to be write-only.

Thanks,
Davidlohr
