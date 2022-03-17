Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC001C433F5
	for <linux-cxl@archiver.kernel.org>; Thu, 17 Mar 2022 18:31:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbiCQScS (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 17 Mar 2022 14:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235157AbiCQScS (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 17 Mar 2022 14:32:18 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9538DE9CA2
        for <linux-cxl@vger.kernel.org>; Thu, 17 Mar 2022 11:31:01 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id q19so3293017pgm.6
        for <linux-cxl@vger.kernel.org>; Thu, 17 Mar 2022 11:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0c2AnKHAK3iM3EVaDmQ1+jJVG3le62Hw54pTeLtsI74=;
        b=3+OzCWg/u1D+s3hhxXImv9D1Cy6V44cs3wG5o3I5m5eHnemxp+mh3LavXfTpWloKb1
         way2qcf4Q5/BSdU6Y0hGx5OllzU++k+6Aoccb7cMfI3v8uObNsWAyk8J9G4FcxbxsDEQ
         2NlIbVq2/Ip56Ezn7uRLiaUMJRMWXagZO1IX9Qf/jLa222aO6HCvTpV/WN/KP3qrAzHK
         Ldd9mHWlJErGkTfjOzSl+05omU5wo5F7dodgpOP1/AC5GT+w2iJ4lQXF+PwT/FOBmUEG
         Xe6WtHj+1WKMEgeRmHYGpMGRL5Ub9HpHeXkHrpKJX//JHAAiL9h4Cgmg/pRGcZ//A7wV
         Pm1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0c2AnKHAK3iM3EVaDmQ1+jJVG3le62Hw54pTeLtsI74=;
        b=A4MGh8QEKlGT5t00K49dHmFW2E1Itkd/bPmda7bB8NekEQsiPX5ds9DtnmDi6gTJo5
         IU6lYTsSSH1V79bgjCvdKq+ElYE3fwqUQM+UUqeW+DF3afXwVxEn7u4VIyjmine3b1Lv
         U6PKwDFlw1LtVB16jCnCnBqtGAIIm+yPLj/fuii40Xu+0fDAxx6e0h1WR9JQDpRWSxh9
         ACwzBYDfFV0zlorT+bCfzJ0v11ArJixphSXFdMOoi1LUQDSP68H+G3NMv9m5KbnkM8fc
         Si70brZuWT5eW1CTsRggHB+hpeVVgiMQcq6SG39uM05nirZgSuEjWzRXXAcEWSogzq+r
         y3fg==
X-Gm-Message-State: AOAM532LNSHUZ1+13kXIdu+LL5UIGarB168WdgG3Zf5Q2yo+6de5ZWQh
        F6lfOWuxOa2eyOPEKJv+nfw4a9q6qmdrpkpVLIZPig==
X-Google-Smtp-Source: ABdhPJxFX0nYe4WST8xR9d+r1Z2GsGW5aZ9p4QMM7mvGGGMYjOH/uvistQ2MHS/m3eJJR7fzTMFhdu39kBZK8ufpuQI=
X-Received: by 2002:a05:6a00:8ca:b0:4e0:2ed3:5630 with SMTP id
 s10-20020a056a0008ca00b004e02ed35630mr6151594pfu.3.1647541861073; Thu, 17 Mar
 2022 11:31:01 -0700 (PDT)
MIME-Version: 1.0
References: <164730733718.3806189.9721916820488234094.stgit@dwillia2-desk3.amr.corp.intel.com>
 <164730735869.3806189.4032428192652531946.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20220317175228.wpzot2nu4snc6bz6@intel.com> <CAPcyv4gyaLun3xeo+cp-KVedR1RrSErH9qSyJ=dpL0fYT+Dvww@mail.gmail.com>
 <20220317182900.3dh6xdmrbqiuqzfl@intel.com>
In-Reply-To: <20220317182900.3dh6xdmrbqiuqzfl@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 17 Mar 2022 11:30:50 -0700
Message-ID: <CAPcyv4i-Yk-L0CdOL1ebOCX5MBSja-Q2R4wEiTDcWfeGiWhyYQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] cxl/pci: Make cxl_dvsec_ranges() failure not fatal
 to cxl_pci
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org,
        Krzysztof Zach <krzysztof.zach@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Mar 17, 2022 at 11:29 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> On 22-03-17 11:20:48, Dan Williams wrote:
> > On Thu, Mar 17, 2022 at 10:52 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
> > >
> > > On 22-03-14 18:22:38, Dan Williams wrote:
> > > > cxl_dvsec_ranges(), the helper for enumerating the presence of an active
> > > > legacy CXL.mem configuration on a CXL 2.0 Memory Expander, is not fatal
> > > > for cxl_pci because there is still value to enable mailbox operations
> > > > even if CXL.mem operation is disabled. Recall that the reason cxl_pci
> > > > does this initialization and not cxl_mem is to preserve the useful
> > > > property (for unit testing) that cxl_mem is cxl_memdev + mmio generic,
> > > > and does not require access to a 'struct pci_dev' to issue config
> > > > cycles.
> > > >
> > > > Update 'struct cxl_endpoint_dvsec_info' to carry either a positive
> > > > number of non-zero size legacy CXL DVSEC ranges, or the negative error
> > > > code from __cxl_dvsec_ranges() in its @ranges member.
> > > >
> > > > Reported-by: Krzysztof Zach <krzysztof.zach@intel.com>
> > > > Fixes: 560f78559006 ("cxl/pci: Retrieve CXL DVSEC memory info")
> > > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > > > ---
> > > >  drivers/cxl/pci.c |   27 ++++++++++++++++++---------
> > > >  1 file changed, 18 insertions(+), 9 deletions(-)
> > > >
> > > > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > > > index 257cf735505d..994c79bf6afd 100644
> > > > --- a/drivers/cxl/pci.c
> > > > +++ b/drivers/cxl/pci.c
> > > > @@ -463,13 +463,18 @@ static int wait_for_media_ready(struct cxl_dev_state *cxlds)
> > > >       return 0;
> > > >  }
> > > >
> > > > -static int cxl_dvsec_ranges(struct cxl_dev_state *cxlds)
> > > > +/*
> > > > + * Return positive number of non-zero ranges on success and a negative
> > > > + * error code on failure. The cxl_mem driver depends on ranges == 0 to
> > > > + * init HDM operation.
> > > > + */
> > >
> > > It shouldn't depend on 0 ranges, it depends on ranges matching existing HDM
> > > decoder ranges. I took a shortcut by just checking global enable originally
> > > because we didn't yet have code to enumerate decoders (anything else would be a
> > > crazy BIOS bug that's probably not worth working around).
> >
> > Hmm, I don't see that as a shortcut. If global enable is set then
> > there is no requirement that CXL DVSEC matches the HDM decoder ranges,
> > if global enable is not set then the HDM decoder ranges are not in
> > effect.
>
> It's true that there is no requirement that the DVSEC matches HDM decoder
> ranges, except as you point out before it's going against spec recommendation.
>
> >
> > This is what the new comment in cxl_hdm_decode_init() is trying to
> > clarify. My proposal is that Linux ignores the recommendation which I
> > think is trying to accommodate legacy CXL 1.1 software stacks which
> > Linux never had.
> >
>
> Okay, that's fine.
>
> >         /*
> >          * Per CXL 2.0 Section 8.1.3.8.3 and 8.1.3.8.4 DVSEC CXL Range 1 Base
> >          * [High,Low] when HDM operation is enabled the range register values
> >          * are ignored by the device, but the spec also recommends matching the
> >          * DVSEC Range 1,2 to HDM Decoder Range 0,1 so, non-zero info->ranges
> >          * are expected.
> >          */
>
> Maybe explicitly say the driver does not attempt to check this recommendation.

Sure, I can add that.
