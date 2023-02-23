Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 512CEC636D7
	for <linux-cxl@archiver.kernel.org>; Thu, 23 Feb 2023 03:55:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbjBWDzO (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 22 Feb 2023 22:55:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjBWDzO (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 22 Feb 2023 22:55:14 -0500
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E749C37566
        for <linux-cxl@vger.kernel.org>; Wed, 22 Feb 2023 19:55:12 -0800 (PST)
Received: by mail-oo1-xc2a.google.com with SMTP id e2-20020a4ac3c2000000b005246390f576so911370ooq.9
        for <linux-cxl@vger.kernel.org>; Wed, 22 Feb 2023 19:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UKCcFzqzFV9eE3+rBxbQK2ZsLNcZACLNff2QQ8rd0G0=;
        b=UhWphed0eYZI3xYPwnT7M9jHvHDpfgE+YkE3p3yuJ9j+zF1DCBwQerOXLX/cM4NFS0
         A3QAg2HDmxYMowUmBXKW5VSY9RCn+12KBSZQHssJ1FR7xekhd6dkQlTqXLXjv62nyRx1
         6Yb37fYM1wjCRPGeEaqFjxsRAp35VinxDfmgE26w258I0e4AjdQyLEz5ZJSb9Fl2LOWs
         obopfch3iDPNT2ciBKT8PSzKlQAog9INkeMDAqXEh9CBdpx0xiKAFxhUJFekD4XvXCMp
         2jRF9Q5oX+DhIBHXjC3Sb8RXKyJc4g0qj83TQ/J7Jm1J7TvJFgBeMch4aUF/CBtt/qwg
         90hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UKCcFzqzFV9eE3+rBxbQK2ZsLNcZACLNff2QQ8rd0G0=;
        b=1oFbELrW8wJqWzj04UFk0WbFvInyPmm4o+4XHwB9EKqiz61ZMYs+fOsmrZdxGEOOzt
         j977rQ+zrlMaXqJOC7TFBJyogX4idwbUIpvDeCFcVbln8cObJy7wsBAe3OVWHAiaZEHG
         +WurX5sJN1nech0+/t63B4gcSINRl2tI7+PXxfZSPPM9+VVRuYcUob9XOihfQD7BveBJ
         XqhNRvh1nXN1UO2QeSzfxCqHQQmwjBSvW2IJ5CdjqSkb7jG9/BG1yaHWmF3aYRonwQ4u
         jbE8kuIyy+vUkE/Ets2mOD2RIOoph8CJ3jYH4zt3Ri0iU7SG4+so1cE27AdqKw7NiF5O
         cHSg==
X-Gm-Message-State: AO0yUKVmk6ABjr5BxTTVYvH5dt6TWWocK6Fm1FwaZV3ahjkecrlNGlwq
        dttlhLnnPdo62wNNQy4xAvRhId4zO/k=
X-Google-Smtp-Source: AK7set/xzN/UW+AIsVR34ufNIUD7ZZy72rmwKesmSLbXFCWQyNWD7SU0tfncjYXEn12MD/CBocOx+A==
X-Received: by 2002:a4a:cb95:0:b0:51a:7265:5059 with SMTP id y21-20020a4acb95000000b0051a72655059mr4757549ooq.0.1677124512262;
        Wed, 22 Feb 2023 19:55:12 -0800 (PST)
Received: from nabeel-linux.myguest.virtualbox.org (cpe-76-183-103-62.tx.res.rr.com. [76.183.103.62])
        by smtp.gmail.com with ESMTPSA id b11-20020aca1b0b000000b0037d8aec19e0sm1883179oib.36.2023.02.22.19.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 19:55:11 -0800 (PST)
Date:   Wed, 22 Feb 2023 21:55:09 -0600
From:   Nabeel M Mohamed <nabeelmd.linux@gmail.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>, linuxarm@huawei.com
Subject: Re: [PATCH v2] cxl/pci: Set the device timestamp
Message-ID: <Y/bjnb0gmmpkjk8r@nabeel-linux.myguest.virtualbox.org>
References: <20230130151327.32415-1-Jonathan.Cameron@huawei.com>
 <Y/Y19p8hqgYGkkKK@nabeel-linux.myguest.virtualbox.org>
 <20230222162700.00006d0f@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230222162700.00006d0f@Huawei.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Feb 22, 2023 at 04:27:00PM +0000, Jonathan Cameron wrote:
> On Wed, 22 Feb 2023 09:34:14 -0600
> Nabeel M Mohamed <nabeelmd.linux@gmail.com> wrote:
> 
> > On Mon, Jan 30, 2023 at 03:13:27PM +0000, Jonathan Cameron wrote:
> > > CXL r3.0 section 8.2.9.4.2 "Set Timestamp" recommends that the host sets
> > > the timestamp after every Conventional or CXL Reset to ensure accurate
> > > timestamps. This should include on initial boot up. The time base that
> > > is being set is used by a device for the poison list overflow timestamp
> > > and all event timestamps.  Note that the command is optional and if
> > > not supported and the device cannot return accurate timestamps it will
> > > fill the fields in with an appropriate marker (see the specification
> > > description of each timestamp).
> > > 
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > >  
> > 
> > Hi Jonathan,
> > 
> > Could you please educate me on the reason for not supporting a
> > "Get Timestamp" mailbox command at this time?
> > 
> > A use-case that I can think of for having "Get Timestamp" in the UAPI
> > is to enable userspace to better correlate the timestamp in the device
> > logs with the wall time by querying the current timestamp on the device.
> > This could be useful if there's some inaccuracy or skew in the device
> > timestamp.
> > 
> > Would that be a valid use-case or am I misunderstanding something here?
> > 
> > I can see why "Set Timestamp" is a kernel-internal command but fail to
> > see why "Get Timestamp" cannot be in the UAPI.
> 

> Hi Nabeel,
> 
> I'd be fine with a patch adding the support, it just didn't solve my
> immediate problem so I didn't want to make this patch more complex.
> 
> Jonathan

Great, thanks for clarifying Jonathan!

I'll be happy to post a patch which adds support for "Get Timestamp".

Btw, this will be my first patch to the CXL driver.
So, I'm wondering if there's any checklist listing the prerequisites
for submitting a patch to the CXL driver - for instance, requirements
on adding new tests for coverage, any existing CXL regression suites
that the patch must pass, etc.

Any pointers on the above would be greatly appreciated!

Thanks,
Nabeel
