Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23578C43334
	for <linux-cxl@archiver.kernel.org>; Thu, 21 Jul 2022 20:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbiGUUyF (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 21 Jul 2022 16:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiGUUyE (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 21 Jul 2022 16:54:04 -0400
Received: from crane.ash.relay.mailchannels.net (crane.ash.relay.mailchannels.net [23.83.222.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F9D8FD76
        for <linux-cxl@vger.kernel.org>; Thu, 21 Jul 2022 13:54:00 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 118B94C20D8;
        Thu, 21 Jul 2022 20:53:57 +0000 (UTC)
Received: from pdx1-sub0-mail-a292.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 846424C217B;
        Thu, 21 Jul 2022 20:53:56 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1658436836; a=rsa-sha256;
        cv=none;
        b=XgfPUC3pTXTw4J9Zu5XLOt4xmyhqjxslKTUu8nxyuq90m9Qfa18Oz2XZKH3b26M/kNt1j+
        sbeKmMup5wbPP8CG/sbvK2KCB7JwjigxjdNtg1jmXwjvpOeZTAKx12p0zSTVvrY8ch+J5n
        YfymOSlQzA7ortk9GcToEuG4vXWdQKxRfY0+UeS3+wA4tcaTPk+qAeXweGNjBu54BFWUPb
        pXc2mDNpsTsvSqkjRe2Vjy5tPQT0JKehc5GGRgWiQf3yYA4IrQpFoRZNdtCtV/HOD0laZc
        oNsq5VtkLjziNUMAj8Vi9Z7QhZQFudkGFTbfqwnUIlNVzFJAedC/npnVMlz26w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1658436836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=chiHf8MtBBZW3plwOQQejUwYN6PlEDbTKhUjU9N51mk=;
        b=eW/2ub2Bcaq3Vm3Jn8Y8pX509bwbexKFsetRk2GVwuEwZFCCMIsPnXnW27lc0WHFGpNZPh
        1pvKYpW+WWPUvwFt5uEyS3+6D8eS8jmtJhFlQRCLfsJJXwwSmNFq+R+ZDBAFMX6GefiwvL
        vF9rC/MlrLc8g67oFaXjgQ8VaawD4WYhyLlyj9chx7KbP5qrSd1j/q1Y606213u04eWihB
        rnQS7LIPNULeFvHXVvPzgH9VX1KbYhhI14ak2ouijCsqjcZaBl50pUdcU9hydVNry6rcO3
        hnXyHym8Wm+PMReyeevBfrGij2JS6X5lTgL3B5DwAgRDMaSNUH8scDIeddvlXQ==
ARC-Authentication-Results: i=1;
        rspamd-674ffb986c-rm2ck;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Irritate-Keen: 4db9656d43e15fc5_1658436836902_2246067422
X-MC-Loop-Signature: 1658436836902:3632667679
X-MC-Ingress-Time: 1658436836902
Received: from pdx1-sub0-mail-a292.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.108.161.118 (trex/6.7.1);
        Thu, 21 Jul 2022 20:53:56 +0000
Received: from offworld (unknown [104.36.29.104])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a292.dreamhost.com (Postfix) with ESMTPSA id 4LplD34qFrzH9;
        Thu, 21 Jul 2022 13:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1658436836;
        bh=chiHf8MtBBZW3plwOQQejUwYN6PlEDbTKhUjU9N51mk=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=amcyUzVaxdzLPHwCoFkqyElU/m0d3JCEv+zRj+1Ymq7Nh34o90GRmSmwYQKtw4/nZ
         IfuomfQZ8N8lZxX4RcPmIMvjEu5mPCKHQGdPdWu+KEZ2pVN+IvPtg683jv0V9pisuP
         PFNEBQfT2dKC3c8Civ7+YvjWXFAN/c1ahfTXtSb4Mc2eqiLG7OEu59igaeU37pjrv4
         No/shBTfR0JGbkITCRzQ180E31V/r+U0Iifdr6yWR2KZnkH3wWnEnLyI9dIUPExKQI
         V6p57KT7oNcSLRZUPNQX9X0tyrODLluUTX48/1nyFaPCJNOrodxjPE6zRzsREg1rKp
         ToZLFIcDJspiw==
Date:   Thu, 21 Jul 2022 13:37:42 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     sunfishho12@gmail.com
Cc:     linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, a.manzanares@samsung.com
Subject: Re: [ndctl PATCH v2] cxl: Add list verbose option to the cxl command
Message-ID: <20220721203742.gb6t4fzkuiyxhwlt@offworld>
References: <20220721192447.16958-1-sunfishho12@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220721192447.16958-1-sunfishho12@gmail.com>
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 21 Jul 2022, sunfishho12@gmail.com wrote:

>From: Matthew Ho <sunfishho12@gmail.com>
>
>This adds the new subcommands cxl list -v, cxl list -vv, and cxl list -vvv, and
>builds on this pending patch series that adds region listing support:
>
>https://lore.kernel.org/linux-cxl/20220715062550.789736-1-vishal.l.verma@intel.com/
>
>cxl list -v is now equivalent to cxl list -RMBDPT, cxl list -vv is
>equivalent to cxl list -RMBDPTi, and cxl list -vvv is equivalent to
>cxl list -RMBDPTiHI. These additions make it easier to list all of the CXL
>devices without having to remember which subcommand must be appended for each
>type of device.
>
>Reviewed-by: Adam Manzanares <a.manzanares@samsung.com>
>Signed-off-by: Matthew Ho <sunfishho12@gmail.com>

With the exception of the switch() handling (see below).

Acked-by: Davidlohr Bueso <dave@stgolabs.net>

>---
>
>Changes since v1 (previously titled "Add list all option to the cxl command"):
> - cxl list -v, cxl list -vv, cxl list -vvv replace cxl list --all,
> providing greater control over detail of the output. --human has been excluded
> as it can be appended by the user.
>
> Documentation/cxl/cxl-list.txt | 20 ++++++++++++++++++++
> cxl/filter.h                   |  1 +
> cxl/list.c                     | 17 +++++++++++++++++
> 3 files changed, 38 insertions(+)
>
>diff --git a/Documentation/cxl/cxl-list.txt b/Documentation/cxl/cxl-list.txt
>index 2906c2f6ef4b..f069aee8c674 100644
>--- a/Documentation/cxl/cxl-list.txt
>+++ b/Documentation/cxl/cxl-list.txt
>@@ -336,6 +336,26 @@ OPTIONS
> --region::
> 	Specify the region name to filter the emitted regions.
>
>+-v::
>+--verbose::
>+	Increase verbosity of the output. This can be specified
>+	multiple times to be even more verbose on the
>+	informational and miscellaneous output, and can be used
>+	to override omitted flags for showing specific
>+	information. Note that cxl list --verbose --verbose is
>+	equivalent to cxl list -vv, and likewise
>+	cxl list --verbose --verbose --verbose is equivalent to
>+	cxl list -vvv.
>+	- *-v*
>+	  Automatically enable --memdevs, --regions, --buses,
>+	  --ports, --decoders, --targets.
>+	- *-vv*
>+	  Everything *-v* provides, plus automatically include
>+	  disabled devices with --idle.
>+	- *-vvv*
>+	  Everything *-vv* provides, plus automatically enable
>+	  --health and --partition.
>+
> --debug::
> 	If the cxl tool was built with debug enabled, turn on debug
> 	messages.
>diff --git a/cxl/filter.h b/cxl/filter.h
>index d22d8b1f798b..256df49c3d0c 100644
>--- a/cxl/filter.h
>+++ b/cxl/filter.h
>@@ -26,6 +26,7 @@ struct cxl_filter_params {
> 	bool human;
> 	bool health;
> 	bool partition;
>+	int verbose;
> 	struct log_ctx ctx;
> };
>
>diff --git a/cxl/list.c b/cxl/list.c
>index 5f604ecddf3c..4763c7c36024 100644
>--- a/cxl/list.c
>+++ b/cxl/list.c
>@@ -52,6 +52,8 @@ static const struct option options[] = {
> 		    "include memory device health information"),
> 	OPT_BOOLEAN('I', "partition", &param.partition,
> 		    "include memory device partition information"),
>+	OPT_INCR('v', "verbose", &param.verbose,
>+		 "increase output detail"),
> #ifdef ENABLE_DEBUG
> 	OPT_BOOLEAN(0, "debug", &debug, "debug list walk"),
> #endif
>@@ -106,6 +108,21 @@ int cmd_list(int argc, const char **argv, struct cxl_ctx *ctx)
> 		param.memdevs = true;
> 	}
>
>+	switch (param.verbose){
>+	default:
>+		break;
>+	case 3:
>+		param.health = true;
>+		param.partition = true;
>+	case 2:
>+		param.idle = true;
>+	case 1:
>+		param.buses = true;
>+		param.ports = true;
>+		param.decoders = true;
>+		param.targets = true;
>+	}
>+

I think you want this:

     switch(param.verbose) {
     default:
     case 3:
	 ...
     case 2:
	 ...
     case 1:
	 ....
     case 0:
	 break;
     }


> 	log_init(&param.ctx, "cxl list", "CXL_LIST_LOG");
> 	if (debug) {
> 		cxl_set_log_priority(ctx, LOG_DEBUG);
>--
>2.34.1
>
