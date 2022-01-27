Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE1CAC433F5
	for <linux-cxl@archiver.kernel.org>; Thu, 27 Jan 2022 11:43:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240672AbiA0LnM (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 27 Jan 2022 06:43:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240662AbiA0LnL (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 27 Jan 2022 06:43:11 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5004DC061714
        for <linux-cxl@vger.kernel.org>; Thu, 27 Jan 2022 03:43:11 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id h21so4210595wrb.8
        for <linux-cxl@vger.kernel.org>; Thu, 27 Jan 2022 03:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=BcH1nHPR47fHpCPeOlz4Kj9mOlG9SQD37Fo/QmEk1cU=;
        b=WAFFOxZpU5TUQTHFouOP6c8dy09XxLm0b1J6nwrivnGepLGKT1d+Fgc2U51oDgMJhY
         ZYu7Pj773SFdpDoIp5luaW9XvmYn2WUQZOs1VdZ5xv4ZAd036rXmgn5pWDBMhHAUUIvZ
         Qdj5v9y+ULW22SlXMVZwmSsuXZCbiZEh9gPMMuk08W9WBPAHwD5pCQt0N6afyOEFlEEd
         HAeeSAe63BHKefXHIRcxXXZpfw5yxsFCKKXvNTrQkB0CK7fQkK4+/7XC1Fwdka3QWS2n
         zAA6G+L9S70PVZ7dvT4q0zN+uQ3EcHTOlAVc0Fu07t3qmvZheZW8Go+ZHX8K2U2O4E/X
         NSbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=BcH1nHPR47fHpCPeOlz4Kj9mOlG9SQD37Fo/QmEk1cU=;
        b=Kb9yIKwGi0zdUEP9CwKrwtvYm39LkJP9jB2os51lnNlVGx+U6hT61AMWzK50yIsq4v
         HKzX+YimVxK/TYjmJOD2X4RjhjMgO/VJns9Yr9XL4n9KNBUcxcFRaRuhPrlS/GCTA6WI
         ucohO11Np40zaFSHr4s9g13eYyly/YfFKkgivgA1c76IvfGcko4oRVZRcnPeVsBg2P/0
         Mc1zDUKveTjUiuMxqq0mwGICMcoBxzsASyFAgubCGibO+PU3BoiWlYU4bp6G4w1usZga
         7/0P340MCaMlDwDRrXx6PaKk4jxqQpk7+s2QZoiPZpx0zCvX7vf/1HHq5c9UL+xUeIxG
         KEbQ==
X-Gm-Message-State: AOAM530/X0rflBP1lOXD6MjWzcbTR/QS6HfyDn4iemWAX5ikhns0jlVw
        kLSJOgQ68sLK8sS1AfPwDXk2uw==
X-Google-Smtp-Source: ABdhPJwkn5cwBSog1lF0erA8j6SzER+eUovEx6ffRIBTjuiZGUyp3/EPvR8QkENKnwBh2uiflF0+HQ==
X-Received: by 2002:adf:ed8f:: with SMTP id c15mr2777933wro.229.1643283789934;
        Thu, 27 Jan 2022 03:43:09 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
        by smtp.gmail.com with ESMTPSA id g5sm2485099wri.108.2022.01.27.03.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 03:43:08 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
        by zen.linaroharston (Postfix) with ESMTP id 2DAA21FFB7;
        Thu, 27 Jan 2022 11:43:08 +0000 (GMT)
References: <20220124171705.10432-1-Jonathan.Cameron@huawei.com>
 <20220124171705.10432-7-Jonathan.Cameron@huawei.com>
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
Subject: Re: [PATCH v4 06/42] hw/cxl/device: Implement basic mailbox (8.2.8.4)
Date:   Thu, 27 Jan 2022 11:31:16 +0000
In-reply-to: <20220124171705.10432-7-Jonathan.Cameron@huawei.com>
Message-ID: <87czkdbe0j.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:

> From: Ben Widawsky <ben.widawsky@intel.com>
>
> This is the beginning of implementing mailbox support for CXL 2.0
> devices. The implementation recognizes when the doorbell is rung,
> handles the command/payload, clears the doorbell while returning error
> codes and data.
>
> Generally the mailbox mechanism is designed to permit communication
> between the host OS and the firmware running on the device. For our
> purposes, we emulate both the firmware, implemented primarily in
> cxl-mailbox-utils.c, and the hardware.
>
<snip>
> +
> +#define define_mailbox_handler(name)                \
> +    static ret_code cmd_##name(struct cxl_cmd *cmd, \
> +                               CXLDeviceState *cxl_dstate, uint16_t *len)
> +#define declare_mailbox_handler(name) define_mailbox_handler(name)
> +
> +#define define_mailbox_handler_zeroed(name, size)                       =
  \
> +    uint16_t __zero##name =3D size;                                     =
    \
> +    static ret_code cmd_##name(struct cxl_cmd *cmd,                     =
  \
> +                               CXLDeviceState *cxl_dstate, uint16_t *len=
) \
> +    {                                                                   =
  \
> +        *len =3D __zero##name;                                          =
    \
> +        memset(cmd->payload, 0, *len);                                  =
  \
> +        return CXL_MBOX_SUCCESS;                                        =
  \
> +    }
> +#define define_mailbox_handler_const(name, data)                        =
  \
> +    static ret_code cmd_##name(struct cxl_cmd *cmd,                     =
  \
> +                               CXLDeviceState *cxl_dstate, uint16_t *len=
) \
> +    {                                                                   =
  \
> +        *len =3D sizeof(data);                                          =
    \
> +        memcpy(cmd->payload, data, *len);                               =
  \
> +        return CXL_MBOX_SUCCESS;                                        =
  \
> +    }
> +#define define_mailbox_handler_nop(name)                                =
  \
> +    static ret_code cmd_##name(struct cxl_cmd *cmd,                     =
  \
> +                               CXLDeviceState *cxl_dstate, uint16_t *len=
) \
> +    {                                                                   =
  \
> +        return CXL_MBOX_SUCCESS;                                        =
  \
> +    }

I missed these #define's - can you upcase them to make it clear they are
macros when used.

--=20
Alex Benn=C3=A9e
