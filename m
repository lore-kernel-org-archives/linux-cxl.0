Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68516C433FE
	for <linux-cxl@archiver.kernel.org>; Thu, 20 Oct 2022 14:03:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiJTOD1 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 20 Oct 2022 10:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbiJTOD0 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 20 Oct 2022 10:03:26 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6A21D3473
        for <linux-cxl@vger.kernel.org>; Thu, 20 Oct 2022 07:03:25 -0700 (PDT)
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MtTkb4PXBz67Lm9;
        Thu, 20 Oct 2022 22:00:07 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 20 Oct 2022 16:03:22 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 20 Oct
 2022 15:03:22 +0100
Date:   Thu, 20 Oct 2022 15:03:20 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <shiju.jose@huawei.com>,
        <rrichter@amd.com>
Subject: Re: [PATCH RFC v2 9/9] cxl/pci: Add (hopeful) error handling
 support
Message-ID: <20221020150320.00006553@huawei.com>
In-Reply-To: <166336990544.3803215.2332306189095144106.stgit@djiang5-desk3.ch.intel.com>
References: <166336972295.3803215.1047199449525031921.stgit@djiang5-desk3.ch.intel.com>
        <166336990544.3803215.2332306189095144106.stgit@djiang5-desk3.ch.intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 16 Sep 2022 16:11:45 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> From: Dan Williams <dan.j.williams@intel.com>
> 
> Add nominal error handling that tears down CXL.mem in response to error
> notifications that imply a device reset. Given some CXL.mem may be
> operating as System RAM, there is a high likelihood that these error
> events are fatal. However, if the system survives the notification the
> expectation is that the driver behavior is equivalent to a hot-unplug
> and re-plug of an endpoint.
> 
> Note that this does not change the mask values from the default. That
> awaits CXL _OSC support to determine whether platform firmware is in
> control of the mask registers.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---

>  
> +/* CXL spec rev3.0 8.2.4.16.1 */
> +#define DATA_HEADER_SIZE 16

I'm not immediately seeing a spec justification for these sizes.
The table refes to containing H2D or D2H headers. 
Jumping back to 3.2.3.3 D2H Data
The D2H Data Header is between 17 and 24 bits (assuming PBR irrelevant here)
H2D header is 24 to 28 bits.

So where does 16 bytes come from?  I'd be tempted to just spit out the whole
512 bit register in 32 bit chunks and leave interpretation of it to userspace.


> +#define FLIT_SIZE (64 + 2)
> +static int header_log_setup(struct cxl_dev_state *cxlds, u32 fe, u8 *log)
> +{
> +	void __iomem *addr;
> +
> +	addr = cxlds->regs.ras + CXL_RAS_HEADER_LOG_OFFSET;
> +
> +	if (fe & CXL_RAS_UC_CACHE_DATA_PARITY || fe & CXL_RAS_UC_CACHE_ADDR_PARITY ||
> +	    fe & CXL_RAS_UC_CACHE_BE_PARITY || fe & CXL_RAS_UC_CACHE_DATA_ECC ||
> +	    fe & CXL_RAS_UC_MEM_DATA_PARITY || fe & CXL_RAS_UC_MEM_ADDR_PARITY ||
> +	    fe & CXL_RAS_UC_MEM_BE_PARITY || fe & CXL_RAS_UC_MEM_DATA_ECC) {
> +		memcpy_fromio(log, addr, DATA_HEADER_SIZE);
> +		return DATA_HEADER_SIZE;
> +	}
> +
> +	if (fe & CXL_RAS_UC_RSVD_ENCODE) {
> +		memcpy_fromio(log, addr, FLIT_SIZE);
> +		return FLIT_SIZE;
> +	}
> +
> +	if (fe & CXL_RAS_UC_RECV_OVERFLOW) {
> +		*log = readb(addr);
> +		return sizeof(u8);
> +	}
> +
> +	return 0;
> +}
> +
