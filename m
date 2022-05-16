Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5FECC433EF
	for <linux-cxl@archiver.kernel.org>; Mon, 16 May 2022 20:14:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245642AbiEPUOl (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 16 May 2022 16:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347963AbiEPUN4 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 16 May 2022 16:13:56 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF8740A0C
        for <linux-cxl@vger.kernel.org>; Mon, 16 May 2022 13:07:28 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id i17so15463920pla.10
        for <linux-cxl@vger.kernel.org>; Mon, 16 May 2022 13:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eREYd70fqXUeLLFjQK2DJcAntqg7RDoYgH/tTf4Wie4=;
        b=OixHNBwh/PyHrSII2ZDA/hIVXdG/yB0bOt23g0Ve1B1XhzIlJD3Y8uudDi4zgt5Cjo
         l7Y1gZ0TeuWhzwPQA9mmJtkGAiakShZGdaRHh9TJB9TWULVu53F0Co9tOjyTZrS/1UJE
         rM3y6o2D0nbKj68cPTIsZlt9/GrdTdvbKU22DxhrGvZbEhDap22N3efBWT575MpuQXLr
         vuDwE1GZlvV5pJ7q+6N5zGDiTN3RJ+LqvB4r2PqD3FZWyDOdFDv1jDsPmO8o89cGrwYU
         82t0nZ7OxJUD7h5h7X07OpkCsAiAHBAa9VP+KQqd4NPiRrrICMhGfFw8uSoMynYps0wz
         YT0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eREYd70fqXUeLLFjQK2DJcAntqg7RDoYgH/tTf4Wie4=;
        b=dOQ9RAlXsvhyRCyQwlWS5WiFs2XuQAGysPU9dlZYI9AA6m2pbXToxCZaR1mSsAcsK4
         h4Dez1uEt+9p5q8hvSXR3qmeNCPf58zRjfndYGMUJvf5+gyza8eI1PGQZzqcxlE3mL7t
         jZOckNTGEkr+4J3Z7szSNkwtEggxaeG1JxZhF8Ko4hvEd3MKyJgJ7EOv5RiiQcIxw4QS
         HiwkjYDWUcS88bEvlTQPKV99pMR6WvM820aDwwH2GLIl2NvsEvwvA155NekPHsVXWVnV
         F74MJTxcbBSTy+niEHgC2WgW8ni7Cgp/+f6IM+cYjKvgrQ379lyCa/CPSlaB8HJHB6Hd
         pSOg==
X-Gm-Message-State: AOAM533xRkBF54RLfxhB1U7o/8CW5dbp3zJpCApi1J3eXaKnyGQrn0k0
        otWdsR6Ius1wk/xiXLKIM34qHR2oW83nYTNfPAiO9w==
X-Google-Smtp-Source: ABdhPJxGHWBM2Rrw9tLp+j7/4HqlY4t2v2lePv91dK8Zjn9mrBt7OMIMLC5QiVUbB3UM35yYburWrppx9ntg8JURvsU=
X-Received: by 2002:a17:902:7296:b0:14b:4bc6:e81 with SMTP id
 d22-20020a170902729600b0014b4bc60e81mr18831564pll.132.1652731647670; Mon, 16
 May 2022 13:07:27 -0700 (PDT)
MIME-Version: 1.0
References: <165237925642.3832067.15995008431029494571.stgit@dwillia2-desk3.amr.corp.intel.com>
 <165237933127.3832067.12500546479146655886.stgit@dwillia2-desk3.amr.corp.intel.com>
 <MN2PR11MB3645A7AC910531B92FF2260088CF9@MN2PR11MB3645.namprd11.prod.outlook.com>
 <CAPcyv4jN=auUqDz4uA-Oy6CwkvyYPX_F5tB_0wzZK3LP=fBmYQ@mail.gmail.com> <MN2PR11MB3645C1EE83DC6B05C06A218388CF9@MN2PR11MB3645.namprd11.prod.outlook.com>
In-Reply-To: <MN2PR11MB3645C1EE83DC6B05C06A218388CF9@MN2PR11MB3645.namprd11.prod.outlook.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 16 May 2022 13:07:16 -0700
Message-ID: <CAPcyv4iVim=o1z+WFGNe+HuUWw=dPpAR_AsS8FsRzGKW39CVbQ@mail.gmail.com>
Subject: Re: [PATCH 14/14] cxl/port: Enable HDM Capability after validating
 DVSEC Ranges
To:     Ariel.Sibley@microchip.com
Cc:     linux-cxl@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, May 16, 2022 at 12:32 PM <Ariel.Sibley@microchip.com> wrote:
>
> > > > Previously, the cxl_mem driver was relying on platform-firmware to =
set
> > > > "mem_enable". That is an invalid assumption as there is no requirem=
ent
> > > > that platform-firmware sets the bit before the driver sees a device=
,
> > > > especially in hot-plug scenarios. Additionally, ACPI-platforms that
> > > > support CXL 2.0 devices also support the ACPI CEDT (CXL Early Disco=
very
> > > > Table). That table outlines the platform permissible address ranges=
 for
> > > > CXL operation. So, there is a need for the driver to set "mem_enabl=
e",
> > > > and there is information available to determine the validity of the=
 CXL
> > > > DVSEC Ranges. Note that the DVSEC Ranges can not be shut off comple=
tely.
> > > > They always decode at least 256MB if "mem_enable" is set and the HD=
M
> > > > Decoder capability is disabled.
> > >
> > > Regarding "can not be shut off completely", CXL 2.0 Section 8.1.3.8.4
> > > has this statement:
> > > ---
> > > A CXL.mem capable device that does not implement CXL HDM Decoder
> > > Capability registers directs host accesses to an address A within its
> > > local HDM memory if the following two equations are satisfied -
> > > Memory_Base[63:28] <=3D (A >> 28) < Memory_Base[63:28]+Memory_Size[63=
:28]
> > > Memory_Active AND Mem_Enable=3D1
> > > ---
> > >
> > > Per the above, if a device advertises Memory_Size =3D 0, then the fir=
st
> > > equation (second part) can never be true. So, a device advertising
> > > Memory_Size =3D 0 will effectively shut off this range, even if
> > > Mem_Enable =3D 1 and the HDM Decoder capability is disabled.
> >
> > Hmm, so now I am confused as to why the spec goes on to say:
> >
> > "If the address A is not backed by real memory (e.g. a device with
> > less than 256 MB of
> > memory), a device that does not implement CXL HDM Decoder Capability re=
gisters
> > must handle those accesses gracefully i.e. return all 1=E2=80=99s on re=
ads and
> > drop writes."
> >
> > This is what led me to conclude that even though Memory_Size is 0, the
> > device is still actively decoding [0, 256MB).
>
> My interpretation of that statement is that such a device would need to
> advertise a capacity of 256M, and behave per the text for the portion of
> the 256M range not backed by physical memory. Such a device would be
> problematic for the host to handle, as I'm not sure how the host would be
> able to determine the portion of the range that is usable. As such, I
> don't think building such a device would be practical.

Right, I don't expect it to happen, but it's easy enough for the
kernel to exclude the possibility.

It just so happens that one of the early revs of the QEMU patch set
introduced this case, so it may not be feasible for hardware, but it's
already happened for emulated devices.

> There are several other locations in the CXL 2.0 spec that indicate that
> devices must manage capacity in units of 256M. E.g. Table 175. Identify
> Memory Device Output Payload.

Yes, for this patch it is just trying to find a reasonable heuristic
for when "Mem_enable =3D 1" and "HDM Decoder Capabilty Enable =3D 0" to
determine that the kernel can go ahead and set "HDM Decoder Capability
Enable =3D 1"
