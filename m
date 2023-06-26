Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D10EB64D9
	for <linux-cxl@archiver.kernel.org>; Mon, 26 Jun 2023 18:58:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232715AbjFZS6q (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 26 Jun 2023 14:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232713AbjFZS6h (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 26 Jun 2023 14:58:37 -0400
Received: from crane.ash.relay.mailchannels.net (crane.ash.relay.mailchannels.net [23.83.222.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7052210D5
        for <linux-cxl@vger.kernel.org>; Mon, 26 Jun 2023 11:58:22 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 9A0A73E17C5;
        Mon, 26 Jun 2023 18:52:46 +0000 (UTC)
Received: from pdx1-sub0-mail-a285.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 1FF813E1791;
        Mon, 26 Jun 2023 18:52:46 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1687805566; a=rsa-sha256;
        cv=none;
        b=Bbl57T2+ADi2oyZLQPnU1DJ9orITy19mNQ7yA46zhHgzahMt5oSdKo+1yGTyRYC/Wj1nHF
        Ag3yjaWQrD7J0hhJ7cU1knAnyo6gGPUCPtC+hCKlpkt5yWkcCdA8TrjgbjdWaN3Wp8lpbP
        8WNxF/qwFqUi7hHq4VZUR3ZrD3hwQ31dRGPyJzr5krzAolfODeDjdhG8damcQNiS8qbuKI
        X8i5ykP4liI394wKxImeqYkTW6CR1un20A3JTyBfPyozOhXv7deuiRZsPZN+IzRsck9xaf
        TsluCCQ+Kq4NJ9k/d6D3qnnzuS1DWuwjFwKqEL26qDaXP0StCILiVYto/Z0yoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1687805566;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=ndrgzQV9OrDQCKwRJGquwDPjRE+v+eH1jIXyfzBqfME=;
        b=ZxhkhgQdwHu6NmdVHS9FOe+8zbMEtmugqgd71DfkR5qvKY0e+yv4T4BCPmQS1I8uID1VXD
        ceMFlMNF2QkOxcjJP4zWE4TBtsXI5LLvP2hY7cjADz1DZvgDhl1otHTQbEUNII7gB2nIK0
        dYtDEpuNenc4xqaPA3JSfvSiOrhgLCYc6jpWWdsAIRFoXz7rsyUL0bM2gZ4kJS2Y8wzXk/
        Bq+PWYpDq8daC2eF6TJrV6O4v8w9YaQ8vJEK4RIUtAp0s8WWkHFq7IwBwJGoS8/gAWYCBe
        h9PdQ2fwHaxtDeCw1yuF69P4Tu9ILd8SML6iYt/o6lBYf91d/Q+HsX2WMNgOLQ==
ARC-Authentication-Results: i=1;
        rspamd-85899d6fcc-pjvxq;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Scare-Gusty: 6e1ca9822166fa75_1687805566429_2532144591
X-MC-Loop-Signature: 1687805566429:2624849073
X-MC-Ingress-Time: 1687805566429
Received: from pdx1-sub0-mail-a285.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.107.49.251 (trex/6.9.1);
        Mon, 26 Jun 2023 18:52:46 +0000
Received: from offworld (host86-183-53-156.range86-183.btcentralplus.com [86.183.53.156])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a285.dreamhost.com (Postfix) with ESMTPSA id 4QqcRJ0rv5z74;
        Mon, 26 Jun 2023 11:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1687805565;
        bh=H1fMt8arYi4MgFdhH6YsZzTc13v8DYJ1Xj8QefHifZ0=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=efFVL3nQcaoG8S/JxUsvCAi5lvfMjve8ysSumG7qQ6Ucxg6lYUvvrVb6XDVM7Q50n
         aewx2CpGadfwJRQH2pi2A6khRGAFDUywYyHn4h4KU9xv+mJ11JcZy4mq16YrrKmpH9
         tqxXib7XGjHEldOYBCoyUBqP96wB/InnOGyBX+yQw7ZXexY9RS0+6Az14XmQUbkEtT
         X1SUmL8mB/+0eacapax2oazIdgm0WXBEpB9BxRwQitgPZSVh1Ob/AVgZTWY+0Ffnbp
         yhbWRMOh+8fPSAg0scqOyiZ3FDJEScVZ8rFhPrsHy3+ZaEU5ud2dQNTzEiC73/yAko
         qbboW0TBR6jeQ==
Date:   Mon, 26 Jun 2023 11:17:12 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     dave.jiang@intel.com, vishal.l.verma@intel.com,
        Jonathan.Cameron@huawei.com, fan.ni@samsung.com,
        a.manzanares@samsung.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 3/7] cxl/mbox: Add sanitation handling machinery
Message-ID: <mj5tguq7esouitvet7msjuzfrvawordwinuh3pvrmvombiqkta@6hbtqvgfiekx>
References: <20230612181038.14421-1-dave@stgolabs.net>
 <20230612181038.14421-4-dave@stgolabs.net>
 <6498bbfb35c6f_2ed72947a@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <6498bbfb35c6f_2ed72947a@dwillia2-xfh.jf.intel.com.notmuch>
User-Agent: NeoMutt/20230517
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Sun, 25 Jun 2023, Dan Williams wrote:

>Davidlohr Bueso wrote:
>>  static irqreturn_t cxl_pci_mbox_irq(int irq, void *id)
>>  {
>> +	u64 reg;
>> +	u16 opcode;
>>	struct cxl_dev_id *dev_id = id;
>>	struct cxl_dev_state *cxlds = dev_id->cxlds;
>>
>>	if (!cxl_mbox_background_complete(cxlds))
>>		return IRQ_NONE;
>>
>> -	/* short-circuit the wait in __cxl_pci_mbox_send_cmd() */
>> -	rcuwait_wake_up(&cxlds->mbox_wait);
>> +	reg = readq(cxlds->regs.mbox + CXLDEV_MBOX_BG_CMD_STATUS_OFFSET);
>> +	opcode = FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_OPCODE_MASK, reg);
>> +	if (opcode == CXL_MBOX_OP_SANITIZE) {
>> +		dev_dbg(cxlds->dev, "Sanitation operation ended\n");
>> +	} else {
>> +		/* short-circuit the wait in __cxl_pci_mbox_send_cmd() */
>> +		rcuwait_wake_up(&cxlds->mbox_wait);
>
>Just a question, is there any harm in awaking this even though nothing
>is waiting? I.e. just wondering if this has functional purpose or is
>just for cleanliness?

No, there is no harm in calling the wakeup if nothing is blocked.
rcuwait will check for nil task pointer before calling wake_up_process().
In such cases it will be a nop.

...

>>
>> +	/*
>> +	 * With sanitize polling, hardware might be done and the poller still
>> +	 * not be in sync. Ensure no new command comes in until so. Keep the
>> +	 * hardware semantics and only allow device health status.
>> +	 */
>> +	if (unlikely(cxlds->security.poll_tmo_secs > 0)) {
>
>CPUs and compilers do a decent job at likely/unlikely branch prediction,
>and given mailbox operations are a slow path I can not imagine this
>unlikely() annotation makes any measurable difference.

So this was more about documenting the rare case more than an actual performance
optimization. Either way is fine I guess.

Thanks,
Davidlohr
