Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F529C433F5
	for <linux-cxl@archiver.kernel.org>; Thu,  5 May 2022 05:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243316AbiEEFVk (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 5 May 2022 01:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243252AbiEEFVj (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 5 May 2022 01:21:39 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE0A1F628
        for <linux-cxl@vger.kernel.org>; Wed,  4 May 2022 22:18:00 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id p8so2786537pfh.8
        for <linux-cxl@vger.kernel.org>; Wed, 04 May 2022 22:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xVyd3Q9+XTUZQlSBQ7JlAxrzZGhY0JSYBpbrHgD4ygw=;
        b=GBXk5cizKEMuepT4krliZTfCCOf/lWWbPRLUjJ0z1SwqAgE6cDEIAbCAbMRlZRUuf6
         lnG6IYKIaAKPt7NAUgC3hnTZOHhf1rVSjrkXztfKXfSqVnXOq7dQteivseTZZdHLXbDg
         QLzYT5N2KmqZ2iOPOCg7xbV2H7qdSs/jpm8QfoahkbM6i74VXYY0Uq60dWlz6+xlrKm6
         sqACJSTeRaHSNKYo6nzT2l677wFTPgJ0EGGQO7EkmQ50sPNRnbbrzmMrHEagFc37xjPF
         UCMKMyTVOhKswDsBLmI77CiCtpzxuyL1rTR3HAzQho67+bs46WjmHOJY/G66PtUCfP0f
         eWkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xVyd3Q9+XTUZQlSBQ7JlAxrzZGhY0JSYBpbrHgD4ygw=;
        b=D8iJUInNZjkNPRMB8+1cINFqQv+L24UXN+NUr9GKMoRhYeC6Bhw3zqNWjcMaweqV4w
         9kYYywFeJoaerT69hcmIoYicxB4EJk9RPhCntzU/KgelxvMKMYzP5uyGSSQWmdUoW8Ge
         d8tGp1fWbg+OVhxQ8Ivs1RZuD80B4vWUIhfYvYsp2Ya3dw+CDnumyhrHu1sboHHUL+sd
         IisVTegs36hdlBJFKHShIRCjJjKSRMwo/amqZVbLSrDdGtLP7Ynhsfg0MAIQ4VMmkVRl
         X6/yX6K1dU6JLAFGkmcx8D/tPlwpeUrIfUwBsKB6FGHGrHI388vXW1tg81fwqoSx2cCl
         eQYQ==
X-Gm-Message-State: AOAM532kL1aTgQfK1PyxCodoUEbsCS85KVe9yfBiQ7c0yDS/8bJfqwGs
        MOOTNlJ9BYZW5YOhUZJOAPeSEF2hgNB8dy3vJH/yqA==
X-Google-Smtp-Source: ABdhPJwPM3foqBEom0oUs7+oAP/Quai5lBsZFY8lgJ2rr+DzPjLk+vgozf3nxqSjqjmG0TIzeWDxPo41S5KH9YYagNo=
X-Received: by 2002:a05:6a00:8c5:b0:4fe:134d:30d3 with SMTP id
 s5-20020a056a0008c500b004fe134d30d3mr24541134pfu.3.1651727880497; Wed, 04 May
 2022 22:18:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220413183720.2444089-1-ben.widawsky@intel.com>
 <20220413183720.2444089-13-ben.widawsky@intel.com> <f9fa0a306b167db2a91021aff70bcdbc8c154391.camel@intel.com>
In-Reply-To: <f9fa0a306b167db2a91021aff70bcdbc8c154391.camel@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 4 May 2022 22:17:49 -0700
Message-ID: <CAPcyv4jM_N0Sz_MpFC9+tr01ysJ16EwkSsbxOXxCM5aC7FSe3w@mail.gmail.com>
Subject: Re: [RFC PATCH 12/15] cxl/region: Add region creation ABI
To:     "Verma, Vishal L" <vishal.l.verma@intel.com>
Cc:     "Widawsky, Ben" <ben.widawsky@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "Weiny, Ira" <ira.weiny@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, May 4, 2022 at 3:57 PM Verma, Vishal L <vishal.l.verma@intel.com> wrote:
>
> On Wed, 2022-04-13 at 11:37 -0700, Ben Widawsky wrote:
> > Regions are created as a child of the decoder that encompasses an
> > address space with constraints. Regions have a number of attributes that
> > must be configured before the region can be activated.
> >
> > Multiple processes which are trying not to race with each other
> > shouldn't need special userspace synchronization to do so.
> >
> > // Allocate a new region name
> > region=$(cat /sys/bus/cxl/devices/decoder0.0/create_pmem_region)
> >
> > // Create a new region by name
> > while
> > region=$(cat /sys/bus/cxl/devices/decoder0.0/create_pmem_region)
> > ! echo $region > /sys/bus/cxl/devices/decoder0.0/create_pmem_region
> > do true; done
> >
> > // Region now exists in sysfs
> > stat -t /sys/bus/cxl/devices/decoder0.0/$region
> >
> > // Delete the region, and name
> > echo $region > /sys/bus/cxl/devices/decoder0.0/delete_region
>
> I noticed a slight ABI inconsistency here while working on the libcxl
> side of this - see below.
>
> > +
> > +static ssize_t create_pmem_region_show(struct device *dev,
> > +                                      struct device_attribute *attr, char *buf)
> > +{
> > +       struct cxl_decoder *cxld = to_cxl_decoder(dev);
> > +       struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxld);
> > +       size_t rc;
> > +
> > +       /*
> > +        * There's no point in returning known bad answers when the lock is held
> > +        * on the store side, even though the answer given here may be
> > +        * immediately invalidated as soon as the lock is dropped it's still
> > +        * useful to throttle readers in the presence of writers.
> > +        */
> > +       rc = mutex_lock_interruptible(&cxlrd->id_lock);
> > +       if (rc)
> > +               return rc;
> > +       rc = sysfs_emit(buf, "%d\n", cxlrd->next_region_id);
>
> This emits a numeric region ID, e.g. "0", where as
>
> > +       mutex_unlock(&cxlrd->id_lock);
> > +
> > +       return rc;
> > +}
> > +
>
> <snip>
>
> > +static ssize_t delete_region_store(struct device *dev,
> > +                                  struct device_attribute *attr,
> > +                                  const char *buf, size_t len)
> > +{
> > +       struct cxl_port *port = to_cxl_port(dev->parent);
> > +       struct cxl_decoder *cxld = to_cxl_decoder(dev);
> > +       struct cxl_region *cxlr;
> > +
> > +       cxlr = cxl_find_region_by_name(cxld, buf);
>
> This expects a full region name string e.g. "region0"
>
> Was this intentional? I don't think it's a huge deal, the library can
> certainly deal with it if needed - but would it be better to have the
> ABI symmetrical between create and delete?

Yes, makes sense to me.
