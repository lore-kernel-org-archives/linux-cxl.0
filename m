Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A38FFC433F5
	for <linux-cxl@archiver.kernel.org>; Tue, 28 Sep 2021 14:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AB926108E
	for <linux-cxl@archiver.kernel.org>; Tue, 28 Sep 2021 14:38:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241206AbhI1Ojv (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 28 Sep 2021 10:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241152AbhI1Oju (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 28 Sep 2021 10:39:50 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9313CC061745
        for <linux-cxl@vger.kernel.org>; Tue, 28 Sep 2021 07:38:11 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id q16so2515008oiw.10
        for <linux-cxl@vger.kernel.org>; Tue, 28 Sep 2021 07:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LGm4HTeA31BZubMpoPdBi1gqAR87KKhwYyhwPLV50Xc=;
        b=pK4/7krjjquE59EU+0TI247YRWaA6knQJNe4F7rLad94asfYDS9Uoz2tbX98GYhPvK
         4qH6PzdbEwaexcsUPjwLGHFkfUivnlagajA0L3jaXcyGHOVmUkdCt/OMDS8/pVfvjUEq
         qIOFT86riEF0gVSfOfwHqrl71KaW9U4x3XYSF90IdCWiEWbR5Qga4P3T6wpLXCGeGSpT
         gEZO1o/2pvFqmBwbUfoiiKe8QYTYaFB0B8LMwrMQYNl7caAJ0ot2IGU16QGu6EUdiqar
         iDSzMgl7BDZ864Tl0LnOVNFZbOhxe83+7tuSJRyF3/x1ght5n6tgcx5SKmS7a1CEm5hd
         KV7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LGm4HTeA31BZubMpoPdBi1gqAR87KKhwYyhwPLV50Xc=;
        b=DQRK9johJ5l9hwit4ORCQrejuAba1DTbkuyDRcU6D0PXj2jQFqhQ8RptiBcGUxZYEH
         kt2BNLjbDLMPEJy+euxkj0LQRc4YhCsSKSbkf7WDT1XZ/LdRdPFPLjehpKPr0pMeoAJS
         kE3yb2ey5cQr1RIo9B75jfd8NwbG8b+5jk0DCC0Ok1kjNN7m9dJFbkoOLsetC8Y0fYrR
         g4pMSzxQUYTmbK2d5iTymM0D6pNkZOmsD8iYK05ksAaL4aAh1JBXzSfQHUYkOrb8ofyK
         AHqHwD+tHfclnHFYrMstkGH+9gVKVpLkx5W6/mNvrZiRdWewdIJMxyjZIGhNWXIRZoLj
         jQ7A==
X-Gm-Message-State: AOAM533Ae+0weBNQvFgGVQ8Bef/eZnfTGc2QRZJGbsNNUBls/jmjl9hs
        H8JNijjEmEl3PjBpdvmBmT/IAL/5adLaFvmE1j+Trg==
X-Google-Smtp-Source: ABdhPJzUc6fntGAtZikZSDIg6zrObw8kPGmDK5a9dwNK3dpklk7JeTD6NbitO+0iq0qRTr+Yc8Y0xKIRlG1DBZB16kY=
X-Received: by 2002:a05:6808:14d3:: with SMTP id f19mr3842224oiw.34.1632839890941;
 Tue, 28 Sep 2021 07:38:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210923172647.72738-1-ben.widawsky@intel.com> <20210923172647.72738-3-ben.widawsky@intel.com>
In-Reply-To: <20210923172647.72738-3-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 28 Sep 2021 07:37:58 -0700
Message-ID: <CAPcyv4gyLKpOh4Scbbq8O8_5HByAymigrybek4F_3_+=3cQ9LQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] cxl/pci: Remove dev_dbg for unknown register blocks
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, Andrew Donnellan <ajd@linux.ibm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "David E. Box" <david.e.box@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "open list:DMA MAPPING HELPERS" <iommu@lists.linux-foundation.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Sep 23, 2021 at 10:27 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> While interesting to driver developers, the dev_dbg message doesn't do
> much except clutter up logs. This information should be attainable
> through sysfs, and someday lspci like utilities. This change
> additionally helps reduce the LOC in a subsequent patch to refactor some
> of cxl_pci register mapping.

Looks good to me:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
