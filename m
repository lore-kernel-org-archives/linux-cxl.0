Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AECFC54EAA
	for <linux-cxl@archiver.kernel.org>; Thu, 26 Jan 2023 19:23:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjAZTXP (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 26 Jan 2023 14:23:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbjAZTXO (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 26 Jan 2023 14:23:14 -0500
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7749B303D6
        for <linux-cxl@vger.kernel.org>; Thu, 26 Jan 2023 11:23:12 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id B510F20145B;
        Thu, 26 Jan 2023 19:23:11 +0000 (UTC)
Received: from pdx1-sub0-mail-a291.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 38570201662;
        Thu, 26 Jan 2023 19:23:11 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1674760991; a=rsa-sha256;
        cv=none;
        b=zcta+ZO1RkvMRY6g7gSq1sk5nZrocyKV8RIBmRF4i88POZyHaG4yOepL5jEg7zRoUc5C+v
        KZ39Mgs0+A8W2ordj8Z4Y2FJmoNGu44GuHhLQjNy/HkMDWZ7gwz+Lcm+PZf0CSqW83qA0A
        lQ6o8WWqeqN6UPMa7DjLGy11gyeaDFQ5XnkP764cKmJuoclZegCw8rdf0yVnfT6jgCQLPn
        0ofmmGWDRoHynWPQgGXYP4E/1BYkiWU9Z11wL+eiofKuddbsXF5Ar4d7rDeM1LFN30qFrP
        EVVBBujnuRHFBXGpGKXnfWBnbgSpXPtVkuzHcWkoqG4zzmSyl1rWxLvfb+/J0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1674760991;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=C0a+w5RbC+qHhGPsqA3/9Nbll7e+w+WBmsgLc/6h4wQ=;
        b=YvXvzA4J6Y0RSAPyN6hUpLzgpz+WFn8Uj0X5eMmkB0/LVgB+eITPcIHDHlNJp66XLbDVQy
        eq6GTZMccsfa3GzkHAizde0kzHCFCsIYNrEWT+M5ddDtac77Hd+Ywry7Z0EoaIYPDtPO1j
        vXwxwiee0zZ0l14/AyfV0q0z3cc1T9QsCjF/JDH/x8kGISia8/7k+mhldtLmnGsq5uarSM
        eJxnI/X+IcWsus1B8oYEGEZ2S4cOltEFDFJKWkf519FDlBI8l3THtOhRzoAoZ8rbUdJyEN
        FykpgQxXQ4H5N207SvTmHh05a5YoxEE9+J+WRwrX+FfvgoCVhcLp0hmTKgm1Uw==
ARC-Authentication-Results: i=1;
        rspamd-9476994bd-4wst2;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Madly-Gusty: 7314975664fdfb28_1674760991547_4055364671
X-MC-Loop-Signature: 1674760991547:1528016736
X-MC-Ingress-Time: 1674760991546
Received: from pdx1-sub0-mail-a291.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.109.196.199 (trex/6.7.1);
        Thu, 26 Jan 2023 19:23:11 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a291.dreamhost.com (Postfix) with ESMTPSA id 4P2rG621qmz8j;
        Thu, 26 Jan 2023 11:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1674760990;
        bh=yFm7KbBxDoSaWkRYoTtewn0gCxbk59Tm/Wx1rLOJijg=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=MQ0V+2+iEPTwshLYKWHN7xAfCS6ylOq5FsSk3rDzq/hqH9QAGXDq4MrSxCb1ntOdI
         YrsbKEC7MwvVXQepZTkXnQpvkYBhou5a6xoeG9mtC9qImgd4U0JqajzECZUw44VrVD
         xOPmL1DtBdEYggsGj9F8l6vo1TEjfhqd8nc3kTLI8RF0mfY9Qa2v8oV2NT6WQeXDxD
         0wHB66XasNfbA1Kk9gBcCM7SXx/6IJwrs3yVD9J1haz7d01g/jRLowXN2ZcB7vFcmd
         lqqqctcIbWT3QSZGdnJdOEAzLt5Zro5QSqU3suKfWWh5x+2gDJTbWoKSeS3nlpkY9X
         86KxQ7X6ZNxbw==
Date:   Thu, 26 Jan 2023 10:56:20 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>, linuxarm@huawei.com
Subject: Re: [PATCH] cxl/pci: Set the device timestamp
Message-ID: <20230126185620.52bfkr7cksjyjghk@offworld>
References: <20230126180458.5145-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230126180458.5145-1-Jonathan.Cameron@huawei.com>
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 26 Jan 2023, Jonathan Cameron wrote:

>Note that the command is optional and if
>not supported and the device cannot return accurate timestamps it will
>fill the fields in with an appropriate marker (see the specification
>description of each timestamp).

A few questions (which I'm missing from the spec):

- How to verify if a ts was actually set? I would assume that if SET
is unsupported, GET will also be, and since you set the ts at
bootup, it should never occur in reality.

- Does "unsupported" return type mean the command cannot mean that
flat out the device cannot handle timestamps or is it more that the
device cannot handle nanosecond resolution?

...

>@@ -65,6 +65,7 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
>	CXL_CMD(GET_SCAN_MEDIA_CAPS, 0x10, 0x4, 0),
>	CXL_CMD(SCAN_MEDIA, 0x11, 0, 0),
>	CXL_CMD(GET_SCAN_MEDIA, 0, CXL_VARIABLE_PAYLOAD, 0),
>+	CXL_CMD(SET_TIMESTAMP, 8, 0, 0),
> };
>
> /*
>@@ -93,6 +94,7 @@ static u16 cxl_disabled_raw_commands[] = {
>	CXL_MBOX_OP_SET_SHUTDOWN_STATE,
>	CXL_MBOX_OP_SCAN_MEDIA,
>	CXL_MBOX_OP_GET_SCAN_MEDIA,
>+	CXL_MBOX_OP_SET_TIMESTAMP,

Why no GET support?

> };
>
> /*
>@@ -857,6 +859,29 @@ int cxl_mem_create_range_info(struct cxl_dev_state *cxlds)
> }
> EXPORT_SYMBOL_NS_GPL(cxl_mem_create_range_info, CXL);
>
>+int cxl_set_timestamp(struct cxl_dev_state *cxlds, u64 ts)
>+{
>+	struct cxl_mbox_cmd mbox_cmd;
>+	struct cxl_mbox_set_timestamp_in pi;
>+
>+	/*
>+	 * Command is optional and functionality should not be affected if
>+	 * the command is not available.
>+	 */
>+	if (!test_bit(CXL_MEM_COMMAND_ID_SET_TIMESTAMP, cxlds->enabled_cmds))
>+		return 0;
>+
>+	pi.timestamp = ts;

Considering we always want "now", maybe just remove the parameter and just
compute ktime_get_real_ns() here?

>+	mbox_cmd = (struct cxl_mbox_cmd) {
>+		.opcode = CXL_MBOX_OP_SET_TIMESTAMP,
>+		.size_in = sizeof(pi),
>+		.payload_in = &pi,
>+	};
>+
>+	return cxl_internal_send_cmd(cxlds, &mbox_cmd);
>+}

Thanks,
Davidlohr
