Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B118C433F5
	for <linux-cxl@archiver.kernel.org>; Thu, 27 Jan 2022 14:07:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242041AbiA0OHR (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 27 Jan 2022 09:07:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237388AbiA0OHR (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 27 Jan 2022 09:07:17 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06EEAC061714
        for <linux-cxl@vger.kernel.org>; Thu, 27 Jan 2022 06:07:17 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id q9-20020a7bce89000000b00349e697f2fbso6031181wmj.0
        for <linux-cxl@vger.kernel.org>; Thu, 27 Jan 2022 06:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=Hq9qqlHo85AwjtjEsLobiqP4b9lWYCusPNp9zTso/Ws=;
        b=eoBR822Nsb2poVFXqKowR6F1C5eDs78PBZSRbieQjigDlhM9gwLHPEWhjv6KQm0DPR
         AGaZK4gSxDWl1YvmvrfQG+dVqvehYws+OSEuwkSDdBAjF8NS11nge8bT3GlnPC/N8aE3
         PGti3DnqVlIJKELjt+rrBKZRaW7yxk8m7neMPIdjrhEKyOIt8/O2sZ2ISfLY0//wzK6C
         yGnvGpVu7ocRuXcRFpIvHhpayWu+Ypbm/+XMzaXzvLtiBf19MS8FLi0VpM/oY4ovcpQh
         1Qa6CIy2e6sx0DxBEsOdzJSpycq/wtAQL/if0MwXlr37PbsOrE0LHWfHSUfWzXsi9DzD
         bKKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=Hq9qqlHo85AwjtjEsLobiqP4b9lWYCusPNp9zTso/Ws=;
        b=cfUB37mzopp/8+PqMfSkLHVo1FQcMYH1EGbXCJmMfgplhExgxiIw30V1EqwP3qPmFT
         rxQEOdEkCwpJXk2V7DGIu2Wbem9kbDk1eUHXFTWVEWAEZw0+q0sC9NtyoPbeM3jLArbl
         jPHj/vv4FRUHN5XeU5PipY3fG+rbrZZxbilG67ggLHtPtbN0KK8D/AAFUDj2i9vOfDgw
         91EWE5TSjM4ipluCvuL6YcGZ4YnB+AvDmcM24dyRSqQC4rrXaVe4IXlRZkdhKvFhf5X3
         CUHoJ65P+yaiUZVV6pyP4y+fxOmSrAQ+1LWgrA5w+i9A8ZJceZuuhq3uyNidX3J8UNJJ
         6dMw==
X-Gm-Message-State: AOAM53261p3ePhlhLJ1Cv9w3k7IAwSPAy1zwjYcaRZVfiL9aYkmHmJ/7
        p7TCYH5BYl4sngZ2LvvcVhRnZA==
X-Google-Smtp-Source: ABdhPJyIvnUBx0tR7GERCvb7MWQrhXLX9JaISw0O7WEtVh5HBjwFgxSjAPqNToRkLFozvY7VW/aG2w==
X-Received: by 2002:a05:600c:3b11:: with SMTP id m17mr3409329wms.192.1643292435560;
        Thu, 27 Jan 2022 06:07:15 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
        by smtp.gmail.com with ESMTPSA id a9sm2356652wmm.32.2022.01.27.06.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 06:07:14 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
        by zen.linaroharston (Postfix) with ESMTP id E8A381FFB7;
        Thu, 27 Jan 2022 14:07:13 +0000 (GMT)
References: <20220124171705.10432-1-Jonathan.Cameron@huawei.com>
 <20220124171705.10432-15-Jonathan.Cameron@huawei.com>
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
Subject: Re: [PATCH v4 14/42] tests/acpi: allow DSDT.viot table changes.
Date:   Thu, 27 Jan 2022 14:06:42 +0000
In-reply-to: <20220124171705.10432-15-Jonathan.Cameron@huawei.com>
Message-ID: <87a6fh9sry.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:

> From: Jonathan Cameron <jonathan.cameron@huawei.com>
>
> The next patch unifies some of the PCI host bridge DSDT
> generation code and results in some minor changes to this file.

I'd just squash this in with the patch that makes the change...
otherwise you risk breaking bisectablility.

>
> Signed-off-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> ---
>  tests/qtest/bios-tables-test-allowed-diff.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bi=
os-tables-test-allowed-diff.h
> index dfb8523c8b..08a8095432 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1 +1,2 @@
>  /* List of comma-separated changed AML files to ignore */
> +"tests/data/acpi/q35/DSDT.viot",


--=20
Alex Benn=C3=A9e
