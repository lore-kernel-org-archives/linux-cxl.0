Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAFCEC433F5
	for <linux-cxl@archiver.kernel.org>; Fri, 10 Sep 2021 19:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C42A06113E
	for <linux-cxl@archiver.kernel.org>; Fri, 10 Sep 2021 19:27:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbhIJT2e (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 10 Sep 2021 15:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232310AbhIJT2e (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 10 Sep 2021 15:28:34 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0AEDC061574
        for <linux-cxl@vger.kernel.org>; Fri, 10 Sep 2021 12:27:22 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id i24so2727836pfo.12
        for <linux-cxl@vger.kernel.org>; Fri, 10 Sep 2021 12:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H2NuBtqsXlS08TAg5eIBe66aoN1bcVzaf/4YKBKstKQ=;
        b=QApP7p14QDlbi/7izCqOZDZ16C0mAevDgDaU9GqWq3qh4ScOv8W8HVIMLQFXSV5lq7
         CdPgCqf7mbMOcWtXlsMsT98olANV4/0WK6o9cBo0D683vpYsUu4imqQfwI5V/mCJXLCa
         oVlHsIFU8e7pZfDte3fnhE7ILLDma2BQZMuvsb08Q1+ROzHqc014b3GgLS6bN9Bh+bJg
         xPgpvOpA2jgzP5jidfGw1crzAgv0K6KWfjw36fI5ION1SLELrKHHGsMClatwYPm3CZcB
         Hg6JBSvOIr8lFPP+NfavERz/fmVk+KK4Z7XrgmAI5IGIRQJpHKfVxb5d/wFDA+ZkGqMx
         PxBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H2NuBtqsXlS08TAg5eIBe66aoN1bcVzaf/4YKBKstKQ=;
        b=WzySwqQx0ZtxNEY8cpDtuormF/9sjqu3FAtkFFhd27Gqmi5zU6jHMeSF+3i8iXh0uU
         TkNdWUP/ch8LMCR4ZyjDCbykHa3MWlS5l0Hk3Jki5grPSu/ewYcRQM0S8fTaTNFBLT0l
         syVUvqkRTNJSRwwJU0DI0aXtdQNb5Kk7aolAq4ePsmoj/jIok3lYMrA68RrOCnjfulZF
         V/7uyQjfCFtjPOUtBojAGaG9aqRbnDNKnfk/8gdaKd/1ZrIwndioGfL7aeU2PGlW1UFF
         tWufj/YNH8L/cSyyoAVZILFg+WSwUej1XHmjyqFSbv6acfq70HGUNZtH1fsN8AJOQphX
         PYUg==
X-Gm-Message-State: AOAM5302+ZYqvxUZBoWQnM5NcmEG7PlUHu52GGVr9O6TMzHdzdAZ2+dr
        3xc7SW4W+uIxQGwEgmCo/uPtuC8SsiPGHhXMVHRkmDx68iQaLg==
X-Google-Smtp-Source: ABdhPJwXjurz9ySlX4qBXLO047VwjuSLxyksuhciSzH5791joI6taPOvmdCQjRSUOsdf1brqdmBWMZ1MyNk0TQA12dc=
X-Received: by 2002:a62:6d07:0:b0:40a:33cd:d3ea with SMTP id
 i7-20020a626d07000000b0040a33cdd3eamr9203881pfc.61.1631302042340; Fri, 10 Sep
 2021 12:27:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210902195017.2516472-1-ben.widawsky@intel.com> <20210902195017.2516472-6-ben.widawsky@intel.com>
In-Reply-To: <20210902195017.2516472-6-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 10 Sep 2021 12:27:11 -0700
Message-ID: <CAPcyv4ivjUqTwd9QiGQ1hHxPwu4Czw0M1Ht5po+cGEiQbvU4ew@mail.gmail.com>
Subject: Re: [PATCH 05/13] cxl/pci: Disambiguate cxl_pci further from cxl_mem
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
> Commit 21e9f76733a8 ("cxl: Rename mem to pci") introduced the cxl_pci
> driver which had formerly been named cxl_mem. At the time, the goal was
> to be as light touch as possible because there were other patches in
> flight. Since things have settled now, and a new cxl_mem driver will be
> introduced shortly, spend the LOC now to clean up the existing names.
>
> While here, fix the kernel docs to explain the situation better after
> the core rework that has already landed.
>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---
>  drivers/cxl/pci.c | 70 +++++++++++++++++++++++------------------------
>  1 file changed, 35 insertions(+), 35 deletions(-)
>
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index b13884275d96..6931885c83ce 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -16,14 +16,14 @@
>   *
>   * This implements the PCI exclusive functionality for a CXL device as it is
>   * defined by the Compute Express Link specification. CXL devices may surface
> - * certain functionality even if it isn't CXL enabled.
> + * certain functionality even if it isn't CXL enabled. While this driver is
> + * focused around the PCI specific aspects of a CXL device, it binds to the
> + * specific CXL memory device class code, and therefore the implementation of
> + * cxl_pci is focused around CXL memory devices.
>   *
> - * The driver has several responsibilities, mainly:
> + * The driver has two responsibilities:

Perhaps:

s/driver has two responsibilities:/driver's responsibilities include:/

>   *  - Create the memX device and register on the CXL bus.
>   *  - Enumerate device's register interface and map them.

..since there are other things to add here:

It also registers an nvdimm bridge device, and you might mention it
registers the mbox_send mechanism to mailbox core. Later it will also
be responsible for coordinating the retrieval of the CDAT.

> - *  - Probe the device attributes to establish sysfs interface.
> - *  - Provide an IOCTL interface to userspace to communicate with the device for
> - *    things like firmware update.
>   */
>
>  #define cxl_doorbell_busy(cxlm)                                                \
> @@ -33,7 +33,7 @@
>  /* CXL 2.0 - 8.2.8.4 */
>  #define CXL_MAILBOX_TIMEOUT_MS (2 * HZ)
>
> -static int cxl_mem_wait_for_doorbell(struct cxl_mem *cxlm)
> +static int cxl_pci_wait_for_doorbell(struct cxl_mem *cxlm)

Should this be cxl_pci_mbox_wait_for_doobell() to match the other helpers?

Other than that, rename looks good to me.
