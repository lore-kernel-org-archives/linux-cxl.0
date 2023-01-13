Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA332C54EBE
	for <linux-cxl@archiver.kernel.org>; Fri, 13 Jan 2023 09:52:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241080AbjAMJwb (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 13 Jan 2023 04:52:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232182AbjAMJwK (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 13 Jan 2023 04:52:10 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4436699C
        for <linux-cxl@vger.kernel.org>; Fri, 13 Jan 2023 01:47:30 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Ntc1R5nxxz6J7YB;
        Fri, 13 Jan 2023 17:43:39 +0800 (CST)
Received: from localhost (10.81.201.219) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 13 Jan
 2023 09:47:27 +0000
Date:   Fri, 13 Jan 2023 09:47:25 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Fan Ni <fan.ni@samsung.com>
CC:     "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "alison.schofield@intel.com" <alison.schofield@intel.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "bwidawsk@kernel.org" <bwidawsk@kernel.org>,
        "gregory.price@memverge.com" <gregory.price@memverge.com>,
        "hchkuo@avery-design.com.tw" <hchkuo@avery-design.com.tw>,
        "cbrowy@avery-design.com" <cbrowy@avery-design.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [RFC] cxl-host: Fix committed check for passthrough decoder
Message-ID: <20230113094725.0000705c@Huawei.com>
In-Reply-To: <20230113002727.11411-1-fan.ni@samsung.com>
References: <CGME20230113002756uscas1p2b602bff26576110407491f67eff5e065@uscas1p2.samsung.com>
        <20230113002727.11411-1-fan.ni@samsung.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.201.219]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 13 Jan 2023 00:27:55 +0000
Fan Ni <fan.ni@samsung.com> wrote:

> For passthrough decoder (a decoder hosted by a cxl component with only
> one downstream port), its cache_mem_registers field COMMITTED
> (see spec 2.0 8.2.5.12 - CXL HDM Decoder Capability Structure) will not
> be set by the current Linux CXL driver. Without the fix, for a cxl
> topology setup with a single HB and single root port, the memdev read/write
> requests cannot be passed to the device successfully as the function
> cxl_hdm_find_target will fail the decoder COMMITTED check and return
> directly, which causes read/write not being directed to cxl type3 device.
> 
> Before the fix, a segfault is observed when trying using cxl memory for
> htop command through 'numactl --membind' after converting cxl memory
> into normal RAM.

We also need to fix that segfault.


> 
> Detailed steps to reproduce the issue with the cxl setup where there is
> only one HB and a memdev is directly attached to the only root port of
> the HB are listed as below,
> 1. cxl create-region region0
> 2. ndctl create-namespace -m dax -r region0
> 3. daxctl reconfigure-device --mode=system-ram --no-online dax0.0
> 4. daxctl online-memory dax0.0
> 5. numactl --membind=1 htop
> 
> Signed-off-by: Fan Ni <fan.ni@samsung.com>

Ah. This mess is still going on. I've not been testing with this
particular combination because the kernel didn't support it.
The kernel code assumes that the implementation made the choice
(which is an option in the spec) to not have any HDM decoders
for the pass through case. As such it never programmed them
(if you dig back a long way in the region bring patch sets in the
kernel you'll find some discussion of this). Now I knew that meant
the configuration didn't 'work' but nothing should be crashing -
unless you mean that something in linux userspace is trying to
access the memory and crashing because that fails
(which is fine as far as I'm concerned ;)

The work around for QEMU testing so far has been to add another root
port and put nothing below that. The HDM decoders then have to be
implemented so the kernel does what we expect.

I'm not against a more comprehensive fix.  Two options come to mind.
1) Add an option to the host bridge device to tell it not to implement
   hdm decoders at all. I'm not keen to just automatically drop them
   because having decoders on a pass through HB is a valid configuration.
2) Cheat and cleanly detect a pass through situation and let the accesses
   through.  I'm not particularly keen on this option though as it
   will fail to test the code once it's 'fixed' in Linux.  IIRC the spec
   doesn't say that programming such an HDM decoder is optional.

I guess we could be a bit naughty with option 1 and flip the logic even
though it would break backwards compatibility. So default to no HDM decoder.
I doubt anyone will notice given that's the configuration that would have
worked.  However I would want to keep the option to enable these decoders
around.  I can spin up a patch or do you want to do it? My suggestion is option
1 with default being no HDM decoder.

Jonathan



> ---
>  hw/cxl/cxl-host.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
> index 1adf61231a..5ca0d6fd8f 100644
> --- a/hw/cxl/cxl-host.c
> +++ b/hw/cxl/cxl-host.c
> @@ -107,8 +107,11 @@ static bool cxl_hdm_find_target(uint32_t *cache_mem, hwaddr addr,
>      uint32_t target_idx;
>  
>      ctrl = cache_mem[R_CXL_HDM_DECODER0_CTRL];
> -    if (!FIELD_EX32(ctrl, CXL_HDM_DECODER0_CTRL, COMMITTED)) {
> -        return false;
> +
> +    /* skip the check for passthrough decoder */

You have a mix of spaces and tabs for indentation. Should all be 4 spaces
for QEMU code.

> +	if (FIELD_EX32(ctrl, CXL_HDM_DECODER0_CTRL, COMMIT)
> +		&& !FIELD_EX32(ctrl, CXL_HDM_DECODER0_CTRL, COMMITTED)) {
> +		return false;

Why is this code specific to a pass through decoder?
All it's telling us (I think) is no one tried to commit the decoder yet.

>      }
>  
>      ig_enc = FIELD_EX32(ctrl, CXL_HDM_DECODER0_CTRL, IG);

