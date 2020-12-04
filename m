Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85EF3C4361A
	for <linux-cxl@archiver.kernel.org>; Fri,  4 Dec 2020 07:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 237EC22571
	for <linux-cxl@archiver.kernel.org>; Fri,  4 Dec 2020 07:36:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbgLDHgg (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 4 Dec 2020 02:36:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbgLDHgg (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 4 Dec 2020 02:36:36 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDEC8C061A51
        for <linux-cxl@vger.kernel.org>; Thu,  3 Dec 2020 23:35:55 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id cm17so4836044edb.4
        for <linux-cxl@vger.kernel.org>; Thu, 03 Dec 2020 23:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ib4z7ovnO/Is9x9bv4eZdlrrRMtAOfboZBD7JQtUG5M=;
        b=MlznnxVBeS9Jeb9K6pxCGMSisJ5di5vo8rnZgccJEokQkubT+b5ELOaP/qYZPZYens
         LTQTZ5qK5+rN7i7TrBiUt/aTlSX5Si22lwK89sloMRq0lkL5fRELUsL6cmnUB3ewrYzQ
         1C9XmpiDtksVcCp4aPdPDUu7mqzrhfTMil4Ii3r3Z+W4Rch+qHSCIy5nHqdZZHzjfuFC
         CouE9HwiB531iUdh3GBA/XBU2A5lxBYq8LwhDwqMK/fdnMIEGn+ShaX5yrUWSLlOXrdb
         pcuY+emGUnm4SuFF1EGQYrkKyVUfjNb/nVosCF9na3545V2UELil7agJD0NNoLsVMpuy
         +qqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ib4z7ovnO/Is9x9bv4eZdlrrRMtAOfboZBD7JQtUG5M=;
        b=XHR0OXbhkd64Tl3nQrpRg2DiEAkl8C9FSgceUZK1EBYEeumxANxvL9HwK54h7JJIdc
         vYV/C23XTPQgU8KxMv88CZnPeVjaqXhOStM6R9cG8TzzsmYg25Ryu8ghRKT8HXPDZt3W
         BvCi0Ea0HVE07Xfv+c3H6xjKNYI56ipagtTIMnCqZTGvR/7P0nBuR8HczH1K3+Bilx4o
         AvvopImSNoohqhGeWWPlcX7KH0UTt19xMN44d8KtQVKO7v0c+HVfrHouS2OywRMLdlUa
         hed6NXPU2bPV0SxDvXMfG4dg18KDkgbcsSnrD7ijUwfOHbz95kKlJXED47TpZ3y9c67L
         zlQg==
X-Gm-Message-State: AOAM532Ce21vFzvs2Gmv+mDcrxtJb73v3Q8lT9Ruy7lWqaDfPT7EfZUt
        Bs0QhhrEruLLD6nXjjEsIE5ZoynI3YHhgV++r1UlSA==
X-Google-Smtp-Source: ABdhPJxnSZOAJkjodNrzG83gLmg0TXLoPO+mgtRWWPBjvZDtvRpGbpYSdnh6boOt1ZZAav86Y2rNmJuHLlFwPeiDAfk=
X-Received: by 2002:a50:e00f:: with SMTP id e15mr6641049edl.210.1607067354664;
 Thu, 03 Dec 2020 23:35:54 -0800 (PST)
MIME-Version: 1.0
References: <20201111054356.793390-1-ben.widawsky@intel.com>
 <20201111054356.793390-6-ben.widawsky@intel.com> <8d332852-9c54-95e0-58c7-72939f347aa6@jonmasters.org>
In-Reply-To: <8d332852-9c54-95e0-58c7-72939f347aa6@jonmasters.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 3 Dec 2020 23:35:51 -0800
Message-ID: <CAPcyv4hYR8Ty2vq6kfG6_h6XRQPv2=-x4S0DgyzAykgx0TWzog@mail.gmail.com>
Subject: Re: [RFC PATCH 5/9] cxl/mem: Find device capabilities
To:     Jon Masters <jcm@jonmasters.org>
Cc:     Ben Widawsky <ben.widawsky@intel.com>, linux-cxl@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Nov 25, 2020 at 10:06 PM Jon Masters <jcm@jonmasters.org> wrote:
>
> On 11/11/20 12:43 AM, Ben Widawsky wrote:
>
> > +             case CXL_CAPABILITIES_CAP_ID_SECONDARY_MAILBOX:
> > +                     dev_dbg(&cxlm->pdev->dev,
> > +                                "found UNSUPPORTED Secondary Mailbox capability\n");
>
> Per spec, the secondary mailbox is intended for use by platform
> firmware, so Linux should never be using it anyway. Maybe that message
> is slightly misleading?
>
> Jon.
>
> P.S. Related - I've severe doubts about the mailbox approach being
> proposed by CXL and have begun to push back through the spec org.

The more Linux software voices the better. At the same time the spec
is released so we're into xkcd territory [1] of what the driver will
be expected to support for any future improvements.

[1]: https://xkcd.com/927/
