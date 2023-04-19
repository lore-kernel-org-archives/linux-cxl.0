Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D32C6FD18
	for <linux-cxl@archiver.kernel.org>; Wed, 19 Apr 2023 16:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232876AbjDSQ7w (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 19 Apr 2023 12:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232779AbjDSQ7u (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 19 Apr 2023 12:59:50 -0400
Received: from crane.ash.relay.mailchannels.net (crane.ash.relay.mailchannels.net [23.83.222.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 775F8768D
        for <linux-cxl@vger.kernel.org>; Wed, 19 Apr 2023 09:59:45 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 3E075921D05;
        Wed, 19 Apr 2023 16:59:42 +0000 (UTC)
Received: from pdx1-sub0-mail-a213.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id CA125922487;
        Wed, 19 Apr 2023 16:59:41 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1681923581; a=rsa-sha256;
        cv=none;
        b=dmB2NqYmKRmAFWCciejmpxSeECPKPrm8oBmlJuFPth06T4KlMWocznc9r+bIxoUqJGKS9G
        UX2KVGDLBDkh4sbpRQo7uqd2XozA9Vc9pBbWHvDh1XV+NP3dxT6x72y8Yegl7X7xFZ0sqx
        sbWTAdrfKPpEbutRl324sneYO7O4VhFk5UXzM4yTyodKvOEZAOtq61qdqrCnbbIxN7qcFV
        qlmZlHNKdWiWuwxv4P/8F32kqJbO0kyLczNS60Ad3UlNnK0ktS5jK9z+cHamvFJ+3ANZqN
        +ZacBW+BeoJ6yWjxFRvCPSXWwFDndVgBmkDSGHgj7jX3nJRJXcacZcL+NrMeXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1681923581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=GlrpWBKuaBYpoGqiFZcArxHP4M5nLzmSf3cbUH4Pkvk=;
        b=6WudLw9fQO+Cj8c8w8vIuwJwkN3xAq+Ln7Zl7Bw3Wd59ihM9nu+uMIRm8iSihSE8RhyRyU
        jyjnxME3JLeQx0HGKcSWD9ViHFqUAvWB5SGCAUYVgUmIvs/gROP+uALunvszpsYJYXksF/
        4qloTlUX8PHRbxtcfvVespJaF0Yr+aNvtQoNURsbAq0A8vcB+HQNfqh2PlRn82jxzi1CXm
        ayvIWgvkwNGlZx6GoA3rlF5BxF/JFFaH2saccQWDhoXgKslCvqjd5XtuHvE1tx1RwM+dbH
        MtavLzsrH/oe3MI9eDWJtxcCbpG0WG98c8vIx5KqSKzvw3iFMiCjFRziS+pdTg==
ARC-Authentication-Results: i=1;
        rspamd-548d6c8f77-vg5nb;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Turn-Share: 7dc958573033c7c1_1681923582066_1204608209
X-MC-Loop-Signature: 1681923582066:226369558
X-MC-Ingress-Time: 1681923582066
Received: from pdx1-sub0-mail-a213.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.123.193.181 (trex/6.7.2);
        Wed, 19 Apr 2023 16:59:42 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a213.dreamhost.com (Postfix) with ESMTPSA id 4Q1n8F2cDHz4C;
        Wed, 19 Apr 2023 09:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1681923581;
        bh=GlrpWBKuaBYpoGqiFZcArxHP4M5nLzmSf3cbUH4Pkvk=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=X8+9ZFdfCJ0J56pCqfZWbo//6CSdjc+anDnYyxMNYRB81aJcQcr0W1OzlxJ3qQJUS
         RFushlcBUTTmBLJzD3CcXfzs+K9BRjrGPO3QEJwXBkmWnjMVq40aibyGERMZHIF0ur
         IOu7tKRtwr/FAmmJ4xvfg8tuj5nkGTW4i6XI1itoRzJ/3KHV6rJ5Y/exzfDkuAlBS4
         aL9bc4T0SOhUcbpJoGN1bcw6XQifXkZIgMVjEAL9y01UYCci199yCSoLkloFs1p50n
         kxZFt2UcVO1QGTnL2Bmgj8keRL2LdaDErP3LVoaJPexIGkmG+F/eTvsxuBdBelOSYR
         Oxw6gzmTztgIw==
Date:   Wed, 19 Apr 2023 09:28:14 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     RAGHU H <raghuhack78@gmail.com>
Cc:     linux-cxl@vger.kernel.org, alison.schofield@intel.com,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: Usage of tools/testing/cxl
Message-ID: <ttel3hfuygwhdi5ds6zmn27szvaf5holl66rvcbl55myaxarqg@cwgud6xhausf>
References: <CAGWUp4qXXOsFgJu9E__Y9FGhK0ARteOF-mP1P19rd3_5K=mgNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAGWUp4qXXOsFgJu9E__Y9FGhK0ARteOF-mP1P19rd3_5K=mgNg@mail.gmail.com>
User-Agent: NeoMutt/20230407
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 19 Apr 2023, RAGHU H wrote:

>Hello,
>
>Please pardon my ignorance, but would like to understand how to use
>tools/testing/cxl to understand the current kernel implementation of
>cxl code base & test framework(tools/testing/cxl).
>
>I have tried "make -C tools/testing/selftests run_tests", but it's a
>bit of a stretch and executes all the tests which may not be related
>to my quest for CXL.

Historically this sort of mock device comes from nfit, and it was originally
the only way to test anything afaik, before qemu came along - and now it's
mostly useful for simpler unit-testing approaches.

To properly use it I suggest reading the run_qemu.sh usage for cxl_test:
https://github.com/pmem/run_qemu/blob/main/run_qemu.sh

run_qemu.sh --cxl  --cxl-test

Thanks,
Davidlohr
