Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26435C433ED
	for <linux-cxl@archiver.kernel.org>; Wed, 31 Mar 2021 15:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D11246101D
	for <linux-cxl@archiver.kernel.org>; Wed, 31 Mar 2021 15:46:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235499AbhCaPqD (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 31 Mar 2021 11:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235711AbhCaPpe (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 31 Mar 2021 11:45:34 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA0CC061574
        for <linux-cxl@vger.kernel.org>; Wed, 31 Mar 2021 08:45:33 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id ce10so30780868ejb.6
        for <linux-cxl@vger.kernel.org>; Wed, 31 Mar 2021 08:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vZvTeEIjG7hTC60MU99hsLQZS7LHfA5UNSzOvxjACt8=;
        b=fXH/mAvHacC9Z8pz246d+YnXXN5MWHNHjElL48QIg54VEmSuiNzgDYSUizBO7MY4ab
         uAVfw9BR3DLIdY0xMpeZyPXKfjxY+7MrXrvnal/hh7RoaJq1zWdGA1lgR1Uzuf0I6HUF
         ZMyzcQV6/xnE8tJvobv6MKdjTHyHeebl91rQCJeimSqlGr0bRBOtccpStf1zFACueNzt
         8XeyZVyqhM5VDYt8zeIXg/2fQhdrlrJharVAJzSiSH13/YHZB1oOrwsZf7ttSj+CD1Bz
         2GzvFkf8t+JuHGBhrPxELoqiyuVamJ8j+Z37OO2rbLkR8ZfGdBvtJIV+9VBZpJvPFf2n
         dRhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vZvTeEIjG7hTC60MU99hsLQZS7LHfA5UNSzOvxjACt8=;
        b=GnW0LdZEh5LwJi4j4jSuPVHbH/9MVeJWicMsG3K6QKdjQk98/mQ0G39khCjYKR/3Vw
         TKUvlBD/OiLqSJ4969x/bpP7lNkhKN62PswS9P5WJoOyBHs8HbYxzwpyMuA2Q/ggu6H4
         1HubRsdNxZv4LVrTfioLlmZ+gwsqUgrla8R/5rGW8cuVnpJHW4P2fDOEJqSIMu9kGfos
         ZNgEnxtPfiSF2qpH/k4ZtC9aOt8VsZVKSD+wz14fCMPo5HOXlbdgDpkkYZ7NkyFD11vA
         EE/HfZlrJwMEAvD+cZ3Ms4EKlV70W77JJwbTlY9evSBqIzFR3mU+H3p67ggr00ULliFP
         2cgQ==
X-Gm-Message-State: AOAM531tM8MDJObe1tWwl0i28Tu9lIfvx4ELKKzP0Z4fkh0EK7an4GO9
        7uMLELL0ULFS/txzd2oc36rwGNZUSeQrvDsXcomVDA==
X-Google-Smtp-Source: ABdhPJw1YouJGVVEEuAelWJYwoGubYOmgwmigz+nnYb7sSU7Yqz3tCAoDuaId7uScLRM/fMDHiCUSusnuCZE97Yzcs0=
X-Received: by 2002:a17:906:8447:: with SMTP id e7mr4225482ejy.523.1617205532398;
 Wed, 31 Mar 2021 08:45:32 -0700 (PDT)
MIME-Version: 1.0
References: <161714738634.2168142.10860201861152789544.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161714739718.2168142.17960000558666300914.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20210331130720.GF1463678@nvidia.com>
In-Reply-To: <20210331130720.GF1463678@nvidia.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 31 Mar 2021 08:45:23 -0700
Message-ID: <CAPcyv4gv3rk+NhdhN=QcJMDwRSziqeDKhYtrnZFa6yOZe-_caQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] cxl/mem: Fix synchronization mechanism for device
 removal vs ioctl operations
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-cxl@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Mar 31, 2021 at 6:07 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Tue, Mar 30, 2021 at 04:36:37PM -0700, Dan Williams wrote:
> > -static void cxlmdev_unregister(void *_cxlmd)
> > +static void cxl_memdev_activate(struct cxl_memdev *cxlmd, struct cxl_mem *cxlm)
> >  {
> > -     struct cxl_memdev *cxlmd = _cxlmd;
> > -     struct device *dev = &cxlmd->dev;
> > +     cxlmd->cxlm = cxlm;
> > +     down_write(&cxl_memdev_rwsem);
> > +     up_write(&cxl_memdev_rwsem);
> > +}
>
> No reason not to put the assignment inside the lock. Though using the
> lock at all is overkill as the pointer hasn't left the local stack
> frame at this point.

Right, I was considering just leaving it as a bare pointer assignment,
in fact that must be sufficient as publishing the cdev needs to depend
on all cdev init having completed. So if this write somehow leaks into
cdev_device_add() there are much larger problems afoot.

>
> >  err_add:
> > -     ida_free(&cxl_memdev_ida, cxlmd->id);
> > -err_id:
> >       /*
> > -      * Theoretically userspace could have already entered the fops,
> > -      * so flush ops_active.
> > +      * The cdev was briefly live, shutdown any ioctl operations that
> > +      * saw that state.
> >        */
>
> Wow it is really subtle that cdev_device_add has this tiny hole where
> it can fail but have already allowed open() :<

Yes, this was something I wanted to address in the cdev api proposal
integrating the debugfs fops proxy / reference counting aproach. I
want a cdev api that does not allow open until after the associated
device has registered and fired the KOBJ_ADD event.

>
> Other than the lock it looks OK
>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Thanks, Jason.
