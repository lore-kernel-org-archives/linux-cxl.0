Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 552C6C433EF
	for <linux-cxl@archiver.kernel.org>; Fri, 15 Jul 2022 21:45:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbiGOVpj (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 15 Jul 2022 17:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiGOVph (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 15 Jul 2022 17:45:37 -0400
Received: from crane.ash.relay.mailchannels.net (crane.ash.relay.mailchannels.net [23.83.222.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3924228E0C
        for <linux-cxl@vger.kernel.org>; Fri, 15 Jul 2022 14:45:33 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id B720B8024FA;
        Fri, 15 Jul 2022 21:45:28 +0000 (UTC)
Received: from pdx1-sub0-mail-a220.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 69D0480229D;
        Fri, 15 Jul 2022 21:45:28 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1657921528; a=rsa-sha256;
        cv=none;
        b=7sXL5SLaeCuDFyejIaSteZjLbwXH14gvySMgdsxb93hoo5U0VqsPpk4vGas433B1M2Gm2J
        al/kloHxO34PD59mWqdga9OuxuHAjyiA3V24qB/mD68twwRN5M4YUEAk2+zBVW+ggJDvEc
        rzvqEo8jJtr9zvSX4kJmmmos/QW35tWjZuoIFzEhgU9SNATZFTRW3HuBgYB78vz0iySR/5
        TVeSHmJPoOHu8o0WSjRj0KibV5FWBR9lYyqHhoQutAn//GEikYzNuj2IrDgqt+0AvoJMyw
        ok9oBgJcqyW9zXSwpX0WSxxR+0BOXIaL6yxRSYfKpAdttsHoa7gM1cKrikrbXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1657921528;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=WF7C0cUBKUw1YYlFEE5qqWdjciIJtgJTSiKieCZzeqM=;
        b=QIsTjRz3avSWHsmvvsh//2LDOI/5de+wnZjOR+v7hHxlIF1ZpGlvU231my0soJx7QKr5z5
        mmnhz7joXQNTnVTRYSMpO+K96TMolbsGG9Aqm/O6UBQoCvk03ck5nlHf+ErypVHpqEQTje
        FIB9Hx8xsl8omgb6/V8B4wz5KjevQD7lxlm8KbSUPaYJCWGIhdnbPehyrDC5ZKpCzc37xs
        l2HD4a6SnP1BvJdhl4FapE/U9dodlpB6RrG+PgqSYn/FPSAXuF6LM1Y0o3M8EKBUH23p3j
        x8x6oMfhABl0bQz5iJxzgWakNjcaRTqYqw9i3L6MfPdqVLQUXbHiOoHqX/TMiA==
ARC-Authentication-Results: i=1;
        rspamd-674ffb986c-lzblc;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Shoe-Dime: 578881220af2da91_1657921528573_685784994
X-MC-Loop-Signature: 1657921528573:70460541
X-MC-Ingress-Time: 1657921528573
Received: from pdx1-sub0-mail-a220.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.112.55.242 (trex/6.7.1);
        Fri, 15 Jul 2022 21:45:28 +0000
Received: from offworld (unknown [104.36.25.13])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a220.dreamhost.com (Postfix) with ESMTPSA id 4Ll4fG1DZHz9g;
        Fri, 15 Jul 2022 14:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1657921526;
        bh=WF7C0cUBKUw1YYlFEE5qqWdjciIJtgJTSiKieCZzeqM=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=TLCMmKAqZRogGH7+Cs9sFp2louIA0+kK2XpuET0SlaXaI6oP2snsm0kImN3yh+QF/
         TIlJbiU1Y2ohLtWwrYQ8J4uurMI9NE6tuyewwXBK0Tfv4QNifgpSt94E0glZbes5uW
         CQpw7qSJN+7so+I2BdbuL8Z94Jr7Ud29uSaY6xsL2K3rbUeUV79RuwRvGavx6r8iCs
         Otqg5IxW40tIBPMHnLaClnz/IUSqhCHS/m6a+WS0SaLs8/AatHXKDgXIvsqQAD9qN1
         5sUDaN9Sn8J3GtGFFZCgjQxJmZLK23pRMd7DiTGcHspgJ2xk4PW6gqPIL6UWfGNYkz
         7CgM1IggyNBzg==
Date:   Fri, 15 Jul 2022 14:29:33 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
        dan.j.williams@intel.com, bwidawsk@kernel.org, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com
Subject: Re: [PATCH RFC 00/15] Introduce security commands for CXL pmem device
Message-ID: <20220715212933.yhg32x6vdlnpipas@offworld>
References: <165791918718.2491387.4203738301057301285.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <165791918718.2491387.4203738301057301285.stgit@djiang5-desk3.ch.intel.com>
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 15 Jul 2022, Dave Jiang wrote:

>This series is seeking comments on the implementation. It has not been fully
>tested yet.

Sorry if this is already somewhere, but how exactly does one test the mock device?
