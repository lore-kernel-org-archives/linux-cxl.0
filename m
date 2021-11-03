Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC82C433F5
	for <linux-cxl@archiver.kernel.org>; Wed,  3 Nov 2021 22:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B5D6610FD
	for <linux-cxl@archiver.kernel.org>; Wed,  3 Nov 2021 22:13:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbhKCWQK (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 3 Nov 2021 18:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbhKCWQJ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 3 Nov 2021 18:16:09 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46511C061714
        for <linux-cxl@vger.kernel.org>; Wed,  3 Nov 2021 15:13:32 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id r28so3637250pga.0
        for <linux-cxl@vger.kernel.org>; Wed, 03 Nov 2021 15:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XyhF293mWz4a//9rv0Jm8ZRpJjsIoAacKdv7MCNZhlc=;
        b=JXyKC7NVroHcHRq/ktPi6TW7dr1Es2tyM8J+pO6O/bcYNyLFETIcgmB7fY9Fwl5/8q
         LuwjPex1dNQHEtH+mUOmuSTpiLZyB53myC6XYI4u0rqRRCSq5bvMuHL6QYwkwuLN0373
         xv7661JsqaidtqFmKDXc9hZJIdWbCDoyIaUzurwq/1G//LvvBDh0fMtVqCPsTSh38N09
         SeN0UL7c5QYNnNuCqkal2NxwS1B0Av63o4gKguvTst+1vC6oglom8ZKdHYxWwIpLUnjO
         wyeItqlg+bggIX24kicN4durcmGhzwrL5Yp/AwtQZLh3IVx0ipiGtGZdnzDLbyAFCc+z
         YaWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XyhF293mWz4a//9rv0Jm8ZRpJjsIoAacKdv7MCNZhlc=;
        b=MjC9MLZ+LqQz91h+t1lqkDRHcjebwgaRtm+ngITbnJX58ATALY2suEF8Jiz/4p+7GW
         QRQRQw4mpLCDm2kBPQMr0v80gV8oPSRDSIy8VDILb3cfm/FCfh53N0n7B4k5bBqW3LAj
         oL+dkTPOHQGk3RGpSscY3OiAS6MEp5fv9R/PVWAMskEZixWNgoWdmow/kj0x5zBzE3Og
         OKAknDLUplauDwCUbilys30N+3CbrQJ2fHLMOTreApF31fq/jVYcolMpTwLgtq6btWjh
         7GmQmnjksSpduMhNjmUpXZMzUSetpBxS92ilHwom2OLMmetyjidkeZiN03DzTKax4mPI
         1XnQ==
X-Gm-Message-State: AOAM530GUVba5hsa19GOOoJJrZ1lwnmpKVSJ9VwXEZnA550X1pZtHlJD
        rQ3QqczsdURYKCXNMvTs2BkWvKdbhbJElgYoMLhNqQ==
X-Google-Smtp-Source: ABdhPJztg5gkopF2124vj614d38uexUKYzekAopXGlEQxlKRNUiaLG+Mt6n4R/Pf6/sJGjqM3HuiiSoRohnyFhSQoVk=
X-Received: by 2002:a63:85c6:: with SMTP id u189mr22379254pgd.377.1635977611747;
 Wed, 03 Nov 2021 15:13:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAPcyv4hcgh2gb8qsS_UXTBSGqYfMPnC6p5kkvNUjm+V6kVKM5g@mail.gmail.com>
 <20211103204103.3687550-1-ira.weiny@intel.com>
In-Reply-To: <20211103204103.3687550-1-ira.weiny@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 3 Nov 2021 15:13:21 -0700
Message-ID: <CAPcyv4gQeZ6PUQswGe61Vd7u0qXOEL8V9Bp0FMJxfj480yh=LA@mail.gmail.com>
Subject: Re: [PATCH] cxl/cxlmem: Remove unused cxlmd field
To:     "Weiny, Ira" <ira.weiny@intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Nov 3, 2021 at 1:41 PM <ira.weiny@intel.com> wrote:
>
> From: Ira Weiny <ira.weiny@intel.com>
>
> This field was left over when the connection between the cxl_memdev and
> cxl_mem was tighter.  It is no longer set nor used so remove it.[1]
>
> [1] https://lore.kernel.org/linux-cxl/CAPcyv4hcgh2gb8qsS_UXTBSGqYfMPnC6p5kkvNUjm+V6kVKM5g@mail.gmail.com/

Looks good, although I'll probably fixup the subject to:

    cxl/memdev: Remove unused cxlmd field

...to start to standardize on a prefix format of
cxl/$(infrastructure_area/C file name). Previous commits used
"cxl/mem:", but I think going forward that prefix can be used for
changes related to the driver in "cxl_mem.ko". Where "cxl/memdev:" is
for changes related to the base 'struct cxl_memdev' infrastructure.

The only reason that drivers/cxl/cxlmem.h has that redundant mention
of "cxl" in filename is to avoid collisions with
"arch/um/include/shared/mem.h" on ARCH=um builds. So "cxl/cxlmem:"
triggered my naming finickiness.
