Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED718C433F5
	for <linux-cxl@archiver.kernel.org>; Wed,  3 Nov 2021 16:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC62A61051
	for <linux-cxl@archiver.kernel.org>; Wed,  3 Nov 2021 16:38:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232806AbhKCQkz (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 3 Nov 2021 12:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbhKCQky (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 3 Nov 2021 12:40:54 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 858F2C061714
        for <linux-cxl@vger.kernel.org>; Wed,  3 Nov 2021 09:38:17 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id r28so2882977pga.0
        for <linux-cxl@vger.kernel.org>; Wed, 03 Nov 2021 09:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z95mNNUHLmFbMGr9YEkdADBChD8m4zVSOpMlanMHXrI=;
        b=hq9EzpIZ3/M1cVl4dLgDt7pXLyB3H7MFyiZXeWHvGZvwdOxh6oJOQjsml3LXiT++ng
         dfJ451Xl0e+cAkDVz6f08MQ7F5aDFP3P//H0dkZlBRdKY00+gc2rJftEiBVIbi3EjPqt
         4ijUhX4PkN/rpt45HbK8fRJjxH/oEeW4UXpSaddaqVeXeaIw3ncZKTOpq+WsRHr68HBQ
         R7i3wxoiYmeFiksP/on68cuzPnBMUqjaZsQyZo2FhkKapnvFmnssZXEIWvTH4fiTWNel
         RuWlb+MXaWohGPLMBxcL3OmgzR+Zyl6kvIugMTyVwQwD9EXoNlNg1T3y8ntcqfaWFPvg
         0xog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z95mNNUHLmFbMGr9YEkdADBChD8m4zVSOpMlanMHXrI=;
        b=UuF/SG9VM6aBCCAV9hFvvDyg3ldMbJ/MmbKDevZTDMIfnILvHjgKCnSQyTlUMvx7Lm
         ji4yuUXN4ToubpTU3KqktqtVEhefAEuGg7Axa3gKwk1KpnoRautkmvd6cEn+MqrE9HRl
         HoBuClQ/GgdGEOugT/ntH9GTuDgt3r7HY2rnyGDpzIkE7j7Q4Oiywt6tSdhrw3T6u/Ev
         gAo849srIhsA10r68HDG/Tkm8i8hahjPTm0nJ9/sEBHZdhaaEWw3lbwyzvFaaxsQo4qx
         e/GDn2VBH+b0aR6xSjPtS6Iue3fwDXSCw2Ivw6+wlKjRVI2jaiFFUYV5DGBSEIXfKoMM
         pdDg==
X-Gm-Message-State: AOAM532WG06rKHseOdwUy2H3Qcl5VAdN0wXwUh0tOM9R6nuNjIZifIHd
        U9IT4oQy6WaYmDrMD6eMfqp9CskDMsbw6lr3u+fthw==
X-Google-Smtp-Source: ABdhPJxZy896tO8jk6ZytLpE6KCnk593HeIDQJ5p/282upEc8wdq8P+4z23c2rcimLnS6qYQvorTKLRB2gv45XxOkUA=
X-Received: by 2002:a05:6a00:140e:b0:444:b077:51ef with SMTP id
 l14-20020a056a00140e00b00444b07751efmr45203014pfu.61.1635957497007; Wed, 03
 Nov 2021 09:38:17 -0700 (PDT)
MIME-Version: 1.0
References: <20211102202901.3675568-1-ira.weiny@intel.com> <20211102202901.3675568-3-ira.weiny@intel.com>
 <20211103135102.00001052@Huawei.com>
In-Reply-To: <20211103135102.00001052@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 3 Nov 2021 09:38:07 -0700
Message-ID: <CAPcyv4hcgh2gb8qsS_UXTBSGqYfMPnC6p5kkvNUjm+V6kVKM5g@mail.gmail.com>
Subject: Re: [INTERNAL PATCH 2/2] cxl/cxlmem: Change cxl_mem to a more
 descriptive name
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     "Weiny, Ira" <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Nov 3, 2021 at 6:51 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Tue, 2 Nov 2021 13:29:01 -0700
> <ira.weiny@intel.com> wrote:
>
> > From: Ira Weiny <ira.weiny@intel.com>
> >
> > The cxl_mem object actually represents the state of a CXL device within the
> > driver.  This is data layered on top of the PCI or other device.  Even though
> > the only device currently represented is a memory device, calling this cxl_mem
> > is confusing because this is not solely a CXL memory device.  Furthermore,
> > cxl_memdev does drive a CXL memory device.  So changing the name helps to
> > distinguish these to structures.
> >
> > Update the structure name, function names, and the kdocs to reflect the
> > real uses of this structure.
> >
> > Acked-by: Ben Widawsky <ben.widawsky@intel.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> >
> ...
> Hi Ira,
>
> >  /**
> >   * struct cxl_mbox_cmd - A command to be submitted to hardware.
> > @@ -90,8 +90,13 @@ struct cxl_mbox_cmd {
> >  #define CXL_CAPACITY_MULTIPLIER SZ_256M
> >
> >  /**
> > - * struct cxl_mem - A CXL memory device
> > - * @dev: The device associated with this CXL device.
> > + * struct cxl_dev_state - The driver device state
> > + *
> > + * cxl_dev_state represents the CXL driver/device state.  It provides an
> > + * interface to mailbox commands as well as some cached data about the device.
> > + * Currently only memory devices are represented.
> > + *
> > + * @dev: The device associated with this CXL state
> >   * @cxlmd: Logical memory device chardev / interface
> >   * @regs: Parsed register blocks
> >   * @payload_size: Size of space for payload
> > @@ -117,7 +122,7 @@ struct cxl_mbox_cmd {
> >   * See section 8.2.9.5.2 Capacity Configuration and Label Storage for
> >   * details on capacity parameters.
> >   */
> > -struct cxl_mem {
> > +struct cxl_dev_state {
> >       struct device *dev;
> >       struct cxl_memdev *cxlmd;
>
> This patch got me thinking about whether the new name should have some
> reference to it being the dev state for a type 3 device, because of this
> pointer the cxlmd making me think this wasn't generic enough to be called
> just cxl_dev_state.

I think it's fine. Type-3 memory expander class devices are the only
device-type that the specification has seen fit to standardize a
driver model. When / if accelerator drivers start to cause collisions
grepping for "cxl_dev_state" we can consider another change to
disambiguate.

>
> Naturally next step was to wonder what this was used for....
>
> Far as I can tell it isn't set or used.  Can we drop this pointer?

Yeah, it was originally linked both directions in early patches, but
that use case did not materialize.
