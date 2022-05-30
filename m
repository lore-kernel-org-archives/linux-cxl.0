Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 232A6C433EF
	for <linux-cxl@archiver.kernel.org>; Mon, 30 May 2022 17:50:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbiE3Ruq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 30 May 2022 13:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240239AbiE3Ruk (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 30 May 2022 13:50:40 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7920495A1E
        for <linux-cxl@vger.kernel.org>; Mon, 30 May 2022 10:50:38 -0700 (PDT)
Received: from fraeml710-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LBjbc4Z61z6H6qH;
        Tue, 31 May 2022 01:49:48 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml710-chm.china.huawei.com (10.206.15.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 30 May 2022 19:50:35 +0200
Received: from localhost (10.81.211.14) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 30 May
 2022 18:50:34 +0100
Date:   Mon, 30 May 2022 18:50:32 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <linuxarm@huawei.com>, <qemu-devel@nongnu.org>,
        <alex.bennee@linaro.org>, Marcel Apfelbaum <marcel@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Markus Armbruster <armbru@redhat.com>,
        Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Tong Zhang <ztong0001@gmail.com>
CC:     <linux-cxl@vger.kernel.org>, Ben Widawsky <ben.widawsky@intel.com>,
        "Peter Maydell" <peter.maydell@linaro.org>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>, <f4bug@amsat.org>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Saransh Gupta1 <saransh@ibm.com>,
        Shreyas Shah <shreyas.shah@elastics.cloud>,
        Chris Browy <cbrowy@avery-design.com>,
        "Samarth Saxena" <samarths@cadence.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <k.jensen@samsung.com>, <dave@stgolabs.net>,
        Alison Schofield <alison.schofield@intel.com>
Subject: Re: [PATCH v10 02/45] hw/cxl/component: Introduce CXL components
 (8.1.x, 8.2.5)
Message-ID: <20220530185032.00003723@Huawei.com>
In-Reply-To: <20220429144110.25167-3-Jonathan.Cameron@huawei.com>
References: <20220429144110.25167-1-Jonathan.Cameron@huawei.com>
 <20220429144110.25167-3-Jonathan.Cameron@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.81.211.14]
X-ClientProxiedBy: lhreml732-chm.china.huawei.com (10.201.108.83) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 29 Apr 2022 15:40:27 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> From: Ben Widawsky <ben.widawsky@intel.com>
> 
> A CXL 2.0 component is any entity in the CXL topology. All components
> have a analogous function in PCIe. Except for the CXL host bridge, all
> have a PCIe config space that is accessible via the common PCIe
> mechanisms. CXL components are enumerated via DVSEC fields in the
> extended PCIe header space. CXL components will minimally implement some
> subset of CXL.mem and CXL.cache registers defined in 8.2.5 of the CXL
> 2.0 specification. Two headers and a utility library are introduced to
> support the minimum functionality needed to enumerate components.
> 
> The cxl_pci header manages bits associated with PCI, specifically the
> DVSEC and related fields. The cxl_component.h variant has data
> structures and APIs that are useful for drivers implementing any of the
> CXL 2.0 components. The library takes care of making use of the DVSEC
> bits and the CXL.[mem|cache] registers. Per spec, the registers are
> little endian.
> 
> None of the mechanisms required to enumerate a CXL capable hostbridge
> are introduced at this point.
> 
> Note that the CXL.mem and CXL.cache registers used are always 4B wide.
> It's possible in the future that this constraint will not hold.
> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Adam Manzanares <a.manzanares@samsung.com>

FYI on a bug, in case anyone else hits it.

> +static void hdm_init_common(uint32_t *reg_state, uint32_t *write_msk)
> +{
> +    int decoder_count = 1;
> +    int i;
> +
> +    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, DECODER_COUNT,
> +                     cxl_decoder_count_enc(decoder_count));
> +    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, TARGET_COUNT, 1);
> +    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, INTERLEAVE_256B, 1);
> +    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, INTERLEAVE_4K, 1);
> +    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, POISON_ON_ERR_CAP, 0);
> +    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_GLOBAL_CONTROL,
> +                     HDM_DECODER_ENABLE, 0);
> +    write_msk[R_CXL_HDM_DECODER_GLOBAL_CONTROL] = 0x3;
> +    for (i = 0; i < decoder_count; i++) {
> +        write_msk[R_CXL_HDM_DECODER0_BASE_LO + i * 0x20] = 0xf0000000;
> +        write_msk[R_CXL_HDM_DECODER0_BASE_HI + i * 0x20] = 0xffffffff;
> +        write_msk[R_CXL_HDM_DECODER0_SIZE_LO + i * 0x20] = 0xf0000000;
> +        write_msk[R_CXL_HDM_DECODER0_SIZE_HI + i * 0x20] = 0xffffffff;
> +        write_msk[R_CXL_HDM_DECODER0_CTRL + i * 0x20] = 0x13ff;

For some unknown reason I missed write masks for the target lists in here.
It was hidden from superficial testing by a bug in the kernel code I was using
that mean these were mostly written to 0.

I'll send a fix out tomorrow (just adds 0xffffffff masks for each of the
target registers).

Given issues I'm seeing in testing around HDM decoder programming I'll look
to follow that up with a patch adding some more rigorous checking of the
values on commit.

Jonathan
