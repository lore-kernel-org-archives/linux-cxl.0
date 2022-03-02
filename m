Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E0F6C433EF
	for <linux-cxl@archiver.kernel.org>; Wed,  2 Mar 2022 16:07:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbiCBQIB (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 2 Mar 2022 11:08:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239309AbiCBQIB (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 2 Mar 2022 11:08:01 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D1097B96
        for <linux-cxl@vger.kernel.org>; Wed,  2 Mar 2022 08:07:17 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id dr20so4728079ejc.6
        for <linux-cxl@vger.kernel.org>; Wed, 02 Mar 2022 08:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=3HxVcZFOx1bhvGyTKX1xjCIBgYPPeFXCl5LnaVw2CJA=;
        b=rtU+gRGSj7iM6CkiD+y572VUCmSgfALxJU1+CWbLyu+QZL1roMbTAmbVvLTJgnYeZ1
         K3ZMWB3VMf2CFaFh/2m58KiUKZxjhcUZHdEX1jQyf8TxWj6zpz9YkZaY4IpYeeVu/R8l
         4V93UDM9u2M8riU5equWta9tkEe+Q2Lxev3e2wKxVPEXxd5228bsribiH68UTHqyAN6F
         S2Juvt47jv8YznnOvtlwOi5WZKKSXGznM128uZUmi7tjc0abJ3BcOe+F3T244YhA57Aw
         E/IJIQE3iAtdS9JPSyLMaEWhD9zmgJHQlO+aDfb70a7HI+BsuMVOIVe40X2YRkT3fxFQ
         MMcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=3HxVcZFOx1bhvGyTKX1xjCIBgYPPeFXCl5LnaVw2CJA=;
        b=nCzpcdlIqHEhxofSWqM2RXosZcVYzOkw3FPZr/Vp/qCfHzLcsvnNjeI3Wdrlx0CC5F
         osvZL7X4S/jadcEiuQEHWzFl0Ck6YVo/1LJfDdGVgp16hR1pmkGqiZFEpClfoL06i3Ao
         4O+ETJHiJNEbbGDkxugDHclwazDS8RHgx0smd2/cDdAFNHXiBgv4Y/5i0dAsoMyv13qs
         KsfCYcM3B3iP6iXe4XAyhC5rL9ibyo7R2vYN3PkeXCS8COpOEmF6EreOivmg5u0Svhch
         kJV/UJNX1D7mV3XUOyV+X3WmoXRXOrVtoPkX8nC4bOuWxax3swjNYAsgoFwG7XoAmE+R
         6/CA==
X-Gm-Message-State: AOAM533Uq7sf5i1TbpX6i+PBG5HE9/vrCZKvsn0FXjYODdsKVGzcySkb
        EuOAhsfzY/7u3R5aXs9bKI6erqJarrX+og==
X-Google-Smtp-Source: ABdhPJwWxK4cqoNeBoaLHgzQNiQC5hNVfDOBRqDGDx6L5n65VP48fvkszAktjlvuftrjUBh1/ggaWw==
X-Received: by 2002:a17:906:3a84:b0:6cd:e829:ca37 with SMTP id y4-20020a1709063a8400b006cde829ca37mr24151790ejd.83.1646237235749;
        Wed, 02 Mar 2022 08:07:15 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
        by smtp.gmail.com with ESMTPSA id zb5-20020a17090687c500b006ce2a98f715sm6393575ejb.117.2022.03.02.08.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 08:07:14 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
        by zen.linaroharston (Postfix) with ESMTP id DBE301FFB7;
        Wed,  2 Mar 2022 16:07:12 +0000 (GMT)
References: <20220211120747.3074-1-Jonathan.Cameron@huawei.com>
 <20220211120747.3074-31-Jonathan.Cameron@huawei.com>
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
Subject: Re: [PATCH v6 30/43] pci/pcie_port: Add pci_find_port_by_pn()
Date:   Wed, 02 Mar 2022 16:07:06 +0000
In-reply-to: <20220211120747.3074-31-Jonathan.Cameron@huawei.com>
Message-ID: <87y21sibin.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:

> From: Jonathan Cameron <jonathan.cameron@huawei.com>
>
> Simple function to search a PCIBus to find a port by
> it's port number.
>
> CXL interleave decoding uses the port number as a target
> so it is necessary to locate the port when doing interleave
> decoding.
>
> Signed-off-by: Jonathan Cameron <jonathan.cameron@huawei.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
