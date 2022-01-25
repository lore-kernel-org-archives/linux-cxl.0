Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC6CC433EF
	for <linux-cxl@archiver.kernel.org>; Tue, 25 Jan 2022 13:56:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242101AbiAYN4C (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 25 Jan 2022 08:56:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386762AbiAYNx4 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 25 Jan 2022 08:53:56 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361E8C06175E
        for <linux-cxl@vger.kernel.org>; Tue, 25 Jan 2022 05:53:55 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id b13so63080253edn.0
        for <linux-cxl@vger.kernel.org>; Tue, 25 Jan 2022 05:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=AQLpznwZjUVv3sUgFHwsQE4uBZUuzaht9HIbBFEo6f4=;
        b=oFVlvNme6+1uraHXIpqVTZJooeuciNw3iWAL/Ey8x2RkjnC+h68gn0/gbbr8v9MAMi
         MXbRgdJY/Hm1keH5w9cjeRuuHJXPP6v64vM0CY7rmBKwlITwHNaLUmqrRLxPYAHGoiSG
         A+0hIMaETf6QYNLW5wQJOV5DsO+rBFp/SkDZ9Cfx6tGZtU1pEB1P5qiejX5d/2+4f+by
         jE0NUFh+b/9men+gJGB4WQKRdhUHLiH2vlD9YR1lzrbbupJY67wPVUcrK7SJ6grjKleA
         VMPliylUt1jrUTqfZzuQ8NoLodZtAerxSkbIdn/jGkHiquBXElaA4bWr8FSBmQPmERY4
         4p7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=AQLpznwZjUVv3sUgFHwsQE4uBZUuzaht9HIbBFEo6f4=;
        b=ZeQOZsfI+rQ+CimLCZIetH5YgWkgceHpELo4QxhA7d/YPySMneWdrfeiaFxrqR/wi6
         gFuk77sumMBarhyoBK9FNAqSJ8Twrl5UNvbS7c7fRs2SNQYdcmzENgBbvWjxmUWPKblr
         2IEja7hePswIpm1Gpyays0NCDxYjRLyxhItW9tr9pynnLWnX2MeNuk1jVEmIl2nDDlrs
         Ynm5id82WjKQ9BJKEo5QSQVQ68otBJI3r7MuAp2DsUXbUbOe2uWqFOs/12YT0AV1aqz6
         yiHgWFRo1LbnaXO4LOXHc8I2ek8rJYWnMUHbm8DxXsVRgrgT0jOrTd9CIARnRQxVwdui
         Qukw==
X-Gm-Message-State: AOAM531lXNuv3hdPX8bAVJnZrxBvgZ8EgtoPQ5DooD+cvFxXIAamZNQ/
        Gj8l9d4j9lY/oXhzKcT6qcylGg==
X-Google-Smtp-Source: ABdhPJy6DeMd2H4MLD/JsGpZo+K3RcDzCGsRbxaB1boo5gDl5I+vBQoaGm3YmYICFx72cFJXlvGjfg==
X-Received: by 2002:aa7:c412:: with SMTP id j18mr11429475edq.393.1643118833563;
        Tue, 25 Jan 2022 05:53:53 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
        by smtp.gmail.com with ESMTPSA id v5sm6164216ejc.40.2022.01.25.05.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 05:53:52 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
        by zen.linaroharston (Postfix) with ESMTP id B3DAA1FFB7;
        Tue, 25 Jan 2022 13:53:51 +0000 (GMT)
References: <20220124171705.10432-1-Jonathan.Cameron@huawei.com>
 <20220124171705.10432-2-Jonathan.Cameron@huawei.com>
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
Subject: Re: [PATCH v4 01/42] hw/pci/cxl: Add a CXL component type (interface)
Date:   Tue, 25 Jan 2022 13:53:45 +0000
In-reply-to: <20220124171705.10432-2-Jonathan.Cameron@huawei.com>
Message-ID: <875yq7exao.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:

> From: Ben Widawsky <ben.widawsky@intel.com>
>
> A CXL component is a hardware entity that implements CXL component
> registers from the CXL 2.0 spec (8.2.3). Currently these represent 3
> general types.
> 1. Host Bridge
> 2. Ports (root, upstream, downstream)
> 3. Devices (memory, other)
>
> A CXL component can be conceptually thought of as a PCIe device with
> extra functionality when enumerated and enabled. For this reason, CXL
> does here, and will continue to add on to existing PCI code paths.
>
> Host bridges will typically need to be handled specially and so they can
> implement this newly introduced interface or not. All other components
> should implement this interface. Implementing this interface allows the
> core PCI code to treat these devices as special where appropriate.
>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
