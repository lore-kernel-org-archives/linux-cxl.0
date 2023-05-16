Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB6EDC77B7F
	for <linux-cxl@archiver.kernel.org>; Tue, 16 May 2023 17:35:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbjEPRfe (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 16 May 2023 13:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbjEPRfd (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 16 May 2023 13:35:33 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69779C9
        for <linux-cxl@vger.kernel.org>; Tue, 16 May 2023 10:35:30 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id BFF917E1E24;
        Tue, 16 May 2023 17:35:28 +0000 (UTC)
Received: from pdx1-sub0-mail-a247.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id DF1ED7E1D4C;
        Tue, 16 May 2023 17:35:27 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1684258528; a=rsa-sha256;
        cv=none;
        b=cXkOWOCvKlR6pUF6sd4/kLNtUcUVT1Y1XRdWPnkw5obc5FZZCbMF04bwVWP/BYBtCA0YIX
        WtuGW5Oi9WezMlifl546l5bLMM++3ewh/h6bMAKFjkOWwam4VvU/0JA02QACfUUsDqr1JB
        c9eTznGaTm09iJa46d4wyg//wTT1cWp66z/QH4nBGHS0NXYymEd6QBzq637kOGfuY2fuaj
        daVA6/rhfsL5JoHZpOd5cIAm4AdPso139OrvqiYnlidg+un383++qXpV4+e39WG+No80sg
        uhb75lkiwJ4f5tsUvZrSTXAlm8Nxgv9jNlNPIbFj/5wP1ojs17YlCCBFLa4USw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1684258528;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=9XyD90OnQ63YZMYy6Ta2akWb3qnbm2JeKFbGK0dbDfk=;
        b=rYLynts+t2Ghxx49Y9gbtpCUT4taE+DDfCkkEIvWIn4GYUMWMc+JYF/3fZZNpBCtWhE/Hm
        gWd/LO5Z/eobfBzszJ0G43eH+PwrDktJh0XfusoeTzBojGVSMBpNmdut5lelhbMlHa92G0
        4UEi0fWIGXunIHkeUp6uAQje2mK5tnx8pOrKi6YfgHUouWLvX4NEUSBuAucM214nrSmHQw
        No4v6k350gQppfUG32t6pCmFR5uFsqd38vkB//pAgfcNtTewD8seqkeMWOSczUi6WFKoOk
        1qxESG8G1PNi8BeptaKbVwqaqf8eauHjpMOUiXEZT50NzmjXnCbqnNvZR8Aw5Q==
ARC-Authentication-Results: i=1;
        rspamd-79bb5575d7-rgq4k;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Glossy-Reaction: 0e7f0cbb4829da32_1684258528532_1548323084
X-MC-Loop-Signature: 1684258528532:2586734644
X-MC-Ingress-Time: 1684258528532
Received: from pdx1-sub0-mail-a247.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.115.252.222 (trex/6.8.1);
        Tue, 16 May 2023 17:35:28 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a247.dreamhost.com (Postfix) with ESMTPSA id 4QLNg31ZKNz4h;
        Tue, 16 May 2023 10:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1684258527;
        bh=9XyD90OnQ63YZMYy6Ta2akWb3qnbm2JeKFbGK0dbDfk=;
        h=Date:From:To:Cc:Subject:Content-Type:Content-Transfer-Encoding;
        b=G+pP3Deq0IRhDiPRnUmIlBW9idLUw5qM21PhuDqmoqa1HJ9kYDQypeCVaCVvYbrmo
         JaOFDKVgJ8eXj9dadaFjajZZQHjaEHVXaU3ls8JkvqMvxmQTGRtIPrYPGjP5W1PF5T
         VfnviJC3yWErKpmnCUHUWhMHkDQPnaospeW3odTrE+SKb2tthQDVT5XD/JtPCfh6XC
         caMdNEtO2C2De+22TNLSFRTYbC+yLtxJFcI4CarE4H/NUKYaiKKwOpjnOesaL4ZJyR
         VJ+Fw5NihJ5t3LQds6thQTxPTqHeuWd3JihqM9Om+/TBEBAYst2MEyr2bk+ugx5fSF
         9zthIuRgFdhjg==
Date:   Tue, 16 May 2023 10:02:24 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     "Li, Ming" <ming4.li@intel.com>
Cc:     dave.jiang@intel.com, alison.schofield@intel.com,
        vishal.l.verma@intel.com, Jonathan.Cameron@huawei.com,
        fan.ni@samsung.com, a.manzanares@samsung.com,
        linux-cxl@vger.kernel.org, dan.j.williams@intel.com
Subject: Re: [PATCH v2] cxl/mbox: Add background cmd handling machinery
Message-ID: <w3ejzka7keybbq5dfpyhlzmtpczsnlv2w3jwj6fmdhny3uwydy@lsfenbjjktbn>
References: <20230502171841.21317-1-dave@stgolabs.net>
 <20230502171841.21317-4-dave@stgolabs.net>
 <gtvozgdx2ak7tekc3heczk5g7gj3cwuoptez6tjmkecader4lo@7t2em7rclcxn>
 <09aaafe8-76c2-85a0-ab5b-fd337c625530@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <09aaafe8-76c2-85a0-ab5b-fd337c625530@intel.com>
User-Agent: NeoMutt/20230407
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 16 May 2023, Li, Ming wrote:

>On 5/3/2023 10:57 PM, Davidlohr Bueso wrote:
>
>> =A0/**
>> =A0 * __cxl_pci_mbox_send_cmd() - Execute a mailbox command
>> =A0 * @cxlds: The device state to communicate with.
>> @@ -177,6 +205,57 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_dev_s=
tate *cxlds,
>> =A0=A0=A0=A0mbox_cmd->return_code =3D
>> =A0=A0=A0=A0=A0=A0=A0 FIELD_GET(CXLDEV_MBOX_STATUS_RET_CODE_MASK, status=
_reg);
>>
>> +=A0=A0=A0 /*
>> +=A0=A0=A0=A0 * Handle the background command in a synchronous manner.
>> +=A0=A0=A0=A0 *
>> +=A0=A0=A0=A0 * All other mailbox commands will serialize/queue on the m=
box_mutex,
>> +=A0=A0=A0=A0 * which we currently hold. Furthermore this also guarantee=
s that
>> +=A0=A0=A0=A0 * cxl_mbox_background_complete() checks are safe amongst e=
ach other,
>> +=A0=A0=A0=A0 * in that no new bg operation can occur in between.
>> +=A0=A0=A0=A0 *
>> +=A0=A0=A0=A0 * Background operations are timesliced in accordance with =
the nature
>> +=A0=A0=A0=A0 * of the command. In the event of timeout, the mailbox sta=
te is
>> +=A0=A0=A0=A0 * indeterminate until the next successful command submissi=
on and the
>> +=A0=A0=A0=A0 * driver can get back in sync with the hardware state.
>> +=A0=A0=A0=A0 */
>> +=A0=A0=A0 if (mbox_cmd->return_code =3D=3D CXL_MBOX_CMD_RC_BACKGROUND) {
>> +=A0=A0=A0=A0=A0=A0=A0 long ret;
>> +=A0=A0=A0=A0=A0=A0=A0 u64 bg_status_reg;
>> +=A0=A0=A0=A0=A0=A0=A0 int i, timeout =3D mbox_cmd->poll_interval;
>> +
>> +=A0=A0=A0=A0=A0=A0=A0 dev_dbg(dev, "Mailbox background operation (0x%04=
x) started\n",
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 mbox_cmd->opcode);
>> +
>> +=A0=A0=A0=A0=A0=A0=A0 for (i =3D 0; i < mbox_cmd->poll_count; i++) {
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D rcuwait_wait_event_timeout(&c=
xlds->mbox_wait,
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cxl_mbox_back=
ground_complete(cxlds),
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 TASK_INTERRUP=
TIBLE,
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 msecs_to_jiff=
ies(timeout));
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret > 0)
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret < 0) /* interrupted by a sign=
al */
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;
>
>What do you think if adding a dev_dbg() here for outputting current percen=
tage complete for debugging? is it helpful?

I don't see it being very relevant here, honestly. Something like that
might be more usful in a longer async context without timeouts.

Thanks,
Davidlohr
