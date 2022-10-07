Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F151BC433F5
	for <linux-cxl@archiver.kernel.org>; Fri,  7 Oct 2022 17:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbiJGRhQ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 7 Oct 2022 13:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiJGRhP (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 7 Oct 2022 13:37:15 -0400
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5453F4C61C
        for <linux-cxl@vger.kernel.org>; Fri,  7 Oct 2022 10:37:11 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 1D13F3C2496;
        Fri,  7 Oct 2022 17:31:29 +0000 (UTC)
Received: from pdx1-sub0-mail-a245 (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id DF90A3C19CC;
        Fri,  7 Oct 2022 17:31:19 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1665163880; a=rsa-sha256;
        cv=none;
        b=I08AjRYgKyrYQ4bmcJ9VPP4XIN6YYdL0Q80OofyBN3edHO9obPAfcvhCfGJsuI2cnXeeW8
        0Li/vv6+hTxvYdw4rCZ6v309rPpZxPSd77qXOoiK+UbWxJrQST0IHAtz3eT5EsHHv7VxmM
        Y+Q58gOaAUny7k7zancYpF+cDOPAxO3s78GJmF+UrZrSjXFIgOfuCsCq4oNUESicgV0xMk
        wWAd8GzgW5hs7lcqowgromQG118OKg7HugVMoq+lEjlFvOYa8G4qH1c2fD7GiVJ7X6m0Ad
        C04E2ng8slyh7hKC6uY77aTHYOsZzB8NDvjXy5gCtT1ohVIL9EdaLXPFe6PC3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1665163880;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=M1VoNPvm8hDyM6i1JILLwiOmB5q/v5oDv1dyE4h86VA=;
        b=1DJOArHnHC0hboqOVmUti4GcOPw3hmQRsjso3KHAIWqEBArT9S9ylx/YXpWLQtnur7/xen
        fUzMBQbypODmm5tgr5XjRr/grnG/d8r8daILHS4pvuGE5DgoczChg0DPNRv5OA5IN2yiIm
        G8BMZMacSdmjcEJpwFx368bEoIokgxKRtooyNpF0dMwMffiegfwkplMYtrp9R3XxLB1AhH
        L1CM/FhX+nYoFtqlyAzPn0vH0lQw/nVkEfKarkqC0cLq7uya1EP0SxW9vM7Mu5NhUc246t
        wv1m7S83QVPGyIO1WUhY0qZJfhZ98bFS4OMB0BhNEBrxh2NioA9oNdBrkMi4jA==
ARC-Authentication-Results: i=1;
        rspamd-7c485dd8cf-5v8k9;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Illustrious-Decisive: 28f7c89a2fc2abcb_1665163880328_1267753359
X-MC-Loop-Signature: 1665163880327:2627510934
X-MC-Ingress-Time: 1665163880327
Received: from pdx1-sub0-mail-a245 (pop.dreamhost.com [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.116.63.144 (trex/6.7.1);
        Fri, 07 Oct 2022 17:31:20 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a245 (Postfix) with ESMTPSA id 4Mkb2F1S4mz88;
        Fri,  7 Oct 2022 10:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1665163877;
        bh=M1VoNPvm8hDyM6i1JILLwiOmB5q/v5oDv1dyE4h86VA=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=L7RYe4oMkAoE4CB7QUIwc8VSNOWU1YWp5I+Aqh9oMaBMeC06T8q/j4e/oY77b78mm
         smT4hws7O/LDBazQfbvm1beKnYthghqLygjVASrF7EYgSC2gdPMPsP5+FV9p4DrI/Z
         wQNMi5l6yUhmlQWDy4A7cM4UdZ8yw1iU+5zSKzKvKEWa9a7qJNU11ciHw7zAMFFE9o
         JNJ9FkUDmX2BXbLn1NaILSaVPw9b29CDtv4EL+Pp4pybEi43mmgflLuNNQoGKGfMpa
         GBg8TQqLXgPK5ZYEG+Bt4ouiGGaB5xjZVU3yMXc7q63ta0KMRuJzdjKKvOPBNNiQFK
         XaVsuiOWm0aXA==
Date:   Fri, 7 Oct 2022 10:10:43 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Gregory Price <gourry.memverge@gmail.com>
Cc:     qemu-devel@nongnu.org, jonathan.cameron@huawei.com,
        linux-cxl@vger.kernel.org, alison.schofield@intel.com,
        a.manzanares@samsung.com, bwidawsk@kernel.org,
        Gregory Price <gregory.price@memverge.com>
Subject: Re: [PATCH 1/2] hw/cxl: set cxl-type3 device type to
 PCI_CLASS_MEMORY_CXL
Message-ID: <20221007171043.kpo4q4zc7xy7pvwf@offworld>
References: <20221006233702.18532-1-gregory.price@memverge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20221006233702.18532-1-gregory.price@memverge.com>
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 06 Oct 2022, Gregory Price wrote:

>Current code sets to STORAGE_EXPRESS and then overrides it.

Good catch.

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
