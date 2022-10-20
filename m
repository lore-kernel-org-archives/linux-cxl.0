Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5730CC43217
	for <linux-cxl@archiver.kernel.org>; Thu, 20 Oct 2022 13:45:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiJTNpp (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 20 Oct 2022 09:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiJTNpk (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 20 Oct 2022 09:45:40 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7696E52C1
        for <linux-cxl@vger.kernel.org>; Thu, 20 Oct 2022 06:45:35 -0700 (PDT)
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MtTMl0GbXz686KW;
        Thu, 20 Oct 2022 21:43:47 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 20 Oct 2022 15:45:32 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 20 Oct
 2022 14:45:32 +0100
Date:   Thu, 20 Oct 2022 14:45:30 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <shiju.jose@huawei.com>,
        <rrichter@amd.com>
Subject: Re: [PATCH RFC v2 9/9] cxl/pci: Add (hopeful) error handling
 support
Message-ID: <20221020144530.00000201@huawei.com>
In-Reply-To: <166336990544.3803215.2332306189095144106.stgit@djiang5-desk3.ch.intel.com>
References: <166336972295.3803215.1047199449525031921.stgit@djiang5-desk3.ch.intel.com>
        <166336990544.3803215.2332306189095144106.stgit@djiang5-desk3.ch.intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
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

...

> +/* CXL spec rev3.0 8.2.4.16.1 */
> +#define DATA_HEADER_SIZE 16
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
I'd forgotten his gremlin.

You can't use memcpy_fromio() because on some architectures it will issue 8 byte
reads and 8.2.4.16.7 states that the log shall be accessed as aligned 4-byte
quantities.

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
Also not valid for same reason.  Do a 32bit read and mask out the bottom byte.

That was a pain to track down (and worst of all we hit the same thing for another
bit of CXL last year I'd forgotten about it :(

> +		return sizeof(u8);
> +	}
> +
> +	return 0;
> +}
> +
