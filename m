Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19275C433EF
	for <linux-cxl@archiver.kernel.org>; Mon, 13 Sep 2021 22:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E812460FC1
	for <linux-cxl@archiver.kernel.org>; Mon, 13 Sep 2021 22:21:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237889AbhIMWXE (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 13 Sep 2021 18:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbhIMWXE (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 13 Sep 2021 18:23:04 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116D2C061574
        for <linux-cxl@vger.kernel.org>; Mon, 13 Sep 2021 15:21:48 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id t1so10789384pgv.3
        for <linux-cxl@vger.kernel.org>; Mon, 13 Sep 2021 15:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CO6JNhGxwzlrYeg/t2AMJl6r/zmgLnJENxYGTPgzp7I=;
        b=ih7DrdV4MOPf9iq7oHtkUamUdVH3SELbHI6yydBl4+sUK/+sYuiYt59B/uyllCZMIa
         7grK8W7MJ1XW4XnqgnFDCFZAcWClFY59Y+5HonPqmXGQ0q241/U7YBExdIupdlSmy9Gx
         bHXRiF538qqn9oW9mwu8DQAHgws/YySDaw9X3uE6yBYuYdh4moSgOmRqXUO8+cWswitp
         BZW101MWvvGjAsQvmyFIbn3fwxqM3vdnEcIzDe5CjbhhI27boUg5dBh04dooNkt2O798
         Qx1V90qrV5iCccgdDNatuovJved4GQ+cr7npOvt51g6KSCZfCoZ4/MXoD1wHVPGdBP5G
         lQOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CO6JNhGxwzlrYeg/t2AMJl6r/zmgLnJENxYGTPgzp7I=;
        b=mUjj3qGTo1G721xBBWm31/JlC7Dk15pfZrDn80u4X9JNFbaVDRaIWp6wFOcPMyGldL
         PsHTD6UQ0v0tLEZbMZawswKJcYfz7oBAx3SR/qEWyifMQsm1NAIT3f+QuRS/QSN++RtN
         t1sCqjH7Cm+YD0p82/KwjUpumLPqEmdGkREr6x1QJCIl48RDyIvZCmGY7MU5zCBMATAl
         rX0FBpdf+d4sCs1ZMvXkgaGdud5lrnpOI1AbtciRL6GjV1q7gK9SLtcC4ur0XvwDeHFl
         0fVJLkMMW9E3E3ORmh33dOxM1MX6D000rMe/vniPtSI9eWALKVADYyH8ZCpvGlBuG7UM
         zuPQ==
X-Gm-Message-State: AOAM532q0dk17N3/VM21pjQ2dYz4NGwfR7ajrO8aIafx5GrKkVzcCKCt
        QswZwv3Sj6oOeFxnelAGMjGlAfDyLArmLjTTECGybakfV2k=
X-Google-Smtp-Source: ABdhPJxRuPQAZqMjZlfQKUFNoNHsUfGvEt+EA8LeQiMKmg81qB6nYrbAQSpzw9xayxgeJiZiE6AhzqDuK8tZEIu0Ia4=
X-Received: by 2002:a63:1262:: with SMTP id 34mr12878848pgs.356.1631571707431;
 Mon, 13 Sep 2021 15:21:47 -0700 (PDT)
MIME-Version: 1.0
References: <163116433533.2460985.14299233004385504131.stgit@dwillia2-desk3.amr.corp.intel.com>
 <163157154183.2652718.10987214856112022775.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <163157154183.2652718.10987214856112022775.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 13 Sep 2021 15:21:36 -0700
Message-ID: <CAPcyv4gZ2WGsFZb0H1O+NirSRKRs2NDhByAF+nVdhFB-pdZgdA@mail.gmail.com>
Subject: Re: [PATCH v5 08/21] cxl/pci: Clean up cxl_mem_get_partition_info()
To:     linux-cxl@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huwei.com>,
        Linux NVDIMM <nvdimm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Sep 13, 2021 at 3:20 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> Commit 0b9159d0ff21 ("cxl/pci: Store memory capacity values") missed
> updating the kernel-doc for 'struct cxl_mem' leading to the following
> warnings:
>
> ./scripts/kernel-doc -v drivers/cxl/cxlmem.h 2>&1 | grep warn
> drivers/cxl/cxlmem.h:107: warning: Function parameter or member 'total_bytes' not described in 'cxl_mem'
> drivers/cxl/cxlmem.h:107: warning: Function parameter or member 'volatile_only_bytes' not described in 'cxl_mem'
> drivers/cxl/cxlmem.h:107: warning: Function parameter or member 'persistent_only_bytes' not described in 'cxl_mem'
> drivers/cxl/cxlmem.h:107: warning: Function parameter or member 'partition_align_bytes' not described in 'cxl_mem'
> drivers/cxl/cxlmem.h:107: warning: Function parameter or member 'active_volatile_bytes' not described in 'cxl_mem'
> drivers/cxl/cxlmem.h:107: warning: Function parameter or member 'active_persistent_bytes' not described in 'cxl_mem'
> drivers/cxl/cxlmem.h:107: warning: Function parameter or member 'next_volatile_bytes' not described in 'cxl_mem'
> drivers/cxl/cxlmem.h:107: warning: Function parameter or member 'next_persistent_bytes' not described in 'cxl_mem'
>
> Also, it is redundant to describe those same parameters in the
> kernel-doc for cxl_mem_get_partition_info(). Given the only user of that
> routine updates the values in @cxlm, just do that implicitly internal to
> the helper.
>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Reported-by: Ben Widawsky <ben.widawsky@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huwei.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
> Changes since v4:
> - Update the kdoc for @partition_align_bytes (Ben)
> - Collect Jonathan's reviewed-by pending above update.

Ugh, nope, still had this change in my working tree. v6 inbound.
