Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B733C64EC4
	for <linux-cxl@archiver.kernel.org>; Tue, 28 Feb 2023 23:35:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjB1Xft (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 28 Feb 2023 18:35:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjB1Xfs (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 28 Feb 2023 18:35:48 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00882B619
        for <linux-cxl@vger.kernel.org>; Tue, 28 Feb 2023 15:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677627341; x=1709163341;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ecQqsFnsMfE7MXdT5oMG0KuaaonWrisPbyX6k46xhwk=;
  b=nz7gSEy1Ax/xmsigc7QCafaNoz038dx7HJUfmyhCJv9qpbiW9VHJHyxD
   jbtydYnCURdcE4nvaAjFgkwSwSBjYTX3QGqB9kdRfJHh+FbU5cEab3yp8
   z23eStCzgKkwr+CEo7QDTZ3UwyO36Z8o3RPDBA/NcT0jSkrHxAE8eqR0p
   xo0R3dF2oA0SuCPvShPh9wfiqoc1qalOrjGaqgng686LF3RAjM4a1NGeX
   EbGzpaomcw3415mKjNcooCL6IbpVkgQbj0mtu0YCgzJIe/Hj7SeYomOot
   lKvacvC4pzkSklSWKnNBMaxs2H1Ncqn4gjoszVRCS8ZrpHKwrR69Eygv/
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="361850415"
X-IronPort-AV: E=Sophos;i="5.98,223,1673942400"; 
   d="scan'208";a="361850415"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2023 15:35:36 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="676492784"
X-IronPort-AV: E=Sophos;i="5.98,223,1673942400"; 
   d="scan'208";a="676492784"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.1.236]) ([10.212.1.236])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2023 15:35:35 -0800
Message-ID: <19e29949-6003-3d90-75d7-735c35b0e279@intel.com>
Date:   Tue, 28 Feb 2023 16:35:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH 1/7] cxl/mbox: Add background cmd handling machinery
Content-Language: en-US
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     dan.j.williams@intel.com, jonathan.cameron@huawei.com,
        ira.weiny@intel.com, fan.ni@samsung.com, a.manzanares@samsung.com,
        linux-cxl@vger.kernel.org
References: <20230224194652.1990604-1-dave@stgolabs.net>
 <20230224194652.1990604-2-dave@stgolabs.net>
 <029b177d-7b91-77f7-a830-5f5ebe3ab0b8@intel.com>
 <20230228201848.b73ralnihs6rbceg@offworld>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230228201848.b73ralnihs6rbceg@offworld>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 2/28/23 1:18 PM, Davidlohr Bueso wrote:
> On Tue, 28 Feb 2023, Dave Jiang wrote:
>>> +
>>> +        dev_dbg(dev, "Mailbox background operation completed\n");
>>
>> May be helpful to also emit the return_code in case of errors.
> 
> Agreed, but that's given next:
> 
>>
>>> +    }
>>> +
>>>     if (mbox_cmd->return_code != CXL_MBOX_CMD_RC_SUCCESS) {
>>>         dev_dbg(dev, "Mailbox operation had an error: %s\n",
>>>             cxl_mbox_cmd_rc2str(mbox_cmd));
> 
> here.

Ah ok.

> 
> Thanks,
> Davidlohr
