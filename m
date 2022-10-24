Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E437C38A2D
	for <linux-cxl@archiver.kernel.org>; Mon, 24 Oct 2022 18:13:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232531AbiJXSN1 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 24 Oct 2022 14:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232673AbiJXSMx (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 24 Oct 2022 14:12:53 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3445F26ED86
        for <linux-cxl@vger.kernel.org>; Mon, 24 Oct 2022 09:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666630482; x=1698166482;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vuLfQ3gT2ojnUQGL80Fqo/IUaxiAjLUclp9WGHAyxoQ=;
  b=VGS7SwzRdcp4nwnHVMwEjE9rlcwi/9oq8VyJxSan9NBq1Z2AMjLWF28Q
   41aRmNBIWfsWYBsTJw2N48DCnFGjJUhNKH/F3IiQE6wx5fhaGmVybFzsM
   1Gx4UmvHqC/KaUo9pIZ8isMdwdB7QSw2JRYbIVUer/W6y7yArOclIKjUp
   m6C9E9jtovG/57ZHaq8Ybz8XUziXJlxeChLhKqOalyiZ59Xsgktkfmfve
   CvwGKCpFPdL2MiRP0UmJK4VVcsHX4jaSD9BaqLxa44VhzuD0OV5AV/fwq
   dsWxiZYDZnsVOLO7qc9U8Zy4/Gony4kHsFwa2fyDgsbga8Dq4z/X/utdK
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="290756726"
X-IronPort-AV: E=Sophos;i="5.95,209,1661842800"; 
   d="scan'208";a="290756726"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 08:49:21 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="582457603"
X-IronPort-AV: E=Sophos;i="5.95,209,1661842800"; 
   d="scan'208";a="582457603"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.212.92.195]) ([10.212.92.195])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 08:49:21 -0700
Message-ID: <941ad4ec-57b8-72e5-f65d-2d714f53e16f@intel.com>
Date:   Mon, 24 Oct 2022 08:49:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.0
Subject: Re: [PATCH v2] cxl: update names for interleave granularity
 conversion macros
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com
References: <166559536239.2130185.18009064249679668239.stgit@djiang5-desk3.ch.intel.com>
 <20221013132135.000054cd@huawei.com>
 <63546550ac59c_14192949f@dwillia2-mobl3.amr.corp.intel.com.notmuch>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <63546550ac59c_14192949f@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


On 10/22/2022 2:49 PM, Dan Williams wrote:
> Jonathan Cameron wrote:
>> On Wed, 12 Oct 2022 10:23:23 -0700
>> Dave Jiang <dave.jiang@intel.com> wrote:
>>
>>> Change names for granularity macros to clearly indicate which
>>> variable is encoded and which is the actual granularity.
>>>
>>> granularity == interleave granularity
>>> enig == encoded interleave granularity
>> I'm not that bothered, but just wanted to note we have uses
>> of eig for this already.  Maybe better to pick either enig or
>> eig throughout ?
> Yes, please 'eig' already exists for this purpose, and I would keep the
> cxl_ prefix. Same on the 'eiw' patch.

Ok I'll update those. Seems like my mail client ate Jonathan's response 
on these. :(

