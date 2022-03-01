Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69EF0C433F5
	for <linux-cxl@archiver.kernel.org>; Tue,  1 Mar 2022 17:47:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232512AbiCARsM (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 1 Mar 2022 12:48:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbiCARsL (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 1 Mar 2022 12:48:11 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D37E0E2
        for <linux-cxl@vger.kernel.org>; Tue,  1 Mar 2022 09:47:28 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id cm8so23049535edb.3
        for <linux-cxl@vger.kernel.org>; Tue, 01 Mar 2022 09:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=46fkMdfnhldasufV90xDHsl7VVgwtq23xkVkYCN993Y=;
        b=Zcw8gkvqyRpCx7TkAb7ewvbX3ESrUtgZgz1+tqTmW+xfrv5qEHo+dTIACLBazRzkG6
         LktcxuvBgvMZi0TZ74HzsvWWJay97EtiiFgRLFL9bp80cUfVY1uAZGb/+0m0jFsksuje
         90j8REdw5T6TL/AIXOknC2I+//tzpCsKVEo+PLqkICMQV0GfzbP5LoUg371e2jjJU9Iz
         Yf67/Wg4GLhEFpb9tLBN1c8Y1INP0rx3+Mw7EmaGBNXrlnMCN8FgGB4eC+XeItvmMXw6
         oa/AfNwD6Jc7Iegt1QGO4vopaei9rJVDBtZ7PGso32bY9D3lc6WhsVcMIRGBQ+Fdfu6p
         f+kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=46fkMdfnhldasufV90xDHsl7VVgwtq23xkVkYCN993Y=;
        b=vlgD09sNmFeexu4cgQz6P+PyiK+Ksp1Bfl/WVH5KjxoDMjNZzg5DONIEA+WVgCZVRe
         vuOEvxhtUziQbV4p2jJPIK5GvBvvSx421fjoZPkZaZfJ8PbQr3znyJho7DUJSYJg/5YJ
         pvt9Jl4MzDTf45SH5AJzAiL9ORQ4ESMdHUvzQs53+4xxTSZ5XSoo3NrGzJ3r88fVXnj4
         AlORQ0grYuUskWVlSrBAkiMFq3zl0rzpy73tpPhRswAMP0soXrg6hu1rGF+lg7pVbod0
         mTjlV9j15dNZyf2JcJuVKOibzkz4P5VXS7GAyEBMXoqgBqdSU/WD+lHntFmfG+llDl1Y
         xD3A==
X-Gm-Message-State: AOAM531lWXRgAEHxFuMi/xL7ZFEsAAVuF7INv7r8ft2PR1VN7p7P5XiR
        qGbaB+t0mOsF4SHLnZM8FBVy7g==
X-Google-Smtp-Source: ABdhPJzGDqFNhnBcVeqndQdVVn1EIsHMjA0aFlvtBsu5SAJrnUqV36pcueRAofN9M+9pIUz3iChE5g==
X-Received: by 2002:a05:6402:34c5:b0:411:f082:d69 with SMTP id w5-20020a05640234c500b00411f0820d69mr25570682edc.65.1646156847271;
        Tue, 01 Mar 2022 09:47:27 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
        by smtp.gmail.com with ESMTPSA id n25-20020aa7db59000000b00415965e9727sm704812edt.18.2022.03.01.09.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 09:47:26 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
        by zen.linaroharston (Postfix) with ESMTP id B534F1FFB7;
        Tue,  1 Mar 2022 17:47:25 +0000 (GMT)
References: <20220211120747.3074-1-Jonathan.Cameron@huawei.com>
 <20220211120747.3074-15-Jonathan.Cameron@huawei.com>
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
Subject: Re: [PATCH v6 14/43] hw/pxb: Allow creation of a CXL PXB (host bridge)
Date:   Tue, 01 Mar 2022 17:47:20 +0000
In-reply-to: <20220211120747.3074-15-Jonathan.Cameron@huawei.com>
Message-ID: <87tuchlg42.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:

> From: Ben Widawsky <ben.widawsky@intel.com>
>
> This works like adding a typical pxb device, except the name is
> 'pxb-cxl' instead of 'pxb-pcie'. An example command line would be as
> follows:
>   -device pxb-cxl,id=3Dcxl.0,bus=3D"pcie.0",bus_nr=3D1
>
> A CXL PXB is backward compatible with PCIe. What this means in practice
> is that an operating system that is unaware of CXL should still be able
> to enumerate this topology as if it were PCIe.
>
> One can create multiple CXL PXB host bridges, but a host bridge can only
> be connected to the main root bus. Host bridges cannot appear elsewhere
> in the topology.
>
> Note that as of this patch, the ACPI tables needed for the host bridge
> (specifically, an ACPI object in _SB named ACPI0016 and the CEDT) aren't
> created. So while this patch internally creates it, it cannot be
> properly used by an operating system or other system software.
>
> Also necessary is to add an exception to scripts/device-crash-test
> similar to that for exiting pxb as both must created on a PCIexpress
> host bus.
>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> Signed-off-by: Jonathan.Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
