Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 439A7C001DE
	for <linux-cxl@archiver.kernel.org>; Fri, 28 Jul 2023 18:34:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbjG1Seu (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 28 Jul 2023 14:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjG1Set (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 28 Jul 2023 14:34:49 -0400
Received: from crane.ash.relay.mailchannels.net (crane.ash.relay.mailchannels.net [23.83.222.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC152109
        for <linux-cxl@vger.kernel.org>; Fri, 28 Jul 2023 11:34:46 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 9E9EB901009;
        Fri, 28 Jul 2023 18:34:42 +0000 (UTC)
Received: from pdx1-sub0-mail-a310.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 08CC19006F8;
        Fri, 28 Jul 2023 18:34:42 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1690569282; a=rsa-sha256;
        cv=none;
        b=mWVpgy+AEcgQyoAhJnaSjKPkcpADO7ADGa0wL5WCPPHxdf9z5nBMfF0oAMhIt5YmjCGpl8
        RRc0Wxh9bZ5Or66XN3uOEo85mjcTFMzqlcvo2NMDPGXPsxCx1PQ9BETROQt6nyXn/tvJTr
        jnXdx0CAvL1qV2pLU1O+WdMXVtoRnU/rXGy9aySLzqDrF+qw1mHm/ttGQ2Mrs7Mohfe+RJ
        0CTrndL2WukCjN3MOkFdXcuoJdHhOsliiHAPu0FOUNgAUYPOMTZNyJZs2TrK41QoybrWZ/
        6yH7gRfUG7Xu/ObKAZtPsl2zPKs6VBs9AY04jMKTIXxeRfG/BTNpZdxCf7CTyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1690569282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=zQhqYnNjVKe0k9s4o3kynJwqDGuG74yUCz3tFI74E44=;
        b=u5tGlGDVrG/Drd++UNZyL6eT1pJplsLp9ehWpwlJ0mWK2NwYKqUpY33rD18hNE3iqnoMmf
        PiCrt25wdXC8Uzh2EEEoNmfMYYnHzoNwvzMq7d0+UONzK2YHaWQULTH52wW8ovUXRVhikn
        h1GoULEHRbVUCvTyJIQrgX0B0MWtFYmIc78yZTsZ0xGqDlvYPGviFy7wAtl1xjw7GvAEl7
        9VZTkMDHJzVfkAYUcWjbcmOwwLlFawVyXlg1YyXOiVS/SnBLmsMuEgxf0rFgHTrCfIeKfV
        t3ho+Tg3u4oFLlVrYX7eS36VLNYq2YsWR0GeeWTHNI3gx7bXMoiuNp/j9XGNYw==
ARC-Authentication-Results: i=1;
        rspamd-d58c88954-xkpb7;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Power-Continue: 4434431075d5babb_1690569282403_2516542743
X-MC-Loop-Signature: 1690569282403:770043495
X-MC-Ingress-Time: 1690569282402
Received: from pdx1-sub0-mail-a310.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.114.181.249 (trex/6.9.1);
        Fri, 28 Jul 2023 18:34:42 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a310.dreamhost.com (Postfix) with ESMTPSA id 4RCGWj0cB2zLM;
        Fri, 28 Jul 2023 11:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1690569281;
        bh=zQhqYnNjVKe0k9s4o3kynJwqDGuG74yUCz3tFI74E44=;
        h=Date:From:To:Subject:Content-Type;
        b=ZQxUlRAYkK6OLUkdLND/xj9xWupzzWnVYZvPEgLePgZu20kkG++tY93GUFrKroaVu
         ovtqfmtI2YBTchj4DDNji/qMjLlNFb3qe4rPlD2O04kUk5L385X9w0Z/WpGfl90mLC
         uPk95pxOc/Y1sslljBZfLRsxjbU6OWV61un9vN/LTmCq/Fe7KO+9jxwy6a3HgYX1ZW
         AcHoJ4UJPFua1SIrGObUHYjAA77rVfR+NLV8nQE29zXHLiLYW1pxqhC9WqPJi1xX0F
         FUYobqhoMWONCBZCg1w0nZRw9wVhcLbWeWGL2lenuRGjTtWYeP+Fuv19qAeHvZD81e
         6MtHgt7M+rsCA==
Date:   Fri, 28 Jul 2023 10:57:18 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     linux-cxl@vger.kernel.org, linux-mm@kvack.org,
        dan.j.williams@intel.com, a.manzanares@samsung.com,
        Jonathan.Cameron@huawei.com, fan.ni@samsung.com,
        ira.weiny@intel.com, alison.schofield@intel.com,
        dave.jiang@intel.com, vishal.l.verma@intel.com,
        gourry.memverge@gmail.com, terry.bowman@amd.com, rrichter@amd.com,
        viacheslav.dubeyko@bytedance.com, sheshas@marvell.com
Subject: Re: [ANNOUNCE/CFP] CXL Microconference at LPC 2023
Message-ID: <m7qmjtzl5ttg7tt2dn63i3yit6qeg6ap7sk4isuf7hibr4chpd@2lgv47hvwqia>
Mail-Followup-To: linux-cxl@vger.kernel.org, linux-mm@kvack.org, 
        dan.j.williams@intel.com, a.manzanares@samsung.com, Jonathan.Cameron@huawei.com, 
        fan.ni@samsung.com, ira.weiny@intel.com, alison.schofield@intel.com, 
        dave.jiang@intel.com, vishal.l.verma@intel.com, gourry.memverge@gmail.com, 
        terry.bowman@amd.com, rrichter@amd.com, viacheslav.dubeyko@bytedance.com, 
        sheshas@marvell.com
References: <a4c2gx2tnm4ckax7qkx2trnvmqjssfytc45sb2zikuayd2marc@rpsjp4icgsvn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <a4c2gx2tnm4ckax7qkx2trnvmqjssfytc45sb2zikuayd2marc@rpsjp4icgsvn>
User-Agent: NeoMutt/20230517
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 14 Jun 2023, Davidlohr Bueso wrote:

>Suggested topics:
>- Ecosystem & Architectural review
>- Dynamic Capacity Devices
>- Fabric Management
>- QEMU support
>- Security (ie: IDE/SPDM)
>- Managing vendor specificity
>- Type 2 accelerator support (bias flip management)
>- Coherence management of type2/3 memory (back-invalidation)
>- P2P (UIO)
>- RAS (GPF, AER)
>- Hotplug (QoS throttling, policies, daxctl)
>- Hot remove
>- Documentation
>- Memory tiering topics that can relate to cxl (out of scope of MM/performance MCs)
>- Industry and academia use cases
>
>Proposals can be submitted here, by August 6th:
>
>https://lpc.events/event/17/abstracts/

A reminder that submissions are due on or before:

   11:59PM UTC on Sunday, August 6, 2023.

Thanks,
Davidlohr
