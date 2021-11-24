Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24CBCC433F5
	for <linux-cxl@archiver.kernel.org>; Wed, 24 Nov 2021 22:03:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245638AbhKXWG1 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 24 Nov 2021 17:06:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245236AbhKXWG1 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 24 Nov 2021 17:06:27 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E139C06173E
        for <linux-cxl@vger.kernel.org>; Wed, 24 Nov 2021 14:03:17 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id n15-20020a17090a160f00b001a75089daa3so6148232pja.1
        for <linux-cxl@vger.kernel.org>; Wed, 24 Nov 2021 14:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=16s7UcoI1ggoDVX9XRSZk645m6dxvQ8lddinmk7z5AI=;
        b=jNAxLW0AilkWXrzLszef6eGL/sdVYwMs0DTvhI4xt/bChY98cAmAnuWwoh42xuzu+j
         +dfCVZ5DuOzIF2movkOlwkd/OEYZYGp+OdVt74mmVeGLDGT47vEYxKd3RRHMP7dFDpEM
         hSaIm2MdC7Zy+RFk9ecA3gSMjBznHnY8EqMNGtFUEsiUsnF4eT5ePpixnB2bJUMYQAmK
         lI+FWE0w5bCuzXvSyAtHBTffuY1KND3WHBWk+q/wVAJcJpIn8LEnd6bXgCGe0msQwq6N
         1MCu1V9pL20O7Wtko1l7QXEsph5uj1Ps6JkgSpV5b8U+v2bUivJrknjM+WPmHhq20S/J
         YS1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=16s7UcoI1ggoDVX9XRSZk645m6dxvQ8lddinmk7z5AI=;
        b=u1L9LxEBFRAI1EOpCBvrGyzPfxR9UOXtouXcrcS90WEPMdaunysRYFwWj44Y0vP3VB
         aMmZ+/vmEm9Ek2TSi7hsFjmx9SULC9lEHYLaPBNyYhNc1782wMg6lWncrkqXFw4MAMhI
         S48CNYFQrHe4VvvRkt1xRuEeu4pGf4pbaP/heXVIAEd1wp5H54Z8DEtBd9LHzI2sHEfc
         5wnckI/f2lHC+JWaKLqBZI6vmaBowgqeti6koe1gw2KiO+7AI7CiTA8RkmKOUn2+4A/W
         2T322ZmW+VPyBW3WXFIOVhXRjte7aH69g5LM01GUK4sR1mkR80eXGpaUovb2NLDtfypg
         LSfg==
X-Gm-Message-State: AOAM531iK4QxJv1pHCKPib2dMbS+ey6hj7coFcQqNU5Au+KqRy+eWfic
        DM1PkCSbhU+IwPvwVBaFXralIVBC5qM/D1yDw663+w==
X-Google-Smtp-Source: ABdhPJwsrH+5hDWFNmTRaL38ZDOvtnVsabDPru6WTPCkRHBzVEZKkkxipeFGrIMiZ4uvKN/q55DfK6gVsxCwcqubI6U=
X-Received: by 2002:a17:90a:e7ca:: with SMTP id kb10mr536849pjb.8.1637791396596;
 Wed, 24 Nov 2021 14:03:16 -0800 (PST)
MIME-Version: 1.0
References: <20211120000250.1663391-1-ben.widawsky@intel.com>
 <20211120000250.1663391-8-ben.widawsky@intel.com> <20211122152224.0000467e@Huawei.com>
 <20211122173226.f72gy2ipbf7awuqw@intel.com>
In-Reply-To: <20211122173226.f72gy2ipbf7awuqw@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 24 Nov 2021 14:03:06 -0800
Message-ID: <CAPcyv4gv93EyTEmgiscAkydT8DAcm8PagQCa3jKfhCj8TD13Dg@mail.gmail.com>
Subject: Re: [PATCH 07/23] cxl/pci: Add new DVSEC definitions
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Nov 22, 2021 at 9:32 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> On 21-11-22 15:22:24, Jonathan Cameron wrote:
> > On Fri, 19 Nov 2021 16:02:34 -0800
> > Ben Widawsky <ben.widawsky@intel.com> wrote:
> >
> > > While the new definitions are yet necessary at this point, they are
> > > introduced at this point to help solidify the newly minted schema for
> > > naming registers.
> > >
> > > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> >
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huwei.com>
>
> Thanks. I realized on re-reading this I didn't like the commit message. I
> reworded to this:
>
> While the new definitions are not yet necessary at this point, they are
> introduced to help solidify the newly minted schema for naming
> registers.
>
> Please let me know if you'd like me to drop your reviewed-by tag.

The typical changelog template for patches like this is:

"In preparation for adding features X, Y, and Z, add definitions for
A, B, and C."

Otherwise, patch looks good.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
