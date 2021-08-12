Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A02AAC4338F
	for <linux-cxl@archiver.kernel.org>; Thu, 12 Aug 2021 01:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CDDB61058
	for <linux-cxl@archiver.kernel.org>; Thu, 12 Aug 2021 01:09:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233112AbhHLBJZ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 11 Aug 2021 21:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbhHLBJZ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 11 Aug 2021 21:09:25 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD0BC061765
        for <linux-cxl@vger.kernel.org>; Wed, 11 Aug 2021 18:09:01 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id hv22-20020a17090ae416b0290178c579e424so7989603pjb.3
        for <linux-cxl@vger.kernel.org>; Wed, 11 Aug 2021 18:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=foz9tsaOXgUUZHUh+e9RBiNX6XJq9QTIW81WXtGFtXQ=;
        b=06o3hYqqEGG5i7IsDRVjfC4BZe65YJywbOrPLMmoBD4BZlUQRub2kJ4bJmo7dyHcnN
         Ae7gsqrVIn1Y2ahu+c22KVg2kVhbtFxfHX3TdOkXnUiFIGljSanxi4mBLVeggAI0qWmn
         pHsPqSTxTXAq9kmUYnNQYXf7dZdaxia+WgheSEqKmQ4qlz6n8EDgwQNUTktW4dbKdZNI
         Zaq/us0uOR9Tr4SmHgpsGB85ixeuJC4uflFmtIlu/Tv5LJn/A6law5s0Qu9HDe6oPsAf
         MVAlvxITRf2id0juxLjuFrk747ybLzGjFHMU7uXm2qCcVDSzIj0n6sL1sqOyr67Osybv
         S/7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=foz9tsaOXgUUZHUh+e9RBiNX6XJq9QTIW81WXtGFtXQ=;
        b=Xp2lOw+pBp9bLbO3xd/BUc+flrHcwswWkEAGPYtOHL5OjNAp97wia40SkMiT9cQNhl
         H59Vu3Q2JztdgeqG475OlYsT3p4ocZKfBwl5OEapIpIwNj2hcmca55ABIsCZPBgizvCa
         2SZgXa0A2DXVTc1V5MyiEE2scBKEoKNW/XfHAtzw/4uxFl6D/J/kWnHveGO7Dkeftvf0
         NTpXdzazFghkbruM98/l0ATV/hZL+cYj8Un/YbhhwGd5EFwvkkOyWPoDtygIGMY8unAn
         1Oyj8kq1XKUj9eRubuVaf14u6bq7VBHCDHXFCUThNyfmhRZs2VmxkwoqXW+T88UvnGno
         UMpg==
X-Gm-Message-State: AOAM5324DOkqnaLsU/VzOC72J7UlqgIIYQRmd3TA0M6n9IpGNEmUxK17
        eMLSZBEbJOHTv1ULGvVlkcsXEKYgqVhuV5FGZQflNA==
X-Google-Smtp-Source: ABdhPJyBoczmV3Ei48fjJ7Lu5yuj3QhBPMdcSAu905u3QlK4ZzL6Gtk8jdPal/JJraNaqSEkUbhEnso/CMRF0H5a2tk=
X-Received: by 2002:a05:6a00:16c6:b029:32d:e190:9dd0 with SMTP id
 l6-20020a056a0016c6b029032de1909dd0mr1545440pfc.70.1628730540743; Wed, 11 Aug
 2021 18:09:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210811194747.44688-1-johnny.li@montage-tech.com>
 <CAPcyv4gecCFVDeV2VwoaNwqycqkHNdKZT4-4KkcqLEbQ9RBsmg@mail.gmail.com> <DA610719-EB4C-40B5-9F53-26760E3BE754@avery-design.com>
In-Reply-To: <DA610719-EB4C-40B5-9F53-26760E3BE754@avery-design.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 11 Aug 2021 18:08:49 -0700
Message-ID: <CAPcyv4gm5sP4q75do27LMHYHHwqx2tK+OSfWmXUUmQaSEtW+Jg@mail.gmail.com>
Subject: Re: CXL Hot and Warm Reset Testing
To:     Chris Browy <cbrowy@avery-design.com>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Aug 11, 2021 at 9:42 AM Chris Browy <cbrowy@avery-design.com> wrote=
:
>
> Hi Dan,
>
> Wondering if you could shed some light on OS orchestrated reset, Sec 9.3 =
of CXL 2.0
> spec.  How is initiated at OS-level?

I have no idea what the spec means by "OS orchestrated reset flow".
Linux PCI core has no idea about special CXL device reset
requirements, it just attempts typical PCI reset methods starting with
FLR, escalating to D3 D0 toggle, and finally attempting secondary bus
reset if any errors were reported on the previous attempts.

> I tried some conventional approach or using sysfs
> remove command on RC and then setting RC bridge control secondary bus res=
et (using
> setpci from Ben's pciutils) and can drive the system into PCIe host reset=
 flow (LTSSM
> Recovery for hot reset) but the CXL host is supposed follow steps in 9.3 =
including to
> send CXL Power Management.Message RESETPREP REQUEST to CXL Device
> before all this.  None of this occurs.
>
> I=E2=80=99m testing on pure QEMU emulation as well the the QEMU co-sim to=
 real DUT.  This
> work also serves the needs for the CXLCV test software.

It's not clear to me how a QEMU behavioral model could send things
like the CXL PM VDM.

> What is the proper procedure to test this from OS or user perspective?  A=
re there sysfs
> entries or other commands that are necessary for CXL compared to PCIe?

/sys/bus/pci/devices/$device/reset is a method to trigger PCI device
reset, but I do not expect that will ever gain CXL specific knowledge.

>
> Is there something missing in QEMU CXL host bridge hardware point of view
> to automatically generate the VDM?

Certainly QEMU is only a behavioral model, and the VDM is a part of a
hardware functional protocol.

> BTW we want to work through all the reset and power mode testing so hot r=
eset is just the start.
>
> For us the QEMU co-sim is a good approach for pre-silicon verification (i=
f we can get the host
> part right).

It sounds promising, but it also sounds out of scope for what the
Linux driver can affect.  As far as I can see, the CXL specification
must assume that OS software treats CXL.io as typical PCIE for the
purposes of issuing resets.
