Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C01C77B73
	for <linux-cxl@archiver.kernel.org>; Tue,  2 May 2023 18:27:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234354AbjEBS15 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 2 May 2023 14:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234359AbjEBS1v (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 2 May 2023 14:27:51 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A8910FF
        for <linux-cxl@vger.kernel.org>; Tue,  2 May 2023 11:27:48 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id E31AF8224AE;
        Tue,  2 May 2023 18:27:47 +0000 (UTC)
Received: from pdx1-sub0-mail-a310.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 057F78224BC;
        Tue,  2 May 2023 18:27:47 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1683052067; a=rsa-sha256;
        cv=none;
        b=jlI58vEey3iHniaTc4PCx3HatoNWWUnfAR1CHXVSP48sPXdEPoTHDfMDfIzN+Ndx8OrcBj
        6ZkGDgFUnqJtlvWsGZc5Cp6lgs/YcIRkTwJABnzOQh3ZRlcpzquqo5XnSfsqAo2XLYnCPa
        ksoso/TmNFRQFh9CsjIdhbH+MikYK5InPTc/foQB/a02FPNpC84INqGrNNAdMml12ntwjb
        w/ReZ1lsjdHBja9sHMiB5TqDX1vydEB+mt7kLz/u2JJgs+Gx0UztqCZyVH22IFelBBZDft
        eIAlWOlfubbUiC4K0iNhF4NpvAbw2s3//2ENDudWkYyKRZRDB9QI1v+fNIkPFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1683052067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=A2QP5lG0VESUlpZiGTzpUbetmWBv9S82x8IbH91/7Jg=;
        b=5420DdqkCv8XX+Dobyd97XJjSM4gmAQRjA5Rj7J1aFc4H066fPGHpFU1uVIhEq1E1/WrlJ
        j9yJgU/Z8L0LsEmADW99LJMN+yb9kvBJ5UAu1YN9NpJX0NTiCtOpC1u5msHVO+lbjQyXjc
        L/5IwkMWWXAlo/lkOtC9EZZjPSBTD2bNYgNLYoXieS1uZ73DAP8uWInegmjZSg+Fusr0P2
        G8E4BhtMNSoHdAcH992d7UgkGoUh8smzelyuoOwXHJaL8tDKrtz70TXo45S+n3hdXE9lRX
        GHs697KFYmLibkyG2c01VridqBmGzf6rIghzq7rNn65YZCEsnCLGR3OSbrWnJQ==
ARC-Authentication-Results: i=1;
        rspamd-548d6c8f77-jm9l4;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Eyes-Average: 770b0483454fa4b1_1683052067634_2420283563
X-MC-Loop-Signature: 1683052067634:664454654
X-MC-Ingress-Time: 1683052067634
Received: from pdx1-sub0-mail-a310.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.107.49.223 (trex/6.7.2);
        Tue, 02 May 2023 18:27:47 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a310.dreamhost.com (Postfix) with ESMTPSA id 4Q9pTt1cqLz6K;
        Tue,  2 May 2023 11:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1683052066;
        bh=A2QP5lG0VESUlpZiGTzpUbetmWBv9S82x8IbH91/7Jg=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=NdQhyqRD6qE6Dn1X2/lNSURYDEpfoaSeng419aJreSq6tmuqJUvhamBr0l3iOVyRH
         OCPIDYlUeDccxJa1smMCsmjhEeqXm668eHHKkZ359kNjvAdiRhVPiZMr0eVURwp/sD
         5qL0QGAuI6LRbvuWCHj/jNl45OCLVvz6wXN9f8F0P1Qv9I53HU/iCnre8Jq5n/aPZB
         FEsY3LthrLfUixy7eLMtnKky2wfv1mlu4IlzO4CKBHRO/6oatLDkLm7VK1uwgToh5N
         Jg9Gqst/NzdEPAuH0GJpqH+AMpr+rX3Ws8S2o8DcsS6826ADF/SwSHBd0+Uhw+3fpK
         Gbg1eJX9evUcg==
Date:   Tue, 2 May 2023 10:55:31 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     dan.j.williams@intel.com
Cc:     dave.jiang@intel.com, alison.schofield@intel.com,
        vishal.l.verma@intel.com, Jonathan.Cameron@huawei.com,
        fan.ni@samsung.com, a.manzanares@samsung.com,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH 3/3] cxl/mbox: Add background cmd handling machinery
Message-ID: <g2tpcoazfydzovq2aholdjlwrjy2cqdnjnq4gn7pb4deadkm5b@65xkqyctszi4>
References: <20230502171841.21317-1-dave@stgolabs.net>
 <20230502171841.21317-4-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230502171841.21317-4-dave@stgolabs.net>
User-Agent: NeoMutt/20230407
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 02 May 2023, Davidlohr Bueso wrote:

>+	/*
>+	 * Handle the background command in a synchronous manner.
>+	 *
>+	 * All other mailbox commands will serialize/queue on the mbox_mutex,
>+	 * which we currently hold. Furthermore this also guarantees that
>+	 * cxl_mbox_background_complete() checks are safe amongst each other,
>+	 * in that no new bg operation can occur in between.
>+	 *
>+	 * Background operations are timesliced in accordance with the nature
>+	 * of the command. In the event of timeout, the mailbox state is
>+	 * indeterminate until the next successful command submission and the
>+	 * driver can get back in sync with the hardware state.
>+	 */
>+	if (mbox_cmd->return_code == CXL_MBOX_CMD_RC_BACKGROUND) {
>+		int i, ret;

bleh this "ret" really wants to be a long.
