Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97858C63697
	for <linux-cxl@archiver.kernel.org>; Tue, 17 Nov 2020 21:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 336392465E
	for <linux-cxl@archiver.kernel.org>; Tue, 17 Nov 2020 21:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="FBb5z0wF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbgKQVpd (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 17 Nov 2020 16:45:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727943AbgKQVpd (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 17 Nov 2020 16:45:33 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9309BC0617A7
        for <linux-cxl@vger.kernel.org>; Tue, 17 Nov 2020 13:45:32 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id q16so8893284edv.10
        for <linux-cxl@vger.kernel.org>; Tue, 17 Nov 2020 13:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5lBVBDWK8SCqKzaHy0L/+mLoij0OAwknWiLnXgPeJSM=;
        b=FBb5z0wFGOiQbc45dE0niLuV0rybunP/wEU/0k6b783EPVbzDuRuejCVpDauBALHfc
         +lc+d6XRbgwNlOlzPZ80uZOVCFXlW1F2ThVz/PgWXDMr5Qk2qXUzVeV/mkMEpA6NGBWJ
         /r6IhOXal5Ashs5MZqCi+/Cclekpk1N7Hu9Viof3LXHIYVpqGBDN2fBwVFtEcO1Bg3xL
         tzN0ffs5tPZJKxTNR/PuvOabZJbNfgH+ytvBghZkwTb90HvxcpdUGn1dX3oNF3/DPg4V
         t49QQpzkPhLWrGwW9cDwq4Kw7uQG5EcgkdpwrzO/HDHONv+D/N6z78dNpCEiwy/lcNpB
         TB3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5lBVBDWK8SCqKzaHy0L/+mLoij0OAwknWiLnXgPeJSM=;
        b=tpKaQFdz1ORGOpRYlO+D8zmTRP23cHUy/QuO1KHVZjgGlfvnxBCDlq8VW9O/9zEyHF
         TRaub8jaSBnV5bqyMsBDh89Py2JGqcbZKSia9GgiZZXgeAQBdauhvgSQrvHoMVldE4x7
         UPMsoM1F5ipagp5asgV2/GEq4fqQLu/SK4YDfw7foR7u4ZsKctcelQ/GvnhXfViI5rWK
         T4DuXwUc7+EEZgZ05kfi2A3MVLIuqluYQKZByLSg6JcB0bf9c+T2OZ5hTcWVivQ1c/l7
         nHzQpRdrmBfe9AyUoL2htAzn3qnjA5uYvKhnXw+/F/eH324OoiyCRXAnGWgdrbiliO3t
         928Q==
X-Gm-Message-State: AOAM530bztQ7cwnP3SqfLUDT5CaHFfZdLtZdtCYJHbw2d7Gm5qzmjtAl
        M/AuqRB9Wjz2/r5ZqsXs8pfqi5m1Rcgma1NRqNFnKg==
X-Google-Smtp-Source: ABdhPJyqTIqMdYQYBJBwXDLjTJrIAYOVAjbbvPmUH0FRy9zTiej41mBWzaPPONfsn2ZvoadeWtEkbQOTbaDmxU63dbg=
X-Received: by 2002:a05:6402:b35:: with SMTP id bo21mr24193805edb.52.1605649531304;
 Tue, 17 Nov 2020 13:45:31 -0800 (PST)
MIME-Version: 1.0
References: <20201111054356.793390-1-ben.widawsky@intel.com>
 <20201111054356.793390-2-ben.widawsky@intel.com> <CAJZ5v0i7fcoBe5o-J7q5fYW_1nUYJ-QdshWOBV5fFf85rD_sDA@mail.gmail.com>
In-Reply-To: <CAJZ5v0i7fcoBe5o-J7q5fYW_1nUYJ-QdshWOBV5fFf85rD_sDA@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 17 Nov 2020 13:45:20 -0800
Message-ID: <CAPcyv4i6MCu6RmLCyE+K-j3bbtrYeA+hJXL4+Zy_Tfhmwv2ErA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/9] cxl/acpi: Add an acpi_cxl module for the CXL interconnect
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Ben Widawsky <ben.widawsky@intel.com>, linux-cxl@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Nov 17, 2020 at 6:33 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
[..]
> > +static struct acpi_driver acpi_cxl_driver = {
>
> First of all, no new acpi_driver instances, pretty please!
>
> acpi_default_enumeration() should create a platform device with the
> ACPI0017 ID for you.  Can't you provide a driver for this one?
>

Ah, yes, I recall we had this discussion around the time the ACPI0012
NFIT driver was developed. IIRC the reason ACPI0012 remaining an
acpi_driver was due to a need to handle ACPI notifications, is that
the deciding factor? ACPI0017 does not have any notifications so it
seems like platform driver is the way to go.
