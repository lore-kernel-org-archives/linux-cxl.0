Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E83CAC433FE
	for <linux-cxl@archiver.kernel.org>; Thu, 27 Jan 2022 11:52:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240274AbiA0LwO (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 27 Jan 2022 06:52:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235985AbiA0LwO (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 27 Jan 2022 06:52:14 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0468C061714
        for <linux-cxl@vger.kernel.org>; Thu, 27 Jan 2022 03:52:13 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id a13so4255836wrh.9
        for <linux-cxl@vger.kernel.org>; Thu, 27 Jan 2022 03:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=J32YRRvubcvH+G0DcSKEUpH881ecDRy/XA4es9r1le0=;
        b=zLgQ/J/yXDoITM3hjrhmxalkfZbFXTwl/w6gxNToy+PrPJG2ApNGJyeKW3biflrkZ6
         rZQHu3Vjtc2buuQ5ZkLc4aWFbWofRgXLxBpeC5cqAdxfg97/ddqjw97ZXvVzf9jQCasi
         DFfSvPmkKGPnrBBF0EYkkqo9NUhmvrZGS5rw9T41VAG5/BFyuF0HaRN2FAsgzpqgNXMD
         GNdNgqhd2P40OlGXGQLyu5npE/wR8l7dMafBuLt+4oQUAXe2dLEawbUK8lZAMaigcN5G
         Vw6deUD3NYoGIgaIVx8KbtiF8VEg3QyyEBrAQfO+FNiZ/LtfPV+I0VfJ69sDCn4aOGYA
         OJqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=J32YRRvubcvH+G0DcSKEUpH881ecDRy/XA4es9r1le0=;
        b=SUMA6/agHnHDek7SchlL/HqsLZRiLGrZ2IQCumkyiR7YX2JgLTadzGC971Mly+RTov
         Vz9Y6xDyUPfy4R8JKQpX7+lw7S2wtZ7Il14tnxPJMJNiOb2GT4SwHI8cF3uT2Vw9tSKv
         9geSN5ETUY0bxhX0quMEB7PaHQc5nWkMUHE26lh9NSdx9cibkmAbu39MlY0jsLjXs4W+
         uPtEzgjQGFJgEfGr+2W7jS+8Jb+DYzAjxjEbOjdk8Qj32b1hNLp+YuqOmz4ngJJESbyu
         KBSyVqsopJi2T6qYzTJymhyoOW/f5sgGM6BrVuB/qLmM6EeU+5sZSqTQH6NA3k3KZ2QJ
         AKSQ==
X-Gm-Message-State: AOAM531+738smS3il89A4j5tR0Y9y5v/zqixGo1QiRTf3zT6M5JnLUEu
        0YUDvPrAi3bu7rVeNQn7fbHGow==
X-Google-Smtp-Source: ABdhPJxqCmE31jPx6t+vwS28BSP8f0Kn//1a2ea2JtqBkkVX9Rf/r4Uggp3lrsOeH2Ipg5wbUFb1+w==
X-Received: by 2002:adf:fb0e:: with SMTP id c14mr2699787wrr.586.1643284332327;
        Thu, 27 Jan 2022 03:52:12 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
        by smtp.gmail.com with ESMTPSA id y15sm3126774wry.36.2022.01.27.03.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 03:52:11 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
        by zen.linaroharston (Postfix) with ESMTP id 8102F1FFB7;
        Thu, 27 Jan 2022 11:52:10 +0000 (GMT)
References: <20220124171705.10432-1-Jonathan.Cameron@huawei.com>
 <20220124171705.10432-10-Jonathan.Cameron@huawei.com>
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
Subject: Re: [PATCH v4 09/42] hw/cxl/device: Timestamp implementation (8.2.9.3)
Date:   Thu, 27 Jan 2022 11:50:08 +0000
In-reply-to: <20220124171705.10432-10-Jonathan.Cameron@huawei.com>
Message-ID: <874k5pbdlh.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:

> From: Ben Widawsky <ben.widawsky@intel.com>
>
> Per spec, timestamp appears to be a free-running counter from a value
> set by the host via the Set Timestamp command (0301h). There are
> references to the epoch, which seem like a red herring. Therefore, the
> implementation implements the timestamp as freerunning counter from the
> last value that was issued by the Set Timestamp command.
>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  hw/cxl/cxl-mailbox-utils.c  | 53 +++++++++++++++++++++++++++++++++++++
>  include/hw/cxl/cxl_device.h |  6 +++++
>  2 files changed, 59 insertions(+)
>
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 1a87846356..cea4b2a59c 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -43,6 +43,9 @@ enum {
>          #define CLEAR_RECORDS   0x1
>          #define GET_INTERRUPT_POLICY   0x2
>          #define SET_INTERRUPT_POLICY   0x3
> +    TIMESTAMP   =3D 0x03,
> +        #define GET           0x0
> +        #define SET           0x1
>  };
>=20=20
>  /* 8.2.8.4.5.1 Command Return Codes */
> @@ -117,8 +120,11 @@ define_mailbox_handler_zeroed(EVENTS_GET_RECORDS, 0x=
20);
>  define_mailbox_handler_nop(EVENTS_CLEAR_RECORDS);
>  define_mailbox_handler_zeroed(EVENTS_GET_INTERRUPT_POLICY, 4);
>  define_mailbox_handler_nop(EVENTS_SET_INTERRUPT_POLICY);
> +declare_mailbox_handler(TIMESTAMP_GET);
> +declare_mailbox_handler(TIMESTAMP_SET);
>=20=20
>  #define IMMEDIATE_CONFIG_CHANGE (1 << 1)
> +#define IMMEDIATE_POLICY_CHANGE (1 << 3)
>  #define IMMEDIATE_LOG_CHANGE (1 << 4)
>=20=20
>  #define CXL_CMD(s, c, in, cel_effect) \
> @@ -129,10 +135,57 @@ static struct cxl_cmd cxl_cmd_set[256][256] =3D {
>      CXL_CMD(EVENTS, CLEAR_RECORDS, ~0, IMMEDIATE_LOG_CHANGE),
>      CXL_CMD(EVENTS, GET_INTERRUPT_POLICY, 0, 0),
>      CXL_CMD(EVENTS, SET_INTERRUPT_POLICY, 4, IMMEDIATE_CONFIG_CHANGE),
> +    CXL_CMD(TIMESTAMP, GET, 0, 0),
> +    CXL_CMD(TIMESTAMP, SET, 8, IMMEDIATE_POLICY_CHANGE),
>  };
>=20=20
>  #undef CXL_CMD
>=20=20
> +/*
> + * 8.2.9.3.1
> + */
> +define_mailbox_handler(TIMESTAMP_GET)
> +{
> +    struct timespec ts;
> +    uint64_t delta;
> +
> +    if (!cxl_dstate->timestamp.set) {
> +        *(uint64_t *)cmd->payload =3D 0;
> +        goto done;
> +    }
> +
> +    /* First find the delta from the last time the host set the time. */
> +    clock_gettime(CLOCK_REALTIME, &ts);

Could you consider using qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL)?
Otherwise by introducing a dependency on real time you'll loose the
ability to get deterministic execution via icount.=20

> +    delta =3D (ts.tv_sec * NANOSECONDS_PER_SECOND + ts.tv_nsec) -
> +            cxl_dstate->timestamp.last_set;
> +
> +    /* Then adjust the actual time */
> +    stq_le_p(cmd->payload, cxl_dstate->timestamp.host_set + delta);
> +
> +done:
> +    *len =3D 8;
> +    return CXL_MBOX_SUCCESS;
> +}
> +
> +/*
> + * 8.2.9.3.2
> + */
> +define_mailbox_handler(TIMESTAMP_SET)
> +{
> +    struct timespec ts;
> +
> +    clock_gettime(CLOCK_REALTIME, &ts);
> +
> +    cxl_dstate->timestamp.set =3D true;
> +    cxl_dstate->timestamp.last_set =3D
> +        ts.tv_sec * NANOSECONDS_PER_SECOND + ts.tv_nsec;
> +
> +    cxl_dstate->timestamp.host_set =3D le64_to_cpu(*(uint64_t *)cmd->pay=
load);
> +
> +    *len =3D 0;
> +    return CXL_MBOX_SUCCESS;
> +}
> +
>  QemuUUID cel_uuid;
>=20=20
>  void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index f88f844cb6..3dde7fb1fb 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -114,6 +114,12 @@ typedef struct cxl_device_state {
>          size_t cel_size;
>      };
>=20=20
> +    struct {
> +        bool set;
> +        uint64_t last_set;
> +        uint64_t host_set;
> +    } timestamp;
> +
>      /* memory region for persistent memory, HDM */
>      uint64_t pmem_size;
>  } CXLDeviceState;


--=20
Alex Benn=C3=A9e
