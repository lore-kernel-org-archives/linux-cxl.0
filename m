Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87ECCC433EF
	for <linux-cxl@archiver.kernel.org>; Fri, 29 Oct 2021 20:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6385E60F55
	for <linux-cxl@archiver.kernel.org>; Fri, 29 Oct 2021 20:29:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbhJ2Ub3 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 29 Oct 2021 16:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhJ2Ub3 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 29 Oct 2021 16:31:29 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774C5C061570
        for <linux-cxl@vger.kernel.org>; Fri, 29 Oct 2021 13:29:00 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 75so10938072pga.3
        for <linux-cxl@vger.kernel.org>; Fri, 29 Oct 2021 13:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yyFgcTAGe16d4H+C3MugXBIqtCEWG0ejJLtCzewvNUA=;
        b=umiw5lNcOqMhNmy29Pstgzh4+jm01M915UNK4SqKSQqk43AYVd6YtPy1yWQNKBHplJ
         GpyZC9PvGJK025lfqsUlhorADR938EHLmG6OSigwcwhGoif9J0p4mRrBjT8N6itnIe2l
         BohBQGvcYbGrc0chcagLFZCY6D968yA/Lho7+QL7cgj5Qyt0pFsEKNyKlaZMYKceJzTU
         /Zx5NZ85vnM7GrGVsst2cl8dcUPgxA5B5Ibs5+KZt9IumMxYy0lf0tYEaqNteUUlsk7g
         JdVXq1Al3sRZhIH1aDGYORhsKS6MzygsBxG3nQ3tRbcGa4jSvbYCFdyC1Q7Ahrs1yDUD
         B3BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yyFgcTAGe16d4H+C3MugXBIqtCEWG0ejJLtCzewvNUA=;
        b=i27NvUpMJlTFKOkvZ4rWN63sk2gm9PtXuJ7eG2f13GGTm1FCExY26XAYbPuNDFxX+B
         2nDIogIjQQsmZhJdGjtheuaCfpnHwdoERKCx8oIjkKpzdGn9XdBNlGlJfAhTjhSNZo8F
         AujPmdmiG0gqPYRPAPiZ4Y+gFNp7AJ+oyNayLA9n/iP4RutdNE2n52qSg5jsdcJ3dXnP
         knIK8lrDZsFIA6+rgEngSd/8tWNgX3Hcs2t+wnmkzCgo3AQ2XxzeE9R/zj+1fTZpcDdF
         +BtcApazJK3qSsiHici5vk4i5fSudq0Q6kQXxE8SyVJOU2wM6bvpNFYgLyfeHu32ZKIm
         r4TQ==
X-Gm-Message-State: AOAM532zdeU4bza9E+R6UJIYNh/Yabuf7MhTtu6g7HT8/IKNx2qJupbn
        ByEWsGmO7yY2DJ+D3lWgI7ulT9WWWb8RoMSkA0Z5eg==
X-Google-Smtp-Source: ABdhPJzs2MyOUD1+pbk9TclO/QoQgSkiaNPAeGM39lOQtNZKWEak0zDG5XA8/+95JBxjUS4ZpT0Kbz2NJ76JtDDouMQ=
X-Received: by 2002:a63:6bc2:: with SMTP id g185mr9767035pgc.356.1635539339870;
 Fri, 29 Oct 2021 13:28:59 -0700 (PDT)
MIME-Version: 1.0
References: <20211022183709.1199701-1-ben.widawsky@intel.com> <20211022183709.1199701-4-ben.widawsky@intel.com>
In-Reply-To: <20211022183709.1199701-4-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 29 Oct 2021 13:28:47 -0700
Message-ID: <CAPcyv4i84xXqNV_V-D9JHNqsVcPyfDGQ-w3t26+aCTUfVRp2tw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 03/28] cxl/acpi: Map component registers for Root Ports
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
> With the addition of cxl_find_register_block() in cxl_core, it becomes
> trivial to complete the TODO left for mapping the component registers of
> root ports. None of the CXL drivers currently use component registers of
> downstream ports (which is what a CXL 2.0 Root Port is). As such, there
> should be no functional change.

Oh, I forgot that cxl_acpi had this todo, I think it would be best to
fold this with the previous patch so that it makes a complete story.

>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---
>  drivers/cxl/acpi.c | 10 ++++++++--
>  drivers/cxl/pci.h  |  4 ++++
>  2 files changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index af1c6c1875ac..7d13e7f0aefc 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -7,6 +7,7 @@
>  #include <linux/acpi.h>
>  #include <linux/pci.h>
>  #include "cxl.h"
> +#include "pci.h"
>
>  static struct acpi_table_header *acpi_cedt;
>
> @@ -206,11 +207,13 @@ static resource_size_t get_chbcr(struct acpi_cedt_chbs *chbs)
>
>  __mock int match_add_root_ports(struct pci_dev *pdev, void *data)
>  {
> +       resource_size_t creg = CXL_RESOURCE_NONE;
>         struct cxl_walk_context *ctx = data;
>         struct pci_bus *root_bus = ctx->root;
>         struct cxl_port *port = ctx->port;
>         int type = pci_pcie_type(pdev);
>         struct device *dev = ctx->dev;
> +       struct cxl_register_map map;
>         u32 lnkcap, port_num;
>         int rc;
>
> @@ -224,9 +227,12 @@ __mock int match_add_root_ports(struct pci_dev *pdev, void *data)
>                                   &lnkcap) != PCIBIOS_SUCCESSFUL)
>                 return 0;
>
> -       /* TODO walk DVSEC to find component register base */
> +       rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
> +       if (!rc)
> +               creg = cxl_reg_block(pdev, &map);
> +
>         port_num = FIELD_GET(PCI_EXP_LNKCAP_PN, lnkcap);
> -       rc = cxl_add_dport(port, &pdev->dev, port_num, CXL_RESOURCE_NONE);
> +       rc = cxl_add_dport(port, &pdev->dev, port_num, creg);
>         if (rc) {
>                 ctx->error = rc;
>                 return rc;
> diff --git a/drivers/cxl/pci.h b/drivers/cxl/pci.h
> index 7d3e4bf06b45..12fdcb1b14e5 100644
> --- a/drivers/cxl/pci.h
> +++ b/drivers/cxl/pci.h
> @@ -31,4 +31,8 @@ enum cxl_regloc_type {
>  #define CXL_REGLOC_RBI_MASK GENMASK(15, 8)
>  #define CXL_REGLOC_ADDR_MASK GENMASK(31, 16)
>
> +#define cxl_reg_block(pdev, map)                                               \
> +       ((resource_size_t)(pci_resource_start(pdev, (map)->barno) +            \
> +                          (map)->block_offset))
> +
>  #endif /* __CXL_PCI_H__ */
> --
> 2.33.1
>
