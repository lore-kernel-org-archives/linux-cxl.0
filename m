Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AAC3C47089
	for <linux-cxl@archiver.kernel.org>; Fri,  2 Dec 2022 16:45:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233546AbiLBQpz convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 2 Dec 2022 11:45:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233449AbiLBQpt (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 2 Dec 2022 11:45:49 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E014CB208
        for <linux-cxl@vger.kernel.org>; Fri,  2 Dec 2022 08:45:48 -0800 (PST)
Received: from fraeml738-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NNzJF0cg1z67v9b;
        Sat,  3 Dec 2022 00:42:37 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml738-chm.china.huawei.com (10.206.15.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 2 Dec 2022 17:45:46 +0100
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 2 Dec
 2022 16:45:46 +0000
Date:   Fri, 2 Dec 2022 16:45:45 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Robert Richter <rrichter@amd.com>,
        <alison.schofield@intel.com>, <terry.bowman@amd.com>,
        <bhelgaas@google.com>, <dave.jiang@intel.com>,
        <nvdimm@lists.linux.dev>
Subject: Re: [PATCH v6 10/12] cxl/port: Add RCD endpoint port enumeration
Message-ID: <20221202164545.000039f5@Huawei.com>
In-Reply-To: <166993045621.1882361.1730100141527044744.stgit@dwillia2-xfh.jf.intel.com>
References: <166993040066.1882361.5484659873467120859.stgit@dwillia2-xfh.jf.intel.com>
        <166993045621.1882361.1730100141527044744.stgit@dwillia2-xfh.jf.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 01 Dec 2022 13:34:16 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> Unlike a CXL memory expander in a VH topology that has at least one
> intervening 'struct cxl_port' instance between itself and the CXL root
> device, an RCD attaches one-level higher. For example:
> 
>                VH
>           ┌──────────┐
>           │ ACPI0017 │
>           │  root0   │
>           └─────┬────┘
>                 │
>           ┌─────┴────┐
>           │  dport0  │
>     ┌─────┤ ACPI0016 ├─────┐
>     │     │  port1   │     │
>     │     └────┬─────┘     │
>     │          │           │
>  ┌──┴───┐   ┌──┴───┐   ┌───┴──┐
>  │dport0│   │dport1│   │dport2│
>  │ RP0  │   │ RP1  │   │ RP2  │
>  └──────┘   └──┬───┘   └──────┘
>                │
>            ┌───┴─────┐
>            │endpoint0│
>            │  port2  │
>            └─────────┘
> 
> ...vs:
> 
>               RCH
>           ┌──────────┐
>           │ ACPI0017 │
>           │  root0   │
>           └────┬─────┘
>                │
>            ┌───┴────┐
>            │ dport0 │
>            │ACPI0016│
>            └───┬────┘
>                │
>           ┌────┴─────┐
>           │endpoint0 │
>           │  port1   │
>           └──────────┘
> 
> So arrange for endpoint port in the RCH/RCD case to appear directly
> connected to the host-bridge in its singular role as a dport. Compare
> that to the VH case where the host-bridge serves a dual role as a
> 'cxl_dport' for the CXL root device *and* a 'cxl_port' upstream port for
> the Root Ports in the Root Complex that are modeled as 'cxl_dport'
> instances in the CXL topology.
> 
> Another deviation from the VH case is that RCDs may need to look up
> their component registers from the Root Complex Register Block (RCRB).
> That platform firmware specified RCRB area is cached by the cxl_acpi
> driver and conveyed via the host-bridge dport to the cxl_mem driver to
> perform the cxl_rcrb_to_component() lookup for the endpoint port
> (See 9.11.8 CXL Devices Attached to an RCH for the lookup of the
> upstream port component registers).
> 
> Tested-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Jonathan Camerom <Jonathan.Cameron@huawei.com>

Bonus points are awarded for the artwork.

J

