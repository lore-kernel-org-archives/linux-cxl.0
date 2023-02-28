Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C9FC64EC4
	for <linux-cxl@archiver.kernel.org>; Tue, 28 Feb 2023 20:47:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjB1Urc (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 28 Feb 2023 15:47:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjB1Urb (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 28 Feb 2023 15:47:31 -0500
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB69813523
        for <linux-cxl@vger.kernel.org>; Tue, 28 Feb 2023 12:47:30 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 1B95642303;
        Tue, 28 Feb 2023 20:47:30 +0000 (UTC)
Received: from pdx1-sub0-mail-a231.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 923F0423D5;
        Tue, 28 Feb 2023 20:47:29 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1677617249; a=rsa-sha256;
        cv=none;
        b=N7Aost6RNKg/YQRt6M6C2jt7BD8szs9fULuc5sSuoBhMeq8r48P51tvKQuSBTaCFN4AuWA
        6UGR+F7lkOR83P0AEByu9YtBIvqt83jWDZS6ZqowRmr54OUSygUqL2x9YSPlT0Y3bPmCnm
        Vo90cMhNZRa3ExDhvhKWGPZWz0tTqZRalHXvcoCOwaljXZxOzJd9REZA6mRb2+C8qlmBvr
        UTUPGkWJbFysKIUkLu4WPjMYtxpzqJz4XLmEDtC+ZcRtdg4lrxxwJG3cq3LhYSOq6+aqjz
        bUIJFgjPdKaKkV/Ls0gjnhA2rY2ryu7arB7Wo73wBIk1XAJPEdbe4+XzFGQI6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1677617249;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=Vjcz6rUAFhatH45BroaWHidoAasDNWmv7zf/pEMkFOk=;
        b=x0omWhfbUA3Teug+KUxQSanm1+XrNb2+0rjL1xKVuX+E1nbxIn4rM3Kc/ntMxjbmRwLb0+
        bdFmri+u7Hxa7d93K7Tv9uWolCKCgEo3DBhcZ6X/8KpXqsDj5Z8AUGVM3oVeyFSfBeSouB
        h+2UfE+vfnMjGPfkm4sg/ok/Iu0ofoygJ4V19N0E9gTmqOe+7ipQ1Rq5BWJSR1VLbtxoSo
        MgIHIO8TWK7B3x9Rw61vXzDocuhIIhOIgF9/BZ0WZ4f4VNJaQa13bo6y9cbQ6/3ZirVoLY
        ynQXQoEOPi16fUF/QJB2bqTDbi+558ARtr8qURomedsiBS/iQ4ycAIn0tL/kXg==
ARC-Authentication-Results: i=1;
        rspamd-69778c65cd-8wc9d;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Shade-Left: 1ae896c779bdb68c_1677617249884_2778048394
X-MC-Loop-Signature: 1677617249884:2375167776
X-MC-Ingress-Time: 1677617249883
Received: from pdx1-sub0-mail-a231.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.123.200.78 (trex/6.7.2);
        Tue, 28 Feb 2023 20:47:29 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a231.dreamhost.com (Postfix) with ESMTPSA id 4PR8Z86r73z3D;
        Tue, 28 Feb 2023 12:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1677617249;
        bh=Vjcz6rUAFhatH45BroaWHidoAasDNWmv7zf/pEMkFOk=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=DrMsZPKIpNmKUu286kx30RhXE+OToYDLtZ8tXc3nLsJwlLip7IbueaR8VvmsbqglB
         liJSJKcyqfE/qtiyK/wQXk5d2lRjJGKoWl06EojYo5o5kvTTceXpRZFIVINSbcKDxn
         6YoACaUP2vqGurJEA4cy6cLqoaeBFLICELB8wxXAe6iCexyRk8n9NWnG+GF2LQui6I
         In9gyyKB0MH+wWL7qJmVxycdbWvRekh9TQrze7q+Khejii2nf0X2EGFi3OpjPwQtTN
         eOiodVLDxue+4G7T7He8LJ6io8bYVdZpX4Iq/UpgYcYKgF9pg+NqcggO7LvSiMjoey
         9/+ImvG9c9Nuw==
Date:   Tue, 28 Feb 2023 12:18:48 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dan.j.williams@intel.com, jonathan.cameron@huawei.com,
        ira.weiny@intel.com, fan.ni@samsung.com, a.manzanares@samsung.com,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH 1/7] cxl/mbox: Add background cmd handling machinery
Message-ID: <20230228201848.b73ralnihs6rbceg@offworld>
References: <20230224194652.1990604-1-dave@stgolabs.net>
 <20230224194652.1990604-2-dave@stgolabs.net>
 <029b177d-7b91-77f7-a830-5f5ebe3ab0b8@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <029b177d-7b91-77f7-a830-5f5ebe3ab0b8@intel.com>
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 28 Feb 2023, Dave Jiang wrote:
>>+
>>+		dev_dbg(dev, "Mailbox background operation completed\n");
>
>May be helpful to also emit the return_code in case of errors.

Agreed, but that's given next:

>
>>+	}
>>+
>>	if (mbox_cmd->return_code != CXL_MBOX_CMD_RC_SUCCESS) {
>>		dev_dbg(dev, "Mailbox operation had an error: %s\n",
>>			cxl_mbox_cmd_rc2str(mbox_cmd));

here.

Thanks,
Davidlohr
