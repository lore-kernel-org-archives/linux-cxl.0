Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 972B2C433EF
	for <linux-cxl@archiver.kernel.org>; Wed,  2 Mar 2022 12:17:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241735AbiCBMRv (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 2 Mar 2022 07:17:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238764AbiCBMRp (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 2 Mar 2022 07:17:45 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 996D9377CD
        for <linux-cxl@vger.kernel.org>; Wed,  2 Mar 2022 04:16:59 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id bg10so3356456ejb.4
        for <linux-cxl@vger.kernel.org>; Wed, 02 Mar 2022 04:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=/84AvN/V83Oq1qZvODm1Fitth6dVROGE3KJULt/rHIU=;
        b=HpEBHuANEXVPI3QwoIH+rLLe9O/rvn9WzHl4I4vxC+rAj9Q2W94G2Gwanldwr3acs3
         2wXJNu0sCAnRw74sjWvqtH8YKF80XYaGLoHLdIJUV0wuKjykMlhwtP/COatoGKZUHwFh
         VRdCI+yqVLQfw138Oyw3txw9xdT9XbyHFgWNYa4qn2Bhd9jJQO4eIObT6nOoMn6aaSkT
         ehC9+yrjWwQ7y21PK7JWPhcirx6qxe5fY4o+WZGj3oSWQ9N1KoVoQBFzIlhLF8L56P3p
         wm25ouCm13LvgVoXRJ5JntvsiPxL1p9UPY4qDe3gkpGeWezjgojkfVN+fv09DEBTIw9a
         P1Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=/84AvN/V83Oq1qZvODm1Fitth6dVROGE3KJULt/rHIU=;
        b=zhLdrwxKhy2CGpVYslBWgJ2K+l0XgP2KZoBGwKn3Qkjubxos9ErrXgnwO5/fEnrKXG
         8TOlxAeGMmYn6IfCZ3gR5pocYXQoc2KtohaHOPKJ1R6iQUUd9WhaoH0m3S3kZfAjhKzr
         kVxQROiJAnqYgcycefT/tcQvnZges8okGYzBm8cLiQ7Br8fCJQIxKUo6VwKYT4IJreXh
         IpRveb6lLL37mc0/ePTH6wFTykgI9p6PxIEG396IVThCpU/08PwkV36KuLEbwHLU+a34
         cgue0aflSrZXB0giTjuTyqSNqh94qsMLJVUrgWvTuKiIv5n1LNp6JVelLxKs+dDkerh7
         zOiA==
X-Gm-Message-State: AOAM533DgOvMlLtHttgia+B25NjZu494wesdbwBlv82GyJoVQECmk4U/
        Qyyw5KCjtEOII0txLn4oJtFgHA==
X-Google-Smtp-Source: ABdhPJzyb8qNK78797w/gXMaIuX6BOJSFa4o0M//VStsYBxdVWN024aMfnRXfLONMHXVf78ZmKwyDQ==
X-Received: by 2002:a17:907:9898:b0:6cd:ed45:1123 with SMTP id ja24-20020a170907989800b006cded451123mr23613605ejc.155.1646223417953;
        Wed, 02 Mar 2022 04:16:57 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
        by smtp.gmail.com with ESMTPSA id f5-20020a1709067f8500b006da68bfdfc7sm399202ejr.12.2022.03.02.04.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 04:16:56 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
        by zen.linaroharston (Postfix) with ESMTP id E9D481FFB7;
        Wed,  2 Mar 2022 12:16:55 +0000 (GMT)
References: <20220211120747.3074-1-Jonathan.Cameron@huawei.com>
 <20220211120747.3074-26-Jonathan.Cameron@huawei.com>
User-agent: mu4e 1.7.9; emacs 28.0.91
From:   Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     qemu-devel@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>, linux-cxl@vger.kernel.org,
        Ben Widawsky <ben.widawsky@intel.com>,
        Peter Maydell <peter.maydell@linaro.org>, linuxarm@huawei.com,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
        Saransh Gupta1 <saransh@ibm.com>,
        Shreyas Shah <shreyas.shah@elastics.cloud>,
        Chris Browy <cbrowy@avery-design.com>,
        Samarth Saxena <samarths@cadence.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v6 25/43] acpi/cxl: Create the CEDT (9.14.1)
Date:   Wed, 02 Mar 2022 12:16:48 +0000
In-reply-to: <20220211120747.3074-26-Jonathan.Cameron@huawei.com>
Message-ID: <87k0dck0qw.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:

> From: Ben Widawsky <ben.widawsky@intel.com>
>
> The CXL Early Discovery Table is defined in the CXL 2.0 specification as
> a way for the OS to get CXL specific information from the system
> firmware.
>
> CXL 2.0 specification adds an _HID, ACPI0016, for CXL capable host
> bridges, with a _CID of PNP0A08 (PCIe host bridge). CXL aware software
> is able to use this initiate the proper _OSC method, and get the _UID
> which is referenced by the CEDT. Therefore the existence of an ACPI0016
> device allows a CXL aware driver perform the necessary actions. For a
> CXL capable OS, this works. For a CXL unaware OS, this works.
>
> CEDT awaremess requires more. The motivation for ACPI0017 is to provide
> the possibility of having a Linux CXL module that can work on a legacy
> Linux kernel. Linux core PCI/ACPI which won't be built as a module,
> will see the _CID of PNP0A08 and bind a driver to it. If we later loaded
> a driver for ACPI0016, Linux won't be able to bind it to the hardware
> because it has already bound the PNP0A08 driver. The ACPI0017 device is
> an opportunity to have an object to bind a driver will be used by a
> Linux driver to walk the CXL topology and do everything that we would
> have preferred to do with ACPI0016.
>
> There is another motivation for an ACPI0017 device which isn't
> implemented here. An operating system needs an attach point for a
> non-volatile region provider that understands cross-hostbridge
> interleaving. Since QEMU emulation doesn't support interleaving yet,
> this is more important on the OS side, for now.
>
> As of CXL 2.0 spec, only 1 sub structure is defined, the CXL Host Bridge
> Structure (CHBS) which is primarily useful for telling the OS exactly
> where the MMIO for the host bridge is.
>
> Link: https://lore.kernel.org/linux-cxl/20210115034911.nkgpzc756d6qmjpl@i=
ntel.com/T/#t
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
