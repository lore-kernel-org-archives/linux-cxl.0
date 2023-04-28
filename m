Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2495C77B61
	for <linux-cxl@archiver.kernel.org>; Fri, 28 Apr 2023 17:18:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345699AbjD1RSv (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 28 Apr 2023 13:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjD1RSu (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 28 Apr 2023 13:18:50 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3ADD2720
        for <linux-cxl@vger.kernel.org>; Fri, 28 Apr 2023 10:18:48 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id D368654257D;
        Fri, 28 Apr 2023 17:18:47 +0000 (UTC)
Received: from pdx1-sub0-mail-a209.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 16125542650;
        Fri, 28 Apr 2023 17:18:47 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1682702327; a=rsa-sha256;
        cv=none;
        b=o8znjwLauizevdpN/wnOnrldwr1CTkajQQ3c0/GFi7RSTbmk61N8UM5bE8XPY6POsT1qje
        WnaY3XJtzyXG/prLfWH2B/cpKhdh6NoduvXJZ3ccBolWvNXAvuxn7ks2RWdRX8NIhyySgR
        N+jwhaROtVV9F2ZcB30JR/+/qr+uniJw107mSq7NUG6NUYv33TMtGp9XnwpYlZ3wC8Dla5
        duKjSRejC7g9cIPKToInNhcs85Gn2nG2A10uxCwic8t0iwr08d8X2V6CZIRFfK1neBZ9RM
        VdKZCVkJVhJCBLWyEhgLdWJ84euZLJL3eE135/4Tam1OzZM9/ToUroA8VekIPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1682702327;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=FhbLke3YE81T/dyAiPWNSYWZx39eMy6PKJRWOoNiCm4=;
        b=r6FeF4EswKJ9Z7CNm7U0tLR4t2FWfqCqT6e1KiMBN15eOGft1PlKXOZphlPbw8hs5j1qcC
        ATzpzZ8d8RkIKz0mF4ZMVmd38VBEAIsbmTf0T4V5q7PVXELXdRg3i6/Ae6whGkwSRfvSRb
        EAkq1UKY7UAMgWUxsfqicFgRuFSLPnIxyenOKUeUi+sVznHtUMRjT0PkR6Piykednt8Qzz
        5HpLwNYhyylG9GtDsOhSP8JssGtoITpoNJQ91YtgjEilxrvhIBInwnLf7DlIEicFaSf8nL
        3vQ9by6mW2kFwIWaPgRIvrNT+I+1jrMX97b3tKWCCaB4dGUV8WvcGL7PT8Jiew==
ARC-Authentication-Results: i=1;
        rspamd-7f66b7b68c-v7wvb;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Desert-Zesty: 2e6b8ebc3ea90136_1682702327615_2232166789
X-MC-Loop-Signature: 1682702327615:2002994278
X-MC-Ingress-Time: 1682702327614
Received: from pdx1-sub0-mail-a209.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.109.138.52 (trex/6.7.2);
        Fri, 28 Apr 2023 17:18:47 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a209.dreamhost.com (Postfix) with ESMTPSA id 4Q7K8629B6z6c;
        Fri, 28 Apr 2023 10:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1682702326;
        bh=FhbLke3YE81T/dyAiPWNSYWZx39eMy6PKJRWOoNiCm4=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=mUhT2LfdmubmQ4KKlHFseOgpomjqeoH/G1qG16hhQw97tE+R2S3SgKcoqhcOL1QHr
         +Unl+kPy5CG67ZhaHGlVzJLsX2qwVox8TR8kCUy/lsQwdCa3xfrLIe6FSKX7ziwMDI
         VXXBP5FBNM37qJqEeGLRVV4iAIBYg05udrVSHMKatOkA7E+g1SMjRO2Y4t3xWuoPnn
         CWdEL/kg6v6n6jqpzRON0tVJE1C7Rqrq1I5zZx1JA4nPY09Ojue0fzqc922MwfbwDo
         /YMtNnJUgtYncKfw3IVjUF4gAVF6tnxs9SvadxepzO8M6cfoYm7QffwlrnDb8ZYEaE
         liSY/J3KlZFjQ==
Date:   Fri, 28 Apr 2023 09:46:46 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dan.j.williams@intel.com, Jonathan.Cameron@huawei.com,
        alison.schofield@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, fan.ni@samsung.com,
        a.manzanares@samsung.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 3/7] cxl/mbox: Add sanitation handling machinery
Message-ID: <rquzz5rz4il2n3jo7eaqwmzadxjzjw7lkmydvgmrpwwaqkhfqt@odc2nwg6i5vu>
References: <20230421092321.12741-1-dave@stgolabs.net>
 <20230421092321.12741-4-dave@stgolabs.net>
 <46b76304-e75f-9a1a-296d-f67237d246d5@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <46b76304-e75f-9a1a-296d-f67237d246d5@intel.com>
User-Agent: NeoMutt/20230407
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 28 Apr 2023, Dave Jiang wrote:

>>  static irqreturn_t cxl_pci_mbox_irq(int irq, void *id)
>>  {
>>	struct cxl_dev_state *cxlds = id;
>>+	u64 reg;
>>+	u16 opcode;
>>	/* spurious or raced with hw? */
>>	if (!cxl_mbox_background_complete(cxlds)) {
>>@@ -107,12 +109,47 @@ static irqreturn_t cxl_pci_mbox_irq(int irq, void *id)
>>		goto done;
>>	}
>>-	/* short-circuit the wait in __cxl_pci_mbox_send_cmd() */
>>-	wake_up(&mbox_wait);
>>+	reg = readq(cxlds->regs.mbox + CXLDEV_MBOX_BG_CMD_STATUS_OFFSET);
>>+	opcode = FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_OPCODE_MASK, reg);
>>+
>>+	if (opcode == CXL_MBOX_OP_SANITIZE) {
>>+		dev_dbg(cxlds->dev, "Sanitation operation ended\n");
>
>I might be missing something. Do we not want to stop waiting as well
>if the sanitation operation has ended?

The thing here is that sanitize won't ever use the mbox_wait, which is
what makes it special (asynchronous).

So while in theory patch 2 enables sanitize to be in the synchronous path,
it can never occur because there is nothing there yet to trigger it (or
anything else for that matter). And this patch ensures that the sanitize
is isolated within __cxl_pci_mbox_send_cmd().

Thanks,
Davidlohr
