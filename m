Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A894C77B60
	for <linux-cxl@archiver.kernel.org>; Fri, 28 Apr 2023 17:37:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjD1Rhc (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 28 Apr 2023 13:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjD1Rhb (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 28 Apr 2023 13:37:31 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF261BE9
        for <linux-cxl@vger.kernel.org>; Fri, 28 Apr 2023 10:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682703451; x=1714239451;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZPaIa3yTl6P52p6h3BrYMzTorkgUlGhYXvpG3aZ02l8=;
  b=KgG0DLQXN90ZX0jFXuXvYjMAj1z/OybPYuqqULFNDAxYS3WxJ7fpqhfT
   OTLynOlAAvusLtgQVFBq6U6pnKTGSk+uKkBMCA0JAjRFU5fxrtIkTKj8K
   3lZAqwvrhYQFT6GkIdaWW1GnXsj52ENEwtJuSdoPYzWXm3vFK1RLsX+ku
   TwwViFR+o6kkVgbHnlwI23m81dqy6JAi4dXkyuuyqbKnqaCtdfXu0W7kG
   sJxFBKAxZg5rzsiF9fRz6BItWNo0xWFdFbF07BYP1HMJkNUUciDDru73L
   JVb0CBaOopAyBlEzJLFCMqY7m+mNRb+5HZRReFKBh+ZYomRwYE+YEgHqY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10694"; a="345257339"
X-IronPort-AV: E=Sophos;i="5.99,235,1677571200"; 
   d="scan'208";a="345257339"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2023 10:37:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10694"; a="727612817"
X-IronPort-AV: E=Sophos;i="5.99,235,1677571200"; 
   d="scan'208";a="727612817"
Received: from egliskay-mobl.amr.corp.intel.com (HELO [10.212.108.170]) ([10.212.108.170])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2023 10:37:29 -0700
Message-ID: <1f4edad0-07a4-e50d-d178-8ea6ca71b8ae@intel.com>
Date:   Fri, 28 Apr 2023 10:37:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH 3/7] cxl/mbox: Add sanitation handling machinery
Content-Language: en-US
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     dan.j.williams@intel.com, Jonathan.Cameron@huawei.com,
        alison.schofield@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, fan.ni@samsung.com,
        a.manzanares@samsung.com, linux-cxl@vger.kernel.org
References: <20230421092321.12741-1-dave@stgolabs.net>
 <20230421092321.12741-4-dave@stgolabs.net>
 <46b76304-e75f-9a1a-296d-f67237d246d5@intel.com>
 <rquzz5rz4il2n3jo7eaqwmzadxjzjw7lkmydvgmrpwwaqkhfqt@odc2nwg6i5vu>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <rquzz5rz4il2n3jo7eaqwmzadxjzjw7lkmydvgmrpwwaqkhfqt@odc2nwg6i5vu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 4/28/23 9:46 AM, Davidlohr Bueso wrote:
> On Fri, 28 Apr 2023, Dave Jiang wrote:
> 
>>>  static irqreturn_t cxl_pci_mbox_irq(int irq, void *id)
>>>  {
>>>     struct cxl_dev_state *cxlds = id;
>>> +    u64 reg;
>>> +    u16 opcode;
>>>     /* spurious or raced with hw? */
>>>     if (!cxl_mbox_background_complete(cxlds)) {
>>> @@ -107,12 +109,47 @@ static irqreturn_t cxl_pci_mbox_irq(int irq, 
>>> void *id)
>>>         goto done;
>>>     }
>>> -    /* short-circuit the wait in __cxl_pci_mbox_send_cmd() */
>>> -    wake_up(&mbox_wait);
>>> +    reg = readq(cxlds->regs.mbox + CXLDEV_MBOX_BG_CMD_STATUS_OFFSET);
>>> +    opcode = FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_OPCODE_MASK, reg);
>>> +
>>> +    if (opcode == CXL_MBOX_OP_SANITIZE) {
>>> +        dev_dbg(cxlds->dev, "Sanitation operation ended\n");
>>
>> I might be missing something. Do we not want to stop waiting as well
>> if the sanitation operation has ended?
> 
> The thing here is that sanitize won't ever use the mbox_wait, which is
> what makes it special (asynchronous).
> 
> So while in theory patch 2 enables sanitize to be in the synchronous path,
> it can never occur because there is nothing there yet to trigger it (or
> anything else for that matter). And this patch ensures that the sanitize
> is isolated within __cxl_pci_mbox_send_cmd().

Gotcha. Thanks for the explanation.
> 
> Thanks,
> Davidlohr
