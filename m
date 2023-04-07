Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E45C76196
	for <linux-cxl@archiver.kernel.org>; Fri,  7 Apr 2023 21:05:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbjDGVFg (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 7 Apr 2023 17:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjDGVFf (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 7 Apr 2023 17:05:35 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648451A8
        for <linux-cxl@vger.kernel.org>; Fri,  7 Apr 2023 14:05:34 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dragan@stancevic.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id BDA853E0DD7;
        Fri,  7 Apr 2023 21:05:33 +0000 (UTC)
Received: from pdx1-sub0-mail-a294.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 3A64C3E0D55;
        Fri,  7 Apr 2023 21:05:33 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1680901533; a=rsa-sha256;
        cv=none;
        b=Qu/itOePCsskU3vANFpP/4p521obpDk6yD19a6SFemDjn2xDf3PFt65U9f/WAU6hXHJjP5
        zGxkBpYPBFuMCtZh+0A08QmEbncKDRPKrIZAlGHj2iUZigks0nvypkIw1a/o30iVZxOliq
        x78oLC+1RrOMcXKsiLLmxgeiFOESq5E7m1HDu6tUiW9teD/5u18mTi6idJRI/amXULnKBN
        vI0U5ztGje8/VrKjr5sF3SbPjHarTkDATUCD1tYgdqOUlE7uUt6D8eWmuG4LxYH076RWQA
        u0UTGorZ20OSzM3NJoSPWN/F65IM+EE3G2FL9VrKdK0wbVeu4ybAQg5/Vp3Xtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1680901533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:dkim-signature;
        bh=kLIJVh6wZLoGZw5fjUt2cLYd3LiMD8Ukj+V8GN1qqDw=;
        b=wHio3Dcz1x2wFzyGP3fl8LFvNdLic5oEra+5A/kyJdI8vomv01oIlqMq0ELluO0odVFFi7
        30POCwV/+S2svcerKtx3Wu6e2BvZ/AIM+8SBvc2NTC6wwFepZzS5nz+aQEp49wxrBEx5HE
        tk6LKDqiQZLH+bjsgQFLvYkCyBczErKcyBc4sG5O08sL2RbL3fwlMYSga7r7FFEvYYAEOr
        qURcvCcm0lMGwjFglW9bofL163dAkioO6zKxUy50pPdpjjmUlTQJUXYPQmlHIzijPmszmE
        BLjQngC8HpmXcg6p09aXpKy4nZMrF5kCmsSXHwaT+0lBa8bIz3sXGQqvB9B2VQ==
ARC-Authentication-Results: i=1;
        rspamd-5468d68f6d-w9llh;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dragan@stancevic.com
X-Sender-Id: dreamhost|x-authsender|dragan@stancevic.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dragan@stancevic.com
X-MailChannels-Auth-Id: dreamhost
X-Blushing-Shrill: 295646891d38cf94_1680901533540_2485106083
X-MC-Loop-Signature: 1680901533540:1185009869
X-MC-Ingress-Time: 1680901533540
Received: from pdx1-sub0-mail-a294.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.107.49.248 (trex/6.7.2);
        Fri, 07 Apr 2023 21:05:33 +0000
Received: from [192.168.1.31] (99-160-136-52.lightspeed.nsvltn.sbcglobal.net [99.160.136.52])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dragan@stancevic.com)
        by pdx1-sub0-mail-a294.dreamhost.com (Postfix) with ESMTPSA id 4PtW9S4XX8z1p;
        Fri,  7 Apr 2023 14:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stancevic.com;
        s=dreamhost; t=1680901533;
        bh=kLIJVh6wZLoGZw5fjUt2cLYd3LiMD8Ukj+V8GN1qqDw=;
        h=Date:From:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
        b=DHxS1AfWkJQkwbsb/LA19+voTqVgUO7werTheAxLVFukpaa2dWicDpU4Rmg6krKLt
         mS78yopjTFpzQ9x3x9pgahOlqWA3k5MzMKoElOPn++0odQiynPzEcxoT+B7jOR4cHf
         3GSNcoOFbQ9+bsxyqDw4KmCcxlGJ2Qnziscdv1fPYsu5etTfM0DSNJoZs72ADFt4/p
         tfStFtH5YLqqGe+g+tFsZIBFoGQ6q7F3QncBoEy0e80SciHTJjFug6g7vLhauLXik4
         aKr/NOEpgsaw3ZI5lKmKcpUdsxJrsis/TRZCOhNrvmn9jRT1achGZE8jTF76p0MqK2
         9znY324r1HUnQ==
Message-ID: <5d1156eb-02ae-a6cc-54bb-db3df3ca0597@stancevic.com>
Date:   Fri, 7 Apr 2023 16:05:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US
From:   Dragan Stancevic <dragan@stancevic.com>
Subject: =?UTF-8?Q?=5bLSF/MM/BPF_TOPIC=5d_BoF_VM_live_migration_over_CXL_mem?=
 =?UTF-8?B?b3J54oCL?=
To:     lsf-pc@lists.linux-foundation.org
Cc:     nil-migration@lists.linux.dev, linux-cxl@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hi folks-

if it's not too late for the schedule...

I am starting to tackle VM live migration and hypervisor clustering over 
switched CXL memory[1][2], intended for cloud virtualization types of loads.

I'd be interested in doing a small BoF session with some slides and get 
into a discussion/brainstorming with other people that deal with VM/LM 
cloud loads. Among other things to discuss would be page migrations over 
switched CXL memory, shared in-memory ABI to allow VM hand-off between 
hypervisors, etc...

A few of us discussed some of this under the ZONE_XMEM thread, but I 
figured it might be better to start a separate thread.

If there is interested, thank you.


[1]. High-level overview available at http://nil-migration.org/
[2]. Based on CXL spec 3.0

--
Peace can only come as a natural consequence
of universal enlightenment -Dr. Nikola Tesla
