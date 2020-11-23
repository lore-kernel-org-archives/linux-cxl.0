Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E1CC63697
	for <linux-cxl@archiver.kernel.org>; Mon, 23 Nov 2020 19:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D54720731
	for <linux-cxl@archiver.kernel.org>; Mon, 23 Nov 2020 19:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="Wdyrvrbq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729827AbgKWTcr (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 23 Nov 2020 14:32:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729506AbgKWTcq (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 23 Nov 2020 14:32:46 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62FE5C061A4D
        for <linux-cxl@vger.kernel.org>; Mon, 23 Nov 2020 11:32:46 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id r22so9672199edw.6
        for <linux-cxl@vger.kernel.org>; Mon, 23 Nov 2020 11:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=idsRRDFvrWEUfaaQ200ZYJgjiqOU5xE6TXnIcThRzMQ=;
        b=Wdyrvrbq+IrLnf9+ZOGO2vv3x+WxFZt2TN+CQ7V+X/sc1SgfxFUTxMH2c873wyRSSg
         59zThKnuOc8hD7N+HFZl1x3lslngFnEKOw+2Ao8MvCSvDxnldO9FFtQjtcsOUeB5C6b/
         Xtj7n7HVpB+fPnessaIv7NA3MYqUNnTK0ZMTQROtRByevKOz5juT8oTyx+Nwtv4R1ewd
         OOgDVqpnjp+08EdQjAxPR8VrfSkArZKscR3jRL5wQYVW00iVXEH1bb0LyfTnkHVBwWdZ
         9m7G3zJ2pDqtCNgFiMw8eRldmF/zXyDcDcAlTy2/EP0GniOHMA5gCJBP2neKHA7KVkR9
         ksQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=idsRRDFvrWEUfaaQ200ZYJgjiqOU5xE6TXnIcThRzMQ=;
        b=Bf0A/WrB/1XN7loxOG3ZYtTHfLn7foWtLJi8HUPVkaKBVrU4Qm5qUWa3PGeJOzJ7A1
         MwOySFIN09mR3iLFzkBzWIPcOZN9tS4O+pX8/zAe2MB0w3AVMTjRnVoFl4V8/j5V8YGt
         eps5NH2TpbOgUMDZbDKK6gICDj14TF+7wlo84QAm4He/7irH4JjNCyQZHrOa4Byv2zXT
         FKyhu0R4LcEgrofseCLv6/V3l0DYysCpHoJbU1dlnDRIXzPSBb0clR8jA59WfDOYuxK1
         bANZL6jnHz6QqTxK0CCKfFMDaVNKaY3OeaN2yqiCGXKDNhu3pHRYAizGkM26o62ISl6t
         nPeQ==
X-Gm-Message-State: AOAM5320bwmLSThnqN37iD0E8jDkKpqsnNIVLZk46wcq2GYe3FW2bz9j
        y7ieBDETmF9v5IHlAaQX3NIv7+727JdXuArEeOF+7w==
X-Google-Smtp-Source: ABdhPJzG6sgIo04MhiGORxtweJtY7Ith2jiGAwGdEG1XvFP+atMBFpBYF8qTDnkKNX7f8mwgWSvRhCZrpVeQDso7ILQ=
X-Received: by 2002:a50:fe02:: with SMTP id f2mr716870edt.97.1606159965112;
 Mon, 23 Nov 2020 11:32:45 -0800 (PST)
MIME-Version: 1.0
References: <CAPcyv4j+zbns+WhnxWXCdoxa=QN40BFXUpmb=04q36H1sX-aBw@mail.gmail.com>
 <20201117002321.GA1344659@bjorn-Precision-5520> <20201123192029.pmmy6ygts5fclz7b@intel.com>
In-Reply-To: <20201123192029.pmmy6ygts5fclz7b@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 23 Nov 2020 11:32:33 -0800
Message-ID: <CAPcyv4jJpvLErK8vBW-D2ZQASU0iJqFLRr7yDXB0kfGPrmi6xw@mail.gmail.com>
Subject: Re: [RFC PATCH 4/9] cxl/mem: Map memory device registers
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-cxl@vger.kernel.org,
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

On Mon, Nov 23, 2020 at 11:20 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
[..]
> > -ENXIO is fine with me.  I just don't see it as often so I don't
> > really know what it is.
> >
> > Bjorn
>
> Dan, Bjorn, I did a fairly randomized look at various probe functions and ENODEV
> seems to be more common. My sort of historical use has been
> - ENODEV: General, couldn't establish device presence
> - ENXIO: Device was there but something is totally misconfigured
> - E*: A matching errno for exactly what went wrong
>
> My question though is, would it be useful to propagate the error up through
> probe?

The error from probe becomes the modprobe exit code, or the write to
the 'bind' attribute errno. So, it's a choice between "No such device
or address", or "No such device". The "or address" mention makes a
small bit more sense to me since the device is obviously present as it
is visible in lspci, but either error code clearly indicates a driver
problem so ENODEV is fine.

For the other error codes I think it would be confusing to return
something like EINVAL from probe as that would be mistaken as an
invalid argument to the modprobe without stracing to see that it came
from the result of a sysfs write
