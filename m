Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B04E4C6FD1D
	for <linux-cxl@archiver.kernel.org>; Mon, 20 Mar 2023 17:44:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjCTRoR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 20 Mar 2023 13:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjCTRnp (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 20 Mar 2023 13:43:45 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5109AEC53;
        Mon, 20 Mar 2023 10:39:40 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id b20so16923318edd.1;
        Mon, 20 Mar 2023 10:39:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679333678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fi1OHs7Bk8TJ5UregfyVR/fDxL3BggpeJfKVN6kZ4QI=;
        b=WfPGmMEhsdSw0Eweit5k38GR7P+DeAopYpE5u6v1Xa5tbYfywacQR9zsnb0nZgXm2R
         iwwbFQkywh1gV0b2gLMSdZZW4zdpJRMgO+0Y1eZIk/5wHUQmwe6lyYyEjvhrZfRhhd07
         74xPxeENge83u2taa8wiUzyRXBZaO3Sk8qruAHmiyz4KhSMRShuiJ6eDPWEl+lYQB0gp
         vpMMFD4oyuJjGZY/9Hr/VM99BCveHisjcDWEHa2/Ns/2zb+emSOIua5V/5dYc5G1ErMd
         VsIW7/+dI9ONJNXbJ+DvLqR2fww41tAtijFuBBQbls4Zubr+5+OHe0wxwj604DU0gyOd
         xjIA==
X-Gm-Message-State: AO0yUKWJXnIlXgLWBApFZ8+1JbDSOXQygSipa3hBNj3mwnVAc45Aq/kU
        EzILEtDdasquQwZ11vtvI2FxoqO40/+S46CZRo6HYm9k
X-Google-Smtp-Source: AK7set8VIdb1Yu9eY0D5QYIlbOBWUwqbQOyN3a6t4VASfDsjzfQEnk526Z7QjD0NaX1RghsJpAdGThjMbg73BPPMyYI=
X-Received: by 2002:a17:906:1b4e:b0:930:310:abcf with SMTP id
 p14-20020a1709061b4e00b009300310abcfmr4702624ejg.2.1679333678504; Mon, 20 Mar
 2023 10:34:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230314004611.48583-1-tony.luck@intel.com>
In-Reply-To: <20230314004611.48583-1-tony.luck@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 20 Mar 2023 18:34:27 +0100
Message-ID: <CAJZ5v0hNQUfWViqxbJ5B4JCGJUuHpWWSpqpCFWPNpGuagoFbsQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: APEI: EINJ: Add CXL error types
To:     Tony Luck <tony.luck@intel.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Mar 14, 2023 at 1:47 AM Tony Luck <tony.luck@intel.com> wrote:
>
> ACPI 6.5 added six new error types for CXL. See chapter 18
> table 18.30.
>
> Add strings for the new types so that Linux will list them in the
> /sys/kernel/debug/apei/einj/available_error_types file.
>
> It seems no other changes are needed. Linux already accepts
> the CXL codes (on a BIOS that advertises them).
>
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  drivers/acpi/apei/einj.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
> index b4373e575660..39bee5a067cc 100644
> --- a/drivers/acpi/apei/einj.c
> +++ b/drivers/acpi/apei/einj.c
> @@ -584,6 +584,12 @@ static const char * const einj_error_type_string[] = {
>         "0x00000200\tPlatform Correctable\n",
>         "0x00000400\tPlatform Uncorrectable non-fatal\n",
>         "0x00000800\tPlatform Uncorrectable fatal\n",
> +       "0x00001000\tCXL.cache Protocol Correctable\n",
> +       "0x00002000\tCXL.cache Protocol Uncorrectable non-fatal\n",
> +       "0x00004000\tCXL.cache Protocol Uncorrectable fatal\n",
> +       "0x00008000\tCXL.mem Protocol Correctable\n",
> +       "0x00010000\tCXL.mem Protocol Uncorrectable non-fatal\n",
> +       "0x00020000\tCXL.mem Protocol Uncorrectable fatal\n",
>  };
>
>  static int available_error_type_show(struct seq_file *m, void *v)
> --

Applied as 6.4 material, thanks!
