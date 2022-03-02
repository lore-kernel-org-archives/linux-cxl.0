Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C57F8C433F5
	for <linux-cxl@archiver.kernel.org>; Wed,  2 Mar 2022 10:21:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236376AbiCBKWS (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 2 Mar 2022 05:22:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbiCBKWS (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 2 Mar 2022 05:22:18 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB6290CE5
        for <linux-cxl@vger.kernel.org>; Wed,  2 Mar 2022 02:21:34 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id w3so1544044edu.8
        for <linux-cxl@vger.kernel.org>; Wed, 02 Mar 2022 02:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=/Lv0QiGiMPXUp9tW+ey9C8YoyPBhTcyAOPxIDFYGmLc=;
        b=bpuIj0g9nNVopoEw9zjYo2yi0w4IuNGMA4rcNxAbM9o2pJXD+xjNn6HzT+c78qbQx+
         dhxwhLp9oz5+DXEFWTen1iVt7N2wcSYdcgr7lnTgQ6ROGdTlCf4GAbLB8fvD571px3EU
         1sjot/B++i35UkBwlBfW+WSgkISPp727wMJdEfl3kLK38hUtScHjiiwyaADCeHeafAkT
         2TH89OQzJGW0yM4cfONxxNrg/3RGeILW6fJwbyy1Jg1ifdoj6lieRDPDMR/A7tfJeT9L
         UQeA6C/+j2j1Pvl55HFbKLgxtAI0pw0F/Sgk0ZukdQGTgN40r2GOGvAY6ALAmznyBM3y
         KJwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=/Lv0QiGiMPXUp9tW+ey9C8YoyPBhTcyAOPxIDFYGmLc=;
        b=QfGy0AWTNDuvAhaOaBzcE+yhHqA27wuHMI8Zca/9ZCQUMuoatyekpqc5hwWAGC3n2Q
         rRLC5Xkzu34okzGd84rwi9sYtqmUUv8fxa8FpHpQ19eqH/RSYs/KuVszRxJPQTTI1CVW
         BLXj/Qrhhe9kqLpPpzJ62EEuLz0FihVyy1UAaaC8tARHe7o39eQnx0tCXJg00piNAdQg
         NJczWVZeqIfqwRBD23ABfa3X+Z0A42SH3UUMVsK9w+uzuOZSCpmLA7oNITSorK05oh2K
         VVrVqZAF9gaD+6SYi/WNkk97q06zdowbxBlizgSu9XlS39+qG8nTRA+tsY/W1CEnCm6E
         kIsg==
X-Gm-Message-State: AOAM532Z9ROrFgio84iltyLOMjDvuxJbWfGM3tad2Tc6K/GjNasdKfcN
        VmcL8sdX35JOX11lKz1oydwwWw==
X-Google-Smtp-Source: ABdhPJx1cHpdl6yo5lQMzlsTz2tuYX4VNlAWau8oWy5J3vROkRy9ofdDujiNxl/7XtO4bssWW2DwUQ==
X-Received: by 2002:a50:f1c9:0:b0:415:a0f6:147d with SMTP id y9-20020a50f1c9000000b00415a0f6147dmr4589046edl.247.1646216493351;
        Wed, 02 Mar 2022 02:21:33 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
        by smtp.gmail.com with ESMTPSA id r23-20020aa7da17000000b00415a1431488sm1142585eds.4.2022.03.02.02.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 02:21:32 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
        by zen.linaroharston (Postfix) with ESMTP id 7F4A91FFB7;
        Wed,  2 Mar 2022 10:21:31 +0000 (GMT)
References: <20220211120747.3074-1-Jonathan.Cameron@huawei.com>
 <20220211120747.3074-24-Jonathan.Cameron@huawei.com>
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
Subject: Re: [PATCH v6 23/43] hw/cxl/component: Implement host bridge MMIO
 (8.2.5, table 142)
Date:   Wed, 02 Mar 2022 10:20:27 +0000
In-reply-to: <20220211120747.3074-24-Jonathan.Cameron@huawei.com>
Message-ID: <87sfs0k638.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:

> From: Ben Widawsky <ben.widawsky@intel.com>
>
> CXL host bridges themselves may have MMIO. Since host bridges don't have
> a BAR they are treated as special for MMIO.  This patch includes
> i386/pc support.
> Also hook up the device reset now that we have have the MMIO
> space in which the results are visible.
>
> Note that we duplicate the PCI express case for the aml_build but
> the implementations will diverge when the CXL specific _OSC is
> introduced.
>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Looks good to me although I'll defer to the i386 maintainers if they
think otherwise.

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
