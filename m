Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A90C433EF
	for <linux-cxl@archiver.kernel.org>; Tue,  1 Mar 2022 15:58:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234530AbiCAP65 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 1 Mar 2022 10:58:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232484AbiCAP65 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 1 Mar 2022 10:58:57 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA8D2655E
        for <linux-cxl@vger.kernel.org>; Tue,  1 Mar 2022 07:58:15 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id d10so32369090eje.10
        for <linux-cxl@vger.kernel.org>; Tue, 01 Mar 2022 07:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=mBA1nrxC2djQfaZpzWM/GlJwzw7WlqUdtrz34aLHs7k=;
        b=qM4vqZpm0X4RD+mmCvA12But+9ZUotM8A+cXFcivf/Vjlqy/oPavIkX7ssZd+/R047
         vrFXPjoN+J0sqJeiwyrLdlm/bPsOtEzhyavnviFBY7E+FK8DqZlYZuYmXLxO93p578TL
         quJHEbhVoybiGfToaf3FfqTTfS/XA30SxDqIiWsQcBMzJHviRctzd9XnpcSA6fANk6bU
         VuWAJvqlqbo4XX8VU76EQUHoxCN0ib4nJPNvV4sG1V2/BTUUfj1TaCLuIQkTLNzd1PGD
         C2ZJrRZf+vFls6wMecqa/1nKOEKcJk8JM9KFOVUi2eXJutyh67FWueIHvcgJBcaRws9y
         CvlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=mBA1nrxC2djQfaZpzWM/GlJwzw7WlqUdtrz34aLHs7k=;
        b=43n3T8eKFjYxUclQqhkNCMEwCbDgcDBOakGjI8rRVMdRzYfuJNP2jlheEnLT+wWSR9
         vMZStpCpBfrUg8+yayUFZimqltcQdTQKnVJzen8nQ/iaLANT+Dkmc/nLgdFD7s3ln/hc
         Fv0KD3VCCTvnZStLyCBgSqoJywpikW1zQ3X1toDX/XqIzwK5HssTTrbCCAR2r/VMMi8h
         DRWUySZ+k74hEHsEDVYCF+f+f1jmk7NlXYp/wRxY4RGVC3fvZaNitk5X/MBeoIwNbmh6
         2pgHNtJhEUIpPpyWQKsjP2k+n+mddTC6pdnkNaIHgwtHT0EklfuwIemFSjbkufAOGfQi
         eAQA==
X-Gm-Message-State: AOAM533lwDbhcVadVg35e2MGzCORBbos+0s1krOkWDVqrD3/w+sswmir
        Jl5kv3xdT2AwYJj2WI46RCUbSQ==
X-Google-Smtp-Source: ABdhPJySCdtzG5JKLMgmRecBIfVd9iUewRfAxR/jmTC9RiwKvRhrydkkK9XRtKfsmDyzEmvR27IV7g==
X-Received: by 2002:a17:906:36ce:b0:6d6:e540:ed65 with SMTP id b14-20020a17090636ce00b006d6e540ed65mr2862826ejc.330.1646150293918;
        Tue, 01 Mar 2022 07:58:13 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
        by smtp.gmail.com with ESMTPSA id ov6-20020a170906fc0600b006cf54ef58ddsm5523747ejb.149.2022.03.01.07.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 07:58:12 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
        by zen.linaroharston (Postfix) with ESMTP id DE88B1FFB7;
        Tue,  1 Mar 2022 15:58:11 +0000 (GMT)
References: <20220211120747.3074-1-Jonathan.Cameron@huawei.com>
 <20220211120747.3074-10-Jonathan.Cameron@huawei.com>
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
Subject: Re: [PATCH v6 09/43] hw/cxl/device: Timestamp implementation (8.2.9.3)
Date:   Tue, 01 Mar 2022 15:54:20 +0000
In-reply-to: <20220211120747.3074-10-Jonathan.Cameron@huawei.com>
Message-ID: <8735k1mzqk.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:

