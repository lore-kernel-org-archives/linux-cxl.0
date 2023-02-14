Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99309C6379F
	for <linux-cxl@archiver.kernel.org>; Tue, 14 Feb 2023 16:53:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232704AbjBNQxo (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 14 Feb 2023 11:53:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232648AbjBNQxo (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 14 Feb 2023 11:53:44 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2D627D70
        for <linux-cxl@vger.kernel.org>; Tue, 14 Feb 2023 08:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676393623; x=1707929623;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=VoFWBMRCOc9l2vG6C7BsCIGihwOYBMBhEAUbkr1n1zY=;
  b=TwDQ3Sm1NVAJlPOFGd8xXFcMCTUXQ/2rT8qQ9RhCk+EJhR/r+H4GWtT7
   +zmg/1GOUS/PQ3PrAkC1Tn/bOnxKag4IDGyMbMAXgwXXMBfpu+sHIbLKh
   sEuIPVI45mxaa1McTODDJoVsYYX5BPlztahcMQxDc0bb10rAk7hZvH0cP
   2dbzyV1RG4WzZynNpAadP8iN4WV6n/9kE77vf+AJSE+NSt6N/ggexXElL
   2J9+kjpuM6+g1a+4RHdvOYtb0vIEX4PTxo4emEyr8BsqMrGEGiPPG5EdO
   SKSHmosMi3GaxgFm2mMG2eoyWrwqW/StSdG2s0lnKELHsmaQ9y9zi0XGj
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="332516833"
X-IronPort-AV: E=Sophos;i="5.97,297,1669104000"; 
   d="scan'208";a="332516833"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 08:53:42 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="793158684"
X-IronPort-AV: E=Sophos;i="5.97,297,1669104000"; 
   d="scan'208";a="793158684"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.93.192]) ([10.212.93.192])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 08:53:41 -0800
Message-ID: <195dcde1-792a-ff57-2b94-b04647370be8@intel.com>
Date:   Tue, 14 Feb 2023 09:53:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH] cxl: remove unnecessary calling of
 pci_enable_pcie_error_reporting()
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Cc:     bhelgaas@google.com, ira.weiny@intel.com,
        Jonathan.Cameron@huawei.com, lukas@wunner.de
References: <167632012093.4153151.5360778069735064322.stgit@djiang5-mobl3.local>
 <63eae2639fce0_32d612941d@dwillia2-xfh.jf.intel.com.notmuch>
 <51fa9a1b-adb9-78c0-bea4-ed27469e078c@intel.com>
In-Reply-To: <51fa9a1b-adb9-78c0-bea4-ed27469e078c@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 2/13/23 8:59 PM, Dave Jiang wrote:
> 
> 
> On 2/13/23 6:22 PM, Dan Williams wrote:
>> Dave Jiang wrote:
>>> With this [1] commit upstream, pci_enable_pci_error_report() is no 
>>> longer
>>> necessary for the driver to call. Remove call and related cleanups.
>>>
>>> [1]: f26e58bf6f54 ("PCI/AER: Enable error reporting when AER is native")
>>
>> Care to fixup the Documentation as well so others do not follow the same
>> pattern?
> 
> Sure I'll add the diffs below.
Sent as separate patch:
https://lore.kernel.org/linux-pci/167639333373.777843.2141436875951823865.stgit@djiang5-mobl3.local/T/#u

> 
>>
>> diff --git a/Documentation/PCI/pcieaer-howto.rst 
>> b/Documentation/PCI/pcieaer-howto.rst
>> index 0b36b9ebfa4b..a82802795a06 100644
>> --- a/Documentation/PCI/pcieaer-howto.rst
>> +++ b/Documentation/PCI/pcieaer-howto.rst
>> @@ -135,15 +135,6 @@ hierarchy and links. These errors do not include 
>> any device specific
>>   errors because device specific errors will still get sent directly to
>>   the device driver.
>> -Configure the AER capability structure
>> ---------------------------------------
>> -
>> -AER aware drivers of PCI Express component need change the device
>> -control registers to enable AER. They also could change AER registers,
>> -including mask and severity registers. Helper function
>> -pci_enable_pcie_error_reporting could be used to enable AER. See
>> -section 3.3.
>> -
>>   Provide callbacks
>>   -----------------
>> @@ -214,15 +205,6 @@ to mmio_enabled.
>>   helper functions
>>   ----------------
>> -::
>> -
>> -  int pci_enable_pcie_error_reporting(struct pci_dev *dev);
>> -
>> -pci_enable_pcie_error_reporting enables the device to send error
>> -messages to root port when an error is detected. Note that devices
>> -don't enable the error reporting by default, so device drivers need
>> -call this function to enable it.
>> -
>>   ::
>>     int pci_disable_pcie_error_reporting(struct pci_dev *dev);
