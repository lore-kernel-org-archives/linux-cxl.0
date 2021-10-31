Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1745C433EF
	for <linux-cxl@archiver.kernel.org>; Sun, 31 Oct 2021 19:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB69B60FBF
	for <linux-cxl@archiver.kernel.org>; Sun, 31 Oct 2021 19:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbhJaT2R (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 31 Oct 2021 15:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbhJaT2Q (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 31 Oct 2021 15:28:16 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB373C061570
        for <linux-cxl@vger.kernel.org>; Sun, 31 Oct 2021 12:25:43 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id f5so15251194pgc.12
        for <linux-cxl@vger.kernel.org>; Sun, 31 Oct 2021 12:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SwYKPUAwH4d9hoh4m3m40XNrW/qaizJYLA7NxjoFooM=;
        b=b+zVEGjfswNiRWFGJacAe09PKFaBe3jYo2D/3F7O3vnKjwiY+SQlordfK4Uh/WHdiD
         LW/Jkr2YirZV1f/1O8gZzEeMTPvvIlr+VVbjA22VBUQu5LMllVGlu0aILH8WhqjsxYg/
         yWQSkJz9jVdy4bdOThKuIkT7c3MavGYjgCT6dYn9OM8Oc4wLKaW1DGm0VRPW/mXdoLVV
         J9sBygoxU0S+rzfgjnJW41SGfWB2uiuBClwL4vMYPLhkRYpn0QbD17aBZCo3usfem/uh
         FWBy/D8l5u1V/aXnafK5BwZlhxU7Vc9rsuQ8m7IeJ7l5JQY/eULEVYzmnGY7tZLugVmD
         zWhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SwYKPUAwH4d9hoh4m3m40XNrW/qaizJYLA7NxjoFooM=;
        b=lo0Vl53JF4qwBNvDE/wOW4zXaJwYAtNuhukiJbkPrcXNZQbUI0JwRnmXyUFX9Nw0xe
         3UlvmEbfrAO02SPjZeawb90+lrVDfkIwKZliWMZyW3fJglhYJQs743A7Iwoh/jzVnX2X
         Ip3dGXSntwovRKRpk7BdeS9HBZ4S7vvYPxCDa6f1zkdOzbKX4d3abPrG6DVsF6RsUKv6
         QUflzBIZWOuhUSW4ywL9CcohAtZOFrU9VtpgBhRL99HcVKLoLlfn9gbEy58fBrjs0u+h
         oT4hsXldYr+fcL7hq+Dvw9Po40MrMudUI3P/1Y+wR86RYVV77ZL3aWB5cSPJPv/s/Qdl
         HmWg==
X-Gm-Message-State: AOAM532Cd9fiY8+izs0rJbx+vD4+oox4zy/rnujPC6CP42sopOy7DNQL
        GRXUaEYpBdpZ/IF6fv7DI+bUKf3tmb9FKJNym97c5g==
X-Google-Smtp-Source: ABdhPJz/Q5myAQb+tsBXAIbaHA5cEb+JNpKppyQAUowibhMjwQvLA8Sa+wsBsIngv/UdTAcQv5XD06YEX8C1IZwx0aM=
X-Received: by 2002:aa7:8019:0:b0:44d:d761:6f79 with SMTP id
 j25-20020aa78019000000b0044dd7616f79mr24337289pfi.3.1635708343195; Sun, 31
 Oct 2021 12:25:43 -0700 (PDT)
MIME-Version: 1.0
References: <20211022183709.1199701-1-ben.widawsky@intel.com> <20211022183709.1199701-12-ben.widawsky@intel.com>
In-Reply-To: <20211022183709.1199701-12-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sun, 31 Oct 2021 12:25:32 -0700
Message-ID: <CAPcyv4jm3Hp_XYkQiNYvwhF-S6-3k4qvs-a=4zS1YKukne1dnQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 11/28] cxl/acpi: Rescan bus at probe completion
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, Chet Douglas <chet.r.douglas@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Oct 22, 2021 at 11:37 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> Ensure that devices being probed before cxl_acpi has completed will get
> a second chance.

I think this is at the wrong level... more below.
>
> CXL drivers are brought up through two enumerable, asynchronous
> mechanism. The leaf nodes in the CXL topology, endpoints, are enumerated
> via PCI headers. The root node's enumeration is platform specific. The
> current defacto mechanism for enumerating the root node is through the
> presence of an ACPI device, ACPI0017.
>
> The primary job of a cxl_mem driver is to determine if CXL.mem traffic
> can be routed to/from the PCIe device that it is being probed. A
> prerequisite in this determination is that all CXL components in the
> path from root to leaf are capable of routing CXL.mem traffic. If the
> cxl_mem driver is probed before cxl_acpi is complete the driver will be
> unable to make this determination. To address this, cxl_acpi (or in the
> future, another platform specific driver) will rescan all devices to
> make sure the ordering is correct.
>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---
>  drivers/cxl/acpi.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 625c5d95b83f..1cc3a74c16bd 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -451,6 +451,14 @@ static u32 cedt_instance(struct platform_device *pdev)
>         return U32_MAX;
>  }
>
> +static void bus_rescan(struct work_struct *work)
> +{
> +       if (bus_rescan_devices(&cxl_bus_type))
> +               pr_err("Failed to rescan CXL bus\n");
> +}
> +
> +static DECLARE_WORK(deferred_bus_rescan, bus_rescan);
> +
>  static int cxl_acpi_probe(struct platform_device *pdev)
>  {
>         int rc;
> @@ -484,9 +492,19 @@ static int cxl_acpi_probe(struct platform_device *pdev)
>         if (rc)
>                 goto out;
>
> -       if (IS_ENABLED(CONFIG_CXL_PMEM))
> +       if (IS_ENABLED(CONFIG_CXL_PMEM)) {
>                 rc = device_for_each_child(&root_port->dev, root_port,
>                                            add_root_nvdimm_bridge);
> +               if (rc)
> +                       goto out;
> +       }
> +
> +       /*
> +        * While ACPI is scanning hostbridge ports, switches and memory devices
> +        * may have been probed. Those devices will need to know whether the
> +        * hostbridge is CXL capable.
> +        */
> +       schedule_work(&deferred_bus_rescan);

I think this belongs in port driver similar to the one in
drivers/cxl/pmem.c, because any port online event might mean that a
downstream port can now attach to the port driver. I prefer a local
ordered workqueue via queue_work() rather than the global unordered
workqueue primarily because it can be flushed without getting
entangled with other random work in the system, but also because the
ordered property is useful for comprehended hierarchical topology
events.

In any event this is missing flushing to prevent races between .text
removal at module_exit() and pending work.
