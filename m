Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C01C4332F
	for <linux-cxl@archiver.kernel.org>; Thu, 13 Oct 2022 01:12:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiJMBMZ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 12 Oct 2022 21:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbiJMBMK (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 12 Oct 2022 21:12:10 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D31FAA7F
        for <linux-cxl@vger.kernel.org>; Wed, 12 Oct 2022 18:10:49 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id A366F5C1766;
        Thu, 13 Oct 2022 01:09:51 +0000 (UTC)
Received: from pdx1-sub0-mail-a209.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 2E8E65C1978;
        Thu, 13 Oct 2022 01:09:51 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1665623391; a=rsa-sha256;
        cv=none;
        b=4/DTGBxse1KVav9cQC0+OGpxERsO2O9dyGH3SxsDv3S2qFAs7Lwrnn1ud7qcs7aordULlr
        evjvKTyaDDOZOo+jR5HeyCUXzRIzsUEcP1vFoZjn3HoLS5UUFJ692zRQdfRiuZI3/Tx2O4
        sOkdah6cSAutdWVMC2qkoYoBP+MftozU2vsyJg5oe4VdHr097etwQHZo7C1zlDQtMWqS/x
        u+X5eUlPMld/82CAw/LZElZUWzV0viW6DuqIaB9Q8cortdlYBtmXOGA7gNj0dJCt41LtJh
        674P8Bif42v/m3N6UmDDBjJDLR3cFMu2/L6AA7VaphQGZ9ytm8DlC7MmSppb8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1665623391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=uqcF94aCLHheri9nBI63EHiSFuJlEDwjRIjqtnzDPz8=;
        b=kJMFyhZkzSenG30laIXptqHAhlrQzgQrRs7mihIU9BS08Mp3TM7IfXrjIU0EyJhPTirGkP
        krBmc9mF+wqp7bmHgPY/lLJDDt5sUupMbkGUDTu+YaEt12zckv9nzi6i7lSIFRnyvovd8s
        tGbd2HS4rth8gxY64mrBlocS4gqGbHffJEq1IYyPkpREWQNx2EGlXN0Ko+NOJRCLQcHefS
        5+PKEZ8uQQfIiwsB0HVqFKCDkv5H8IoyYWWX3zDkg9jszvupteDwo2C85N0HEjVbkEJCYB
        WZ592puASUKhPnsYGXAOB0so8akned9Am5uGW3y1vmbuWLUFDAzOQBalFWY4vg==
ARC-Authentication-Results: i=1;
        rspamd-7c485dd8cf-p6dxs;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Befitting-Inform: 15d4b40c3813b8d0_1665623391469_3496832369
X-MC-Loop-Signature: 1665623391468:2071551074
X-MC-Ingress-Time: 1665623391468
Received: from pdx1-sub0-mail-a209.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.116.63.144 (trex/6.7.1);
        Thu, 13 Oct 2022 01:09:51 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a209.dreamhost.com (Postfix) with ESMTPSA id 4Mnrz23xxQz4f;
        Wed, 12 Oct 2022 18:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1665623390;
        bh=uqcF94aCLHheri9nBI63EHiSFuJlEDwjRIjqtnzDPz8=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=dwnaHvNDP/LaqiyF88d9LMJLruDmEandq/Z5ipQh7yA2q2vfHudSxG0l1eNcxAxpw
         xqdqK/hqmW5g549fCX3vKUVRtEfcbWn5rp+h08vxOjebbGHr8mmW8cE+lZy1i1ZuMp
         noRhpMu0MNJ0+FlaurguenGJ2sSFusdUW2tvxGqUCSLp/IuxaEwVviBCemYpqMqCjK
         VnxmVPNFC6S/ZNcLo0r8dBcuGC7SIvWfbJq9jfLxcsgt76Kv8nGmDkzvQ07hH5xrYY
         0PzM5bGfT0VBVqJpxd8z0StdDzyaD8g9YPnFUkFjBuYQuNVviZif1vzBVtG9RTCVmI
         y01fsc3pf0VYg==
Date:   Wed, 12 Oct 2022 17:48:57 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com
Subject: Re: [PATCH] cxl: update var names for interleave granularity
 conversion macros
Message-ID: <20221013004857.narsyyyhjepxkobt@offworld>
References: <166552460832.1940763.12713460501172006832.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <166552460832.1940763.12713460501172006832.stgit@djiang5-desk3.ch.intel.com>
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 11 Oct 2022, Dave Jiang wrote:

>Change var names for granularity macros to clearly indicate which
>variable is encoded and which is the actual granularity.
>
>ig == interleave granularity
>enig == encoded interleave granularity
>
>Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
