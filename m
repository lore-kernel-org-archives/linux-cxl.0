Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF7EC433F5
	for <linux-cxl@archiver.kernel.org>; Wed, 18 May 2022 02:44:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234313AbiERCoi (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 17 May 2022 22:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232506AbiERCoh (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 17 May 2022 22:44:37 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F6B2D1E9
        for <linux-cxl@vger.kernel.org>; Tue, 17 May 2022 19:44:36 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id ds11so701864pjb.0
        for <linux-cxl@vger.kernel.org>; Tue, 17 May 2022 19:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X2FJaCePAUevv1eWu/h3WRNcd5dB7WOBTFqz7r/xs6w=;
        b=YI1P0vu3AafCKN84sZ0nuH6gBs5wH2oEPI+oPtPtQ35PSU9WsPx8/gS4uwoqDuNnEL
         MeNeRXLE90YvClr5xAnZkNPwnoViTojzatYpz8L4xmjvr3RHtxEY+rkDEU5LxcnkvNpP
         tnOyIymaDw9nxvvSXopYtINSm02HP+sg0+YyQNnkZhXRX9o7xnWQNcUayskqOvKeFijW
         LY12TNXF8bSpFeHV07hf/BGqC71JnKUnAbfU+rpdafcrohuWzSPEOIeU33Oc5rmxDg4G
         nbISWzgoQ+VdBRuR+9DY3HepOizc0iOCzSBVC6PkHHggcsUbb/GdCsvTtnvdxNk7m2Sb
         ugUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X2FJaCePAUevv1eWu/h3WRNcd5dB7WOBTFqz7r/xs6w=;
        b=DGHlC4m+DkNzkQ9DDAtMhdACJQ9WOFh+TysTmbnJaEDXV0cRUW5kCijE27/1bLkfF+
         MfPHVFBrQ9Ua+7uxwxfqqFQ4fxC6S+5HbERfvl7/DpTP8/6a+koz4N2zbBfKBaXAbI+w
         PVAAnUnVGR90qEfuFFYOv5rCLJ5VDBiUwj3GGOvk5ENTY3pmROFMC3hUtAXvv0wRr2bB
         wHPfllrUqSvSRR5h+29nQZTyDEgkdarUgrPjH1RxIAQqd/IqoyR0x94icoTLY1U0Ne4y
         mF4/3b28Sj8Xh0GScuwsbai5tsPZLOEOwuncRBEo2mEcCZ/Gnlbo3tXyueE5PGu3V6HS
         IO3g==
X-Gm-Message-State: AOAM5312TG/9Bt0pEbT7iWtPVU3fgvZSirJ9qq/qojoLNQr4oTQo1Nsl
        2BSu++zzR7nOb04P47MP5Y5nAm9afyueeavVj5dEXg==
X-Google-Smtp-Source: ABdhPJzUzKlZD8z6mv9yfE0LHGdrTbQUX+6tbmuaAUEJe1vITIEV8/ImPpTzqDEUJUBnSnuoe8pKEqYAMYPj4GmqUCc=
X-Received: by 2002:a17:902:7296:b0:14b:4bc6:e81 with SMTP id
 d22-20020a170902729600b0014b4bc60e81mr24925996pll.132.1652841876148; Tue, 17
 May 2022 19:44:36 -0700 (PDT)
MIME-Version: 1.0
References: <165237933127.3832067.12500546479146655886.stgit@dwillia2-desk3.amr.corp.intel.com>
 <165283418817.1033989.11273676872054815459.stgit@dwillia2-xfh> <MN2PR11MB3645021EB1CC6D28206D75AD88D19@MN2PR11MB3645.namprd11.prod.outlook.com>
In-Reply-To: <MN2PR11MB3645021EB1CC6D28206D75AD88D19@MN2PR11MB3645.namprd11.prod.outlook.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 17 May 2022 19:44:28 -0700
Message-ID: <CAPcyv4jVAMsbUfN3D_5DnPKKP4FdU1V50XL1ZgZpdff7-c5tQQ@mail.gmail.com>
Subject: Re: [PATCH v2 14/14] cxl/port: Enable HDM Capability after validating
 DVSEC Ranges
To:     Ariel.Sibley@microchip.com
Cc:     linux-cxl@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Weiny, Ira" <ira.weiny@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, May 17, 2022 at 7:08 PM <Ariel.Sibley@microchip.com> wrote:
>
> > Previously, the cxl_mem driver was relying on platform-firmware to set
> > "mem_enable". That is an invalid assumption as there is no requirement
> > that platform-firmware sets the bit before the driver sees a device,
> > especially in hot-plug scenarios. Additionally, ACPI-platforms that
> > support CXL 2.0 devices also support the ACPI CEDT (CXL Early Discovery
> > Table). That table outlines the platform permissible address ranges for
> > CXL operation. So, there is a need for the driver to set "mem_enable",
> > and there is information available to determine the validity of the CXL
> > DVSEC Ranges. While DVSEC Ranges are expected to be at least
> > 256M in size, the specification (CXL 2.0 Section 8.1.3.8.4 DVSEC CXL
> > Range 1 Base Low) allows for the possibilty of devices smaller than
> > 256M. So the range [0, 256M) is considered active even if Memory_size
> > is 0.
>
> Regarding "So the range [0, 256M) is considered active even if
> Memory_size is 0."
>
> Since Memory_Base is included in address A, this portion of the equation
> from CXL 2.0 Section 8.1.3.8.4 mandates that for host access to address A
> to be directed to local HDM memory, Memory_Size[63:28] must be > 0:
>
> (A >> 28) < Memory_Base[63:28] + Memory_Size[63:28]
>
> This means if a device advertises Memory_Size = 0, no host access will
> result in access to the HDM memory.
>
> I would also note this text from CXL 2.0 Section 8.1.3.8:
> "A CXL.mem capable device is permitted to report zero memory size."
>
> For a device with a non-zero capacity less than 256M to satisfy the
> equation, it would need to advertise a Memory_Size of at least 256M.

I think we need an errata to delete the "(e.g. a device with less than
256 MB of memory)" mention. I otherwise do not see how such a device
can exist if Memory_size must be >= 256M.
