Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78841C433F5
	for <linux-cxl@archiver.kernel.org>; Thu, 27 Jan 2022 12:01:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232965AbiA0MBX (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 27 Jan 2022 07:01:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235293AbiA0MBT (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 27 Jan 2022 07:01:19 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02FC1C061747
        for <linux-cxl@vger.kernel.org>; Thu, 27 Jan 2022 04:01:19 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id s9so4327929wrb.6
        for <linux-cxl@vger.kernel.org>; Thu, 27 Jan 2022 04:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=SJMNltEFIBFgRfXY/9TKs/P+kxKApyZgAbg4a3ViYJQ=;
        b=YgMGGe1rLpXkvn5ttphlEZROPN6e3s/Jlu9obpuzgQT8bt9qzPMBrgPhMiI6aBy4Su
         /0dsAjlYPpFTBoTuO2QPwjVOAKxXdey2JVZDFh9p0oGw7lYLxkuAZSMXbSi9lJKC02NA
         749a7S1hvSzq0xIWnhw1MH9Ots49I81pguLMnjC/jJLbPYJauFIs5fAlUYl/TxfKuyVi
         dZMJDZksYX4QGWXiH8MEo2Wee9HZcuzkWx6WJGpy9B3FJqK796NtrDyt7rWM06oF/3Kl
         b7WpHIXEf4suhDbNo+2Nuqc1qYa0fKLWx8EtmPIFYvKnQIMUgTUhMdQKjpgpTJIavKyk
         f0WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=SJMNltEFIBFgRfXY/9TKs/P+kxKApyZgAbg4a3ViYJQ=;
        b=RHgBZ05nYoEaxVWbGuFAVYc4Sn3qgSHan6QsIiPqoDogwMGqJhy0KslwUJIZDXyIRV
         Q69IGv49XBFzOsn0+329YgufmqHORK2ZVHR8m8Mz+bf5q2RAal6H8TP4cvOxLTAkydnJ
         YSUklED86QBC6ah3rL9AKoN5tZXLin99q4DGXlTr01dmffANAOyRbBHE9WVt/BPPj/hn
         72kaDN/EGz/BAPtXSMwTm1dgr/uCZGB8acTjyL6RanFbr0gpHCC5p1elxqwRpfOYWmyU
         1EhC0LDQzht+28Flt81Vi+4JRgPEd1OsqhkSqmjvLSjemEEIbfM+P2LZZtbs1t15S9LU
         eYVw==
X-Gm-Message-State: AOAM533Rtfvw4f3zeiKMEO9jRd5lTwnXTmZy7pSlHGI1MpiU5mocYT2l
        +7unGxZ5+ADrSmtDQ41HYiD8S7eN3Tg8jQ==
X-Google-Smtp-Source: ABdhPJyOl5e9SOAErFENG0DQV3jPGZl7A2ZmYS7qXZ5vU/Ym3cpFF11PsDMqGPhp0ftxMJLNqxbzjQ==
X-Received: by 2002:a5d:53cf:: with SMTP id a15mr2623857wrw.677.1643284877565;
        Thu, 27 Jan 2022 04:01:17 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
        by smtp.gmail.com with ESMTPSA id bh26sm1827525wmb.40.2022.01.27.04.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 04:01:16 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
        by zen.linaroharston (Postfix) with ESMTP id EF2D81FFB7;
        Thu, 27 Jan 2022 12:01:15 +0000 (GMT)
References: <20220124171705.10432-1-Jonathan.Cameron@huawei.com>
 <20220124171705.10432-12-Jonathan.Cameron@huawei.com>
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
Subject: Re: [PATCH v4 11/42] hw/pxb: Use a type for realizing expanders
Date:   Thu, 27 Jan 2022 12:01:11 +0000
In-reply-to: <20220124171705.10432-12-Jonathan.Cameron@huawei.com>
Message-ID: <87v8y59ylw.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:

> From: Ben Widawsky <ben.widawsky@intel.com>
>
> This opens up the possibility for more types of expanders (other than
> PCI and PCIe). We'll need this to create a CXL expander.
>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
