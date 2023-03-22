Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 148BDC6FD20
	for <linux-cxl@archiver.kernel.org>; Wed, 22 Mar 2023 00:35:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjCVAfJ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 21 Mar 2023 20:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjCVAfI (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 21 Mar 2023 20:35:08 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02AD574E1
        for <linux-cxl@vger.kernel.org>; Tue, 21 Mar 2023 17:35:07 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id D16203C284A;
        Wed, 22 Mar 2023 00:35:06 +0000 (UTC)
Received: from pdx1-sub0-mail-a273.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 3C2083C2E11;
        Wed, 22 Mar 2023 00:35:06 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1679445306; a=rsa-sha256;
        cv=none;
        b=OBsxZpy/TLeiN7paDbKQuHYsfm62PEX0oEWmHN3ByRXoulogBLkaGy3MkoQNTFP0D0HRnU
        mcxlX8UOj4wXwI+RdgckT4lAulW2tgJRn+E4Q4Y678FMRIpT8lI9mWX/WyqPZdm9Nj7RTw
        4B3k6W46+puk3oOlIuZkeim5D4rlJRu5fOuAKwKjIKSo2079bjJTdEmCQk1+sVlQIVDpQJ
        tEMK6HSVuSDEtcued5ElXGETQ2kxRsVtXBr4+2lB06DW+HLbjBdFQzRAUjplabGaK8t1wx
        wnoPWzNyu+3exGxs6d6e9wOEc0n01DvklrVkVei259+IAjkphcFDgmsLoYS/UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1679445306;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=LHl8Ycm5DtFIhQfcd3H5apDVy6yPkxbG0UAMI5K+ejg=;
        b=aadJlu49rcCGLyDdzl+beMXRDvlWDd9+L9SV9ta2KFvImt85FEY26cTE/mhj0wuCpRKGrQ
        54Qg727nfWvUTmwqGqeEtuRK9JaX+HE194SQYFcDexVMMXElmRBtaaDoTbXYwnYWgcr2x7
        +HXihLODMScjWQPRpUcKtg0YE/P0/0iH7c/45Du2w+1yefd8WHJekNNwIZpK7F+jd1R0//
        YwUEdFEZIvslH7SKIEAjaoONpffD2TfMKhHvNiIO1Crranl7Y7EXuPOFJhbAIOA5u2qBAI
        Y0ZTAcG/1tKawpFfbSR07uPPo+u+Qpdqn2KG9+osBq/BWxew1BKePA+oEtrqTg==
ARC-Authentication-Results: i=1;
        rspamd-766d96cb5b-l7sxs;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Slimy-Arithmetic: 18ffe9961b2eb66b_1679445306643_2275959767
X-MC-Loop-Signature: 1679445306643:3369902498
X-MC-Ingress-Time: 1679445306643
Received: from pdx1-sub0-mail-a273.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.104.253.212 (trex/6.7.2);
        Wed, 22 Mar 2023 00:35:06 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a273.dreamhost.com (Postfix) with ESMTPSA id 4Ph8d54CL8z2F;
        Tue, 21 Mar 2023 17:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1679445306;
        bh=LHl8Ycm5DtFIhQfcd3H5apDVy6yPkxbG0UAMI5K+ejg=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=Jv/cYzEjxIwuAiNIpL+g6g5CwpRjnHWAuX556pAlStouW6BHLgr/GeTfk5ipvfavz
         LActfK45yvXyDhdAqQN3izWZcNISCZXN/5Jd2zOL/M9GJdqJrbP5TqUE7WdDcfotYH
         KsBbedbs+yj99Wml5q/Bdv37apNcSoTCdE8RiVsuMQFs3z/WbHhBbjX0+vfjwn34dP
         CR6kWnywYiV3dbmQ3kRfKcJvWtCxT5AUo5ajUizCmbbRHoHUUds5duJ8B3TcW1V+Pb
         DkjWaF8rBxuCgTCyqBVwYtw4IBnWAstNOyk0wtWpFtRFClMRQ/0OO1S6yP+00WEmwm
         TIsQQ1xFALA6g==
Date:   Tue, 21 Mar 2023 17:05:14 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     dan.j.williams@intel.com
Cc:     jonathan.cameron@huawei.com, ira.weiny@intel.com,
        fan.ni@samsung.com, a.manzanares@samsung.com,
        linux-cxl@vger.kernel.org, dave.jiang@intel.com
Subject: Re: [PATCH v3 0/7] cxl: Background cmds and device sanitation
Message-ID: <20230322000514.nlxg5u3oryep3eag@offworld>
References: <20230224194652.1990604-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230224194652.1990604-1-dave@stgolabs.net>
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 24 Feb 2023, Davidlohr Bueso wrote:

>Hello,
>
>This series adds support for the rest of the security related cxl operations
>which are not strictly dependent on PMEM.
>
>Patch 1 adds the required background cmd handling bits (polling and irq).
>This is really the main motivation of the series as there are various
>features that will need this regardless of sanitation.
>
>Patch 2 adds a new sysfs 'security/state' file, which shows "disabled" if
>no security features are available - which is more intuitive than no showing
>it.
>
>Patch 3 adds a way to check if the device is actively used by tracking regions
>with target the memdevice to sanitize. I realize this might not be what is
>desired and wanted to get the expectations for this. This is more of a RFC
>patch.
>
>Patches 4-7 add the Sanitation and Secure Erase support, per CXL3.0 specs.
>
>These changes have been tested with both the mock device as well as with qemu[0,1].
>
>Changes from v2 (https://lore.kernel.org/linux-cxl/20221206011501.464916-1-dave@stgolabs.net/):
>- Redid the bacground cmd handling to use a syncronous approach instead.
>- Added cxl_memdev_active_region() to check if the memdevice is being used
>  (actively decoding any HPA ranges).
>- Create a new security sysfs directory with a 'state' file which is always visible.
>- The sysfs files' to trigger the security commands is only visible if
>  cpu_cache_has_invalidate_memregion().
>- Added a sanitize test for the mock device.
>
>Please consider for v6.4.

Hi Dan, ping? I would like to see were we stand with this series and hopefully
still time for 6.4 material - but that's not important. The open points which
imo would best be answered before attempting a v4 based on the current input:

- Are you ok with the approach in patch 1?

- Are you ok with security directory always showing at least the state file? As
Dave mentions this differs somewhat with nfit, but for that matter so does the
whole security semantics (this is now a directory vs a single, multiplexed file).

- Regarding ensuring the device is not actively decoding, would Alison/Fan's suggestion
to use commit_end/hdm_end instead of my hacky patch 3 be feasible? Or did you
have something else in mind?

Thanks,
Davidlohr
