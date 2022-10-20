Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70918C4332F
	for <linux-cxl@archiver.kernel.org>; Thu, 20 Oct 2022 16:10:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbiJTQKG (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 20 Oct 2022 12:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbiJTQKB (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 20 Oct 2022 12:10:01 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 996CD37FBE
        for <linux-cxl@vger.kernel.org>; Thu, 20 Oct 2022 09:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666282200; x=1697818200;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3xGHC5dCuv4/esrWb/goRqygakrf7l4q4nRYtGA51vo=;
  b=Hx4wFp3IkmSoB+nt1UXHEnIOwY6KW8Dch7qiwbbH6TtplcAiV6pwUF4d
   4+EIAG2wsLW/89Wg0ERrL3ZLXveveZUh66ASASuEvBqa0N/61Qw/7AIky
   I0yDuWtklqG0yt4U2rxMAWubOTt06eAFdhm3q9eVoXDvU/HG3X1Om90v8
   9yyPvQ0QdSGaL8jLPMx9B+7lyLnTvmdDfz6DDzCTy26+0hrcJjIJ0TG2d
   TGkv3+9l/Us4t9a5zg7HOXTLoW6R9eMtz2p9tY0cRs46QI4D7Dp3tXLBT
   RNUiWnVHo45u1r1fIaw/FDPuYCcCiggU6ZA0TLVLxWMZ1Pdh/TS8gmyGD
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="307854934"
X-IronPort-AV: E=Sophos;i="5.95,199,1661842800"; 
   d="scan'208";a="307854934"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 09:06:52 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="734934791"
X-IronPort-AV: E=Sophos;i="5.95,199,1661842800"; 
   d="scan'208";a="734934791"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.212.65.105]) ([10.212.65.105])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 09:06:51 -0700
Message-ID: <032c48b4-f1d5-6458-ccde-04ce8b1a7f10@intel.com>
Date:   Thu, 20 Oct 2022 09:06:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.3.3
Subject: Re: [PATCH RFC v2 9/9] cxl/pci: Add (hopeful) error handling support
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, alison.schofield@intel.com,
        vishal.l.verma@intel.com, bwidawsk@kernel.org,
        dan.j.williams@intel.com, shiju.jose@huawei.com, rrichter@amd.com
References: <166336972295.3803215.1047199449525031921.stgit@djiang5-desk3.ch.intel.com>
 <166336990544.3803215.2332306189095144106.stgit@djiang5-desk3.ch.intel.com>
 <20221020165203.00002101@huawei.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20221020165203.00002101@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


On 10/20/2022 8:52 AM, Jonathan Cameron wrote:
> On Fri, 16 Sep 2022 16:11:45 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
>
>> From: Dan Williams <dan.j.williams@intel.com>
>>
>> Add nominal error handling that tears down CXL.mem in response to error
>> notifications that imply a device reset. Given some CXL.mem may be
>> operating as System RAM, there is a high likelihood that these error
>> events are fatal. However, if the system survives the notification the
>> expectation is that the driver behavior is equivalent to a hot-unplug
>> and re-plug of an endpoint.
>>
>> Note that this does not change the mask values from the default. That
>> awaits CXL _OSC support to determine whether platform firmware is in
>> control of the mask registers.
> Hi Dave,
>
> So I just implemented correctable error reporting and it never gets
> to the handling in here.  My perhaps wrong assumption is that the
> device would use ERR_COR messages to indicate those?
>
> They get to the AER handlers (which print appropriately) but because
> they have been corrected are never reported to the PCIe drivers.
>
> https://elixir.bootlin.com/linux/latest/source/drivers/pci/pcie/aer.c#L956
>
> I guess we will want a hook for those as well so we can log the
> extra info on what the error was when they occur.

Are you suggesting having that function call pdrv->err_handler with 
either going through ->error_detected() or a new callback like 
->correctable_error_notify()?


>
> Jonathan
