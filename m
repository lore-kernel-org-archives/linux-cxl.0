Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3078C433F5
	for <linux-cxl@archiver.kernel.org>; Wed,  2 Mar 2022 12:17:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234033AbiCBMS1 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 2 Mar 2022 07:18:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241686AbiCBMS1 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 2 Mar 2022 07:18:27 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3088F1408C
        for <linux-cxl@vger.kernel.org>; Wed,  2 Mar 2022 04:17:44 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a8so3317901ejc.8
        for <linux-cxl@vger.kernel.org>; Wed, 02 Mar 2022 04:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=XFbsNJ/C8bGOizqltxDMSepVZdclwbG6sb4etyg80Ak=;
        b=dmWAoLHD+jxyQfpkqYN6miTKY4pqgOWbiq7KTwnspmAwpUdK3txyqQPQLiICaz0BYo
         S+eaA9ZaL9Fq7vIOyjjNCisHaTPKa4894VTU0udtmWn3nIBKG+sH8Gw9pOk6QZowvN7N
         /15DxiCbZ8enreVFoheClqwPMHJA4ILHYZbnUNQbvGruHyfYibHIqXkrvE5pkEvGSqn0
         lx4B3Z3Ok1iWahrTsq/+D8sWKaoDRVvH0tE1xSzn8+7V65KsMgf9Degiy5gPtoJM/ldk
         VRyez9e1GEt2UdVMbSTnGaYZ4YiRcvbOljc36iVeMkurD/6W+x+d2t+wpowexEu6+e0Y
         X0KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=XFbsNJ/C8bGOizqltxDMSepVZdclwbG6sb4etyg80Ak=;
        b=crdQX8hqu/YT6iNp0bS7LKGcSrCSqqGjfkLzruhB1VCl7840+JqdKOgIfvB7e0OksT
         CD3FZJaUAk6Fm2BTf/z67ehd+/5ONK6YBWqC9xv4KK1ZeRpqkMqmhJcMocYOY+6V1Fe0
         PveyAYRVHs79DJWgB7AIHeRVZo7WKw0LhFm4j2y3f/89i755ufvTQZ9v4LxihK0XGPrB
         c5oAXJH2xs96e+0zBIC4WcI86lzAI7XptaqJ5l13+wyUOStHttJmM/2FxFrkdbQ0zTAb
         k5dr8GhdXK9M225y6A60XMJrzxHDsETWIuqDZ1GqoaFpivAhAkwe/g2wzGtRAqTxgml4
         AvwQ==
X-Gm-Message-State: AOAM5315Z6Ijx69eg2tPEOhmT5guub6g29p33us0nIitB22y2yTpYXt/
        MY5O1Q0fG6A/pgqciK2O1ST9HQ==
X-Google-Smtp-Source: ABdhPJxcb3KLiVPqrIY+ap+FGTLMif1vYEWIVSVtnBlP44+TC5zacuoa8DO8MJe7t52mI7A8VBCMMw==
X-Received: by 2002:a17:906:1c57:b0:69f:2625:3f67 with SMTP id l23-20020a1709061c5700b0069f26253f67mr21784165ejg.632.1646223462683;
        Wed, 02 Mar 2022 04:17:42 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
        by smtp.gmail.com with ESMTPSA id q9-20020a170906770900b006d20acf7e2bsm6257729ejm.200.2022.03.02.04.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 04:17:41 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
        by zen.linaroharston (Postfix) with ESMTP id E7F9B1FFB7;
        Wed,  2 Mar 2022 12:17:40 +0000 (GMT)
References: <20220211120747.3074-1-Jonathan.Cameron@huawei.com>
 <20220211120747.3074-27-Jonathan.Cameron@huawei.com>
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
Subject: Re: [PATCH v6 26/43] hw/cxl/component: Add utils for interleave
 parameter encoding/decoding
Date:   Wed, 02 Mar 2022 12:17:35 +0000
In-reply-to: <20220211120747.3074-27-Jonathan.Cameron@huawei.com>
Message-ID: <87fso0k0pn.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:

> From: Jonathan Cameron <jonathan.cameron@huawei.com>
>
> Both registers and the CFMWS entries in CDAT use simple encodings
> for the number of interleave ways and the interleave granularity.
> Introduce simple conversion functions to/from the unencoded
> number / size.  So far the iw decode has not been needed so is
> it not implemented.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
