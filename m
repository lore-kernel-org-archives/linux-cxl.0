Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C5C2C433F5
	for <linux-cxl@archiver.kernel.org>; Fri, 28 Jan 2022 18:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349116AbiA1S7h (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 28 Jan 2022 13:59:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345483AbiA1S7g (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 28 Jan 2022 13:59:36 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D157DC06173B
        for <linux-cxl@vger.kernel.org>; Fri, 28 Jan 2022 10:59:36 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id c3so6950612pls.5
        for <linux-cxl@vger.kernel.org>; Fri, 28 Jan 2022 10:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kBbQz+1vrQjh8zY1rf+NQJqHkH3SafLp7NoALvG+TlM=;
        b=7igZFM/i33XFVSZM2s1YTUXcszqkljuhraDPJAXq4Rxn09XQm92rt/gT4NuR/P44Fa
         MPnBo9k26d2H8PFxpVTihEvJIddhA9gN43nxg4aEJWiZjh5PugSpsP28JPm5DGOUjmmv
         gGfi5o3s4qkO9wgWsSWA71qiq9UDVnBDzsV6tXsaqzg2xoi6ovG71nWmizpZF/TX8+5w
         lxFMP0qs5JzoKpaSKmLIrodAM2PKLOlZyZYloLjyeK49IfLkP8qbuNdL7GwdwJ4PLopa
         +7//ObRDy61Bs03lwjrwKQw6VMaI4dcHLZFpHnRmYTO0sWDzTnhA802PzCMT6Gdg2VGx
         l3og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kBbQz+1vrQjh8zY1rf+NQJqHkH3SafLp7NoALvG+TlM=;
        b=qqsNEt97AnOH0tQjmb/Lefs02+nDCLPO8rtaFrk26nNnDlrk7sAqgTHtVj8OOa5Oze
         2Moi49nGjgF620zHYk4Q69Hj0TeLC5y5xz/k3fkWX7WH3QW9na4bNo6BmYuQjh+6WRVk
         bdjTXy0RJr0jfL7J+uZq+2TY+6PrNVgU9KOlbv516ptGbOcfyWARXV5rfo5oYQzCArpk
         zYEw0vK5v+f/tSEP8tep0n2cAVcVIAisPheSspjsQ1yR0d5BZkBNwVXlMutFrbbuqCBX
         OaXbOAAwAJdG0ca7RJgY3YdrobhFlAYafANZN7m6rp1CXsvdXYcGa8e4qtu9Bh/fP4OX
         IkLw==
X-Gm-Message-State: AOAM532BfWwmE8tpROEtySyuGrL4uzdvEOXI2WfHLLzac1OvHEe1d6zv
        adjmhmy0fRMX5qY4hFXrQom3xriw7m4lkAlAUHY73O2XRCQ=
X-Google-Smtp-Source: ABdhPJz9x36kJjRfJYIckvuO6+Jc99rIlb/SZbj5F2YS4Voujflzvok9hNDifRwkFyybbysfVYpWHhw2oDGG0AonAGA=
X-Received: by 2002:a17:902:b20a:: with SMTP id t10mr9636635plr.132.1643396376380;
 Fri, 28 Jan 2022 10:59:36 -0800 (PST)
MIME-Version: 1.0
References: <20220128002707.391076-1-ben.widawsky@intel.com>
 <20220128002707.391076-2-ben.widawsky@intel.com> <CAPcyv4h53gj9vETFcj_RebW+Zt=q+1yOmMo9CpyzHdABanpPRg@mail.gmail.com>
In-Reply-To: <CAPcyv4h53gj9vETFcj_RebW+Zt=q+1yOmMo9CpyzHdABanpPRg@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 28 Jan 2022 10:59:26 -0800
Message-ID: <CAPcyv4hj=1=+8UvqzSZqJ12ef1F15Hpzud7YjJpz7dZa0=9=QQ@mail.gmail.com>
Subject: Re: [PATCH v3 01/14] cxl/region: Add region creation ABI
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, patches@lists.linux.dev,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Jan 28, 2022 at 10:14 AM Dan Williams <dan.j.williams@intel.com> wrote:
[..]
> Here is that put_device() I was expecting, that kfree() earlier was a
> double-free it seems.
>
> Also, I would have expected a devm action to remove this. Something like:
>
> struct cxl_port *port = to_cxl_port(cxld->dev.parent);
>
> cxl_device_lock(&port->dev);
> if (port->dev.driver)
>     devm_cxl_add_region(port->uport, cxld, id);
> else
>     rc = -ENXIO;
> cxl_device_unlock(&port->dev);
>
> ...then no matter what you know the region will be unregistered when
> the root port goes away.

...actually, the lock and ->dev.driver check here are not needed
because this attribute is only registered while the cxl_acpi driver is
bound. So, it is safe to assume this is protected as decoder remove
synchronizes against active sysfs users.
