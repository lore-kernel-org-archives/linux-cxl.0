Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E91C433EF
	for <linux-cxl@archiver.kernel.org>; Wed,  2 Mar 2022 12:14:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241707AbiCBMP3 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 2 Mar 2022 07:15:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237017AbiCBMP2 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 2 Mar 2022 07:15:28 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD11457A4
        for <linux-cxl@vger.kernel.org>; Wed,  2 Mar 2022 04:14:43 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id x5so1958199edd.11
        for <linux-cxl@vger.kernel.org>; Wed, 02 Mar 2022 04:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=NV6NA/Nwe48ecOcCM9J4f7Mq7Gweo54m6HO2YMX84EI=;
        b=q31j2+aRkgwG9MJ6B1vhEGHABIOnU7MXqMHaHAxULrzm5wlog/VshiVPVW+4lTkwzJ
         0ZQqNBmNCHPnqBmm0UeBH4cXZJylcXC0wHG05k6KsDoZZZBJQ4r2VFDQ+pm75vpZf2SV
         Sak4wHu4fzyLq9WnEIvbdt8rh16hHBMhHDMzaZKDzpkDnbC4PzebNLiowlYq8YJ7m1P5
         lDUrCsT+6v/uRrLXPGXjPeTkpO1+dUf/02N836OUYT8Cdh31B/vP01yS4oQsqgNdgFFU
         hoZsbKPxQ3uUEGWbm64mPjhGVT1no1VEKE7wXVhqpkMoFEyddZ2MYs5CULNBXSiZ+b8Z
         SzpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=NV6NA/Nwe48ecOcCM9J4f7Mq7Gweo54m6HO2YMX84EI=;
        b=oLJBfDiiF/CHXMANDe2YyjST6gDPf8sZskq9U4TbO6zKOlP5J3BFvB62qsCD2e+pHE
         bvAb8/VPKdphtweYZ8kYlqpa+ECZjJPdU5Mw2/TkBclp/G+ja8tqCwI0LyQEW4gMfeWV
         YfH+JdziVlWQ+QjfUrp68NlXJptVvmxyYAKyE9AUew+Ixt/hR0DnApZYW3cQ4WcVI1W9
         2XJKXMPjN0xSfhekFMqoFhYureWfnmGZdnb73H1F1V7FMeYO/d2z+PhjeLlGVVisiY1C
         bF5AZTZJw0OE7nlCgg1WL++zLizqQYEuoziaJVjRHNYCEcoPgyqZK/q87VMcbLQXvFB+
         yfmA==
X-Gm-Message-State: AOAM530ldsfH/p+sEqXsGRYIbZZ0i5SEUO6sUeewN892KZSBNU/qGtPF
        7I0i/a7vFcknA3ahZg4jAPD8cw==
X-Google-Smtp-Source: ABdhPJyEC4fp7pQ0GFEdG7j/1PsqJDZz8Hc/EXvtMksf39pzgpjXIv2Wb9mHDVK8qAgaGvSHp1rb6w==
X-Received: by 2002:a05:6402:5304:b0:413:8a0c:c54a with SMTP id eo4-20020a056402530400b004138a0cc54amr21032819edb.172.1646223278902;
        Wed, 02 Mar 2022 04:14:38 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
        by smtp.gmail.com with ESMTPSA id my16-20020a1709065a5000b006d6e1023b7bsm1856260ejc.8.2022.03.02.04.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 04:14:37 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
        by zen.linaroharston (Postfix) with ESMTP id D65641FFB7;
        Wed,  2 Mar 2022 12:14:36 +0000 (GMT)
References: <20220211120747.3074-1-Jonathan.Cameron@huawei.com>
 <20220211120747.3074-25-Jonathan.Cameron@huawei.com>
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
Subject: Re: [PATCH v6 24/43] acpi/cxl: Add _OSC implementation (9.14.2)
Date:   Wed, 02 Mar 2022 12:14:15 +0000
In-reply-to: <20220211120747.3074-25-Jonathan.Cameron@huawei.com>
Message-ID: <87o82ok0ur.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:

> From: Ben Widawsky <ben.widawsky@intel.com>
>
> CXL 2.0 specification adds 2 new dwords to the existing _OSC definition
> from PCIe. The new dwords are accessed with a new uuid. This
> implementation supports what is in the specification.
>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

From my limited understanding of the ACPI AML DSL we use:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
