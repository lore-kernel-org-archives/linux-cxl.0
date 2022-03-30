Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 831FBC433EF
	for <linux-cxl@archiver.kernel.org>; Wed, 30 Mar 2022 00:42:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241179AbiC3AoY (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 29 Mar 2022 20:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233084AbiC3AoY (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 29 Mar 2022 20:44:24 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5513182AD7
        for <linux-cxl@vger.kernel.org>; Tue, 29 Mar 2022 17:42:40 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id n18so19097773plg.5
        for <linux-cxl@vger.kernel.org>; Tue, 29 Mar 2022 17:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w8HogclTMgmXbtv6l9NSXrYFja93QdZ6Yt9uotZLQUc=;
        b=TjxoX7G5yw2SJq49ElFfMokU/ROWD7iDVdjs4PBqjOCoErQd12BJmPs3Ven/TkpiWR
         s0SHope5Yhe3RoSG1n123PCOLaLz72j/koLCwpgWInlUROjRIeByZZFdKkvvOitp5MS8
         uA37LPFqs5/7Wy0XXs/K74CQIzlHEQ/EpKQHjZnDhDYttJCz8q5t7BsFYstcVpD/8YWi
         DnQtjPykN6ztFGEcOsSEovPGwSsj7Jp3SO4cmsw3zccKt6quQuMfngoj1BBc7SdyHly3
         FCqOpjIwFzhfG4s2epv1VoUfjJKknVrzpwnjQuIjt473B4AV0uW4Aet5QYx7+5qOMnFq
         Ciug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w8HogclTMgmXbtv6l9NSXrYFja93QdZ6Yt9uotZLQUc=;
        b=4eh2sCu0dn4K5DEBSjJMZaO4jyQ103FQEbuUILroRG+kPFICj6dgsz2QnNlgR8yovJ
         ry/YBVZkcbKBpqzS+0+3l0ZVtZalCxaGH9LWTxd5xBXFsXAeeuARk+3tCMI9OJj807yv
         BBl6ivSdiYZXMGvWIGkC7vKoyjPQAjslwNCOtc9d3/g0v1JSLNdvICPbxMKylhbx5ZmF
         sWgMg4Be/NMFBBGAq0+tivEGWTu0gzlx+mrVtxA5VPkDQc/l4YoqghD9An3So9huAPVm
         3/zmITzii7CCQDqJHPL1jehb5JsVj23zygJ9Hj94KMp+y7UuqLcnJZh2Q78L49opwCS6
         HJNg==
X-Gm-Message-State: AOAM533acIp9VBE3KpqncPGYFKbTWn7h9W8qUSji8FXyakR7GnkVrmoS
        BNPm4Gz9eOd1z6VbwxpDUd/ztRFamdM9yYLNjabODA==
X-Google-Smtp-Source: ABdhPJxrCItJLRZ0qytpxbYC7anMvsekGXyq/3FbMjxN1LBdKnr6CqBkFf6r26I8Z1aaM3h1N4fA5QubZFTh8lrHfnQ=
X-Received: by 2002:a17:90a:430d:b0:1bc:f340:8096 with SMTP id
 q13-20020a17090a430d00b001bcf3408096mr1895696pjg.93.1648600960396; Tue, 29
 Mar 2022 17:42:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220317234049.69323-1-dave@stgolabs.net> <20220317234049.69323-6-dave@stgolabs.net>
In-Reply-To: <20220317234049.69323-6-dave@stgolabs.net>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 29 Mar 2022 17:42:29 -0700
Message-ID: <CAPcyv4jn2LqwZ0LG3pFG1tWP21U_bbMJSO1STOc0N_rg=KRa5Q@mail.gmail.com>
Subject: Re: [PATCH 5/5] cxl/mbox: Retry sending mbox command upon RETRY return_code
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Mar 17, 2022 at 4:41 PM Davidlohr Bueso <dave@stgolabs.net> wrote:
>
> As mentioned in CXL 2.0 specs: the hardware can set a Retry
> Required if the the command was not completed due to a
> temporary error. An optional single retry may resolve the
> issue. This is the only retry case as in general they are
> not recommended for commands that return an error.

So I disagree that the driver should be deploying this behaviour by
default. This was also tried for the ACPI NVDIMM commands and it was
helpful for Linux to not play along and get the firmware implementers
to get their act together and detail when a retry is appropriate. So,
this policy is up to the submitter. If that agent has information that
the kernel does not have about a retry being effective, it is free to
attempt the retry after the failure. Otherwise, the spec is overly
hopeful in expecting an implementation to attempt a speculative /
optional retry. Hopefully, a default Linux policy to fail commands
that end in a retry encourages fixes to devices / firmwares that want
to use optional retry as a crutch... or it encourages the discipline
to come back to the specification working group with explicit
per-command updates to define the scenarios when a retry is mandatory
and not optional.
