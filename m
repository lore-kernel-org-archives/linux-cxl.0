Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6121BC4338F
	for <linux-cxl@archiver.kernel.org>; Sat, 14 Aug 2021 19:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E04560F48
	for <linux-cxl@archiver.kernel.org>; Sat, 14 Aug 2021 19:47:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbhHNTru (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sat, 14 Aug 2021 15:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbhHNTrt (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sat, 14 Aug 2021 15:47:49 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55396C061764
        for <linux-cxl@vger.kernel.org>; Sat, 14 Aug 2021 12:47:20 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id u15so737538plg.13
        for <linux-cxl@vger.kernel.org>; Sat, 14 Aug 2021 12:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mWobPHdEXZTTUTlE3qOOEyRjsgo1OvVNBLDOF1yCxNQ=;
        b=oI3IfnEpa7bjomZPNXqz/+oKH9ZbEtqytSVv0KC+mbmuzafNjejrLhZK0tGeMmQkwe
         Jqsnim8I0DxG0trbrlQTpA3OABviJU23fi8rZC9kcRYzVM5xvKt5UXstJRyfbW5q91St
         JknUrNMqWuJlvRnnYN4hVIE3g/E3FkYjiulBOc3f2Eq2jnV8LeJqKKpKyEColo5NYp9k
         jKBt7DC2Egf+p5LD0iemJa7aF/4yxBXIUck0BtRq64QU5CtAV1DbAiNVi2ffOEjXElEu
         TaFc0I0uDUQVr+NmioTM76IHjUCXuHl4ZVxKybgLM+GRBdWWvJkmOdIFW028cYSccEA9
         KMMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mWobPHdEXZTTUTlE3qOOEyRjsgo1OvVNBLDOF1yCxNQ=;
        b=h5GmRpM3fpnZrsdH7CpSxq0rQ2FpehGt8V5G4qZK13Sd5J69e9FHtFLHiMs9mzPcbC
         FNIVYLPxHBEDDqnl09st9YEOH1QHMH8xjijG/KH58PDdWk+Wb9bScYa8h/TqqbKlw8PY
         /gdYaWGO74x9twh/5jsU/1cs3oDdnQSycFBtF/y/WZ0xU6Z9ib6/pAOf/iNhAXwHqrW9
         d+a7CG+9N3zDvXsXa2ajmwWsY5pKPLWRdjps1SUVX+1LMUswoAB8NFkzoKFDcY8dEK4G
         HAnABidqty0QFYN/B1zeG8o3NNLP5zoCnU+MXIXUjO8Z19kFz90ZimKrTrMlXlKI414i
         bkgg==
X-Gm-Message-State: AOAM531LvHeqyAn4HjeSq+VhCo0RSxI6nrDP5zA/i+dDZqLS58cb/t5L
        iCBoMBCz9psFBGqmE2aDXdPjyIREYRi8t81xCJrUbg==
X-Google-Smtp-Source: ABdhPJw0SKp3i/Dzexxs7u/+WD9m6AwBaGteXEVuQqQK+D6pifE4E52fRSurroXMiYI+384nnxh+8vWfSuK95HXv5H4=
X-Received: by 2002:a17:90b:18f:: with SMTP id t15mr8518388pjs.168.1628970439871;
 Sat, 14 Aug 2021 12:47:19 -0700 (PDT)
MIME-Version: 1.0
References: <DM5PR12MB2534D383B0226498DD7F2005BDFA9@DM5PR12MB2534.namprd12.prod.outlook.com>
 <20210813171421.GA2593219@bjorn-Precision-5520> <20210814111620.wn6422g3dbed52ex@archlinux>
In-Reply-To: <20210814111620.wn6422g3dbed52ex@archlinux>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sat, 14 Aug 2021 12:47:09 -0700
Message-ID: <CAPcyv4iDZQuDvE9kBjpjTTWA4z7-aZ=AAon-OREObyzDWALfMw@mail.gmail.com>
Subject: Re: CXL Hot and Warm Reset Testing
To:     Amey Narkhede <ameynarkhede03@gmail.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Vikram Sethi <vsethi@nvidia.com>,
        Chris Browy <cbrowy@avery-design.com>,
        linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Shanker Donthineni <sdonthineni@nvidia.com>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Sat, Aug 14, 2021 at 4:16 AM Amey Narkhede <ameynarkhede03@gmail.com> wrote:
>
> On 21/08/13 12:14PM, Bjorn Helgaas wrote:
> > [+cc Amey (working on PCI resets), linux-pci]
> >
> > On Fri, Aug 13, 2021 at 05:01:32PM +0000, Vikram Sethi wrote:
> > > Hi Dan,
> > >
> > > > -----Original Message-----
> > > > From: Dan Williams <dan.j.williams@intel.com>
> > > >
> > > > On Wed, Aug 11, 2021 at 9:42 AM Chris Browy <cbrowy@avery-design.com>
> > > > wrote:
> > > >
> > > > /sys/bus/pci/devices/$device/reset is a method to trigger PCI
> > > > device reset, but I do not expect that will ever gain CXL specific
> > > > knowledge.
> > > >
> > > CXL reset may need some thought, specially for devices that don't
> > > expose FLR but do expose CXL reset (while former does not affect
> > > CXL.cache/mem, the latter wipes out CXL.cache/mem state in the
> > > device and there is discoverability as to whether or not memory
> > > contents can be cleared as part of CXL reset). We may need a way of
> > > triggering CXL reset from userspace, and if the existing
> > > /sys/bus/pci/devices/$device/reset won't have knowledge of CXL
> > > reset, there still should be a prioritized order in the kernel in
> > > which CXL reset is attempted before more drastic resets like SBR.
> > > IIRC CXL reset can also impact all functions that use CXL.cache/mem,
> > > but not legacy PCIe functions on the device which do not use
> > > CXL.cache/mem (there is discoverability as to which functions are
> > > not impacted by CXL reset).
> > >
> > > Thanks,
> > > Vikram
>
> We can add new reset method and expose it to userspace via new 'reset_method'
> sysfs attribute introduced in this series
> https://lore.kernel.org/linux-pci/20210805162917.3989-1-ameynarkhede03@gmail.com/

It's not clear to me that's a suitable place for CXL reset though. CXL
reset wants to coordinate with the device's participation in a
potential interleave-set across multiple devices. So something like
/sys/bus/cxl/devices/memX/reset might be a better location for
coordinated CXL reset if needed. Again though, the primary use case
for userspace triggered reset is device assignment, and there are
better mechanisms to assign CXL.mem resources to a guest.
