Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1113E748E9
	for <linux-cxl@archiver.kernel.org>; Mon,  2 Oct 2023 15:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238274AbjJBPzg (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 2 Oct 2023 11:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238269AbjJBPzf (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 2 Oct 2023 11:55:35 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1148BD
        for <linux-cxl@vger.kernel.org>; Mon,  2 Oct 2023 08:55:32 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id AB72CC1F9E;
        Mon,  2 Oct 2023 15:49:47 +0000 (UTC)
Received: from pdx1-sub0-mail-a294.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 370D9C1CC1;
        Mon,  2 Oct 2023 15:49:47 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1696261787; a=rsa-sha256;
        cv=none;
        b=Knm8AY00uUm4d2Vo987xRInxc7MpZwsD18irOpknFIjMHnrPM7arxI7ETtbeZat02y+0it
        F4I8Nd0aOHoW2hr7VZNDbZG9ihbwO2HREIXU8YH/wFIiranDK2oB0ZPL705d/xpwajpaXH
        XpQqNKG95GXdmq0xU07xTTeOt2Za+btmCi/SiOrxz0NzkQF0upZyBCsdq1UqqTf5LT9vEf
        kUNe5/7mmFcqyZrUXocRRPIvkytt2mwd7rmnWR/acW4WsS72i5yZDkAra39+xveGH6FRKM
        aZX985u5ZL4GZYYx1LfdwJraUx8uaEkZB+qgOdLi9MBcyARZ4iL8x1Ho60hxrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1696261787;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=j5qT5m3XDOuyV0HIcfg2JacnkVWddUz1SShpaJFxsWw=;
        b=9/TiOr0DgzKN918lZ2ys12UMP4FwHuWadIosvYNF0MO+X8nOkpwzQDBN/BY9aT2yx8ygsY
        PuQ3hu/rmYcd33PlYWvnMjEDFM6XJO9dIKwRRCNOBOPFmxdVrUjFN7kXNmlBd77WKSTNE+
        0HF212E1sArLxGmOuZrueLiWxbU2FwmmrwKb+I84hx32zEvKvu0XHOo2c8+WcDlrX6qX6l
        mwsi1H1kvepuLLTUIAfl/KFoqhB0885zp3HhOw1yyzhTB9IJcxzCExE1qhN2G9mxBS3aia
        y8TGq0Fy2RlSYciYq4yUaF53dT1Esj25y7pb+uQ4V/TPycpiX0xAw5ZtayqzCw==
ARC-Authentication-Results: i=1;
        rspamd-7d5dc8fd68-7jvhx;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Shelf-Towering: 04fced7c2089358e_1696261787485_144509975
X-MC-Loop-Signature: 1696261787485:507935012
X-MC-Ingress-Time: 1696261787485
Received: from pdx1-sub0-mail-a294.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.109.140.241 (trex/6.9.1);
        Mon, 02 Oct 2023 15:49:47 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a294.dreamhost.com (Postfix) with ESMTPSA id 4Rzlky56XFz6b;
        Mon,  2 Oct 2023 08:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1696261786;
        bh=j5qT5m3XDOuyV0HIcfg2JacnkVWddUz1SShpaJFxsWw=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=PFBlmp5HODNIU97CZpZ62LL6vwCiaSuy6YYKnOctODOVamW5DE8+6xVV/d5NG53YT
         0R5dNHYXrRexWZrSnEDBLggsycjlveDYMEbbwbWHrkWSMx54n7iJGRMQpowl8FSEDq
         dAwgbBXIDeB+VDA/thCpKqLdtHjKbLdfAx/whLa6f8SpMi8VtcOgEL3rNxgpJRT3ez
         Te27HKBy4ZQj4v80BS7pAaSkAJG/EvsJsCvrPPS5stD4URR8oEAIxhCZG+scGbDXO8
         ylaVS/ji+XLq1iJShAqfyVSntc9b1/EpgUUQ1Jq3sEm3ovdvEr08+JYJaoWP9t/aT8
         fMF0tS2xLoZ1w==
Date:   Mon, 2 Oct 2023 08:49:43 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, ira.weiny@intel.com
Subject: Re: [PATCH v2 2/4] cxl/pci: Cleanup 'sanitize' to always poll
Message-ID: <xqouql3fxo5zyyjqjoxn5g7nmupwh6qei7opsb6cymcvb5a3ou@gg5z2ebxeq7t>
References: <169602896768.904193.11292185494339980455.stgit@dwillia2-xfh.jf.intel.com>
 <169602897906.904193.9057960720070253436.stgit@dwillia2-xfh.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <169602897906.904193.9057960720070253436.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: NeoMutt/20230517
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 29 Sep 2023, Dan Williams wrote:

>In preparation for fixing the init/teardown of the 'sanitize' workqueue
>and sysfs notification mechanism, arrange for cxl_mbox_sanitize_work()
>to be the single location where the sysfs attribute is notified. With
>that change there is no distinction between polled mode and interrupt
>mode. All the interrupt does is accelerate the polling interval.
>
>The change to check for "mds->security.sanitize_node" under the lock is
>there to ensure that the interrupt, the work routine and the
>setup/teardown code can all have a consistent view of the registered
>notifier and the workqueue state. I.e. the expectation is that the
>interrupt is live past the point that the sanitize sysfs attribute is
>published, and it may race teardown, so it must be consulted under a
>lock.

That makes sense, but this is currently under hardirq, so we'd need the
threaded flavor instead to take the mutex.

Thanks,
Davidlohr
