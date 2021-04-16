Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD5A7C433B4
	for <linux-cxl@archiver.kernel.org>; Fri, 16 Apr 2021 00:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9875F610FC
	for <linux-cxl@archiver.kernel.org>; Fri, 16 Apr 2021 00:30:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236771AbhDPAaY (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 15 Apr 2021 20:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236680AbhDPAaX (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 15 Apr 2021 20:30:23 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11220C061574
        for <linux-cxl@vger.kernel.org>; Thu, 15 Apr 2021 17:30:00 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id m3so30182606edv.5
        for <linux-cxl@vger.kernel.org>; Thu, 15 Apr 2021 17:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+JQ+5PYFrCESqWTWXQG4TnqoQj2dB5lWApYO0AEnXqE=;
        b=Wj71gi/NPwcdU7VxwkIuTewf0E3DQtS1gGmF0wjZmgow4McMk8Sd87vKneMXrfWMyR
         6FqaKhlj+5LI5cqkUVAuPOJB9Gyv6nKbx7DZ4FlopTXBwNagwohiv0dZVTND9D8939D+
         s1Lza341vtLWJjpfQbkHfTMixPdYEYX/bvH9toXgXFjjGjoPSEk5AOoKZmQuzincMWRQ
         Zpzcx7sJ4/QeaSFKQNO5EC9DTkgaDSKaacoqNIm1GxGUmvrORBvdQAFjyT+5t60pnX4d
         jRGDej43vWjtYgu9TUXeNKG0pCQwNRBW9FErouAkzkJYeGMlIWQFy8vF1d7Ng5HnddvH
         r8hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+JQ+5PYFrCESqWTWXQG4TnqoQj2dB5lWApYO0AEnXqE=;
        b=pwM/t9B8fW5TyoDc+McMORE94Zh80xNfkZWqgbEZ/8Hr0bo5wMBIWEF4r9LLih/Y7L
         ti3kxldViGB3aWFU2DNhayCtdrC2u+3vHxYzPpEQ75mIM/xlhIUhYzdhcoiOU0w8GYiT
         OAqQANADMB9dag/Gj2eSpDgJyhu6BNedvlOt9K91JswQTMnJuywLhfrTZiCDn1INMUIE
         kAG7Al77pDQbhmDO8w/9yIhrVnnTvG+ubAu9vdcR9yDxrs5RpwCoJv/pG+xXn/KeNBqC
         Ah3zxMwVWQJt5tExg/JDmuJgwJWSfCRv+jx9ePclnaMGvt9oPzBw/MYUUwR1WVyefspW
         H99A==
X-Gm-Message-State: AOAM533QmbSm31hENcKTej9tfa+oHpNj5GUW/EHw6DalIgyRNZ3l9ulF
        U3P3KDS4An/RYDkh9mKZTNH7pPn623wvoohuJ75/oQ==
X-Google-Smtp-Source: ABdhPJwfb1ArxTcMuMtNmI6uf8uaS73DakGrcDRHPZUbCZBSneAIoOerIU60FngYTqOxTa3cHKfYbAFu9su7XL0GlgQ=
X-Received: by 2002:a05:6402:4301:: with SMTP id m1mr7428632edc.210.1618532998871;
 Thu, 15 Apr 2021 17:29:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210415232610.603273-1-ben.widawsky@intel.com> <20210415232610.603273-3-ben.widawsky@intel.com>
In-Reply-To: <20210415232610.603273-3-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 15 Apr 2021 17:29:47 -0700
Message-ID: <CAPcyv4h6BeEhn0W4tkUqjj+2-XLMkEWab2SHq5mJNa0x4MRDkA@mail.gmail.com>
Subject: Re: [PATCH 3/3] cxl/mem: Demarcate vendor specific capability IDs
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Apr 15, 2021 at 4:26 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> Vendor capabilities occupy 0x8000 to 0xFFFF according to CXL 2.0 spec
> 8.2.8.2.1 CXL Device Capabilities. While they are not defined by the
> spec, they are allowed and not "unknown". Call this detail out in the
> logs to let users easily distinguish the difference.
>
> Fixes: 8adaf747c9f0b ("cxl/mem: Find device capabilities")

Would need the abbrev length fixup if this was a fix, but I don't
think I can justify this to Linus as a fix v5.12. It's new development
for the next merge window.

Same comment for patch2.
