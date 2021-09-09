Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 060FEC433EF
	for <linux-cxl@archiver.kernel.org>; Thu,  9 Sep 2021 19:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1276611AD
	for <linux-cxl@archiver.kernel.org>; Thu,  9 Sep 2021 19:04:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbhIITFL (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 9 Sep 2021 15:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbhIITFK (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 9 Sep 2021 15:05:10 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B583AC061574
        for <linux-cxl@vger.kernel.org>; Thu,  9 Sep 2021 12:04:00 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id x19so2601001pfu.4
        for <linux-cxl@vger.kernel.org>; Thu, 09 Sep 2021 12:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Swo3agxALsglopiGgRKDNj9c67iYJRmSV4H3mwHfPac=;
        b=U2dmlBE3n5SrPHahLM7VFhjG7vDIo9l9u3xWFX7OYRiWf18iYAfwBW53PyeujLqfkh
         jfzGx/GKd6nz87duyw4m14JUxFgLPDJtdjaA53vy4kH5y6IxtB8bHzV0TxIqkyMDYeTA
         SToWW6J6OwKI6/GAJIPUJCl9GtWFSH52E3eR0DNz5z3OtN7F+YeKDucEaX84n+UOWPsv
         VbjUD4MXce6mdVm/b2ggfHhBP5QAvudzo6d/1N7OVagb5h+7Ipi+MBYr//ogW7HHMG2/
         r0blqtlUPGz/fpVd5jDieAQqkjIz/XiSURQttrAIVHBYCGpi9bfkkbXjrkbjtza0Lfk4
         ycgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Swo3agxALsglopiGgRKDNj9c67iYJRmSV4H3mwHfPac=;
        b=cINsSDgAWvWjwg2Ywiax73a3T1KXVGyuhLwRqSbBjR6LXBNxnC/a5dDcV3aeCV8RCG
         qCAzimOWiE4XaL45Ammwxr8dHMgouS1GFjUbrs/ijv5lU+ZA5enb33QtqcqW7M5M33Dr
         NAkcfEsm96fOcNGLkmLQ1SObezrcaBgYawPIDfdnNKp7WTSavGgsn73muRSYmZ7J+edT
         c93WToSGhoBH2I6cJZfhD4KsJGWwxE36bYxdUWlZWCxx/vMmQ278ppMG4qOX6i6d4v94
         uPtR1F6yNd0y3oecfmNyEusb10SfNBlfb3Od+zxUDHACjuhpS4SJpSCRJr7a+wC4vMuY
         MGYg==
X-Gm-Message-State: AOAM532wXDWFh7eeaXC5hWgwgyopGFI6IUG7cRi0En/iQC/k/+7cOjLd
        oRWazSI+r9zLdVN3VrFAljyX3PjOJeDWhPjywfNFwA==
X-Google-Smtp-Source: ABdhPJyUHnzbadVo+zIK07fXM7S807SaVh8mJPMZw7wMIMHpi7ZURrDbAN9I0NOw9Qu3RU6gvKfGObJDahiLWYTzPIg=
X-Received: by 2002:a63:3545:: with SMTP id c66mr3911181pga.377.1631214240166;
 Thu, 09 Sep 2021 12:04:00 -0700 (PDT)
MIME-Version: 1.0
References: <163116429183.2460985.5040982981112374615.stgit@dwillia2-desk3.amr.corp.intel.com>
 <163116437437.2460985.13509423327603255812.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20210909172226.mwj6jdmmhmxir4je@intel.com>
In-Reply-To: <20210909172226.mwj6jdmmhmxir4je@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 9 Sep 2021 12:03:49 -0700
Message-ID: <CAPcyv4iwTSE2iV6d-56rwE7OhZno=oTwHk6N_XdvJMVObCO_WQ@mail.gmail.com>
Subject: Re: [PATCH v4 15/21] cxl/pmem: Translate NVDIMM label commands to CXL
 label commands
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Sep 9, 2021 at 10:22 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> On 21-09-08 22:12:54, Dan Williams wrote:
> > The LIBNVDIMM IOCTL UAPI calls back to the nvdimm-bus-provider to
> > translate the Linux command payload to the device native command format.
> > The LIBNVDIMM commands get-config-size, get-config-data, and
> > set-config-data, map to the CXL memory device commands device-identify,
> > get-lsa, and set-lsa. Recall that the label-storage-area (LSA) on an
> > NVDIMM device arranges for the provisioning of namespaces. Additionally
> > for CXL the LSA is used for provisioning regions as well.
> >
> > The data from device-identify is already cached in the 'struct cxl_mem'
> > instance associated with @cxl_nvd, so that payload return is simply
> > crafted and no CXL command is issued. The conversion for get-lsa is
> > straightforward, but the conversion for set-lsa requires an allocation
> > to append the set-lsa header in front of the payload.
> >
> > Acked-by: Ben Widawsky <ben.widawsky@intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  drivers/cxl/pmem.c |  125 ++++++++++++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 121 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
> > index a972af7a6e0b..29d24f13aa73 100644
> > --- a/drivers/cxl/pmem.c
> > +++ b/drivers/cxl/pmem.c
> > @@ -1,6 +1,7 @@
> >  // SPDX-License-Identifier: GPL-2.0-only
> >  /* Copyright(c) 2021 Intel Corporation. All rights reserved. */
> >  #include <linux/libnvdimm.h>
> > +#include <asm/unaligned.h>
> >  #include <linux/device.h>
> >  #include <linux/module.h>
> >  #include <linux/ndctl.h>
> > @@ -48,10 +49,10 @@ static int cxl_nvdimm_probe(struct device *dev)
> >  {
> >       struct cxl_nvdimm *cxl_nvd = to_cxl_nvdimm(dev);
> >       struct cxl_memdev *cxlmd = cxl_nvd->cxlmd;
> > +     unsigned long flags = 0, cmd_mask = 0;
> >       struct cxl_mem *cxlm = cxlmd->cxlm;
> >       struct cxl_nvdimm_bridge *cxl_nvb;
> >       struct nvdimm *nvdimm = NULL;
> > -     unsigned long flags = 0;
> >       int rc = -ENXIO;
> >
> >       cxl_nvb = cxl_find_nvdimm_bridge();
> > @@ -66,8 +67,11 @@ static int cxl_nvdimm_probe(struct device *dev)
> >
> >       set_bit(NDD_LABELING, &flags);
> >       rc = -ENOMEM;
> > -     nvdimm = nvdimm_create(cxl_nvb->nvdimm_bus, cxl_nvd, NULL, flags, 0, 0,
> > -                            NULL);
> > +     set_bit(ND_CMD_GET_CONFIG_SIZE, &cmd_mask);
> > +     set_bit(ND_CMD_GET_CONFIG_DATA, &cmd_mask);
> > +     set_bit(ND_CMD_SET_CONFIG_DATA, &cmd_mask);
> > +     nvdimm = nvdimm_create(cxl_nvb->nvdimm_bus, cxl_nvd, NULL, flags,
> > +                            cmd_mask, 0, NULL);
> >       dev_set_drvdata(dev, nvdimm);
> >
> >  out_unlock:
> > @@ -89,11 +93,124 @@ static struct cxl_driver cxl_nvdimm_driver = {
> >       .id = CXL_DEVICE_NVDIMM,
> >  };
> >
> > +static int cxl_pmem_get_config_size(struct cxl_mem *cxlm,
> > +                                 struct nd_cmd_get_config_size *cmd,
> > +                                 unsigned int buf_len, int *cmd_rc)
> > +{
> > +     if (sizeof(*cmd) > buf_len)
> > +             return -EINVAL;
> > +
> > +     *cmd = (struct nd_cmd_get_config_size) {
> > +              .config_size = cxlm->lsa_size,
> > +              .max_xfer = cxlm->payload_size,
> > +     };
> > +     *cmd_rc = 0;
> > +
> > +     return 0;
> > +}
> > +
> > +static int cxl_pmem_get_config_data(struct cxl_mem *cxlm,
> > +                                 struct nd_cmd_get_config_data_hdr *cmd,
> > +                                 unsigned int buf_len, int *cmd_rc)
> > +{
> > +     struct cxl_mbox_get_lsa {
> > +             u32 offset;
> > +             u32 length;
> > +     } get_lsa;
> > +     int rc;
> > +
> > +     if (sizeof(*cmd) > buf_len)
> > +             return -EINVAL;
> > +     if (struct_size(cmd, out_buf, cmd->in_length) > buf_len)
> > +             return -EINVAL;
> > +
> > +     get_lsa = (struct cxl_mbox_get_lsa) {
> > +             .offset = cmd->in_offset,
> > +             .length = cmd->in_length,
> > +     };
> > +
> > +     rc = cxl_mem_mbox_send_cmd(cxlm, CXL_MBOX_OP_GET_LSA, &get_lsa,
> > +                                sizeof(get_lsa), cmd->out_buf,
> > +                                cmd->in_length);
> > +     cmd->status = 0;
> > +     *cmd_rc = 0;
> > +
> > +     return rc;
> > +}
> > +
> > +static int cxl_pmem_set_config_data(struct cxl_mem *cxlm,
> > +                                 struct nd_cmd_set_config_hdr *cmd,
> > +                                 unsigned int buf_len, int *cmd_rc)
> > +{
> > +     struct cxl_mbox_set_lsa {
> > +             u32 offset;
> > +             u32 reserved;
> > +             u8 data[];
> > +     } *set_lsa;
> > +     int rc;
> > +
> > +     if (sizeof(*cmd) > buf_len)
> > +             return -EINVAL;
> > +
> > +     /* 4-byte status follows the input data in the payload */
> > +     if (struct_size(cmd, in_buf, cmd->in_length) + 4 > buf_len)
> > +             return -EINVAL;
> > +
> > +     set_lsa =
> > +             kvzalloc(struct_size(set_lsa, data, cmd->in_length), GFP_KERNEL);
> > +     if (!set_lsa)
> > +             return -ENOMEM;
> > +
> > +     *set_lsa = (struct cxl_mbox_set_lsa) {
> > +             .offset = cmd->in_offset,
> > +     };
> > +     memcpy(set_lsa->data, cmd->in_buf, cmd->in_length);
> > +
> > +     rc = cxl_mem_mbox_send_cmd(cxlm, CXL_MBOX_OP_SET_LSA, set_lsa,
> > +                                struct_size(set_lsa, data, cmd->in_length),
> > +                                NULL, 0);
> > +
> > +     /*
> > +      * Set "firmware" status (4-packed bytes at the end of the input
> > +      * payload.
> > +      */
> > +     put_unaligned(0, (u32 *) &cmd->in_buf[cmd->in_length]);
> > +     *cmd_rc = 0;
> > +     kvfree(set_lsa);
> > +
> > +     return rc;
> > +}
> > +
> > +static int cxl_pmem_nvdimm_ctl(struct nvdimm *nvdimm, unsigned int cmd,
> > +                            void *buf, unsigned int buf_len, int *cmd_rc)
> > +{
> > +     struct cxl_nvdimm *cxl_nvd = nvdimm_provider_data(nvdimm);
> > +     unsigned long cmd_mask = nvdimm_cmd_mask(nvdimm);
> > +     struct cxl_memdev *cxlmd = cxl_nvd->cxlmd;
> > +     struct cxl_mem *cxlm = cxlmd->cxlm;
> > +
> > +     if (!test_bit(cmd, &cmd_mask))
> > +             return -ENOTTY;
> > +
> > +     switch (cmd) {
> > +     case ND_CMD_GET_CONFIG_SIZE:
> > +             return cxl_pmem_get_config_size(cxlm, buf, buf_len, cmd_rc);
> > +     case ND_CMD_GET_CONFIG_DATA:
> > +             return cxl_pmem_get_config_data(cxlm, buf, buf_len, cmd_rc);
> > +     case ND_CMD_SET_CONFIG_DATA:
> > +             return cxl_pmem_set_config_data(cxlm, buf, buf_len, cmd_rc);
> > +     default:
> > +             return -ENOTTY;
> > +     }
> > +}
> > +
>
> Is there some intended purpose for passing cmd_rc down, if it isn't actually
> ever used? Perhaps add it when needed later?

Ah true, copy-pasta leftovers from other similar routines. I'll clean this up.
