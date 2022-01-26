Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3975C2BA4C
	for <linux-cxl@archiver.kernel.org>; Wed, 26 Jan 2022 18:06:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244100AbiAZSGk (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 26 Jan 2022 13:06:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232788AbiAZSGj (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 26 Jan 2022 13:06:39 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93665C06161C
        for <linux-cxl@vger.kernel.org>; Wed, 26 Jan 2022 10:06:39 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id s9so456741wrb.6
        for <linux-cxl@vger.kernel.org>; Wed, 26 Jan 2022 10:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=SUD15Xe4vNahY/NaTaU1Ia3FZqtSNmlnp2SZLaOHK0A=;
        b=xihVaJZs0zfPxHjxle5aTU/8wxPT98//QsFZr50nN9txpXQfBuYjEzAKJM8rYEfzNV
         WbaUwQ6TwoJQB56ABw3y3gptLdmrevFQul2IENyfqtSoaKko7BUXKIkFdIASLYGe3wFK
         4qlETbQ7Q2InMFr/ntvJgu+B+ba/1HDumzy4OPxEh0uiTooPne0Hm3Oz5YsPOibw5HTz
         AimfAljmELGU9toslr4z/vqxLVD/G64S3SAH7APMobFcYGeB6ACiyWUvNMzd4gZT5PWm
         5Hhs9BMRaNIdsiL6I8cYehN3ZFdi/johfLvi2PFKirCiBs7490NpcRkYyzh2ZIerqPI2
         cC/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=SUD15Xe4vNahY/NaTaU1Ia3FZqtSNmlnp2SZLaOHK0A=;
        b=WvUzPggmQ1ZrFfL9zMEo/yJZOGI7foonbG6aY935Jccn2MyfCHSy8yQvHTigCBPk4x
         5g3y1mZ3O5zFjbbYImyXxizjGYJ5q7Nprd6ooM/FB+t8r1UaW98SasuUg1b5+NwsNmcr
         93NOzy3NWQCOtzchhO73UVAPKkfyUiWAxrouqyqXYkr9nOi3aJsiwqpjTOnuJs0rvo/y
         GWsPwiml56GsDRySYTWWRkaB5oUr1pfoYihk6XanDvnNSDIXivqkzQoAv8wpafBbTZ12
         JsQ0K1IDk8Sgv7UaLYWqUfSXjlSK9BGWu8d7eg6W26DQuOinaoBRebSNxAI7AXyFgoLs
         yAGQ==
X-Gm-Message-State: AOAM530fOwb+u3KUwjTRCZN7RLgY6DWhXhSoEMQoBgBaF0KKvRw0iWTg
        yM3KX1LXi7G41ChKLtZ9aOQhKQ==
X-Google-Smtp-Source: ABdhPJyatRU7H8bGEXZUAswGd8tPDe0oTmGX6rXn+8tH/euENSVQS1cpGVIGvxQuTZmOU8igT8vvOA==
X-Received: by 2002:a5d:6488:: with SMTP id o8mr23375656wri.219.1643220398072;
        Wed, 26 Jan 2022 10:06:38 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
        by smtp.gmail.com with ESMTPSA id u14sm20011565wrm.58.2022.01.26.10.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 10:06:36 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
        by zen.linaroharston (Postfix) with ESMTP id 5F1B51FFB7;
        Wed, 26 Jan 2022 18:06:36 +0000 (GMT)
References: <20220124171705.10432-1-Jonathan.Cameron@huawei.com>
 <20220124171705.10432-4-Jonathan.Cameron@huawei.com>
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
Subject: Re: [PATCH v4 03/42] MAINTAINERS: Add entry for Compute Express
 Link Emulation
Date:   Wed, 26 Jan 2022 18:06:31 +0000
In-reply-to: <20220124171705.10432-4-Jonathan.Cameron@huawei.com>
Message-ID: <8735lacqxf.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:

> From: Jonathan Cameron <jonathan.cameron@huawei.com>
>
> The CXL emulation will be jointly maintained by Ben Widawsky
> and Jonathan Cameron.  Broken out as a separate patch
> to improve visibility.
>
> Signed-off-by: Jonathan Cameron <jonathan.cameron@huawei.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
