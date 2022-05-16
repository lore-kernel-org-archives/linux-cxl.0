Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B80C433EF
	for <linux-cxl@archiver.kernel.org>; Mon, 16 May 2022 18:52:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238836AbiEPSww (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 16 May 2022 14:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345205AbiEPSwk (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 16 May 2022 14:52:40 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 922DA3EBBC
        for <linux-cxl@vger.kernel.org>; Mon, 16 May 2022 11:52:39 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id oe17-20020a17090b395100b001df77d29587so187329pjb.2
        for <linux-cxl@vger.kernel.org>; Mon, 16 May 2022 11:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/xDbhnv9K0BABBNi9MgvsAqsUAVdCese6H5nQFFXI5A=;
        b=hrEzp44Ln3ZPjY3pOgtSiX/8hs3FLp1xmRDlox7cDd+LRtbylutaPb5XvwEalioPr7
         lerYFnCtg1jxAMqbqJxpy9sNkVFufANE+MZ1Ztuupb9uwDighK9uz06xU+V18TqlI1XH
         +VuZqqLKJ1xS1oO6N0Upl7ZiMW2XFis2vtD5rqFssYbootLSzBBlpt258EJMqfI+JS5b
         L2agaGHOA5ZhpqHBS14wPQSbFGftk04FNPbM4fUm+Nq7WyWXM//F0SfV46nb4dmpHgq7
         ByKRdcD4+7jlqwcU7U0gQanyuw/RbmlWNE9hL3v7GuyiFeFWCdsXyhfSBzKr/xlEq3RX
         d7hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/xDbhnv9K0BABBNi9MgvsAqsUAVdCese6H5nQFFXI5A=;
        b=gde9leSSt5cRU+wfpsj0YlNTXuStw07AhvVGUCup6biWfNN9HoS7L89YHNo46oSWUZ
         8vQM6RV18fwlqS3TZ5iC3HU6e8IB2Ufde0a9b11HMNz4ehwD893Yyr0UK+KEwly2SNij
         gTxIOMHR9qqQ/hnuAkNrd/oJUi6HqrVV437MJ+qud/I3O22yjscOBmm1cGES5Hh9n2jO
         FBNTWjw2HOGHALeaLRLbw9uKj7sT8boC6k2fkBwfoWCeLHZjOgHRtuNffgvFj5qcQ2i+
         ytAMDPXn/2PygboQDUQFcZyywyRgR3VVUARrjCzJLqhEElcM5Iy3l/TAcZBgGKPpaIvo
         8nYQ==
X-Gm-Message-State: AOAM530Hno4k77Ef3ps49skpzp039CMm5+u8oIfULgtUevplHZElCuts
        Vq09UtL6eDbC6+4WSbizlpulSzYESvM/VTjXRA6+yw==
X-Google-Smtp-Source: ABdhPJyPTcV2YUYWmfW7H4ESSx5evGBy9obaqEgcVmJYZEcu1fb29DpoblnDBXQXtrjn6jb3kq/62GJJ6fX68JRq5MI=
X-Received: by 2002:a17:902:7296:b0:14b:4bc6:e81 with SMTP id
 d22-20020a170902729600b0014b4bc60e81mr18570937pll.132.1652727159095; Mon, 16
 May 2022 11:52:39 -0700 (PDT)
MIME-Version: 1.0
References: <165237925642.3832067.15995008431029494571.stgit@dwillia2-desk3.amr.corp.intel.com>
 <165237933127.3832067.12500546479146655886.stgit@dwillia2-desk3.amr.corp.intel.com>
 <MN2PR11MB3645A7AC910531B92FF2260088CF9@MN2PR11MB3645.namprd11.prod.outlook.com>
In-Reply-To: <MN2PR11MB3645A7AC910531B92FF2260088CF9@MN2PR11MB3645.namprd11.prod.outlook.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 16 May 2022 11:52:28 -0700
Message-ID: <CAPcyv4jN=auUqDz4uA-Oy6CwkvyYPX_F5tB_0wzZK3LP=fBmYQ@mail.gmail.com>
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

On Mon, May 16, 2022 at 11:41 AM <Ariel.Sibley@microchip.com> wrote:
>
> > Previously, the cxl_mem driver was relying on platform-firmware to set
> > "mem_enable". That is an invalid assumption as there is no requirement
> > that platform-firmware sets the bit before the driver sees a device,
> > especially in hot-plug scenarios. Additionally, ACPI-platforms that
> > support CXL 2.0 devices also support the ACPI CEDT (CXL Early Discovery
> > Table). That table outlines the platform permissible address ranges for
> > CXL operation. So, there is a need for the driver to set "mem_enable",
> > and there is information available to determine the validity of the CXL
> > DVSEC Ranges. Note that the DVSEC Ranges can not be shut off completely=
.
> > They always decode at least 256MB if "mem_enable" is set and the HDM
> > Decoder capability is disabled.
>
> Regarding "can not be shut off completely", CXL 2.0 Section 8.1.3.8.4
> has this statement:
> ---
> A CXL.mem capable device that does not implement CXL HDM Decoder
> Capability registers directs host accesses to an address A within its
> local HDM memory if the following two equations are satisfied -
> Memory_Base[63:28] <=3D (A >> 28) < Memory_Base[63:28]+Memory_Size[63:28]
> Memory_Active AND Mem_Enable=3D1
> ---
>
> Per the above, if a device advertises Memory_Size =3D 0, then the first
> equation (second part) can never be true. So, a device advertising
> Memory_Size =3D 0 will effectively shut off this range, even if
> Mem_Enable =3D 1 and the HDM Decoder capability is disabled.

Hmm, so now I am confused as to why the spec goes on to say:

"If the address A is not backed by real memory (e.g. a device with
less than 256 MB of
memory), a device that does not implement CXL HDM Decoder Capability regist=
ers
must handle those accesses gracefully i.e. return all 1=E2=80=99s on reads =
and
drop writes."

This is what led me to conclude that even though Memory_Size is 0, the
device is still actively decoding [0, 256MB).
