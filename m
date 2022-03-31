Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B4C8C433F5
	for <linux-cxl@archiver.kernel.org>; Thu, 31 Mar 2022 12:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235997AbiCaMWN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 31 Mar 2022 08:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235996AbiCaMWN (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 31 Mar 2022 08:22:13 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D648C58814
        for <linux-cxl@vger.kernel.org>; Thu, 31 Mar 2022 05:20:25 -0700 (PDT)
Received: from fraeml740-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KTj5T690xz685N3;
        Thu, 31 Mar 2022 20:18:53 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml740-chm.china.huawei.com (10.206.15.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 31 Mar 2022 14:20:23 +0200
Received: from localhost (10.122.247.231) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 31 Mar
 2022 13:20:22 +0100
Date:   Thu, 31 Mar 2022 13:20:21 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linuxarm@huawei.com>, <qemu-devel@nongnu.org>,
        Alex =?ISO-8859-1?Q?Be?= =?ISO-8859-1?Q?nn=E9e?= 
        <alex.bennee@linaro.org>, Marcel Apfelbaum <marcel@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Markus Armbruster <armbru@redhat.com>
CC:     <linux-cxl@vger.kernel.org>, Ben Widawsky <ben.widawsky@intel.com>,
        "Peter Maydell" <peter.maydell@linaro.org>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Philippe =?ISO-8859-1?Q?Mathieu-D?= =?ISO-8859-1?Q?aud=E9?= 
        <f4bug@amsat.org>, Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Saransh Gupta1 <saransh@ibm.com>,
        Shreyas Shah <shreyas.shah@elastics.cloud>,
        Chris Browy <cbrowy@avery-design.com>,
        Samarth Saxena <samarths@cadence.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH v8 02/46] hw/cxl/component: Introduce CXL components
 (8.1.x, 8.2.5)
Message-ID: <20220331132021.000014c4@huawei.com>
In-Reply-To: <20220318150635.24600-3-Jonathan.Cameron@huawei.com>
References: <20220318150635.24600-1-Jonathan.Cameron@huawei.com>
        <20220318150635.24600-3-Jonathan.Cameron@huawei.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml717-chm.china.huawei.com (10.201.108.68) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 18 Mar 2022 15:05:51 +0000
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
There will be one other addition to this in v9 which is to add
the device GPF dvsec structure definition.

I'll also add the relevant instantiation of this to the type 3 device
and the Port GPF instantiation for the root port and switch
DSP as these are mandatory (Even if they aren't that interesting to an OS)

>
