Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B182C433E0
	for <linux-cxl@archiver.kernel.org>; Sat, 30 Jan 2021 23:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58F3B64E1C
	for <linux-cxl@archiver.kernel.org>; Sat, 30 Jan 2021 23:52:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232280AbhA3Xwi (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sat, 30 Jan 2021 18:52:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbhA3XwV (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sat, 30 Jan 2021 18:52:21 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF95C06174A
        for <linux-cxl@vger.kernel.org>; Sat, 30 Jan 2021 15:51:41 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id u11so7878360plg.13
        for <linux-cxl@vger.kernel.org>; Sat, 30 Jan 2021 15:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=cxvqbAo1IAIrwLB5kk+h8Luaw/WcNq7od57uwR/z/0A=;
        b=PjLjww8QTw6X6rVMAjtISyXtX7JMmqVaUJx3F60RM3ylFSLWRRcZCFrQlsjCSBGBqx
         Oj3eIeIel+lx5s/2LzA2cqzsOlBvs+jrSV4AXQBePenX9TqRNh4fBF2xa1vy/ZURdeOn
         +lhC0/eWjRwZcBS/1uE7a0/fxUpCmQEsIlkvVUw8XTrYgT7HEkD84ilH2PhECtGuizOl
         3L/Qf/himoTN1JGUyeYCivImS0tAyPYb9OeJvkMbXST578xzSCdUkQFxivOMQrwZRtAE
         nxCiaSxwoehw8rIP5fQZOuvdxKVzXZHozdLwXh4cjAQrPf6k9Zf1rWPHmWo72HtJywGU
         U2Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=cxvqbAo1IAIrwLB5kk+h8Luaw/WcNq7od57uwR/z/0A=;
        b=VfFQAa9iGpRHDboJwZVaBssln35R+xpU+aZEbubVzXLyPj9x+tLBX01JjQaq+J8Jn4
         jucZLQ000CvyMiyNG0RWVpGIcGThf97HuBP252ac1sOM8zZ7YwZZ8DL5p3inLXGGHcPN
         8kNBL26tFIXBLYhTLkendaNNWARD5CjK1OKT96JgxYNGCLut5K5aFFW6Mx8MuTTcprQE
         YSiuGDB/YUPyb4F2lIBoSwRP2XjYtuAJSDYj3aJtAZFOWYeTdkY20u7G7mb/S7Ie5aAw
         jW8wHY0kyDzcybmRictScNA5rzCivmzY7LV38aAgv5bgV3d+KkSPBlTtYNDqboSiQ2eA
         S16w==
X-Gm-Message-State: AOAM531pJkJyA0J3YdN9b86pZ+qUYTNdLgXBRoqGA/GRdd46jWbg18Qg
        YbymDeJtV1aKIAGqvIWXKlGzZLgR2u1vlw==
X-Google-Smtp-Source: ABdhPJyDODycXpp/h5ITu3myrcAhtELZTjRYPPBKofKsdhKWkycX4cAiMkSboMfRs6hOUzcld1n8Cw==
X-Received: by 2002:a17:902:edcd:b029:df:d2b1:ecf0 with SMTP id q13-20020a170902edcdb02900dfd2b1ecf0mr11639635plk.15.1612050701068;
        Sat, 30 Jan 2021 15:51:41 -0800 (PST)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id c5sm12745797pfi.5.2021.01.30.15.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jan 2021 15:51:40 -0800 (PST)
Date:   Sat, 30 Jan 2021 15:51:39 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
cc:     linux-cxl@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Jon Masters <jcm@jonmasters.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        daniel.lll@alibaba-inc.com,
        "John Groves (jgroves)" <jgroves@micron.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>
Subject: Re: [PATCH 01/14] cxl/mem: Introduce a driver for CXL-2.0-Type-3
 endpoints
In-Reply-To: <20210130002438.1872527-2-ben.widawsky@intel.com>
Message-ID: <54655f17-2e4a-cc1e-262c-b365e3de9b20@google.com>
References: <20210130002438.1872527-1-ben.widawsky@intel.com> <20210130002438.1872527-2-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 29 Jan 2021, Ben Widawsky wrote:

> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> new file mode 100644
> index 000000000000..3b66b46af8a0
> --- /dev/null
> +++ b/drivers/cxl/Kconfig
> @@ -0,0 +1,35 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +menuconfig CXL_BUS
> +	tristate "CXL (Compute Express Link) Devices Support"
> +	depends on PCI
> +	help
> +	  CXL is a bus that is electrically compatible with PCI Express, but
> +	  layers three protocols on that signalling (CXL.io, CXL.cache, and
> +	  CXL.mem). The CXL.cache protocol allows devices to hold cachelines
> +	  locally, the CXL.mem protocol allows devices to be fully coherent
> +	  memory targets, the CXL.io protocol is equivalent to PCI Express.
> +	  Say 'y' to enable support for the configuration and management of
> +	  devices supporting these protocols.
> +
> +if CXL_BUS
> +
> +config CXL_MEM
> +	tristate "CXL.mem: Endpoint Support"

Nit: "CXL.mem: Memory Devices" or "CXL Memory Devices: CXL.mem" might look 
better, but feel free to ignore.

Acked-by: David Rientjes <rientjes@google.com>
