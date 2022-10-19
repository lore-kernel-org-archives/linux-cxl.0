Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D590CC433FE
	for <linux-cxl@archiver.kernel.org>; Wed, 19 Oct 2022 17:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiJSRil (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 19 Oct 2022 13:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbiJSRiZ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 19 Oct 2022 13:38:25 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C975D33376
        for <linux-cxl@vger.kernel.org>; Wed, 19 Oct 2022 10:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666201102; x=1697737102;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GSyQt2neY4uRPwwjB7xjUNm+eZPvPWRCzFVf/9hsjxM=;
  b=QGeTRRc9BnIEw+lx4Bm59aZrPXDDj9S3PKmtfuIDTyWeevyoRZd6CVNR
   +kjl9PrwHXOlYo1RCh1KN1O91KPAL80sBFFPr4bHHzZzYDrLSrBeU3I0g
   sfIrlEBwDV+u98UkJJHHBnZHuc021igcP9CHuflQvIoja9tYIUuBF2n2S
   mXRiz7W3RkqzxyCM+rKQp+Djgxgt42HVYyG7eQ28ddlqjQyidFx5nAvPg
   k2x0BQ6SaTG/CqO1Rw6q+loJGUaBkgsRQO6BpwVs/l0FWnxTSao1rK9/0
   tG4VczNneRZ7QvZEd6dFcvtnv9xKtkg00oeP3XjATmlsU5zxuT9kmwIEO
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="305219169"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="305219169"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 10:38:17 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="734334718"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="734334718"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.213.175.138]) ([10.213.175.138])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 10:38:15 -0700
Message-ID: <ae8330db-ab77-7952-e846-de7dc527890c@intel.com>
Date:   Wed, 19 Oct 2022 10:38:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.3.3
Subject: Re: [PATCH RFC v2 0/9] cxl/pci: Add fundamental error handling
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, alison.schofield@intel.com,
        vishal.l.verma@intel.com, bwidawsk@kernel.org,
        dan.j.williams@intel.com, shiju.jose@huawei.com, rrichter@amd.com
References: <166336972295.3803215.1047199449525031921.stgit@djiang5-desk3.ch.intel.com>
 <20221011151744.00005278@huawei.com>
 <1e4de3fa-4e80-cc99-7fbf-3f6669766648@intel.com>
 <20221011181915.000031a1@huawei.com> <20221019183012.00007201@huawei.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20221019183012.00007201@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


On 10/19/2022 10:30 AM, Jonathan Cameron wrote:
> On Tue, 11 Oct 2022 18:19:15 +0100
> Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
>
>> On Tue, 11 Oct 2022 08:18:34 -0700
>> Dave Jiang <dave.jiang@intel.com> wrote:
>>
>>> On 10/11/2022 7:17 AM, Jonathan Cameron wrote:
>>>> On Fri, 16 Sep 2022 16:10:53 -0700
>>>> Dave Jiang <dave.jiang@intel.com> wrote:
>>>>     
>>>>> Series set to RFC since there's no means to test. Would like to get opinion
>>>>> on whether going with using trace events as reporting mechanism is ok.
>>>>>
>>>>> Jonathan,
>>>>> We currently don't have any ways to test AER events. Do you have any plans
>>>>> to support AER events via QEMU emulation?
>>>> Sorry - missed this entirely as gotten a bit behind reading CXL emails.
> Hi Dave,
>
> Quick update.
>
> Working QEMU emulation - but needs some/lots of cleanup. Particularly fun was
> figuring out why I wasn't getting messages past the upstream switch port.
> Turned out the serial number ECAP was on top of the AER ECAP. Oops - thankfully
> that patch isn't upstream yet.
> Also QEMU AER rooting seems to be based on some older PCIE spec
> so needed some tweaks to get the device to actually issue ERR_FATAL etc.
>
> Anyhow, should have something you can play with in a day or two.

Awesome! Thanks! :)


> In meantime an example dump (not writing the header log yet!)
>
> pcieport 0000:0c:00.0: AER: Uncorrected (Non-Fatal) error received: 0000:0f:00.0
> cxl_pci 0000:0f:00.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Requester ID)
> cxl_pci 0000:0f:00.0:   device [8086:0d93] error status/mask=00004000/00000000
> cxl_pci 0000:0f:00.0:    [14] CmpltTO                (First)
> cxl_ras_uc: mem3: status: 'Cache Data Parity Error' first_error: 'Cache Data Parity Error' header log: {0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0}
> cxl_pci 0000:0f:00.0: mem3: restart CXL.mem after slot reset
> cxl_port endpoint6: No CMA mailbox
> cxl_pci 0000:0f:00.0: mem3: error resume successful
> pcieport 0000:0e:00.0: AER: device recovery successful
>
> Jonathan
