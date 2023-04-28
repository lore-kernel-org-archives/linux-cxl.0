Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F9F9C77B60
	for <linux-cxl@archiver.kernel.org>; Fri, 28 Apr 2023 17:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346225AbjD1Ru5 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 28 Apr 2023 13:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346201AbjD1Ru4 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 28 Apr 2023 13:50:56 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00EE3F5
        for <linux-cxl@vger.kernel.org>; Fri, 28 Apr 2023 10:50:54 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 6F0E2501C9D;
        Fri, 28 Apr 2023 17:50:53 +0000 (UTC)
Received: from pdx1-sub0-mail-a209.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id DA8EE501834;
        Fri, 28 Apr 2023 17:50:52 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1682704253; a=rsa-sha256;
        cv=none;
        b=w+G+37qvcxTRp37ZVATiThSrkULBHOXbz7n9B+4hA580pwBMH5wFA8/nzBd6+EuIggYxiB
        E0vvUhnFvo8cvYymcxCczP5rjZOX+/Z88sZyL4wETkOTyL+JrS58xJjyYdaj+s2SFad2dI
        lkhkYywveuEsd9aqTlrPY467Y6DQBRH80Fh/B9+2GFVLCMctVDsXpFMpDZiNeB+dFtzSa+
        YFz6apzTQBYAocpHQ0ypV4eMevm2tavBVRx6oOVMJTWK93X5gZQlJ/Esj99uH8ZEu7mUds
        VQIQyEbB1S+UZHguwRKNs/WzqEriPtHrUbJ6z8J2oUvTrZQ8QRMzcMjxxkyFJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1682704253;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=cEnnmH2CAM7+LWgvn6C4ClJLr+h9K1S/9YV3IYSUPdw=;
        b=MWeiyP7u9qD2elKFIVB7/lO049T8JbGcoEpxLnxfcR4qBILO7FCDA1KJDF00sECaQKyQpW
        Cxz2PDHG1flYtpj+vnPq4T60LZSet9wXl8sAgz8qcxt5tXrPS1Fk6t8/j3zslusrWJJ7bE
        CbhcgkvNM6eodRFWFYKB7JofVvz2OUrEu6mHF2dKnyJJm7gxk4M7Ung04R1E2sk3jd+edo
        /Ktr7O3U7mOZemOXaYTGQEZcvrdSDLlgndnLG1tNubRhiDhaN60F8zoZmkjiZmXQYaJqpi
        JpcVIvHYUSo9K9Ng+N7ZRMLdAZbaAu3b6C4Kg3Bs+c2PBF1HQZ6cd7hC1vys0A==
ARC-Authentication-Results: i=1;
        rspamd-548d6c8f77-nq998;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Reaction-Callous: 013e63dd2fe469bd_1682704253202_3587849935
X-MC-Loop-Signature: 1682704253202:1997280229
X-MC-Ingress-Time: 1682704253202
Received: from pdx1-sub0-mail-a209.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.102.66.27 (trex/6.7.2);
        Fri, 28 Apr 2023 17:50:53 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a209.dreamhost.com (Postfix) with ESMTPSA id 4Q7Ks818Ynz6c;
        Fri, 28 Apr 2023 10:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1682704252;
        bh=cEnnmH2CAM7+LWgvn6C4ClJLr+h9K1S/9YV3IYSUPdw=;
        h=Date:From:To:Cc:Subject:Content-Type:Content-Transfer-Encoding;
        b=iMs/DrhkZcKdqiRCmvSg6SiQugoiHdvOBfEz3iHGa+NWpyTRummnrSCxjy6rnHDf4
         DRSqPvJe45MN9WjtqeEj0tSCkLGV/XJbvmvT9VuWj/9ths9H3kLthzQmBPISbZSGCd
         c0QtLNxLkMUFQB/nW4IIo08YpzgMnXwaSBuf0y2TP78EqZvhHI9md7EN0UlAW/kwnE
         ECi9AohRFsMwDmhhePmTT3fuC2QFvpIOvj8YkyI69TmNY/IDTBBHBg9XYgCTQlx9Tl
         Xaukzr8s6vkifTHijbJ9M9v+vSxJdSKzS/OLMtuG0A/odCfpGyt8fdyAt0yS1lqUGj
         3s6uMPwSFiiPg==
Date:   Fri, 28 Apr 2023 10:18:52 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dan.j.williams@intel.com, Jonathan.Cameron@huawei.com,
        alison.schofield@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, fan.ni@samsung.com,
        a.manzanares@samsung.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 2/7] cxl/mbox: Add background cmd handling machinery
Message-ID: <lq33scjudy22a7xpa7vrefhfk6uolzy6wvq4wimwvwg4emeo53@aa6n2n5up3gh>
References: <20230421092321.12741-1-dave@stgolabs.net>
 <20230421092321.12741-3-dave@stgolabs.net>
 <cb80b111-c639-aaff-f8dd-8ceacf124b1a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <cb80b111-c639-aaff-f8dd-8ceacf124b1a@intel.com>
User-Agent: NeoMutt/20230407
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 28 Apr 2023, Dave Jiang wrote:

>>+static DECLARE_WAIT_QUEUE_HEAD(mbox_wait);
>
>I apologize if I've asked this before and you've already answered.
>What is the reason the mbox_wait a module global wq instead of a per
>device wq? Just thinking when you tear down a device, you may want to
>wake all pending for that device to clean up.

Yes, I agree that doing the wait per-device is better, and not only
for tear down reasons. By doing it globally, the queue reflects waits
=66rom different devices, but the driver really has no control about
the order of the wait of each device is, so upon a blind wake_up(),
it could perfectly well be that the first node in the waitq is not
the node for that device.

This all goes away with per-device, with the note that because of the
mbox_mutex there never will only ever be a single waiter, so no concept
of a queue really.

Thanks,
Davidlohr
