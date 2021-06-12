Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EEFEC48BE6
	for <linux-cxl@archiver.kernel.org>; Sat, 12 Jun 2021 00:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46DEC613D9
	for <linux-cxl@archiver.kernel.org>; Sat, 12 Jun 2021 00:08:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbhFLAKm (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 11 Jun 2021 20:10:42 -0400
Received: from mail-pj1-f54.google.com ([209.85.216.54]:39556 "EHLO
        mail-pj1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbhFLAKm (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 11 Jun 2021 20:10:42 -0400
Received: by mail-pj1-f54.google.com with SMTP id w14-20020a17090aea0eb029016e9e0e7983so211433pjy.4
        for <linux-cxl@vger.kernel.org>; Fri, 11 Jun 2021 17:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hGLFyLESMIgo99vWAnXA3J0lKjK1kQXAD/JyJ1aKsZk=;
        b=QbII9VgB8n74k5K/jFnXpmVK+M1t2h2uYfthcmYVLcLX21+gOXDCMUJ2OEvFRQtZth
         uYhUA0p47+XXAKEXbdlxQeeCpaHRpGsQLd0w/hiz3Me5wpQZD4jiucHL7pUZwj8HbRau
         C2164UGRNBNojotFntcaX1wN4KWUYUNLo5063jEvJy5RFX8h7v6pQPCXLnULVzu2ZTVw
         sqK9AUWZC9WC5ee6tXU84/HUR+5gT1d29ArWcOOss6OZMY2MfFuvU6JyZ5H+aiAK8LZu
         3KF4/t9qw/CgrlcHEqkct40QF2AdfABFL6/vqUCj1/55MuZ/zEEG9RNNAiozR75RgmXL
         CTqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hGLFyLESMIgo99vWAnXA3J0lKjK1kQXAD/JyJ1aKsZk=;
        b=YcT3CSmndcOIfhTnsPR3Nb2XLM3RzzWUBnD0epFNhOCAc71KlNdOhhkVuI6OQkLMgx
         Ddsn3J7y5WvVWIsdJ5jt1m1/z56e8ZFiMu/Yqhz8S6cxG+OAz0amPJkP3xRqnU3xNE5O
         PkzkSP2LphayqmwIdwEcrFHxyehyl4fX/iDnvpFhtLiI8IaYJxnOxOVB6/xkE+c1I2/3
         uAp6IE+LBdoN4UXVW29CnpU1oItowyz59p9v24oMXadrlx9x2ROY6h8DK67uC2BxEvDu
         EDVmX8/FIziQEfPgjGX/+q6zx48+wkkbNjyrOdSwC0fmKemwVSa/J0PmsIr7ZQlx0YfH
         lFZQ==
X-Gm-Message-State: AOAM5311LzJchbSf5D3tv31M/Y8SNrYf+6o6alvkkalRe2bhPvoma3yw
        Lwgr/WgitE6lEX9U5LMP86+gHj4w8TdEOPlRgSh0HA==
X-Google-Smtp-Source: ABdhPJzWnHWBBuelObRnLJjV0cwtOackeAz3RyD+CKkcuWLFAmuidh4v8+rcKDkgjSaaI097BNGGhzQAwSEoie+Ek/A=
X-Received: by 2002:a17:902:f1cb:b029:10c:5c6d:88b with SMTP id
 e11-20020a170902f1cbb029010c5c6d088bmr6253794plc.52.1623456463807; Fri, 11
 Jun 2021 17:07:43 -0700 (PDT)
MIME-Version: 1.0
References: <162336395765.2462439.11368504490069925374.stgit@dwillia2-desk3.amr.corp.intel.com>
 <162336396844.2462439.1234951573910835450.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20210611123953.000054df@Huawei.com>
In-Reply-To: <20210611123953.000054df@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 11 Jun 2021 17:07:32 -0700
Message-ID: <CAPcyv4hU-b1=5eAn=Fs65AwYMQj58txMj_D3Y_Ynq72QO-qJrQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] cxl/pmem: Add initial infrastructure for pmem support
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, Linux NVDIMM <nvdimm@lists.linux.dev>,
        Ben Widawsky <ben.widawsky@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Jun 11, 2021 at 4:40 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Thu, 10 Jun 2021 15:26:08 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
>
> > Register an 'nvdimm-bridge' device to act as an anchor for a libnvdimm
> > bus hierarchy. Also, flesh out the cxl_bus definition to allow a
> > cxl_nvdimm_bridge_driver to attach to the bridge and trigger the
> > nvdimm-bus registration.
> >
> > The creation of the bridge is gated on the detection of a PMEM capable
> > address space registered to the root. The bridge indirection allows the
> > libnvdimm module to remain unloaded on platforms without PMEM support.
> >
> > Given that the probing of ACPI0017 is asynchronous to CXL endpoint
> > devices, and the expectation that CXL endpoint devices register other
> > PMEM resources on the 'CXL' nvdimm bus, a workqueue is added. The
> > workqueue is needed to run bus_rescan_devices() outside of the
> > device_lock() of the nvdimm-bridge device to rendezvous nvdimm resources
> > as they arrive. For now only the bus is taken online/offline in the
> > workqueue.
> >
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>
> I'm not that familiar with nvdimm side of things, so this is mostly
> superficial review of the patch itself.
>
> A few really minor comments inline, but otherwise looks good to me.
>
> Jonathan
>
[..]
> > +static void unregister_nvb(void *_cxl_nvb)
> > +{
> > +     struct cxl_nvdimm_bridge *cxl_nvb = _cxl_nvb;
> > +     bool flush = false;
> > +
> > +     /*
> > +      * If the bridge was ever activated then there might be in-flight state
> > +      * work to flush. Once the state has been changed to 'dead' then no new
> > +      * work can be queued by user-triggered bind.
> > +      */
> > +     device_lock(&cxl_nvb->dev);
> > +     if (cxl_nvb->state != CXL_NVB_NEW)
> > +             flush = true;
>
> flush = clx_nvb->state != CXL_NVB_NEW;
>
> perhaps?

Oh, yeah, that's nicer.

[..]
> > +static void cxl_nvb_update_state(struct work_struct *work)
> > +{
> > +     struct cxl_nvdimm_bridge *cxl_nvb =
> > +             container_of(work, typeof(*cxl_nvb), state_work);
> > +     bool release = false;
> > +
> > +     device_lock(&cxl_nvb->dev);
> > +     switch (cxl_nvb->state) {
> > +     case CXL_NVB_ONLINE:
> > +             online_nvdimm_bus(cxl_nvb);
> > +             if (!cxl_nvb->nvdimm_bus) {
>
> I'd slightly prefer a simple return code from online_nvdimm_bus()
> so the reviewer doesn't have to look up above to find out that
> this condition corresponds to failure.

Yeah, not sure why I made that so obscure.
