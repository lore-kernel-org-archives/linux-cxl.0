Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55CD8E8FDC3
	for <linux-cxl@archiver.kernel.org>; Wed,  4 Oct 2023 01:13:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232316AbjJDBNb (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 3 Oct 2023 21:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbjJDBNb (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 3 Oct 2023 21:13:31 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F66AB
        for <linux-cxl@vger.kernel.org>; Tue,  3 Oct 2023 18:13:27 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 79C6481C60;
        Wed,  4 Oct 2023 01:13:27 +0000 (UTC)
Received: from pdx1-sub0-mail-a210.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id F2EAA81A89;
        Wed,  4 Oct 2023 01:13:26 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1696382007; a=rsa-sha256;
        cv=none;
        b=tVLwn1G2jnQ9o21Hvjnowr1pPCC5bu98Mh6PAqiF0kocGfkFRATCsxjGEt8GHVbZrh9qwN
        cN1PPMlTsCFGYxPRn+q66TuCkhrH54RYk9VmnYhZDXRTlMFgzF9yES5gA7nsGZKCxLDdG4
        D1F+msjzaBPigdiWPDod+JJOxtk9D8bRjF7wNw+QJo8nXI5/dmA9EUEftAvYuHO2qZGFdk
        PM48I8JjO/O64xWsGRJ1aq5MpciSpWciTYEi9toXMr+mveXEFnryrZg2Avihwi189rEt3/
        TOlxyaYRuUvA+j3BC9MNHV9toEmGa+dUK8PQL92dYqwmBg3qfp6HJTjp7CH6GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1696382007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=WrsP/HpUs1ommhRepoh0GftVa17ZvJZ2Mj3b7rAm1SA=;
        b=X5cM+FeVS0tiiqgrF11LHUvrKCjIJgvwqFuMbIDj9/GHKFQAr4VeAgJDjVxF8LUlYtBgS1
        XanhC6qwT66mfLN79KsbGnU3fRdzRYFbv0uu1LRdCqPwwe4FqrvtzOUgZKctnBAVdHSPfb
        mFa3z4SRubnUHKPEPx/IFWlasyj0pSXmYM4OAYtjUvkhJ7MlwqmPCQK6aBkF9WRCX+yypT
        9EVOsWwTkyuIpnP33SNJSZFp+DO3mk+gwHNt1+m1eVHKYh1a2d7ZA4L9Z7VArMaccV8hK9
        fPf7JhLH7iceIPBktmrefgXQj+UAVW1CQfkTLNrJ1XxjN7hyT5+/CAH0HpxWcw==
ARC-Authentication-Results: i=1;
        rspamd-7d5dc8fd68-wtc42;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Wide-Eyed-Sponge: 2c5e82072794f6bf_1696382007269_3056228352
X-MC-Loop-Signature: 1696382007269:1779616179
X-MC-Ingress-Time: 1696382007268
Received: from pdx1-sub0-mail-a210.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.120.41.146 (trex/6.9.1);
        Wed, 04 Oct 2023 01:13:27 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a210.dreamhost.com (Postfix) with ESMTPSA id 4S0cBt46z2z76;
        Tue,  3 Oct 2023 18:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1696382006;
        bh=WrsP/HpUs1ommhRepoh0GftVa17ZvJZ2Mj3b7rAm1SA=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=CChMwxv7Sy1gLTqSy8S8i4YJa8/OcRfPkEtP878UyWBV1V8EVxl6JvPYZGGlcfAlD
         AB267wEj7V/Y7S9yJ045LhWJZMiHGdwEE3H7C1CxVsuRdbapljTKTA4JhYRjzwo3xV
         WMYKPS8pio3cojmGzrN1MaSqjepOgcSMIHI3kylmXNuSeYsQcDFHih8TmKXAucsQZa
         3BW/tkG3Yqh/pwYkkXmwiPIxnSJXJHr8TkH54qa6eATYtplh9yFQEVwztzBOiU3Rre
         lxZCwD3MpQ7NfESLIWl1I01U6v+JoPmup9dgn8Rshw5eS9jn0boZHpOmAFK4I7gxoJ
         dplJuMfbQHLUw==
Date:   Tue, 3 Oct 2023 18:13:23 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, ira.weiny@intel.com
Subject: Re: [PATCH v2 2/4] cxl/pci: Cleanup 'sanitize' to always poll
Message-ID: <6egif53ircc3t3qvb6xfraadmx4h7l4ajwnxrnrnfr6k2kq3y3@zzochkls6mcr>
References: <169602896768.904193.11292185494339980455.stgit@dwillia2-xfh.jf.intel.com>
 <169602897906.904193.9057960720070253436.stgit@dwillia2-xfh.jf.intel.com>
 <xqouql3fxo5zyyjqjoxn5g7nmupwh6qei7opsb6cymcvb5a3ou@gg5z2ebxeq7t>
 <651cb95aa1af5_ae7e729438@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <651cb95aa1af5_ae7e729438@dwillia2-xfh.jf.intel.com.notmuch>
User-Agent: NeoMutt/20230517
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 03 Oct 2023, Dan Williams wrote:

>Davidlohr Bueso wrote:
>> On Fri, 29 Sep 2023, Dan Williams wrote:
>>
>> >In preparation for fixing the init/teardown of the 'sanitize' workqueue
>> >and sysfs notification mechanism, arrange for cxl_mbox_sanitize_work()
>> >to be the single location where the sysfs attribute is notified. With
>> >that change there is no distinction between polled mode and interrupt
>> >mode. All the interrupt does is accelerate the polling interval.
>> >
>> >The change to check for "mds->security.sanitize_node" under the lock is
>> >there to ensure that the interrupt, the work routine and the
>> >setup/teardown code can all have a consistent view of the registered
>> >notifier and the workqueue state. I.e. the expectation is that the
>> >interrupt is live past the point that the sanitize sysfs attribute is
>> >published, and it may race teardown, so it must be consulted under a
>> >lock.
>>
>> That makes sense, but this is currently under hardirq, so we'd need the
>> threaded flavor instead to take the mutex.
>
>Yes I missed that, will fix.

With the following this seem to be running just fine along with locking
debugging on (just need to confirm that the sysfs notification works with
polling in userspace upon completion).

root@cxl:/sys/bus/cxl/devices/mem0# cat security/state
disabled
root@cxl:/sys/bus/cxl/devices/mem0# echo 1 > security/sanitize
[   77.641857] cxl_pci:__cxl_pci_mbox_send_cmd:297: cxl_pci 0000:0d:00.0: Sending command: 0x4500
[   77.648236] cxl_pci:cxl_pci_mbox_wait_for_doorbell:72: cxl_pci 0000:0d:00.0: Doorbell wait took 0ms
[   77.656379] cxl_pci:__cxl_pci_mbox_send_cmd:297: cxl_pci 0000:0d:00.0: Sending command: 0x4400
[   77.662616] cxl_pci:cxl_pci_mbox_wait_for_doorbell:72: cxl_pci 0000:0d:00.0: Doorbell wait took 0ms
[   77.669227] cxl_pci:__cxl_pci_mbox_send_cmd:343: cxl_pci 0000:0d:00.0: Sanitization operation started
root@cxl:/sys/bus/cxl/devices/mem0# cat security/state
sanitize
root@cxl:/sys/bus/cxl/devices/mem0# echo 1 > security/sanitize
[   81.705796] cxl_pci 0000:0d:00.0: Failed to get security state : -16 -bash: echo: write error: Device or resource busy
[   85.761560] cxl_pci:cxl_mbox_sanitize_work:158: cxl_pci 0000:0d:00.0: Sanitization operation ended


----
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index b0023e479315..b8f69ce883be 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -187,7 +187,7 @@ static int cxl_sanitize_setup_notifier(struct cxl_memdev *cxlmd)
  {
	struct cxl_dev_state *cxlds = cxlmd->cxlds;
	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
-	struct device *dev = cxlds->dev;
+	struct device *dev = &cxlmd->dev;
	struct kernfs_node *sec;

	if (!test_bit(CXL_SEC_ENABLED_SANITIZE, mds->security.enabled_cmds))
@@ -483,7 +483,7 @@ static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds)
	if (irq < 0)
		return 0;

-	if (cxl_request_irq(cxlds, irq, cxl_pci_mbox_irq, NULL))
+	if (cxl_request_irq(cxlds, irq, NULL, cxl_pci_mbox_irq))
		return 0;

	dev_dbg(cxlds->dev, "Mailbox interrupts enabled\n");
