Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21672C433EF
	for <linux-cxl@archiver.kernel.org>; Tue, 25 Jan 2022 17:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239111AbiAYRFw (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 25 Jan 2022 12:05:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347712AbiAYRDc (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 25 Jan 2022 12:03:32 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561AEC061753
        for <linux-cxl@vger.kernel.org>; Tue, 25 Jan 2022 09:03:30 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id q141-20020a1ca793000000b00347b48dfb53so2363059wme.0
        for <linux-cxl@vger.kernel.org>; Tue, 25 Jan 2022 09:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=pHqmzBCmLUqqK5yo/LysYPjTU/stvam03/Fw8w0sa6g=;
        b=ADmrS7zWiaWsCjA5EjIiGyW/FJXYv40umPayPqEMfEuvFR4OLsfqO9yIPE+bsK61OL
         Hr4ZeteJM3B5hgBU6DPA3sc0A8YfGIXdI6P/Rwcm13MkyDwoZBPHcrExV9DkYv1ReuRI
         0Ia9ky/kvL/R3D93N6QuLMD9D80SEMNdckADOMvA5E3xHS3fJIydf+Bttd46w6vTBW67
         Sm6YCgVO0ga5KaWiNp9nqF94oHIzoncHdVfrv0Li7yJ82vWCegspxu5Dv/UsMrFkINQL
         fnvxm/Seos5WIXK65KBNpC6GjhHNVMdmawmOhFjsUtUH/FMCd4VOlZgzS3eucjEYY2A7
         iIsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=pHqmzBCmLUqqK5yo/LysYPjTU/stvam03/Fw8w0sa6g=;
        b=CrI1/EcmpUst37rb+inI9hX5ozbzCmtj3/BihSeT5p0m9z/DBTztKr1HVEWyAGv3o7
         3+YYgqnn8pVJcej5AWFtSRC0p+1vnolMqEAf8Cwh/K3GErSPkmmMsjfOxjkxl47/Df2U
         Y7emYxNXCZHB7njCLqsD5qHlcTR2N2uzq+e5e3BTw5SzJ5MF5XU3678+FHeWoHNoht3B
         jCyThM/7XBTnJw3vqF6/jSA2bAvoYz6PsrZfAK9ifuLmDUW/cEcyYLjlraUAN/5aL2//
         /MfFhMrJ7TzgRGLlJ8X4ParpJQH94BKh7QutDr6whwovcx5opgS7oEFZoPtp5ADIJZFo
         t4xQ==
X-Gm-Message-State: AOAM533nVOm5PBD71bsFFDUZQppMHWrKESu7YS/xw4fpWdv4n24EgCs8
        4C1p4bMIs8HtUfMNC6GU1rPQvQ==
X-Google-Smtp-Source: ABdhPJyB9P/tzuV3XlJ5guavNUkTJZE7K553teX9o4saPKFW4mxqHsBH86a7a3axaIr9jRup6xd7rA==
X-Received: by 2002:a7b:c7cf:: with SMTP id z15mr3756471wmk.105.1643130208861;
        Tue, 25 Jan 2022 09:03:28 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
        by smtp.gmail.com with ESMTPSA id 10sm854184wmc.44.2022.01.25.09.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 09:03:27 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
        by zen.linaroharston (Postfix) with ESMTP id 77AAD1FFB7;
        Tue, 25 Jan 2022 17:03:26 +0000 (GMT)
References: <20220124171705.10432-1-Jonathan.Cameron@huawei.com>
 <20220124171705.10432-30-Jonathan.Cameron@huawei.com>
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
Subject: Re: [PATCH v4 29/42] hw/cxl/host: Add support for CXL Fixed Memory
 Windows.
Date:   Tue, 25 Jan 2022 17:02:32 +0000
In-reply-to: <20220124171705.10432-30-Jonathan.Cameron@huawei.com>
Message-ID: <87sftbd9y9.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:

> From: Jonathan Cameron <jonathan.cameron@huawei.com>
>
> The concept of these is introduced in [1] in terms of the
> description the CEDT ACPI table. The principal is more general.
> Unlike once traffic hits the CXL root bridges, the host system
> memory address routing is implementation defined and effectively
> static once observable by standard / generic system software.
> Each CXL Fixed Memory Windows (CFMW) is a region of PA space
> which has fixed system dependent routing configured so that
> accesses can be routed to the CXL devices below a set of target
> root bridges. The accesses may be interleaved across multiple
> root bridges.

This breaks the linux-user builds...
> diff --git a/hw/cxl/meson.build b/hw/cxl/meson.build
> index 0eca715d10..27dff3868b 100644
> --- a/hw/cxl/meson.build
> +++ b/hw/cxl/meson.build
> @@ -1,5 +1,9 @@
> -softmmu_ss.add(when: 'CONFIG_CXL', if_true: files(
> -  'cxl-component-utils.c',
> -  'cxl-device-utils.c',
> -  'cxl-mailbox-utils.c',
> +specific_ss.add(when: 'CONFIG_CXL', if_true: files(
> +      'cxl-component-utils.c',
> +      'cxl-device-utils.c',
> +      'cxl-mailbox-utils.c',
> +      'cxl-host.c',
> +))
> +specific_ss.add(when: 'CONFIG_CXL', if_false: files(
> +      'cxl-host-stubs.c',
>  ))

I think you want this:

  softmmu_ss.add(when: 'CONFIG_CXL',
                 if_true: files(
                   'cxl-component-utils.c',
                   'cxl-device-utils.c',
                   'cxl-mailbox-utils.c',
                   'cxl-host.c'),
                 if_false: files(
                   'cxl-host-stubs.c',
                 ))

  # This is required as well:
  softmmu_ss.add(when: 'CONFIG_ALL', if_true: files('cxl-host-stubs.c'))


--=20
Alex Benn=C3=A9e
