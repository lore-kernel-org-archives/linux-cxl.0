Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22880C433F5
	for <linux-cxl@archiver.kernel.org>; Thu, 27 Jan 2022 14:11:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242232AbiA0OLw (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 27 Jan 2022 09:11:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242211AbiA0OLw (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 27 Jan 2022 09:11:52 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11374C061714
        for <linux-cxl@vger.kernel.org>; Thu, 27 Jan 2022 06:11:52 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id a13so5012347wrh.9
        for <linux-cxl@vger.kernel.org>; Thu, 27 Jan 2022 06:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=nfBtEnUaAD+Rl57EBhhAi7yBAFPLODzTZc4TVL6N3wU=;
        b=i+F/SpSK1sgmeVVUg5Ao+uTuympTSQjIqxOsTx56HkG7Mlg2mm0RZMb7YXypCaBePX
         WqsJBRKnBF0d1oIcByS6lQ6bJExz9UplPg5AqLYp42HbeF5vC88ue3Qs0wRVqWpD+BCg
         ciOVdTf1m4t0wEmIUUBkeejJhDdybH6wh3LDMK3XBidmUExeT2AjYv1LRA5/y3q7CLF+
         3Q5vmZjmNd1WMS0b+gfCPqnA930iqa3yFsdZTT7/av2UukWYs7+SvhQGVxmKNx3h3dPE
         hTzfxhS2T/QN6d3dtf4cDP08Sbo7Vr/lNxeckuIyMptAlftj36xuLnB2M8X5/jHH4fOk
         IntA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=nfBtEnUaAD+Rl57EBhhAi7yBAFPLODzTZc4TVL6N3wU=;
        b=PRa298TzYFtoHR6cWms62U6US9Ee6ikthpudn+sABleDzDTWgqWfuZD7yikrYUwCpc
         3rtkrfDfVcmfQ3d01Hr01IxU9dONOiwVPXXSFgCcqsHvvDoKiFZ0ETaxxDZDwSJ+hr7c
         J1oxCj4JFCP7piwLPaeCfPvoCNA66wH/rLXo5dhQzevolYAJeyLcQskMWpAGp8iQaZhH
         8RlhAADQsfb/VXP0Ta8lzWrWVhEfS337bOY62x526dGg4Sg5y3nmRF0R+FApjpBjFqpV
         Gk0deE1CsVoMwry4EzJGrshW3j8ORmRZ9iNBBh+9FzGmibcs+JRGFlrknxJWGNKBtzJZ
         5bRw==
X-Gm-Message-State: AOAM532aliRD7IwYn8tfxQwmgwOJZM3OuRWuX879Dj6hXq2CtLmtobnh
        g1VylHQpamtppc5p6vZm6WR3pQ==
X-Google-Smtp-Source: ABdhPJywtdipFXmukBO+I0QEyggurZdjA9YNF3Y9x0oKpJkpu859hPM/bdut3+8SLR27Nc++86wEAw==
X-Received: by 2002:adf:e60f:: with SMTP id p15mr3176772wrm.177.1643292710553;
        Thu, 27 Jan 2022 06:11:50 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
        by smtp.gmail.com with ESMTPSA id n5sm2318273wmq.43.2022.01.27.06.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 06:11:49 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
        by zen.linaroharston (Postfix) with ESMTP id 674831FFB7;
        Thu, 27 Jan 2022 14:11:48 +0000 (GMT)
References: <20220124171705.10432-1-Jonathan.Cameron@huawei.com>
 <20220124171705.10432-16-Jonathan.Cameron@huawei.com>
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
Subject: Re: [PATCH v4 15/42] acpi/pci: Consolidate host bridge setup
Date:   Thu, 27 Jan 2022 14:10:00 +0000
In-reply-to: <20220124171705.10432-16-Jonathan.Cameron@huawei.com>
Message-ID: <875yq59skb.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:

> From: Ben Widawsky <ben.widawsky@intel.com>
>
> This cleanup will make it easier to add support for CXL to the mix.
>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  hw/i386/acpi-build.c | 38 +++++++++++++++++++++-----------------
>  1 file changed, 21 insertions(+), 17 deletions(-)
>
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index ce823e8fcb..1d8ee988f2 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1398,6 +1398,23 @@ static void build_smb0(Aml *table, I2CBus *smbus, =
int devnr, int func)
>      aml_append(table, scope);
>  }
>=20=20
> +enum { PCI, PCIE };

Make this a typed enum and update the signatures to use it instead of
int to prevent confusion.

> +static void init_pci_acpi(Aml *dev, int uid, int type, bool native_pcie_=
hp)
> +{
> +    if (type =3D=3D PCI) {
> +        aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A03")));
> +        aml_append(dev, aml_name_decl("_ADR", aml_int(0)));
> +        aml_append(dev, aml_name_decl("_UID", aml_int(uid)));
> +    } else {
> +        aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A08")));
> +        aml_append(dev, aml_name_decl("_CID", aml_eisaid("PNP0A03")));
> +        aml_append(dev, aml_name_decl("_ADR", aml_int(0)));
> +        aml_append(dev, aml_name_decl("_UID", aml_int(uid)));
> +        /* Expander bridges do not have ACPI PCI Hot-plug enabled */
> +        aml_append(dev, build_q35_osc_method(native_pcie_hp));
> +    }
> +}
> +
>  static void
>  build_dsdt(GArray *table_data, BIOSLinker *linker,
>             AcpiPmInfo *pm, AcpiMiscInfo *misc,
> @@ -1429,9 +1446,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>      if (misc->is_piix4) {
>          sb_scope =3D aml_scope("_SB");
>          dev =3D aml_device("PCI0");
> -        aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A03")));
> -        aml_append(dev, aml_name_decl("_ADR", aml_int(0)));
> -        aml_append(dev, aml_name_decl("_UID", aml_int(pcmc->pci_root_uid=
)));
> +        init_pci_acpi(dev, pcmc->pci_root_uid, PCI, false);
>          aml_append(sb_scope, dev);
>          aml_append(dsdt, sb_scope);
>=20=20
> @@ -1447,11 +1462,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>      } else {
>          sb_scope =3D aml_scope("_SB");
>          dev =3D aml_device("PCI0");
> -        aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A08")));
> -        aml_append(dev, aml_name_decl("_CID", aml_eisaid("PNP0A03")));
> -        aml_append(dev, aml_name_decl("_ADR", aml_int(0)));
> -        aml_append(dev, aml_name_decl("_UID", aml_int(pcmc->pci_root_uid=
)));
> -        aml_append(dev, build_q35_osc_method(!pm->pcihp_bridge_en));
> +        init_pci_acpi(dev, pcmc->pci_root_uid, PCIE, !pm->pcihp_bridge_e=
n);
>          aml_append(sb_scope, dev);
>          if (mcfg_valid) {
>              aml_append(sb_scope, build_q35_dram_controller(&mcfg));
> @@ -1562,17 +1573,10 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>=20=20
>              scope =3D aml_scope("\\_SB");
>              dev =3D aml_device("PC%.02X", bus_num);
> -            aml_append(dev, aml_name_decl("_UID", aml_int(bus_num)));
>              aml_append(dev, aml_name_decl("_BBN", aml_int(bus_num)));
> -            if (pci_bus_is_express(bus)) {
> -                aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A0=
8")));
> -                aml_append(dev, aml_name_decl("_CID", aml_eisaid("PNP0A0=
3")));
>=20=20
> -                /* Expander bridges do not have ACPI PCI Hot-plug enable=
d */
> -                aml_append(dev, build_q35_osc_method(true));
> -            } else {
> -                aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A0=
3")));
> -            }
> +            init_pci_acpi(dev, bus_num,
> +                          pci_bus_is_express(bus) ? PCIE : PCI, true);
>=20=20
>              if (numa_node !=3D NUMA_NODE_UNASSIGNED) {
>                  aml_append(dev, aml_name_decl("_PXM", aml_int(numa_node)=
));

Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


--=20
Alex Benn=C3=A9e
