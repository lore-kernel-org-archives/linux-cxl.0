Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6CB7C6FD18
	for <linux-cxl@archiver.kernel.org>; Tue, 25 Apr 2023 16:24:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234165AbjDYQYT (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 25 Apr 2023 12:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233893AbjDYQYS (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 25 Apr 2023 12:24:18 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F2810CC
        for <linux-cxl@vger.kernel.org>; Tue, 25 Apr 2023 09:24:17 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 9D13D413F4;
        Tue, 25 Apr 2023 16:24:09 +0000 (UTC)
Received: from pdx1-sub0-mail-a289.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 3571141418;
        Tue, 25 Apr 2023 16:24:09 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1682439849; a=rsa-sha256;
        cv=none;
        b=AnDj5wOMfFAy2gqKDYAX3TxXMvDcbtM8QowIETRSNaIOnO1OR/SeWswUE8QVp+FmxS9GwQ
        xbzdkY8mNh2MNITpwoSjOD79lhFxGGWjbrks/6Hh8a8iNxnTvN2GhHnuY3Zm8IpczEktgk
        OY+OyoS4r5lv9a6gw1866w+UdsUnl6CDq41wq2UQEyyzoCJeF1SrozL52MxNErJQMDrFaK
        g3Nc4iegP59Du2STJREnYcSDr+aShHG1d86P/GixmzAvQiAIGBsBx10R0nqjagi6SP7utn
        6kVUGs+lWzPUNnarcs/SkfZ9e8mt1MTVp9p99NBoZ3LzGMrT3lhIrTYY4BZ8KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1682439849;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=XNlBXZ7cAJAeLN0GjelyFcM92txNpPLgIyOfpPToU0U=;
        b=pDFIG9Bgm33l736Dby+uuj8CjEU+pIszvURnQ8+2WeorKSlaKv5bPjTpEq86ThcCvWR3Ui
        wMRPA5l3N4FKuVBdZkru0yozipn3hGHx1+uaeo9+u9a0vPOcuPAl8A3eK/7jMhwcsc0zP7
        WAgRpuRpsA9tauqZfSSAfjEvtfB94jjltozxBDXOjuL3CgND69grQn8AxnTXxo6OpC3tAr
        NCyYON27IXp/Lr3ccNfIDDKeCHvpGsMDIgWzI0Qp37+3esCs6YViQ81y7H8C4vRUvp8Wkc
        +mZiN91lCcZYWOLtecFFS+IAqAk+OpbdSLjzBi2ra7RggN/1LGEmoOfJkxef0w==
ARC-Authentication-Results: i=1;
        rspamd-548d6c8f77-s5g2c;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Trouble-Unite: 65ba422a00eeef08_1682439849460_837525758
X-MC-Loop-Signature: 1682439849460:906833067
X-MC-Ingress-Time: 1682439849460
Received: from pdx1-sub0-mail-a289.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.107.49.214 (trex/6.7.2);
        Tue, 25 Apr 2023 16:24:09 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a289.dreamhost.com (Postfix) with ESMTPSA id 4Q5S4S6Gwfz8S;
        Tue, 25 Apr 2023 09:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1682439849;
        bh=XNlBXZ7cAJAeLN0GjelyFcM92txNpPLgIyOfpPToU0U=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=UEfPwdsti1IDNmDcUjDQiJMNMpcixxaR7ENQnudTg3px75iskNO5JASzBqzuVTN+3
         /VBrcsYLVlEPuvxfK4IpdS4m0CFgDgwgVVAqnZVn5bXog9RoopCgHcChaGBlYrIo5T
         40DXKUWxq8mlnMSmuIWND/2W6Z37R59Le4wdAj6ft2O7hU1z1OCyzdUsb8bNH0a9sN
         9J+j4q+aK3hdPgET07FWDitgcCSqrAFAUJ1xe86as+3N2R36m8IHNn/u1EZGz470Xz
         53HNT/sQ0/ZKH72BMO7fxWT3gQ1fqzZIVy/I3+hRNGl5MOgBeexHaBKenB86jqxMBG
         NdDPPIQgMYX7A==
Date:   Tue, 25 Apr 2023 08:52:24 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     vishal.l.verma@intel.com
Cc:     linux-cxl@vger.kernel.org
Subject: Re: [PATCH 2/2] cxl/memdev: Introduce sanitize-memdev functionality
Message-ID: <hipikawsie44jgqqwcbx7gswhcwz7nb2uqevyhr2tgdqn7dqep@4yl3peb24pe7>
References: <20230423015920.11384-1-dave@stgolabs.net>
 <20230423015920.11384-3-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230423015920.11384-3-dave@stgolabs.net>
User-Agent: NeoMutt/20230407
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Sat, 22 Apr 2023, Davidlohr Bueso wrote:

>+int cxl_memdev_sanitize(struct cxl_memdev *memdev, const char *op)
>+{
>+	struct cxl_ctx *ctx = cxl_memdev_get_ctx(memdev);
>+	char *path = memdev->dev_buf;
>+	int len = memdev->buf_len;
>+
>+	if (snprintf(path, len,
>+		     "%s/security/%s", memdev->host_path, op)  >= len) {

Bleh I forgot to update this (will do in an eventual v2), s/host_path/dev_path

Thanks,
Davidlohr
