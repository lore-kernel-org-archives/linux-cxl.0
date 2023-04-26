Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B777C77B78
	for <linux-cxl@archiver.kernel.org>; Wed, 26 Apr 2023 18:58:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbjDZS6S (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 26 Apr 2023 14:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233612AbjDZS6R (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 26 Apr 2023 14:58:17 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F11A93C3
        for <linux-cxl@vger.kernel.org>; Wed, 26 Apr 2023 11:57:33 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 8A12064247B;
        Wed, 26 Apr 2023 18:56:54 +0000 (UTC)
Received: from pdx1-sub0-mail-a313.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 1607B641F1D;
        Wed, 26 Apr 2023 18:56:54 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1682535414; a=rsa-sha256;
        cv=none;
        b=6l11AtrmlmVmOhfp/m/rHN5fIznfE1ATgDTB3w8ueuGpEj9+MtRc62q6fs32WHccMoSY/M
        51CNGvObjoEkiXEsnLHAeR7TCFzEYJ5fRqfqIEu5SueBvSgQqqm17KPspmx1Lci4SPx8EO
        iHef6i/pZTfgBWD//bo/rqpvN99ruC8x1JeAbhw0YOktcy0NDEa2rYZ7FSAmg92ifAcv0B
        aErwf5Mt+JQYcKaAJUiVaddqIXscxXiRrYpPtuFr/Ks2a9neU3DN+6jZeLIZT6nhBfCj18
        NgEtD+3mFWwl/bbF3kl6ewl1BQ0pMUvJASlsUhqUMpUYs2X7NwsJRUJZsqzHZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1682535414;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=vmrjD090fLgYN/03z3GoxNj+C/Le+7fn6jrTyoicUFM=;
        b=4i/B3iwn5+mtxT0dDUG0yavviTV7zMCfIdck0IyBXzeLcdQLkVOpD3enhAzZgZJ1r/Tlsz
        DHLUUjb/SN7P5eMeXDDxEu4Wfsh9E2revyLkhxIVN99xbuBEqwSHwkkbgh9EBLuVrWU5j4
        L7+yNIaOEjbd5+mWL0wCPAy/+WxYDywcpJJf1ibnr2uHSK8GVwpEaqXYKfYiUDf/XfFJmR
        bReWQOWlvUcbBzylxkjFurgIyY0CiQM4BkXRSyXnTpGJDbsMk21SSBanbxhpLQ/tIdbTbt
        moEecfDMfESUTFNPmAN9UI6HfxlkFbkCmr0Zs4HG3a4BgO+7B2kv2hC3m/njBQ==
ARC-Authentication-Results: i=1;
        rspamd-7f66b7b68c-j57tc;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Continue-White: 407b76ac08790735_1682535414309_2002364555
X-MC-Loop-Signature: 1682535414309:4182134521
X-MC-Ingress-Time: 1682535414309
Received: from pdx1-sub0-mail-a313.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.127.59.20 (trex/6.7.2);
        Wed, 26 Apr 2023 18:56:54 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a313.dreamhost.com (Postfix) with ESMTPSA id 4Q67QF54jHz87;
        Wed, 26 Apr 2023 11:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1682535413;
        bh=vmrjD090fLgYN/03z3GoxNj+C/Le+7fn6jrTyoicUFM=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=TaI0eZ5s0+hzPT/FtcmpZzqedc+HIoubQxNBUIUgIDtQYna3kiSu1jrb1EBtNz6RE
         ewp9FQexxcjh0Cz7T7q7HxuRNjB5BaeBXPL4EdQjcXYXr975ik5+M4Uw3PDYUnlKy+
         SSdidN5HcdQOxBFZelOmHLLtQsEucXLiGp5WPPl+3hLKQJlX18ASadYQJZiax25cOJ
         3Xh2icaWrc1iAGSWU9jLqbTNQCZxtKdji4ribNEBeLwf6T1PNnODTEZ56oXqjx8QlI
         W/nPIJnjT9Fldr4KJvb4+yRFXjMnKdVGx850IgCyCyDTldA3xbZMBqSVQjePtqFIhF
         VMH0SuSFBUIeA==
Date:   Wed, 26 Apr 2023 11:25:07 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     "Verma, Vishal L" <vishal.l.verma@intel.com>
Cc:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 1/2] cxl/memdev: Introduce wait-sanitize functionality
Message-ID: <qfnmbur5kofs6tyje7e4xyui6jyifv4lt3oyydre5n2z5igzsm@wgwqdb4hbazf>
References: <20230423015920.11384-1-dave@stgolabs.net>
 <20230423015920.11384-2-dave@stgolabs.net>
 <a1546a23259826fa1e1e469e7d9de902ae914e7e.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <a1546a23259826fa1e1e469e7d9de902ae914e7e.camel@intel.com>
User-Agent: NeoMutt/20230407
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 26 Apr 2023, Verma, Vishal L wrote:

>These mostly look good - just one thing about the symbol script
>additions in both this patch and the next one -  The different LIBCXL_N
>sections in this correspond to a library release, and are used for
>libtool versioning.
>
>New symbols in a new release all go together in a new section in this
>file. e.g. the pending branch has a 'LIBCXL_5' section for symbols
>going in the v77 release (corresponding to kernel v6.3). Assuming these
>patches are targeting v78 / v6.4, its new symbols should go in a new
>LIBCXL_6 section.

I really have no specific version of ndctl in mind here, and for the kernel
I'm "targeting" v6.5, so no hurry with this. It was mostly have the cxl
tool support there for whenever the kernel bits landed (plus recycle testing
to exercise the sysfs poll(2) support).

Would it make sense for you to update the libcxl.sym file for whenever you
pick this up? If so I can just get rid of the entries in a v2.

Thanks,
Davidlohr
