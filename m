Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D282C433EF
	for <linux-cxl@archiver.kernel.org>; Thu, 28 Apr 2022 21:10:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234151AbiD1VOL (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 28 Apr 2022 17:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352025AbiD1VOK (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 28 Apr 2022 17:14:10 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929686E55F
        for <linux-cxl@vger.kernel.org>; Thu, 28 Apr 2022 14:10:52 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id b12so5433157plg.4
        for <linux-cxl@vger.kernel.org>; Thu, 28 Apr 2022 14:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QMkiFYyjcdg0nw4up8SDMRG3sFyNm+6Gb+F4PzH7X+Q=;
        b=JA2PBajHMljiTqCGPV4kM8XizLUvpqqGtTBjV2LBTzuaunKb6v7/3HcGydlBbSWM8c
         As5YX/ec1elWhSy1f2K6tzCFPY7G44wfyqwuLMUyr7ht1gdm3gyialmS6g8kyEU5Y8Iq
         584xhPguKkAIk3qyKvhIenuez3Pa0DgEV5u4AY2VN2OWU2yLshn0sT79HVQNXwH4FLAR
         PNbj0iBUQtx7A7D7GBWN4JLISlqnKjDLTUSOsHAB3gcEgjNS15sViW9WXvpwYThL7lOb
         R5JX3G2YfrSzq3iM01IVcvXLkGx3XY/zoNZoby7sgLdrWPOf7JnsJbMHgGRsHzFYbQSF
         9U3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QMkiFYyjcdg0nw4up8SDMRG3sFyNm+6Gb+F4PzH7X+Q=;
        b=uiQ2wQAkHeeWueACW8gFFkAKP7XNnWAGRyhQQ2YIjvlVIWCod6OcV+DNXbRcWWqNRu
         P5fWY+sMDDci6PMuyep9Wbi/YzxUZFKHvIZiEpket7I14Wic4gIgFbtoXpjBkRtTAFAl
         EgciHyjyeHZpWQsXqLWv1VjUaqL416xgLaDeFJtrtbjJdKy8ZYSb8W2GWKTRjvZxjio+
         OVrGezoq4eVQaLD6hhk9yBhZU8iM4nqU96HuuJMc05bIVY7VTg1EzvxvZ9ph3U+jxaLI
         fMOHwY0duZBYnNnULlsSNFl5KGYPtSPY3OKG897xtiL1EHRifweOm8p7feOZaFjR9m1i
         dGdA==
X-Gm-Message-State: AOAM530pnfbkPVjJuZ7RVj6IQn2bjifX9YIaZnOXorRhG1PSoXQN40I0
        2rLo5b0KUWMO0MNKnAoDgXR0iralujWqfr85Ce27xg==
X-Google-Smtp-Source: ABdhPJx1SbAUk2GcAgn71//1H3+AqRBvMK733IykdFqRBunTDTO9zL9nY7N2gsfigNKgdCBQKFQc4LnSECGCk15oXvw=
X-Received: by 2002:a17:902:ea57:b0:15a:6173:87dd with SMTP id
 r23-20020a170902ea5700b0015a617387ddmr36147911plg.147.1651180252431; Thu, 28
 Apr 2022 14:10:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220426180832.00005f0b@Huawei.com> <CAPcyv4i+=ArjE7uH_jKGS+B9-dLJ3An_T+NgWB2xqC-7Zh-VYA@mail.gmail.com>
 <20220426190615.000063ed@Huawei.com> <CAPcyv4gjn7MAo-kzW40EAc9J6zQaOKh0a-42GyV1X5Efac_W_Q@mail.gmail.com>
 <20220426203850.00006538@Huawei.com> <CAPcyv4jsd=mWOU0ftgxBzwD6KhZ1oMCRVDm5WTYStfbF7_jBTA@mail.gmail.com>
 <20220427093552.0000376e@Huawei.com>
In-Reply-To: <20220427093552.0000376e@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 28 Apr 2022 14:10:40 -0700
Message-ID: <CAPcyv4gFWw9s6r9kUoL-_P9qnaZSJBMz+EcmfY+0g1NHrJQx7Q@mail.gmail.com>
Subject: Re: CXL type 3 which doesn't have cxl mem enabled.
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Apr 27, 2022 at 1:36 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
> >
> > Oh yuck, yes the default init state of any device is that it will
> > decode the first 256MB of memory as long as mem_enabled is set, and
> > devices are "trusted" to not decode anything that they shouldn't.
> >
> > I'm wondering if Linux should take a more draconian approach and
> > mandate that all devices that advertise the CXL 2.0 Class Code
> > capability must boot in HDM decoder enabled mode, or Mem_enable=0
> > mode. Any CXL 2.0 device found to have Mem_enable=1 without HDM
> > decoders enabled will have HDM decoder operation forced upon them so
> > that Linux can trust that nothing is being decoded by accident, if
> > that breaks the system, that's a BIOS bug, not a Linux bug. Of course,
> > could have a module parameter to override that policy while the BIOS
> > update is in-flight to the target system.
>
> I'm not sure it is technically a BIOS bug. Using the range approach with
> everything fully set up - e.g. with Memory also in the EFI memory map
> and other appropriate places is fine.  We should just ignore those
> devices.  Hopefully they also have the lock set.

The problem is that having the range in the EFI memory map is
ambiguous as to whether the BIOS programmed the CXL device to claim
that range, or some other (untrusted/unexpected) entity programmed the
device to claim those ranges. The only positive indication that the
platform BIOS expects CXL devices to claim EFI memory map ranges is if
the entry appears in the CFMWS with the "Fixed Device Configuration"
bit set.

> We could make what you suggest a Linux 'boot standard' though...
> We'd want to communicate that strongly to various BIOS teams though.
> Even better if we can get other OSVs on side.

Similar to the existing standard that the driver sets with respect to
vendor specific commands I expect this is a kernel policy that can be
set first and discussed later when / if it starts to conflict with
reality. In the meantime it lets the driver have some reasonable
boundaries about the configurations it needs to be prepared to accept.

> I'll check with our BIOS team whether they'd mind this restriction.

Especially in the case of legacy CXL 1.1 devices that pre-date the
definition of the CXL 2.0 memory device class code, I would be
surprised if this policy stance impacted existing or in-flight product
plans, but yes please speak up now.
