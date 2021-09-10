Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B19DEC433EF
	for <linux-cxl@archiver.kernel.org>; Fri, 10 Sep 2021 23:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AA61611AD
	for <linux-cxl@archiver.kernel.org>; Fri, 10 Sep 2021 23:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232396AbhIJXN0 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 10 Sep 2021 19:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbhIJXNZ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 10 Sep 2021 19:13:25 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F630C061574
        for <linux-cxl@vger.kernel.org>; Fri, 10 Sep 2021 16:12:14 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id e7so3205401pgk.2
        for <linux-cxl@vger.kernel.org>; Fri, 10 Sep 2021 16:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=My1hAE9UmvbgPd70gpjzYyJu5HDdDMTj7h2LXux7u6E=;
        b=eymDm++BE1h/91SFvWExKk4oFFpC3TnF/bPY49s6bOjzUXuy3IVLz4Q+Z9owwSWvjN
         qQQ/JCRGaO8bV6e+bnR8Y0Q7LAQYRc9Nf2Q5sPaJVyp7YZuoiwO+RTjMBt8MBa2zVu1z
         6VTm/er6dklLC6OBxJfiOaGxkdWqIEypCIiVS9cf2bTZORxOr0+tnkxn1ShfCbWlnTq4
         T9yryCatmazsOuCDksqi5OcyltCThZ/5G6w0X9VbHWhptAPh0brqdRc9lr1DMhRLmd8C
         7p+/2dTnDrPFZOR1jt5NX3Uyeln0670HNSJQ7mN8/SiAB5n0pDG6PkfTlzsgdDAtYaNC
         HOeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=My1hAE9UmvbgPd70gpjzYyJu5HDdDMTj7h2LXux7u6E=;
        b=HiNcEq7zfKARs6k1JfglctuAdcvV4DTnIJommB5r0V5EePHosdIwdZFisRbb3DlbON
         QYODYbDcdJgR0Gggs4EPU2YkQQx6N1zEZja3k+E/y+1KRmuL+8fhST1QkHL46H2wYT+w
         oMBKunhFe8Xt1Yo/5Ht/M2iV/Zi+ngE7N+gDMggaHFjZsc7gvI1GoFIJNwiF+aLg0o8g
         1IAJvCqlst/m3eJcFYu7USz3uN75vf4ocx6ss+YZFOvcunWtLjU04JuOZNsQ+bs1nBKc
         wzNV/cvktuU9EzOGZw/Hzs/V1RFV+We99VSfZlODWzUk/2K7y5X7Kz/DEf3Ww+tShgV5
         9e/Q==
X-Gm-Message-State: AOAM531fGo4mtkzbVODMOxRpuSabFgNqe3BeZOP8j7CQKEvZULEphhG8
        tHzvYi+GyDH5KQCGJ+KxIjB+3dRU5Rm0xLAFwrx7hw==
X-Google-Smtp-Source: ABdhPJyCoLGGixBJwjqUFKEWUKvqvcwYs3rW/+bc6SOxptYF4Mm8EC/+OEOC3/mdkDzdlVuwh+mcTjeShWvGd69kfAE=
X-Received: by 2002:a63:1e0e:: with SMTP id e14mr102405pge.5.1631315533888;
 Fri, 10 Sep 2021 16:12:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210902195017.2516472-1-ben.widawsky@intel.com> <20210902195017.2516472-10-ben.widawsky@intel.com>
In-Reply-To: <20210902195017.2516472-10-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 10 Sep 2021 16:12:03 -0700
Message-ID: <CAPcyv4iaSJuo2UUwO+LgXVO5QEBwvr20rLeKuHZ_2QJ-XizC+g@mail.gmail.com>
Subject: Re: [PATCH 09/13] cxl/pci: Retain map information in cxl_mem_probe
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Sep 2, 2021 at 12:50 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> In order for a memdev to participate in cxl_core's port APIs, the
> physical address of the memdev's component registers is needed. This is
> accomplished by allocating the array of maps in probe so they can be
> used after the memdev is created.

Is this still needed if you append this map information to the memdev directly?
