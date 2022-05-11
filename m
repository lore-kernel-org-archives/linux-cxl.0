Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30DB1C433EF
	for <linux-cxl@archiver.kernel.org>; Wed, 11 May 2022 19:43:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243274AbiEKTnv (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 11 May 2022 15:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238550AbiEKTnr (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 11 May 2022 15:43:47 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2241C06F4
        for <linux-cxl@vger.kernel.org>; Wed, 11 May 2022 12:43:45 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id x52so2828137pfu.11
        for <linux-cxl@vger.kernel.org>; Wed, 11 May 2022 12:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r811j6eZntFkEB24jk0IhB718MeA1eoELT7MsSEeU6k=;
        b=CjxjqMXeIBtrewF2G3L87rsF3XDYqBVJ/PaoZuDza2rq6dzXN/GTDxZtIdzII7oFZc
         3rJJ0OSy2WqCtgQbO3bcXCpcAyffm9VuQ3AorcJSvGMiA6YzXJSHS0L1tP6p930tx9HR
         zU7wpif9qHuoAWdpaNVK07aj1lSDDr/pUajfq0d68yzjoWfVXVEyMfbh2QkutKnvxXpl
         44PxmTNgosRIMX6vH3NVSt5xZKGfaLAexXkVTIXk+VglKaQPt/W3FjBA8QX3bIPsbnWf
         az5ZoxAt3Oif+oP9SobIuaZbhvzjdg7rr9mbZXtQMp2f9KairrHMp0QRpt+XywylhXOe
         wN3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r811j6eZntFkEB24jk0IhB718MeA1eoELT7MsSEeU6k=;
        b=fnQD9uXe7hxA/ZAIsOq9YqyruGP7c3/G+2HF3Amrc2fkVOplOlOL8PbPptZusxZzew
         ZCNN/b1HI2a2GDMwFIz3Ycl00GDYES+Lssdw+cAcqTLF4s9kWOmbM6v56XV6p0FPBtFb
         w4ebcWFPYqEwXydAuQGC+i2UVK8V5hZaN/4SUkEKum1MSD1v8hXgQI4mSNtENSz6LxxK
         65SMSYPmE7dtYftyBU9qvkutfPWTIsZ/T0f4RyOMkp/9FvBZiSwolNApPhl0JyFZiQoY
         6VOwJMz1jrtrTTmttaxRSH9dDWftHGeI34DUK2RbzBPe2cx5JX7E8ou0ZhCXo4dokVgo
         Cn6g==
X-Gm-Message-State: AOAM532BZ1IFmQknSmAZHThmuNR8mEhqsRd1DHiZcw43KDGTM2b51E7N
        NWBFSCIgV5IxEftxTuMSGM1fEDBDlK+fTiv7cqUuQA==
X-Google-Smtp-Source: ABdhPJx8P7JiKMTzNVPqJeincz7Gm59t6RnBoIGRvE01/hgTF/6TTjsC1RdVmrgjbp/iZ1las7TflyWS1FiW/DCRm0U=
X-Received: by 2002:a05:6a02:283:b0:342:703e:1434 with SMTP id
 bk3-20020a056a02028300b00342703e1434mr21764235pgb.74.1652298225118; Wed, 11
 May 2022 12:43:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220503153449.4088-1-Jonathan.Cameron@huawei.com>
 <CAPcyv4geBaTkoJ+Gefgq6RaKHtB3NMh5ruZ-1yV_i0UVaw3SWA@mail.gmail.com>
 <20220507101848.GB31314@wunner.de> <20220509104806.00007c61@Huawei.com>
 <20220511191345.GA26623@wunner.de> <20220511191943.GB26623@wunner.de>
In-Reply-To: <20220511191943.GB26623@wunner.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 11 May 2022 12:43:34 -0700
Message-ID: <CAPcyv4hUKjt7QrA__wQ0KowfaxyQuMjHB5V-=rZBm=UbV4OvSg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] DOE usage with pcie/portdrv
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Gavin Hindman <gavin.hindman@intel.com>,
        Linuxarm <linuxarm@huawei.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        linux-cxl@vger.kernel.org, CHUCK_LEVER <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, May 11, 2022 at 12:20 PM Lukas Wunner <lukas@wunner.de> wrote:
>
> On Wed, May 11, 2022 at 09:13:45PM +0200, Lukas Wunner wrote:
> > When an IDE-capable device is runtime suspended to D3hot and later
> > runtime resumed to D0, it may not preserve its internal state.
> > (The No_Soft_Reset bit in the Power Management Control/Status Register
> > tells us whether the device is capable of preserving internal state
> > over a transition to D3hot, see PCIe r6.0, sec. 7.5.2.2.)
> >
> > Likewise, when an IDE-capable device is reset (e.g. due to Downstream
> > Port Containment, AER or a bus reset initiated by user space),
> > internal state is lost and must be reconstructed by pci_restore_state().
> > That state includes the SPDM session or IDE encryption.
>
> Digging a little further, sec. 6.33.8 says that "The No_Soft_Reset bit
> must be Set", so at least IDE will always survive a D3hot transition.
>
> But the reset argument still stands:  That same section says that all
> IDE streams transition to Insecure and all keys are invalidated upon
> reset.

Right, this isn't the only problem with reset vs ongoing CXL operations...

https://lore.kernel.org/linux-cxl/164740402242.3912056.8303625392871313860.stgit@dwillia2-desk3.amr.corp.intel.com/
