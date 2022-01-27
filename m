Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59169C433F5
	for <linux-cxl@archiver.kernel.org>; Thu, 27 Jan 2022 14:29:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242361AbiA0O3c (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 27 Jan 2022 09:29:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242359AbiA0O3c (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 27 Jan 2022 09:29:32 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2A7C061714
        for <linux-cxl@vger.kernel.org>; Thu, 27 Jan 2022 06:29:31 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id bg19-20020a05600c3c9300b0034565e837b6so3392663wmb.1
        for <linux-cxl@vger.kernel.org>; Thu, 27 Jan 2022 06:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=RicQOisaO04B9GBLBPS0jGWaeVqHqZaQe9mPCjO4FXI=;
        b=Vap2O54BFKTXQ4CV64PilR+EKDbadYgvJk7rtSaw1uQSBDnU1bjEJQrD5bX8pfwMBZ
         aBE6SWyNaTk0bHnJrbAjqYsqj+uAglJsq5E0RWsq3d5JD2HNWfolE8WHWMqR5r35vbPs
         ywDSegDysixIJjstEgKkhv42Sph/xyIlfvpxyBYOS+nl8QVnBwn1YZMTKhvHgThcZCOw
         fFwOwcFpzohyjlhA61fw4yUTYGmcOIu039ewv8i0vG6jFaOKrv3FGfYUp+O+veuMvQwA
         1LChEO2GoiMZThF0zIepI6X/gPfrP1jr3pp+SX1N5g2YxlTCG05TliomILc4UEsGDz2f
         OJ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=RicQOisaO04B9GBLBPS0jGWaeVqHqZaQe9mPCjO4FXI=;
        b=VgUWvPj7DG2D/qTKGBe5AvSjcbp7VNpgMoNyvAfQiSE766GnTjzhia4QYN2MpGqjAv
         vbon1eYERz9owfIIMRXLllJBL86I7HWoCeINXiSIT7WncKBvhtcrcGBB2qkzYuutnmyL
         TIfopQwlvK8Pjmi42K7fGUTVsKExKvG1N6KnZNx5I1To+jOyqYgYXBLewEGZ6yXUVMhx
         1srNa7yP2coO3RVsb9yBLVAh3N84zHs8TtRH1Dr4mCl9nfjxDgY3x7uO6hw1t9f/AqZr
         ZjDLiiWprNMgYMmUmg257pnwKIuOpdzq3G4RzxcshqMSBWbqbf1qKAf0XGR8w3mEwrgf
         v1dg==
X-Gm-Message-State: AOAM5306z4kJxe86O8jCuZDRHTSBAcQVuWTpyNH5Dw4d/wx5j0hgqXHB
        2CS3Wi/JsWjqwmur2gfCXRXOuw==
X-Google-Smtp-Source: ABdhPJxT9o6yEHtZkzPqNS2kWs8gjkwfalClUNDJP5093P+1RycF21QeT0Y101HSOeJhoNum580e8g==
X-Received: by 2002:a05:600c:3d94:: with SMTP id bi20mr12024697wmb.14.1643293770277;
        Thu, 27 Jan 2022 06:29:30 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
        by smtp.gmail.com with ESMTPSA id r12sm2211152wrw.73.2022.01.27.06.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 06:29:29 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
        by zen.linaroharston (Postfix) with ESMTP id 63E191FFB7;
        Thu, 27 Jan 2022 14:29:28 +0000 (GMT)
References: <20220124171705.10432-1-Jonathan.Cameron@huawei.com>
User-agent: mu4e 1.7.6; emacs 28.0.91
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
Subject: Re: [PATCH v4 00/42] CXl 2.0 emulation Support
Date:   Thu, 27 Jan 2022 14:22:52 +0000
In-reply-to: <20220124171705.10432-1-Jonathan.Cameron@huawei.com>
Message-ID: <87sft98d6f.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:

> Previous version was RFC v3: CXL 2.0 Support.
> No longer an RFC as I would consider the vast majority of this
> to be ready for detailed review. There are still questions called
> out in some patches however.

I've been through and added comments through the first half of the
patches. I'll see if I can get to the second half next week however if
you beat me to it with a re-rev I expect some ripples from the requested
changes.

Aside from ensuring the rest of the builds work:

  https://gitlab.com/stsquad/qemu/-/pipelines/456700583/failures
=20=20
it looks pretty good to me. I await the next version ;-)

--=20
Alex Benn=C3=A9e
