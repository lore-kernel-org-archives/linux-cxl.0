Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91951C433EF
	for <linux-cxl@archiver.kernel.org>; Tue,  1 Mar 2022 18:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiCASxT (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 1 Mar 2022 13:53:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232515AbiCASxS (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 1 Mar 2022 13:53:18 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA7A27176
        for <linux-cxl@vger.kernel.org>; Tue,  1 Mar 2022 10:52:35 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id dr20so8643378ejc.6
        for <linux-cxl@vger.kernel.org>; Tue, 01 Mar 2022 10:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=CvAAYXbWo8/vkqSGWl+Sox1VYgzhZxbSVldG7bIhOyo=;
        b=ZSqMtNWLjQH5IsMW9inLAU0zBYU8ua6bA3JQko5vKuABWc130rArCA+IqFwL8DU5xx
         uBysQttUE9ZaTrwoz1V/vVE3BvQ1iN1T9AJi4RWN6yzGY3E5H3C9T0qxs5/ieZBAjz6+
         54ZXv52O3OVWtRAlynkVqR4TwKDIRADxhATf0aXLKXl5xtXBQNSLnhXsvvAZboEFskEm
         HY5Ofs57Bb6HCPqzl1A38r/FbYCC2FQtK2fY+mYlvUDMExeFNVRHQjTz+r9MzhlXUI0y
         5UgyVhztG4sjQlLLzAUZRRbCrwJmwUIO5RPN5J7S7uDD/Uj4X2jmWkW2O9SZrg/ARRVR
         q4Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=CvAAYXbWo8/vkqSGWl+Sox1VYgzhZxbSVldG7bIhOyo=;
        b=WXg+V1uoa8/rbsOW428mH13mIeSfNhFiT5AnJWMgKEYHXDv/xQWQhg/uDwPVw1JIsD
         c4wu0cPkDXzK96xrg+8qZu+LgRlQJQtyYWjk00WqkVjuZsrAYINk6U3heyah3WwmvQJ8
         iMpdtLiAEovlu4rZSn4DhSRMlAgRrlp7pLocBfKj11emQXaHE+rPcOCUU4VSK+i31gu7
         RWqrubSjqmOp9mr12cUUbwXfLSSqMeH4lN/GjBxpcXDqN/eF0wlq1FH3NRKH0BnePOO6
         MlfAztlvNA6ACV0bclfUA3pgTghMYF2fCqryEGo1ymq7m2lS6TK9GG0rBNxC0mgJXjHN
         bsJw==
X-Gm-Message-State: AOAM531b6Owjf0Jz25UDUgMuPiC2aM+X2I3lqKc4Gq6I5lyoYYeMH5iS
        PqiNLe9NTJifJfj2C3h5FuDiaQ==
X-Google-Smtp-Source: ABdhPJwE9jPTUxxjeh8/vloUGEClfE7y+1L7iS496ofKxqYP1fhuCbYYYRjC08GEE18dJ2HrhNvfcQ==
X-Received: by 2002:a17:906:c30f:b0:6a7:7de0:7e43 with SMTP id s15-20020a170906c30f00b006a77de07e43mr19276778ejz.475.1646160753603;
        Tue, 01 Mar 2022 10:52:33 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
        by smtp.gmail.com with ESMTPSA id u5-20020a170906b10500b006ce6fa4f510sm5519315ejy.165.2022.03.01.10.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 10:52:32 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
        by zen.linaroharston (Postfix) with ESMTP id 0D2B81FFB7;
        Tue,  1 Mar 2022 18:52:32 +0000 (GMT)
References: <20220211120747.3074-1-Jonathan.Cameron@huawei.com>
 <20220211120747.3074-21-Jonathan.Cameron@huawei.com>
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
Subject: Re: [PATCH v6 20/43] hw/cxl/device: Add some trivial commands
Date:   Tue, 01 Mar 2022 18:46:30 +0000
In-reply-to: <20220211120747.3074-21-Jonathan.Cameron@huawei.com>
Message-ID: <875yoxld3j.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:

> From: Ben Widawsky <ben.widawsky@intel.com>
>
> GET_FW_INFO and GET_PARTITION_INFO, for this emulation, is equivalent to
> info already returned in the IDENTIFY command. To have a more robust
> implementation, add those.
>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  hw/cxl/cxl-mailbox-utils.c | 69 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 68 insertions(+), 1 deletion(-)
>
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 808faec114..d022711b2a 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -44,6 +44,8 @@ enum {
>          #define CLEAR_RECORDS   0x1
>          #define GET_INTERRUPT_POLICY   0x2
>          #define SET_INTERRUPT_POLICY   0x3
> +    FIRMWARE_UPDATE =3D 0x02,
> +        #define GET_INFO      0x0
>      TIMESTAMP   =3D 0x03,
>          #define GET           0x0
>          #define SET           0x1
> @@ -52,6 +54,8 @@ enum {
>          #define GET_LOG       0x1
>      IDENTIFY    =3D 0x40,
>          #define MEMORY_DEVICE 0x0
> +    CCLS        =3D 0x41,
> +        #define GET_PARTITION_INFO     0x0
>  };
>=20=20
>  /* 8.2.8.4.5.1 Command Return Codes */
> @@ -114,6 +118,39 @@ DEFINE_MAILBOX_HANDLER_NOP(events_clear_records);
>  DEFINE_MAILBOX_HANDLER_ZEROED(events_get_interrupt_policy, 4);
>  DEFINE_MAILBOX_HANDLER_NOP(events_set_interrupt_policy);
>=20=20
> +/* 8.2.9.2.1 */
> +static ret_code cmd_firmware_update_get_info(struct cxl_cmd *cmd,
> +                                             CXLDeviceState *cxl_dstate,
> +                                             uint16_t *len)
> +{
> +    struct {
> +        uint8_t slots_supported;
> +        uint8_t slot_info;
> +        uint8_t caps;
> +        uint8_t rsvd[0xd];
> +        char fw_rev1[0x10];
> +        char fw_rev2[0x10];
> +        char fw_rev3[0x10];
> +        char fw_rev4[0x10];
> +    } __attribute__((packed)) *fw_info;
> +    _Static_assert(sizeof(*fw_info) =3D=3D 0x50, "Bad firmware info
> size");

note: we have QEMU_PACKED, QEMU_BUILD_BUG_ON and friends in compiler.h whic=
h are
preferred for potential compiler portability reasons.

> +
> +    if (cxl_dstate->pmem_size < (256 << 20)) {
> +        return CXL_MBOX_INTERNAL_ERROR;
> +    }
> +
> +    fw_info =3D (void *)cmd->payload;
> +    memset(fw_info, 0, sizeof(*fw_info));
> +
> +    fw_info->slots_supported =3D 2;
> +    fw_info->slot_info =3D BIT(0) | BIT(3);
> +    fw_info->caps =3D 0;
> +    snprintf(fw_info->fw_rev1, 0x10, "BWFW VERSION %02d", 0);

Given you have a fixed string here could you not:

  pstrcpy(fw_info->fw_rev1, 0x10, "BWFW VERSION 0");
=20=20
> +
> +    *len =3D sizeof(*fw_info);
> +    return CXL_MBOX_SUCCESS;
> +}
> +
>  /* 8.2.9.3.1 */
>  static ret_code cmd_timestamp_get(struct cxl_cmd *cmd,
>                                    CXLDeviceState *cxl_dstate,
> @@ -260,6 +297,33 @@ static ret_code cmd_identify_memory_device(struct cx=
l_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
>=20=20
> +static ret_code cmd_ccls_get_partition_info(struct cxl_cmd *cmd,
> +                                           CXLDeviceState *cxl_dstate,
> +                                           uint16_t *len)
> +{
> +    struct {
> +        uint64_t active_vmem;
> +        uint64_t active_pmem;
> +        uint64_t next_vmem;
> +        uint64_t next_pmem;
> +    } __attribute__((packed)) *part_info =3D (void *)cmd->payload;
> +    _Static_assert(sizeof(*part_info) =3D=3D 0x20, "Bad get partition in=
fo size");
> +    uint64_t size =3D cxl_dstate->pmem_size;
> +
> +    if (!QEMU_IS_ALIGNED(size, 256 << 20)) {
> +        return CXL_MBOX_INTERNAL_ERROR;
> +    }
> +
> +    /* PMEM only */
> +    part_info->active_vmem =3D 0;
> +    part_info->next_vmem =3D 0;
> +    part_info->active_pmem =3D size / (256 << 20);
> +    part_info->next_pmem =3D part_info->active_pmem;
> +
> +    *len =3D sizeof(*part_info);
> +    return CXL_MBOX_SUCCESS;
> +}
> +
>  #define IMMEDIATE_CONFIG_CHANGE (1 << 1)
>  #define IMMEDIATE_POLICY_CHANGE (1 << 3)
>  #define IMMEDIATE_LOG_CHANGE (1 << 4)
> @@ -273,15 +337,18 @@ static struct cxl_cmd cxl_cmd_set[256][256] =3D {
>          cmd_events_get_interrupt_policy, 0, 0 },
>      [EVENTS][SET_INTERRUPT_POLICY] =3D { "EVENTS_SET_INTERRUPT_POLICY",
>          cmd_events_set_interrupt_policy, 4, IMMEDIATE_CONFIG_CHANGE },
> +    [FIRMWARE_UPDATE][GET_INFO] =3D { "FIRMWARE_UPDATE_GET_INFO",
> +        cmd_firmware_update_get_info, 0, 0 },
>      [TIMESTAMP][GET] =3D { "TIMESTAMP_GET", cmd_timestamp_get, 0, 0 },
>      [TIMESTAMP][SET] =3D { "TIMESTAMP_SET", cmd_timestamp_set, 8, IMMEDI=
ATE_POLICY_CHANGE },
>      [LOGS][GET_SUPPORTED] =3D { "LOGS_GET_SUPPORTED", cmd_logs_get_suppo=
rted, 0, 0 },
>      [LOGS][GET_LOG] =3D { "LOGS_GET_LOG", cmd_logs_get_log, 0x18, 0 },
>      [IDENTIFY][MEMORY_DEVICE] =3D { "IDENTIFY_MEMORY_DEVICE",
>          cmd_identify_memory_device, 0, 0 },
> +    [CCLS][GET_PARTITION_INFO] =3D { "CCLS_GET_PARTITION_INFO",
> +        cmd_ccls_get_partition_info, 0, 0 },
>  };
>=20=20
> -
>  void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
>  {
>      uint16_t ret =3D CXL_MBOX_SUCCESS;


--=20
Alex Benn=C3=A9e
