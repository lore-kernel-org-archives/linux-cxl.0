Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE8EC433F5
	for <linux-cxl@archiver.kernel.org>; Wed,  2 Mar 2022 13:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240439AbiCBN4D (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 2 Mar 2022 08:56:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242671AbiCBNz7 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 2 Mar 2022 08:55:59 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03E1C7C0E
        for <linux-cxl@vger.kernel.org>; Wed,  2 Mar 2022 05:54:36 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id t11so2918091wrm.5
        for <linux-cxl@vger.kernel.org>; Wed, 02 Mar 2022 05:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=veeaUjUn+FUQY470e1mkrwZGuA+EahQ3ScQLbqNSYVM=;
        b=L76R0PXD6zshCdwHrkBD93YVBX4HPuSEsTjsQ89KBRfSAhJq8YOW/bM/MR5suC0leo
         qJRQfXzFCwfMLmrCZirIf2mDatmwHI865tMUY9QqhCqaYaZmG3R4BBYjFJY8SYSUrmVr
         ZGWhubiMuR1kP75DTOBk5waN/VG+5DRAR9iIB6BpVs6AM2jzQPFnCRRZlJTQZFimZMRx
         DZVhCD2zJ5yxLnaNh2K6CNl3hKCtfeUtTn2datMOJ1ybDCuGLfxBT6l9dZefTqItgRXr
         sZLkWxm9Mjke7Dy9kZ/xNqOKAV9zRvvsm2TN+LD7DgRLsB+9cNIs9hgq7XUdEg8rzUgn
         egeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=veeaUjUn+FUQY470e1mkrwZGuA+EahQ3ScQLbqNSYVM=;
        b=AM+an4vcEy9KZeUfZHFG/5gkXDOonbCg5CgOPqCqtOyUkh7FSKunkgxHCGZ8M0kw22
         yPL66BxfxHIhgOBpTTBYcRX63bP4X3raGx2oC2Y/GG9ugaATlo46Pus1/KuNzLkALxLn
         xIbOIfKKk0GRYVEhO4eNdSPfHaV+mfIXUo3h+Q6cybXyLjKZ++o1Kq3ZfXVqfbv9JvOp
         IvMr+IQyT0CcI10c+pnLCabEQszz39Hp48njNSwlniOiP+zd0KPLnvm8ocLifPXDAOXK
         OrfZOpZUXV3sbUl24XyxfExsEXlh3fY0lmwGtPPDAmT7lU3AaeCYXAGlS5WCgBwITZ73
         hOWA==
X-Gm-Message-State: AOAM5336gZn6nbQ7sCmfuG8V+GVyBq8JZSJQIQaJU1gcCEeWMcNvt2a0
        BwRqdl9VpNWzvvv93UwiRRgEyw==
X-Google-Smtp-Source: ABdhPJz25iERODI7sKKweiwLob9JpOOXsDnn+Cze8Rh2KLpJzVitQ9s2Q6H/oI6LUJWkuqCcPMcHjg==
X-Received: by 2002:a5d:544d:0:b0:1ee:880d:3391 with SMTP id w13-20020a5d544d000000b001ee880d3391mr21838854wrv.72.1646229275410;
        Wed, 02 Mar 2022 05:54:35 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
        by smtp.gmail.com with ESMTPSA id n8-20020adf8b08000000b001f046cc8891sm1041497wra.24.2022.03.02.05.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 05:54:34 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
        by zen.linaroharston (Postfix) with ESMTP id 81BE01FFB7;
        Wed,  2 Mar 2022 13:54:33 +0000 (GMT)
References: <20220211120747.3074-1-Jonathan.Cameron@huawei.com>
 <20220211120747.3074-30-Jonathan.Cameron@huawei.com>
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
Subject: Re: [PATCH v6 29/43] hw/pci-host/gpex-acpi: Add support for dsdt
 construction for pxb-cxl
Date:   Wed, 02 Mar 2022 13:53:45 +0000
In-reply-to: <20220211120747.3074-30-Jonathan.Cameron@huawei.com>
Message-ID: <877d9cjw86.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:

> This adds code to instantiate the slightly extended ACPI root port
> description in DSDT as per the CXL 2.0 specification.
>
> Basically a cut and paste job from the i386/pc code.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
<snip>
> @@ -139,6 +140,7 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig=
 *cfg)
>          QLIST_FOREACH(bus, &bus->child, sibling) {
>              uint8_t bus_num =3D pci_bus_num(bus);
>              uint8_t numa_node =3D pci_bus_numa_node(bus);
> +            bool is_cxl;
>=20=20
>              if (!pci_bus_is_root(bus)) {
>                  continue;
> @@ -153,9 +155,19 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfi=
g *cfg)
>                  nr_pcie_buses =3D bus_num;
>              }
>=20=20
> +            is_cxl =3D pci_bus_is_cxl(bus);
> +

nit: you could hoist the setting of is_cxl to the declaration and leave
it to the compiler to move it about if you want.

Anyway:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
