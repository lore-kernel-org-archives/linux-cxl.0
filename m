Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F27C05027
	for <linux-cxl@archiver.kernel.org>; Tue, 14 Feb 2023 03:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbjBND7q (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 13 Feb 2023 22:59:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbjBND7p (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 13 Feb 2023 22:59:45 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61111CDEC
        for <linux-cxl@vger.kernel.org>; Mon, 13 Feb 2023 19:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676347179; x=1707883179;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VToIQ6QCeoQde9Heb86hAZZR6ObFV8wceMoEW8GRZ0g=;
  b=H8Li79LIm9pG1NQkrdauGM82ZhHwhD6+m8GxuWEf9iJgfNQA763YWxNJ
   WFlnNiK3KcKUlvavIPX9a1ob0dD/fA8UnaHVB8qHPdwt9BXAhopsVw7IX
   w4OlVieQ3kYnl+Lzr0oIKb6aQ0VdllcrlXJWsVQvxSBok4ISSPd3Hs0iT
   KcQqDe4itvV8itaY+jpv+GeW17KCADH40f3/tqLfiJSWORHaFFgP1io4T
   P5fa62GWmfYnKw3wBNNe17VpN3FUanGQ7QVIEDN3AJ7ecI22deSW6Oahm
   p25cBRGUjvg6hte/pTmdEPJSvr7fDQARAjbyS31jhJ5NhPxZnbaZIdYv/
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="358480160"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="358480160"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 19:59:38 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="757835238"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="757835238"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.99.85]) ([10.212.99.85])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 19:59:38 -0800
Message-ID: <51fa9a1b-adb9-78c0-bea4-ed27469e078c@intel.com>
Date:   Mon, 13 Feb 2023 20:59:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH] cxl: remove unnecessary calling of
 pci_enable_pcie_error_reporting()
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Cc:     bhelgaas@google.com, ira.weiny@intel.com,
        Jonathan.Cameron@huawei.com, lukas@wunner.de
References: <167632012093.4153151.5360778069735064322.stgit@djiang5-mobl3.local>
 <63eae2639fce0_32d612941d@dwillia2-xfh.jf.intel.com.notmuch>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <63eae2639fce0_32d612941d@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 2/13/23 6:22 PM, Dan Williams wrote:
> Dave Jiang wrote:
>> With this [1] commit upstream, pci_enable_pci_error_report() is no longer
>> necessary for the driver to call. Remove call and related cleanups.
>>
>> [1]: f26e58bf6f54 ("PCI/AER: Enable error reporting when AER is native")
> 
> Care to fixup the Documentation as well so others do not follow the same
> pattern?

Sure I'll add the diffs below.

> 
> diff --git a/Documentation/PCI/pcieaer-howto.rst b/Documentation/PCI/pcieaer-howto.rst
> index 0b36b9ebfa4b..a82802795a06 100644
> --- a/Documentation/PCI/pcieaer-howto.rst
> +++ b/Documentation/PCI/pcieaer-howto.rst
> @@ -135,15 +135,6 @@ hierarchy and links. These errors do not include any device specific
>   errors because device specific errors will still get sent directly to
>   the device driver.
>   
> -Configure the AER capability structure
> ---------------------------------------
> -
> -AER aware drivers of PCI Express component need change the device
> -control registers to enable AER. They also could change AER registers,
> -including mask and severity registers. Helper function
> -pci_enable_pcie_error_reporting could be used to enable AER. See
> -section 3.3.
> -
>   Provide callbacks
>   -----------------
>   
> @@ -214,15 +205,6 @@ to mmio_enabled.
>   
>   helper functions
>   ----------------
> -::
> -
> -  int pci_enable_pcie_error_reporting(struct pci_dev *dev);
> -
> -pci_enable_pcie_error_reporting enables the device to send error
> -messages to root port when an error is detected. Note that devices
> -don't enable the error reporting by default, so device drivers need
> -call this function to enable it.
> -
>   ::
>   
>     int pci_disable_pcie_error_reporting(struct pci_dev *dev);
