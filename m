Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B31C433EF
	for <linux-cxl@archiver.kernel.org>; Mon, 25 Apr 2022 18:16:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241036AbiDYSTc (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 25 Apr 2022 14:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235475AbiDYSTb (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 25 Apr 2022 14:19:31 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977A63B03B
        for <linux-cxl@vger.kernel.org>; Mon, 25 Apr 2022 11:16:26 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id u6-20020a17090a1f0600b001d86bd69427so104837pja.5
        for <linux-cxl@vger.kernel.org>; Mon, 25 Apr 2022 11:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TaMkW2A7mACkrKsllO0mQMCR7JITRLY7FVQAarVkr7c=;
        b=d+pIGC6L2PfJ7BQV440ocf78Sg6t4uZVuioilhoVYqW6hw22ZESk0kGFoS7XaX2ndp
         c2EIKgrD1hGim5iuZyILISMCW3PpqqLkcUwdlLStH15HalkUh2IbzX/xD2uVtb8PcEQ6
         6g/F8sZXPbmKWCFPTqZIzc0itLebfVGYfFDJFN86BK+WusOD+FHF4CKUvi8N9RM6dj3d
         oKlYbqIJ+3jSLzcSylCMAf3QUmXnm/9Io7qzfPi+e1kPqADu7EcQeL72dLDCxBVxyb3M
         1ldPSCJ5uAkKQlHVsgBM+Mh/nhS9NGzsEE4mDjUfXtcAxWj+ig4NT4EMjPrwislvVjZf
         pWVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TaMkW2A7mACkrKsllO0mQMCR7JITRLY7FVQAarVkr7c=;
        b=znUwx+oSdJE+LjDccMDlwnkmA3RnpWUY+4Ff9fgxcLtxhPTHXaxERw29CiAd3h5Htu
         CZKdVGUs/bsI6Kk1q40JMinkxu8pPHk+gKGB6nSkezT0mUJXeeATdRg8Z1Ao9oGHMKNE
         laJ7apiuPDBs1Xn6dNKwWu9Mz1/YUlMudzlb/Ddz9LIBMbeHTuXa1TPZaJMx/4lGmNX/
         pZQU+HMQp/0TEKZ0IMblbBmtzhOiOTasQdxZphokK+I7urPDgzLv65SYwGnkD5sLP7yp
         O5V/nqlp/n1M273HQ/34SQzwFzMr/NG0pBh7QvK7xVH+MzZU2v4L7Ke3v00gmF2P2qPo
         Ru2A==
X-Gm-Message-State: AOAM532vEFXfRg0l07opoy3eb3ZyA6rLtqYmAfPVSb+qEW50gwmSwQ28
        1PA2E1k+d+4D1j1SHVgxfdaywTvdRVyF2UCxnebEEg==
X-Google-Smtp-Source: ABdhPJyLr1KTbjgdmTOeL1kI0PEbocwFyEuZYOpeRS0uC3PKSSsWg4O+zxEygMZb8up7qKZ/0VDab48ZATdGXXsZqS8=
X-Received: by 2002:a17:902:e885:b0:158:e564:8992 with SMTP id
 w5-20020a170902e88500b00158e5648992mr19389092plg.34.1650910586145; Mon, 25
 Apr 2022 11:16:26 -0700 (PDT)
MIME-Version: 1.0
References: <4f277b84c2ee770f6a2706744b96fb1dfd6184a7.camel@intel.com> <20220425181357.GA1647966@bhelgaas>
In-Reply-To: <20220425181357.GA1647966@bhelgaas>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 25 Apr 2022 11:16:15 -0700
Message-ID: <CAPcyv4j9UOU9RjfRz2-5NpVGWoxbQ=A0AzGnFAd=MVmJNsSBjg@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] PCI/ACPI: add support for CXL _OSC
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Verma, Vishal L" <vishal.l.verma@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "Jonathan.Cameron@Huawei.com" <Jonathan.Cameron@huawei.com>,
        "a.manzanares@samsung.com" <a.manzanares@samsung.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "Moore, Robert" <robert.moore@intel.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Apr 25, 2022 at 11:14 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Fri, Apr 22, 2022 at 10:24:34PM +0000, Verma, Vishal L wrote:
> > On Wed, 2022-04-13 at 01:36 -0600, Vishal Verma wrote:
> > > Changes since v5[1]:
> > > - Collect an reviewed-by tags from Rafael, Adam, and David
> > > - Fix a couple of missed s/CXL/extended/ in acpi_bus.h (Rafael)
> >
> > Rafael, or Bjorn,
> >
> > Dan has offered to take this through cxl.git. Any objections to that -
> > would you prefer it to go through either the PCI or ACPI trees instead?
>
> OK by me if Dan or Rafael takes it.

Thanks Bjorn, and Rafael. It simplifies a few things if it is kept
with the other CXL changes for this merge cycle, so I'll take it
through cxl.git.