> From: Ben Widawsky <ben.widawsky@intel.com>
>
> Errata F4 to CXL 2.0 clarified the meaning of the timer as the
> sum of the value set with the timestamp set command and the number
> of nano seconds since it was last set.
>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  hw/cxl/cxl-mailbox-utils.c  | 44 +++++++++++++++++++++++++++++++++++++
>  include/hw/cxl/cxl_device.h |  6 +++++
>  2 files changed, 50 insertions(+)
>
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 8aa1b1e525..258285ab03 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -44,6 +44,9 @@ enum {
>          #define CLEAR_RECORDS   0x1
>          #define GET_INTERRUPT_POLICY   0x2
>          #define SET_INTERRUPT_POLICY   0x3
> +    TIMESTAMP   =3D 0x03,
> +        #define GET           0x0
> +        #define SET           0x1
>  };
>=20=20
>  /* 8.2.8.4.5.1 Command Return Codes */
> @@ -106,9 +109,48 @@ DEFINE_MAILBOX_HANDLER_NOP(events_clear_records);
>  DEFINE_MAILBOX_HANDLER_ZEROED(events_get_interrupt_policy, 4);
>  DEFINE_MAILBOX_HANDLER_NOP(events_set_interrupt_policy);
>=20=20
> +/* 8.2.9.3.1 */
> +static ret_code cmd_timestamp_get(struct cxl_cmd *cmd,
> +                                  CXLDeviceState *cxl_dstate,
> +                                  uint16_t *len)
> +{
> +    uint64_t time, delta;
> +
> +    if (!cxl_dstate->timestamp.set) {
> +        *(uint64_t *)cmd->payload =3D 0;
> +        goto done;
> +    }
> +
> +    /* First find the delta from the last time the host set the time. */
> +    time =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> +    delta =3D time - cxl_dstate->timestamp.last_set;
> +
> +    /* Then adjust the actual time */
> +    stq_le_p(cmd->payload, cxl_dstate->timestamp.host_set + delta);
> +
> +done:

Again I think an unnecessary goto for want of:

 uin64_t final_time =3D 0;
 if (cxl_dstate->timestamp.set) {
    /* First find the delta from the last time the host set the time. */
    time =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
    delta =3D time - cxl_dstate->timestamp.last_set;
    final_time =3D cxl_dstate->timestamp.host_set + delta;
 }

 /* Then adjust the actual time */
 stq_le_p(cmd->payload, final_time);


> +    *len =3D 8;
> +    return CXL_MBOX_SUCCESS;
> +}
> +
> +/* 8.2.9.3.2 */
> +static ret_code cmd_timestamp_set(struct cxl_cmd *cmd,
> +                                  CXLDeviceState *cxl_dstate,
> +                                  uint16_t *len)
> +{
> +    cxl_dstate->timestamp.set =3D true;
> +    cxl_dstate->timestamp.last_set =3D qemu_clock_get_ns(QEMU_CLOCK_VIRT=
UAL);
> +
> +    cxl_dstate->timestamp.host_set =3D le64_to_cpu(*(uint64_t *)cmd->pay=
load);
> +
> +    *len =3D 0;
> +    return CXL_MBOX_SUCCESS;
> +}
> +
>  static QemuUUID cel_uuid;
>=20=20
>  #define IMMEDIATE_CONFIG_CHANGE (1 << 1)
> +#define IMMEDIATE_POLICY_CHANGE (1 << 3)
>  #define IMMEDIATE_LOG_CHANGE (1 << 4)
>=20=20
>  static struct cxl_cmd cxl_cmd_set[256][256] =3D {
> @@ -120,6 +162,8 @@ static struct cxl_cmd cxl_cmd_set[256][256] =3D {
>          cmd_events_get_interrupt_policy, 0, 0 },
>      [EVENTS][SET_INTERRUPT_POLICY] =3D { "EVENTS_SET_INTERRUPT_POLICY",
>          cmd_events_set_interrupt_policy, 4, IMMEDIATE_CONFIG_CHANGE },
> +    [TIMESTAMP][GET] =3D { "TIMESTAMP_GET", cmd_timestamp_get, 0, 0 },
> +    [TIMESTAMP][SET] =3D { "TIMESTAMP_SET", cmd_timestamp_set, 8, IMMEDI=
ATE_POLICY_CHANGE },
>  };
>=20=20
>  void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index 7fd8d0f616..8102d2a813 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -117,6 +117,12 @@ typedef struct cxl_device_state {
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

Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
