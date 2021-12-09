Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 690AAC433EF
	for <linux-cxl@archiver.kernel.org>; Thu,  9 Dec 2021 21:23:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbhLIV0r (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 9 Dec 2021 16:26:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbhLIV0q (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 9 Dec 2021 16:26:46 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4257C061746
        for <linux-cxl@vger.kernel.org>; Thu,  9 Dec 2021 13:23:12 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id x131so6543657pfc.12
        for <linux-cxl@vger.kernel.org>; Thu, 09 Dec 2021 13:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q1y40vwpY3Sw4jhQ/x9l/XpwpUAS7nPuNQY4dGM2Uu8=;
        b=qTPELtrLYl4Xzl0g6RUqyXacsYXoWWU47N94T17ifwhprPd8JJqOqioL2idvm/UuQV
         pHy3SGMrNFPHjivkxSOU/DfuN6YNE3lpkVSMTM9JchO404NBHlmqBp5SPGNztiD90S1U
         1VSJGHz+yxwK+VEANSr8JFWyA+y8H1REzCZd8BN3x2w5fP8kHkeVWTpCQvZtY3YnZYzu
         k6+4ceaUQA1S728SclIsF1ZJWdWSr68iIinNjq4byRuTEnbzzBnwUsQgpqMDTBI3zFgt
         jTaCCjl4VJ3fRA4fzDL7fbcfrTLl0teDrvh/Y68z7GTqzULfdIIaCb8S6Nupw2+euh0S
         eyQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q1y40vwpY3Sw4jhQ/x9l/XpwpUAS7nPuNQY4dGM2Uu8=;
        b=OTB6h5fVrqNIi9kbvU/RFSVs04HdpdlLrnpqvjodRxgWFr2iBDHQgLX6digsKh4774
         I3jWpKDX/4UckEq/U4xa05SBjIZayi3sA6me94OHhQjniVv7qaZnsE5YIAcaRyN8sXLm
         7nqfXQGuWaV9i3QeSgz+J59J9LecOKY4n5s3hmDmUNuqB1gn6zb4/aMHQwN6frl6OaH1
         9R5efXchniZVJE/Vmwe2/lVerQeBzGLwNkiMTWDiZnL8pK5HRnWdiD4z6EmL9//qljKX
         W5JkUumGBC56mczTNs3MLAyTEJiiEia3vfiG1y9Xvt0S3jjHe/33KsPUz3VIvU43cOW8
         9LyQ==
X-Gm-Message-State: AOAM5304vA9No8uQgbsdfUDhaLxvC1OGhFAc5Xyzo4BvhGx8cwpfGnjc
        uz1fU64+ku6HZ8Dx3VbaBhOfBH7qbTCHjjSd9AAjp33VZXs=
X-Google-Smtp-Source: ABdhPJzZ/x0UyBdtt+niU/T7RBqziuW2HepFc1nqI6147NhBQiJ35nUZFAUOi/zVO81REM1URaHdaBGqQF3dv6SMrnY=
X-Received: by 2002:a62:7ec4:0:b0:4a3:219b:7008 with SMTP id
 z187-20020a627ec4000000b004a3219b7008mr14211545pfc.3.1639084992380; Thu, 09
 Dec 2021 13:23:12 -0800 (PST)
MIME-Version: 1.0
References: <CAPcyv4hMzLsfCoKc7fD5NLNOfaRTddb42BVdhyN50PM3dSDM9w@mail.gmail.com>
 <20211209210909.3520533-1-vishal.l.verma@intel.com>
In-Reply-To: <20211209210909.3520533-1-vishal.l.verma@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 9 Dec 2021 13:23:01 -0800
Message-ID: <CAPcyv4j5E0QQGLEipqKykc0M9-ormsf-ZWFZdXJp+4PTDzNEiw@mail.gmail.com>
Subject: Re: [ndctl PATCH v7] cxl: add a cxl utility and libcxl library
To:     Vishal Verma <vishal.l.verma@intel.com>
Cc:     linux-cxl@vger.kernel.org, Linux NVDIMM <nvdimm@lists.linux.dev>,
        Ben Widawsky <ben.widawsky@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Dec 9, 2021 at 1:09 PM Vishal Verma <vishal.l.verma@intel.com> wrote:
>
> CXL - or Compute eXpress Link - is a new interconnect that extends PCIe
> to support a wide range of devices, including cache coherent memory
> expanders. As such, these devices can be new sources of 'persistent
> memory', and the 'ndctl' umbrella of tools and libraries needs to be able
> to interact with them.
>
> Add a new utility and library for managing these CXL memory devices. This
> is an initial bring-up for interacting with CXL devices, and only includes
> adding the utility and library infrastructure, parsing device information
> from sysfs for CXL devices, and providing a 'cxl-list' command to
> display this information in JSON formatted output.
>
> Cc: Ben Widawsky <ben.widawsky@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---
>
> Changes in v7:
> - Update the man page w.r.t the new default behavior (Dan)
> - Use error() and usage_with_options() to fail when no list entities are
>   specified (Dan)

Looks good.
