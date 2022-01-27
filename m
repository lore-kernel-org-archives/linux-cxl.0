Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF8BC433EF
	for <linux-cxl@archiver.kernel.org>; Thu, 27 Jan 2022 12:00:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbiA0MAP (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 27 Jan 2022 07:00:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiA0MAO (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 27 Jan 2022 07:00:14 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A216C061714
        for <linux-cxl@vger.kernel.org>; Thu, 27 Jan 2022 04:00:14 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id a13so4293732wrh.9
        for <linux-cxl@vger.kernel.org>; Thu, 27 Jan 2022 04:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=QrXnYqB322/NMxK2rGYEhWex1R0mxBSK4v3HkaeYkxM=;
        b=vi1lWKEp5p2i4F0MfvPYJIQsnDli94qeICmPHV2aFjGpfmqOthThrWcidDR1LZIySx
         Pj2yoJmb+iUFY/VyiIBZJiu2o7CcDGM/aoTOLBGz/9jsfOHh1a7LnUT0OcY0/UWZwiTB
         8jnkph0WRO306ZusdbV/WaXLQrpX6NZoLmDrdtw70u+Pt5COLq1OPl1+x5PA1exWVyLC
         u4IBlpa/wzO6ekI3Mvb3i591oAuhuD59sMgSwVItVwxM/YRPKvAYP7uWn/25RAMpAyka
         zGZvsPj1oz+oip9SvavqMxT42Egl49nCrAcn9FdZVu7j+4VsLUPubTYcQsd4y2CFvXkc
         HDGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=QrXnYqB322/NMxK2rGYEhWex1R0mxBSK4v3HkaeYkxM=;
        b=SQtxacbwOZfAIn2oM2jngXmqEBT6IcM4IuFSiehsGj/MWWbllf5vTgrvfsJwRNZdyZ
         t6pGCgLDG+qPHEVjhOMoJRHUyPufyM1MhVgBkvHZ1GJAQh6gkTBUabXNupJ5eEQ4M/wm
         bAgynNsJG0wevGzq4Yj2UCF2TglwNGDbaerbFqwCjd+hAiyR7k8YpN4atM/jARDOZ6Ru
         0C6ofcLTEZiIDlbTpSbBlq4XBSvkYJZ48KzEpA3rnUIyJgLaZYFxDYuvtujPxcx37zc4
         bmXooQSUDxocZQ1BKXZCDc5NvpwVCXLE6rwVv9torEpF5OMq0ZWhakyE8wFBxawUR4Dd
         OTdA==
X-Gm-Message-State: AOAM530zz4MhlCkqq6ZVqvd5jIpT1ezAQ6e2nZywA6ZChVnShMN0CfPO
        ckBwEImmqjbnpXHtzuCbPllfQQ==
X-Google-Smtp-Source: ABdhPJxHZdBZrrxKmCdd3hXnwrEWjAr64UX7U0v6S+gZDK6fFg+Ppq1OD++ve4OK0IoIlL4Chf+GMw==
X-Received: by 2002:a5d:65ce:: with SMTP id e14mr2800858wrw.245.1643284813058;
        Thu, 27 Jan 2022 04:00:13 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
        by smtp.gmail.com with ESMTPSA id o10sm2352988wri.19.2022.01.27.04.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 04:00:12 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
        by zen.linaroharston (Postfix) with ESMTP id 8BD9C1FFB7;
        Thu, 27 Jan 2022 12:00:11 +0000 (GMT)
References: <20220124171705.10432-1-Jonathan.Cameron@huawei.com>
 <20220124171705.10432-11-Jonathan.Cameron@huawei.com>
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
Subject: Re: [PATCH v4 10/42] hw/cxl/device: Add log commands (8.2.9.4) + CEL
Date:   Thu, 27 Jan 2022 11:55:47 +0000
In-reply-to: <20220124171705.10432-11-Jonathan.Cameron@huawei.com>
Message-ID: <87zgnh9yno.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:

> From: Ben Widawsky <ben.widawsky@intel.com>
>
> CXL specification provides for the ability to obtain logs from the
> device. Logs are either spec defined, like the "Command Effects Log"
> (CEL), or vendor specific. UUIDs are defined for all log types.
>
> The CEL is a mechanism to provide information to the host about which
> commands are supported. It is useful both to determine which spec'd
> optional commands are supported, as well as provide a list of vendor
> specified commands that might be used. The CEL is already created as
> part of mailbox initialization, but here it is now exported to hosts
> that use these log commands.
>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  hw/cxl/cxl-mailbox-utils.c | 67 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 67 insertions(+)
>
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index cea4b2a59c..0ab0592e6c 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -46,6 +46,9 @@ enum {
>      TIMESTAMP   =3D 0x03,
>          #define GET           0x0
>          #define SET           0x1
> +    LOGS        =3D 0x04,
> +        #define GET_SUPPORTED 0x0
> +        #define GET_LOG       0x1
>  };
>=20=20
>  /* 8.2.8.4.5.1 Command Return Codes */
> @@ -122,6 +125,8 @@ define_mailbox_handler_zeroed(EVENTS_GET_INTERRUPT_PO=
LICY, 4);
>  define_mailbox_handler_nop(EVENTS_SET_INTERRUPT_POLICY);
>  declare_mailbox_handler(TIMESTAMP_GET);
>  declare_mailbox_handler(TIMESTAMP_SET);
> +declare_mailbox_handler(LOGS_GET_SUPPORTED);
> +declare_mailbox_handler(LOGS_GET_LOG);
>=20=20
>  #define IMMEDIATE_CONFIG_CHANGE (1 << 1)
>  #define IMMEDIATE_POLICY_CHANGE (1 << 3)
> @@ -137,6 +142,8 @@ static struct cxl_cmd cxl_cmd_set[256][256] =3D {
>      CXL_CMD(EVENTS, SET_INTERRUPT_POLICY, 4, IMMEDIATE_CONFIG_CHANGE),
>      CXL_CMD(TIMESTAMP, GET, 0, 0),
>      CXL_CMD(TIMESTAMP, SET, 8, IMMEDIATE_POLICY_CHANGE),
> +    CXL_CMD(LOGS, GET_SUPPORTED, 0, 0),
> +    CXL_CMD(LOGS, GET_LOG, 0x18, 0),
>  };
>=20=20
>  #undef CXL_CMD
> @@ -188,6 +195,66 @@ define_mailbox_handler(TIMESTAMP_SET)
>=20=20
>  QemuUUID cel_uuid;
>=20=20
> +/* 8.2.9.4.1 */
> +define_mailbox_handler(LOGS_GET_SUPPORTED)
> +{

Here is where I get a bit wary of the define_mailbox_handler define
which from what I can tell just hides the declarations. This makes the
handling of things like *cmd rather opaque. There is an argument for the
boilerplate definitions (_nop and _zeroed) but perhaps not these.

> +    struct {
> +        uint16_t entries;
> +        uint8_t rsvd[6];
> +        struct {
> +            QemuUUID uuid;
> +            uint32_t size;
> +        } log_entries[1];
> +    } __attribute__((packed)) *supported_logs =3D (void *)cmd->payload;
> +    _Static_assert(sizeof(*supported_logs) =3D=3D 0x1c, "Bad supported l=
og size");
> +
> +    supported_logs->entries =3D 1;
> +    supported_logs->log_entries[0].uuid =3D cel_uuid;
> +    supported_logs->log_entries[0].size =3D 4 * cxl_dstate->cel_size;
> +
> +    *len =3D sizeof(*supported_logs);
> +    return CXL_MBOX_SUCCESS;
> +}
> +
> +/* 8.2.9.4.2 */
> +define_mailbox_handler(LOGS_GET_LOG)
> +{
> +    struct {
> +        QemuUUID uuid;
> +        uint32_t offset;
> +        uint32_t length;
> +    } __attribute__((packed, __aligned__(16))) *get_log =3D (void *)cmd-=
>payload;
> +
> +    /*
> +     * 8.2.9.4.2
> +     *   The device shall return Invalid Parameter if the Offset or Leng=
th
> +     *   fields attempt to access beyond the size of the log as reported=
 by Get
> +     *   Supported Logs.
> +     *
> +     * XXX: Spec is wrong, "Invalid Parameter" isn't a thing.
> +     * XXX: Spec doesn't address incorrect UUID incorrectness.
> +     *
> +     * The CEL buffer is large enough to fit all commands in the emulati=
on, so
> +     * the only possible failure would be if the mailbox itself isn't big
> +     * enough.
> +     */
> +    if (get_log->offset + get_log->length > cxl_dstate->payload_size) {
> +        return CXL_MBOX_INVALID_INPUT;
> +    }
> +
> +    if (!qemu_uuid_is_equal(&get_log->uuid, &cel_uuid)) {
> +        return CXL_MBOX_UNSUPPORTED;
> +    }
> +
> +    /* Store off everything to local variables so we can wipe out the pa=
yload */
> +    *len =3D get_log->length;
> +
> +    memmove(cmd->payload, cxl_dstate->cel_log + get_log->offset,
> +           get_log->length);
> +
> +    return CXL_MBOX_SUCCESS;
> +}
> +
>  void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
>  {
>      uint16_t ret =3D CXL_MBOX_SUCCESS;


--=20
Alex Benn=C3=A9e
