Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB21C433F5
	for <linux-cxl@archiver.kernel.org>; Fri, 28 Jan 2022 19:50:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239494AbiA1TuO (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 28 Jan 2022 14:50:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbiA1TuN (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 28 Jan 2022 14:50:13 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F4DC061714
        for <linux-cxl@vger.kernel.org>; Fri, 28 Jan 2022 11:50:13 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id i65so7090042pfc.9
        for <linux-cxl@vger.kernel.org>; Fri, 28 Jan 2022 11:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ve/7r9CpoO59qBotnQ6Pyq3Z6ok1RLagVzNhRR5gtoQ=;
        b=kc/WSjogE5kc/MtttYzoCyCVErJXo5MMY8BhKYth1tHRLZU8lFY9t0osSsFETz7oaN
         NhSaG6+AVPfHAO4yzlEAtln8YXb7UW7tRGfm8Xi9789M4HszuiQtaeZHD/IVLy2ZohE1
         5vsX8sFzoQUaRrbyhIBwdDaa5OtmgYx1OPLk1aX2vKvRm7nld8oD2AmEchJGhZIkbuyh
         KdaJrmJ4euvStw0eJjFfQdmJxPPWMFP55WyZ7PoPUxcZgT3wSAF/sJBnh0zTOHw60u/3
         aOn4/CHaY92g7N47hpgyxgOzrIWpa/UPW9wyyKBZoz7vgE8fyV+0R17sDnIqm9NbOaBQ
         RQPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ve/7r9CpoO59qBotnQ6Pyq3Z6ok1RLagVzNhRR5gtoQ=;
        b=QBEzQmWkcPnpVrxbbTZ9/wgb44jUUndPsStlcICwAQp815PkhKzTr1gfys8TPzELFL
         MpPoDYWCS0SHYJOQ+lMk3MHIiSJIs4quhjKsBVq5HVHX/gWzWMmAS3eytcOPt90KqVXf
         vc7ELlELtU+LVsi9J72DqSg/exM+5XIvf22G2YfzQb798iWY6IrOE5e/T8ed9h0+L3cM
         UlgyoMjOINYRrhF3066sxZrqZlUvIT1V9idsGjPchT8p25FOlwBcD7GQx5JqUsfBIwDR
         Dxslr+t9ajdKdyCT515pocCOmZWVb9U5z1c/FL8xT9hD9xYQETjNuxaq9Wgx6NMH+V3V
         x2tw==
X-Gm-Message-State: AOAM531hB4e+458+caC4nmpyCtHHta2a4czgHj72oO8iHSk6m7UJySBO
        TQY7iWRhonZ5HBuo/WiUhpVhqpaI8rxJN31Q88RyV7+qv/C20Q==
X-Google-Smtp-Source: ABdhPJyXkUNSnDrHDG6UZGsFaqpXOXt/gowvJOSfbKmCBz2GXmjiac7uM30V5FY/2kYuVppdh4MXomK9hlMPbxmek+Q=
X-Received: by 2002:a63:85c6:: with SMTP id u189mr7657446pgd.437.1643399412740;
 Fri, 28 Jan 2022 11:50:12 -0800 (PST)
MIME-Version: 1.0
References: <SA1PR05MB8015E5AC7D6F6D028D5FD8F48C219@SA1PR05MB8015.namprd05.prod.outlook.com>
In-Reply-To: <SA1PR05MB8015E5AC7D6F6D028D5FD8F48C219@SA1PR05MB8015.namprd05.prod.outlook.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 28 Jan 2022 11:50:02 -0800
Message-ID: <CAPcyv4iGNVSYXe1Rdh4mRzNOKSAnTMOkEMzJvH_DUW2Tu6aMtw@mail.gmail.com>
Subject: Re: Treating CXL Type 3 device as a block device
To:     "Treon, Justin" <justin.treon@advantest.com>
Cc:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Jan 27, 2022 at 3:40 PM Treon, Justin
<justin.treon@advantest.com> wrote:
>
> The pmem.io blog lists directions to make block device from pmem with 'nd=
ctl create-namespace -v --type=3Dpmem --mode=3Dfsdax'  Is it possible to us=
e ndctl to create a block device from a CXL type 3 device with volatile mem=
ory to so tools like fio can be used for testing?
>
> Is the 5.16 or 5.17 kernel required or can the 5.15 kernel be used?

CXL PMEM support is a work in progress. The eventual flow will be
something like:

cxl create-region ...
ndctl create-namespace --region=3D$cxl_region ...

Previously PMEM regions were statically defined by ACPI, with CXL they
will be created dynamically.

> Is there another way to make a cxl block device?

With patches posted recently [1] there is nascent support for creating
a PMEM region, but as mentioned that's still under active review /
revision.

[1]: https://lore.kernel.org/r/20220128002707.391076-1-ben.widawsky@intel.c=
om
