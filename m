Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF3A7C433EF
	for <linux-cxl@archiver.kernel.org>; Thu,  7 Oct 2021 21:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B357760F51
	for <linux-cxl@archiver.kernel.org>; Thu,  7 Oct 2021 21:48:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238388AbhJGVuO (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 7 Oct 2021 17:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234061AbhJGVuN (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 7 Oct 2021 17:50:13 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36531C061570
        for <linux-cxl@vger.kernel.org>; Thu,  7 Oct 2021 14:48:19 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id w14so4849491pll.2
        for <linux-cxl@vger.kernel.org>; Thu, 07 Oct 2021 14:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LqeeWLBdEMen7maIkjY/4J3flhMXzCDb/t8RnZTgiWU=;
        b=pR2KEE6RusCXx+MklNSFuPy5EjwmLnPKJSO56R7Unu8UF1R23J8MsXwSngK7Fo5PNC
         CxU7aEC3XS1xBlsIXw0b9BNQQeoKTi3goxK87LNC/9kyPqHG4RI/4PsREs/LP6kOmzyK
         xw4g7gY2JX1wKWJiolaUCY+0FT0zTafJjSYBUeTbvCf2LuOn2LNhn9hGYMHg07bJwQtN
         9gLCIUU4T1carFYqjq+NBo4IHZOae3/Q8KlogDAxjK+wOzHPWhzF6t06s1St7lMD3sNc
         X8dt7IPKXhl+t12628zBCJvMyi3PzfMawKTYer4d8ej9qD1TEAQgninZQ0tHgFWjfxww
         Oftw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LqeeWLBdEMen7maIkjY/4J3flhMXzCDb/t8RnZTgiWU=;
        b=Joc6gGubChW848KsaTqCPyrrfUS5k1h0k93M9dbPkD1SNBxpSHM8W1N4CziOyUA0lL
         +K1uzRIDI0/vUQCMy25IMu1p3rE8aBxh5M+5X6t4I8GhoqCPiwEeSFCLf+dwm8M8w81B
         SNYrQeJN+EUbAYhSXTJQSc79/vvUBl966ubvSvbiV+d5PcCFGcDrlmhRD6UYddQ8/Mpa
         XjXDOqXgKB1DApwXxjDMk05yfLaYDBKNZhmdOtoJgOz4bJz28FDi27Byk90ujWjtV152
         Vi3c3+q9T/BwHj4rT/0FIrG3JmH9zP0BYndF6LZDSCdJ5Rt9JzV3j0jn4G3pWnJHIgTO
         K0rg==
X-Gm-Message-State: AOAM530N/rBjwnAG0K3pL0CDHsdRhAMcOCMI8Au75yJmJvLoWLNN11a2
        Y3UEbNAI2eVdwnj+etKKHhMvQUM2LD7EuNHrDBH1ZDDnJEcQtQ==
X-Google-Smtp-Source: ABdhPJwEfGlgqs9GpAtE1nL1rleHgffGs26xk6wfUx5NmJOSyu/q5c1ZnhkuPQXsLt9mvCozcqrdYKbTLDZhbw/sJzE=
X-Received: by 2002:a17:90a:d686:: with SMTP id x6mr8218128pju.8.1633643298600;
 Thu, 07 Oct 2021 14:48:18 -0700 (PDT)
MIME-Version: 1.0
References: <20211007204753.3321681-1-vishal.l.verma@intel.com>
In-Reply-To: <20211007204753.3321681-1-vishal.l.verma@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 7 Oct 2021 14:48:07 -0700
Message-ID: <CAPcyv4jJmGB3kkAfNp1fF=MDpHFdx_6kt+xCN5BJrk+HNSs_BA@mail.gmail.com>
Subject: Re: [PATCH] tools/testing/cxl: add mock output for the
 GET_HEALTH_INFO command
To:     Vishal Verma <vishal.l.verma@intel.com>
Cc:     linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Oct 7, 2021 at 1:48 PM Vishal Verma <vishal.l.verma@intel.com> wrote:
>
> Add mocked health information for cxl_test memdevs. This allows
> cxl-cli's 'list' command to display the canned health_info fields.
>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---
>  drivers/cxl/cxlmem.h         | 12 ++++++++++++
>  tools/testing/cxl/test/mem.c | 24 ++++++++++++++++++++++++
>  2 files changed, 36 insertions(+)
>
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index c4f450ad434d..c7957cce8e8b 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -228,6 +228,18 @@ struct cxl_mbox_set_lsa {
>         u8 data[];
>  } __packed;
>
> +/* See CXL 2.0 Table 181 Get Health Info Output Payload */
> +struct cxl_mbox_health_info {
> +       u8 health_status;
> +       u8 media_status;
> +       u8 ext_status;
> +       u8 life_used;
> +       __le16 temperature;
> +       __le32 dirty_shutdowns;
> +       __le32 volatile_errors;
> +       __le32 pmem_errors;
> +} __packed;

I think this one can be local to tools/testing/cxl/test/mem.c unless /
until the driver has a reason to issue this command itself, but I
think I want to keep the expectation that the kernel just notifies
userspace about health changes, it never ingests / polls that data
itself. Otherwise if this definition is going to be in the kernel code
proper I think it would want some definitions for those status fields,
but let's skip all that and move this into tools/testing/.

> +
>  /**
>   * struct cxl_mem_command - Driver representation of a memory device command
>   * @info: Command information as it exists for the UAPI
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index 12a8437a9ca0..bd707e83a3e9 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -28,6 +28,10 @@ static struct cxl_cel_entry mock_cel[] = {
>                 .opcode = cpu_to_le16(CXL_MBOX_OP_SET_LSA),
>                 .effect = cpu_to_le16(EFFECT(1) | EFFECT(2)),
>         },
> +       {
> +               .opcode = cpu_to_le16(CXL_MBOX_OP_GET_HEALTH_INFO),
> +               .effect = cpu_to_le16(0),
> +       },
>  };
>
>  static struct {
> @@ -156,6 +160,23 @@ static int mock_set_lsa(struct cxl_mem *cxlm, struct cxl_mbox_cmd *cmd)
>         return 0;
>  }
>
> +static int mock_health_info(struct cxl_mem *cxlm, struct cxl_mbox_cmd *cmd)
> +{
> +       struct cxl_mbox_health_info health_info = {
> +               .health_status = 0x7,
> +               .media_status = 0x3,
> +               .ext_status = 0x18,

Might be nice to comment what these mean so someone at a glance can
compare it to the cxl list output. Extra credit for adding #defines,
but I don't think that's necessary.


> +               .life_used = 15,
> +               .temperature = cpu_to_le16(25),
> +               .dirty_shutdowns = cpu_to_le16(10),
> +               .volatile_errors = cpu_to_le16(20),
> +               .pmem_errors = cpu_to_le16(30),
> +       };

Perhaps a:

        if (cmd->size_out < sizeof(health_info))
                return -EINVAL;

...to make the static analyzers and match the other mock routines.

Otherwise, looks good.

> +
> +       memcpy(cmd->payload_out, &health_info, sizeof(health_info));
> +       return 0;
> +}
> +
>  static int cxl_mock_mbox_send(struct cxl_mem *cxlm, struct cxl_mbox_cmd *cmd)
>  {
>         struct device *dev = cxlm->dev;
> @@ -177,6 +198,9 @@ static int cxl_mock_mbox_send(struct cxl_mem *cxlm, struct cxl_mbox_cmd *cmd)
>         case CXL_MBOX_OP_SET_LSA:
>                 rc = mock_set_lsa(cxlm, cmd);
>                 break;
> +       case CXL_MBOX_OP_GET_HEALTH_INFO:
> +               rc = mock_health_info(cxlm, cmd);
> +               break;
>         default:
>                 break;
>         }
>
> base-commit: ed97afb53365cd03dde266c9644334a558fe5a16
> --
> 2.31.1
>
