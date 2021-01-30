Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A462C433E0
	for <linux-cxl@archiver.kernel.org>; Sat, 30 Jan 2021 23:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3914364E15
	for <linux-cxl@archiver.kernel.org>; Sat, 30 Jan 2021 23:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232786AbhA3Xys (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sat, 30 Jan 2021 18:54:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232580AbhA3Xxg (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sat, 30 Jan 2021 18:53:36 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F9EC0617AB
        for <linux-cxl@vger.kernel.org>; Sat, 30 Jan 2021 15:52:03 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id t29so9041783pfg.11
        for <linux-cxl@vger.kernel.org>; Sat, 30 Jan 2021 15:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=Ui0BeJCwGOKq8ej5x7M1Q9u0lMO3l7TRN0DCBw5DBWc=;
        b=MzV7DeqSQEU06RPg78K/siciEFk1jfbTpumwWmLQl6H6Gtps4XMqo2d69/O5cLG2ib
         sWHVna8f+tRiTekQ27iMrabwakv/X6Gbl2kRVK/U/BGlRXp3T9i1yQQSuVnU6lr+dm/x
         8FEPu29yNnBux/VASHH7ScQ+Jl0IiYohkU6+RCuQUg1EgQPqAcab+9vyY4J5yCbNcTRR
         nr53UK6NJNWZfhq5VD+V3Le0HG/nMeKhW74bPHwhTL5zw+kABM4AX6dL+VwufuqFX1nq
         tUL0JTNvh8Ct349k+VfR9Xo8+biP3GeU+ESkvAHVcmQEBivIFsiEhTmpY/WaIHhwMGhe
         hhVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=Ui0BeJCwGOKq8ej5x7M1Q9u0lMO3l7TRN0DCBw5DBWc=;
        b=iXvPEc5hse0tc18T+MN6wkaVBx0tjMz/s9KUb+pHe/SrYDYyauILmv8q4tJ/sbmuNa
         KZ5G6Cvafy3oFZcJQXXp6koQMQkdQv2MXr074+yb0fakz0dBXXPWRhT7D27hpqdShHbS
         G7lnGln474yRCt6C65I2pX4d56pteBe3apoDdK6QfD9FGXfB/IGcXezY6v72YRuvbTqb
         rmm8m92XkTltPz70mHHzjLrabLUQwNkmdYu5tYtXpm5hxtxLqTYat9RhaYew3Ssunjgw
         JxxEY+Z/0OeMBNer2CkMWplRXdIu1TD8BtxDiyd9HVZLrffOoWCmlcBqzLY287cSFUK1
         DHiQ==
X-Gm-Message-State: AOAM533QgiBK7KnK57D6oso8nYFY+UfzIFW/TkBYQgGUQNoefzZqIGsK
        n+C5Tf6sPZzcEtkZdwOwAHAEuw==
X-Google-Smtp-Source: ABdhPJwhLUNT7kvzAUWFbzT9Lc1dFYnkmDtxMuvH7NNwX3Q8WOwnNGrRfaRhmDarU4sLoHVBNmVU6w==
X-Received: by 2002:a63:7947:: with SMTP id u68mr3474320pgc.451.1612050723241;
        Sat, 30 Jan 2021 15:52:03 -0800 (PST)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id e12sm13104562pga.13.2021.01.30.15.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jan 2021 15:52:02 -0800 (PST)
Date:   Sat, 30 Jan 2021 15:52:01 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
cc:     linux-cxl@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>,
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
Subject: Re: [PATCH 05/14] cxl/mem: Register CXL memX devices
In-Reply-To: <20210130002438.1872527-6-ben.widawsky@intel.com>
Message-ID: <ecd93422-b272-2b76-1ec-cf6af744ae@google.com>
References: <20210130002438.1872527-1-ben.widawsky@intel.com> <20210130002438.1872527-6-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 29 Jan 2021, Ben Widawsky wrote:

> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> new file mode 100644
> index 000000000000..fe7b87eba988
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -0,0 +1,26 @@
> +What:		/sys/bus/cxl/devices/memX/firmware_version
> +Date:		December, 2020
> +KernelVersion:	v5.12
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) "FW Revision" string as reported by the Identify
> +		Memory Device Output Payload in the CXL-2.0
> +		specification.
> +
> +What:		/sys/bus/cxl/devices/memX/ram/size
> +Date:		December, 2020
> +KernelVersion:	v5.12
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) "Volatile Only Capacity" as reported by the
> +		Identify Memory Device Output Payload in the CXL-2.0
> +		specification.
> +
> +What:		/sys/bus/cxl/devices/memX/pmem/size
> +Date:		December, 2020
> +KernelVersion:	v5.12
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) "Persistent Only Capacity" as reported by the
> +		Identify Memory Device Output Payload in the CXL-2.0
> +		specification.

Aren't volatile and persistent capacities expressed in multiples of 256MB?
