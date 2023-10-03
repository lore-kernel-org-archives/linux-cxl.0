Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27360E7AD77
	for <linux-cxl@archiver.kernel.org>; Tue,  3 Oct 2023 17:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbjJCRk2 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 3 Oct 2023 13:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjJCRk2 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 3 Oct 2023 13:40:28 -0400
Received: from crane.ash.relay.mailchannels.net (crane.ash.relay.mailchannels.net [23.83.222.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78182A6
        for <linux-cxl@vger.kernel.org>; Tue,  3 Oct 2023 10:40:19 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id AE48D4C2805;
        Tue,  3 Oct 2023 17:40:15 +0000 (UTC)
Received: from pdx1-sub0-mail-a210.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 089D34C2E51;
        Tue,  3 Oct 2023 17:40:15 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1696354815; a=rsa-sha256;
        cv=none;
        b=Q6vfRKxLsCzLc1SxJUoxZs5jTf+60DPQupvSS6Xj24THnZHeRT65aqOI+RtI4H0TzX+NRQ
        C0bdkvX8dX9NzaE7kOd9CPt9xdwmH1z/jS0/S9UaaFEAkuTifJQ/CG1xH7u32ssevGvh+V
        0juoN1eBT3k/OFlevYgV0jn75QEc+iiRIUyO9zxTVJZEawk/rCA7msM9MhlnYE/IEyn6HZ
        p/skNoeRvh5KybkoOKCFijA6pqCJGkzj7tOZR6W5+Nqfj8JRE8dILar9DcJiVq5SjtRfJH
        BJTZMQ8jT2OXWHDUjrCnPM6dxCZBXtR9ezDxR9ViNzr41jjcbqqGZMOExhk3uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1696354815;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=aPw5lIR70AMawRF3JtAYBAN94XPTnWt97skPBxymU58=;
        b=D3xAKSlCR4fDTxYemTRhNEtiXD8VZKAdnvvAy+VN6e+Bdh6SAYFs/BWSLkTbtDvPIAvYOy
        gw5t8cdoQ1JZvk7FmbcpWROGKAvYIJHQRSiU3RGremC9hECAhRR5GErSCPm4dUW0WRsusw
        /Gihgn9Yi6jPC3Ruh4JOFvOk85dq2pwQR0FC3KNkv4gHDZ8z2w6l0BOULbElXGxZEGeRyW
        B8jOd5qXMINKij4K8uwUPnLhtnCyPfF6CrBPw+S4kx7A9AO1eRjUQb30NcnEkWm4uTVua4
        7FCELJbvmS0F1LFusKcyI9IrSJKk/BE9nXMX5osOXQGxcxm4ObK0FpZ/PoWD0w==
ARC-Authentication-Results: i=1;
        rspamd-7c449d4847-6dlvz;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Spicy-Cellar: 5773f8fd7a8bdc94_1696354815535_213324791
X-MC-Loop-Signature: 1696354815535:621290474
X-MC-Ingress-Time: 1696354815534
Received: from pdx1-sub0-mail-a210.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.104.112.135 (trex/6.9.1);
        Tue, 03 Oct 2023 17:40:15 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a210.dreamhost.com (Postfix) with ESMTPSA id 4S0Q7y4TYJzWP;
        Tue,  3 Oct 2023 10:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1696354814;
        bh=aPw5lIR70AMawRF3JtAYBAN94XPTnWt97skPBxymU58=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=PcEn/PIMglmWbtUg/k5fws2vrH5fXhyP10eM4wCmY/lAhdqqo2aRVGVwKgs7msVtF
         3AMlWULwg9EM9ckOLQO7bp9GSMv4psPgQMY7xaqF+j4W27vIqkuWnngKAhV1XVNHzN
         Nv9iX2I5R6ii2Shf1NZWjG+yE/L6+q6GACMaBITvfsDpZoKFG38Awgc2Z+pZvaCfat
         XCl7cGJB3j4X0BclHqRsCA469ASOduHJlcPH7Hh0doYKpw3eGaJC1RNbEm+sdnzXh0
         Q5oR/LFVS5OGeBmARDRWRkwwvpwlz0RsLtGPjDCTZUgC1ZpoHye35L8qB3fj8JiQ8a
         tdLX02Kw6onzg==
Date:   Tue, 3 Oct 2023 10:40:11 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH v2 4/4] cxl/mem: Fix shutdown order
Message-ID: <agfhiujmhd7ru53byxtadglrloegf7kme25p4jhpq77s36veid@mj36iv5mpad4>
References: <169602896768.904193.11292185494339980455.stgit@dwillia2-xfh.jf.intel.com>
 <169602898991.904193.3059334392093961032.stgit@dwillia2-xfh.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <169602898991.904193.3059334392093961032.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: NeoMutt/20230517
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 29 Sep 2023, Dan Williams wrote:

>Ira reports that removing cxl_mock_mem causes a crash with the following
>trace:
>
> BUG: kernel NULL pointer dereference, address: 0000000000000044
> [..]
> RIP: 0010:cxl_region_decode_reset+0x7f/0x180 [cxl_core]
> [..]
> Call Trace:
>  <TASK>
>  cxl_region_detach+0xe8/0x210 [cxl_core]
>  cxl_decoder_kill_region+0x27/0x40 [cxl_core]
>  cxld_unregister+0x29/0x40 [cxl_core]
>  devres_release_all+0xb8/0x110
>  device_unbind_cleanup+0xe/0x70
>  device_release_driver_internal+0x1d2/0x210
>  bus_remove_device+0xd7/0x150
>  device_del+0x155/0x3e0
>  device_unregister+0x13/0x60
>  devm_release_action+0x4d/0x90
>  ? __pfx_unregister_port+0x10/0x10 [cxl_core]
>  delete_endpoint+0x121/0x130 [cxl_core]
>  devres_release_all+0xb8/0x110
>  device_unbind_cleanup+0xe/0x70
>  device_release_driver_internal+0x1d2/0x210
>  bus_remove_device+0xd7/0x150
>  device_del+0x155/0x3e0
>  ? lock_release+0x142/0x290
>  cdev_device_del+0x15/0x50
>  cxl_memdev_unregister+0x54/0x70 [cxl_core]
>
>This crash is due to the clearing out the cxl_memdev's driver context
>(@cxlds) before the subsystem is done with it. This is ultimately due to
>the region(s), that this memdev is a member, being torn down and expecting
>to be able to de-reference @cxlds, like here:
>
>static int cxl_region_decode_reset(struct cxl_region *cxlr, int count)
>...
>                if (cxlds->rcd)
>                        goto endpoint_reset;
>...
>
>Fix it by keeping the driver context valid until memdev-device
>unregistration, and subsequently the entire stack of related
>dependencies, unwinds.
>
>Fixes: 9cc238c7a526 ("cxl/pci: Introduce cdevm_file_operations")
>Reported-by: Ira Weiny <ira.weiny@intel.com>
>Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
