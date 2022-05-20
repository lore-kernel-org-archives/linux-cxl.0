Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB4B8C433F5
	for <linux-cxl@archiver.kernel.org>; Fri, 20 May 2022 15:10:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244602AbiETPKF (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 20 May 2022 11:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350612AbiETPKD (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 20 May 2022 11:10:03 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3630177883
        for <linux-cxl@vger.kernel.org>; Fri, 20 May 2022 08:10:00 -0700 (PDT)
Received: from fraeml710-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4L4VSF0LgKz67Prk;
        Fri, 20 May 2022 23:06:53 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml710-chm.china.huawei.com (10.206.15.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 20 May 2022 17:09:58 +0200
Received: from localhost (10.122.247.231) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 20 May
 2022 16:09:57 +0100
Date:   Fri, 20 May 2022 16:09:56 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Ariel Sibley <ariel.sibley@microchip.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH v4 13/13] cxl/port: Enable HDM Capability after
 validating DVSEC Ranges
Message-ID: <20220520160956.00000602@huawei.com>
In-Reply-To: <165299979159.2207134.5045405239146790589.stgit@dwillia2-xfh>
References: <165291692286.1426646.10683669594268317024.stgit@dwillia2-xfh>
        <165299979159.2207134.5045405239146790589.stgit@dwillia2-xfh>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml737-chm.china.huawei.com (10.201.108.187) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 19 May 2022 15:38:56 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> CXL memory expanders that support the CXL 2.0 memory device class code
> include an "HDM Decoder Capability" mechanism to supplant the "CXL DVSEC
> Range" mechanism originally defined in CXL 1.1. Both mechanisms depend
> on a "mem_enable" bit being set in configuration space before either
> mechanism activates. When the HDM Decoder Capability is enabled the CXL
> DVSEC Range settings are ignored.
> 
> Previously, the cxl_mem driver was relying on platform-firmware to set
> "mem_enable". That is an invalid assumption as there is no requirement
> that platform-firmware sets the bit before the driver sees a device,
> especially in hot-plug scenarios. Additionally, ACPI-platforms that
> support CXL 2.0 devices also support the ACPI CEDT (CXL Early Discovery
> Table). That table outlines the platform permissible address ranges for
> CXL operation. So, there is a need for the driver to set "mem_enable",
> and there is information available to determine the validity of the CXL
> DVSEC Ranges.
> 
> Arrange for the driver to optionally enable the HDM Decoder Capability
> if "mem_enable" was not set by platform firmware, or the CXL DVSEC Range
> configuration was invalid. Be careful to only disable memory decode if
> the kernel was the one to enable it. In other words, if CXL is backing
> all of kernel memory at boot the device needs to maintain "mem_enable"
> and "HDM Decoder enable" all the way up to handoff back to platform
> firmware (e.g. ACPI S5 state entry may require CXL memory to stay
> active).
> 
> Fixes: 560f78559006 ("cxl/pci: Retrieve CXL DVSEC memory info")
> Cc: Dan Carpenter <dan.carpenter@oracle.com>
> [dan: fix early terminiation of range-allowed loop]
> Cc: Ariel Sibley <ariel.sibley@microchip.com>
> [ariel: Memory_size must be non-zero]
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Link: https://lore.kernel.org/r/165291692286.1426646.10683669594268317024.stgit@dwillia2-xfh
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Hi Dan,

...

>  
> +	/*
> +	 * The current DVSEC values are moot if the memory capability is
> +	 * disabled, and they will remain moot after the HDM Decoder
> +	 * capability is enabled.
> +	 */
>  	info.mem_enabled = FIELD_GET(CXL_DVSEC_MEM_ENABLE, ctrl);
>  	if (!info.mem_enabled)
> -		return 0;
> +		return __cxl_hdm_decode_init(cxlds, cxlhdm, &info);

 __cxl_hdm_decode_init() returns bool whereas
cxl_hdm_decode_init() return 0 on success negative on error.

Leads to odd situation of getting a probe failed with a return value
of 1.

>  
>  	for (i = 0; i < hdm_count; i++) {
>  		u64 base, size;
> 

