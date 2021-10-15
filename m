Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8463DC433FE
	for <linux-cxl@archiver.kernel.org>; Fri, 15 Oct 2021 20:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C9B7611C1
	for <linux-cxl@archiver.kernel.org>; Fri, 15 Oct 2021 20:16:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242989AbhJOUSy (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 15 Oct 2021 16:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242980AbhJOUSx (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 15 Oct 2021 16:18:53 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0258C061768
        for <linux-cxl@vger.kernel.org>; Fri, 15 Oct 2021 13:16:43 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id np13so7965905pjb.4
        for <linux-cxl@vger.kernel.org>; Fri, 15 Oct 2021 13:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GLrCUjMS6PpGbtB+8mhXMW1Ydnsrl8bMCJvRUQizels=;
        b=WVmWXqed83hwr0BldYX/afwa2GbpIGZwQjPSy/t/0JCMx9AA3HwxPAEoNSxpJnB0Yx
         fik28dWjsco5sZcynW6vCxEOGuDCcJkT3iUqTzko4G0XSQOOqA+QSRlWvgPkUzZ8V9vT
         4xwMKveUV/iuXskzwET7y/xGFKIkQhDlpaDHWOyGcvlA1O1xIIHo8ciWtrekXQ8bvaal
         alYpuUsz7ne8h38wf9qOthjsznOmfoClqe3jgW9ABNzMY2OCsxJTyAIrylM7Fevvghsz
         UpnlHNCPaziwRwsJVKVa9CXVQb/qVr+HtLg3/tKYpQyECxNGKlOz4xssnXiOuRWJeOcA
         R8ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GLrCUjMS6PpGbtB+8mhXMW1Ydnsrl8bMCJvRUQizels=;
        b=aPxKJnTlUKX4Ez4WQJ6kusS4EFjcD7RFvyyR0x3ZFbBfFMo8csXk6ebgnAHr2CdDS8
         lg5A0U/vuOLQXk0aZ8qpHFffuTUM0UXjcQMcCI9Egp4vOYdPHwKzLUAh6GeZGbsImkEK
         PmwXx8l8rnYA5IGv6GvPxn0mbadmOHh3xTEq6LxrtHf2Tl6/rAZWqovsN92Ql1QNsl/y
         WJCClHKipGW7pJWRPKkBw+QpoL9OdIpLq35dga5KHcikhApJDCs9RVhS6Q7DtsMRviP4
         V45Jfyw7aXtY4wQ8u1MUJUy2Nkwe7Hn9pTfOU3EX89ODryeW1sm1qD5QOG6m2WiCyepX
         X2ng==
X-Gm-Message-State: AOAM530Xp7khkdlpVULXlmP+gOpQCQuAsILjPDAg60cqk+z3KI0Lyd9J
        sCotkkvbIAD1crWRziSY/IXqfc+HT6+c0Ed25kR5jg==
X-Google-Smtp-Source: ABdhPJyqO7cyxR1HWTwbNFXiy3gHcuBypDcdwk0AxuecjBTkJfqydJHqiG8cOEwJT7yATjZpuEurgvMIvodG41/Bexc=
X-Received: by 2002:a17:90a:a085:: with SMTP id r5mr29951880pjp.8.1634329003303;
 Fri, 15 Oct 2021 13:16:43 -0700 (PDT)
MIME-Version: 1.0
References: <163379783658.692348.16064992154261275220.stgit@dwillia2-desk3.amr.corp.intel.com>
 <163379785305.692348.7804260538462033304.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20211015171507.000010dd@Huawei.com>
In-Reply-To: <20211015171507.000010dd@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 15 Oct 2021 13:16:34 -0700
Message-ID: <CAPcyv4hOyXdoDcVUu8+x=xQCTfQQbafWZwA_wqmHq57K5DpEBw@mail.gmail.com>
Subject: Re: [PATCH v3 03/10] cxl/pci: Fix NULL vs ERR_PTR confusion
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, stable <stable@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Oct 15, 2021 at 9:16 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Sat, 9 Oct 2021 09:44:13 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
>
> > cxl_pci_map_regblock() may return an ERR_PTR(), but cxl_pci_setup_regs()
> > is only prepared for NULL as the error case.
> >
>
> What's the logic behind doing this rather than adjusting the call site to
> check for an error pointer?

Minimize the fix for the stable backport. In the later patches the
cxl_pci_map_regblock() => cxl_map_regblock() conversion goes from
returning a pointer to an error code.

> Either approach is fine as far as I'm concerned though so this is really
> just a request for a bit more info in this patch description.

I can include that note above to clarify.

>
> FWIW
>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks.
