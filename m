Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B344C77B75
	for <linux-cxl@archiver.kernel.org>; Mon, 22 May 2023 15:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233410AbjEVPTG (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 22 May 2023 11:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233312AbjEVPTF (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 22 May 2023 11:19:05 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCD4CD
        for <linux-cxl@vger.kernel.org>; Mon, 22 May 2023 08:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684768742; x=1716304742;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gt5kZ1g2Hm68dDnO8etBAEt8IovhDNYiTb23E49oOss=;
  b=Vp4cZq3jo5/LHCHO+3w9aDVSTWBYwLtd+Kclr5bxDenkNjRrld37MrHs
   GSoHEgp4dPY3PUU6sYk4cSQHvS5MrSzqI/QTNFDKB7zZbCytosKCXYMa+
   HmPS8PtJB5+Ru2FeEbt0PQYmMmDa/zsskRrb4MgXV0VwlbiU2X0H8vqWv
   KINvkdiqRVzYk5hxgI5v/bmHxY80lnx3Yf9SazDQp99L7RrqzcuIQrbi/
   z5ZfE+b7RM3w6nog9UL83qPgQBnCpeHBgEQbj7/LGTVKt3UiepRgF9WGf
   zoWMNfF0eBZHbss4PzBkjZHQdgf726eM62mP+DOelAb/RRBy3fODbqvcd
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="332562757"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="332562757"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 08:19:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="773395721"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="773395721"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.213.173.219]) ([10.213.173.219])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 08:19:02 -0700
Message-ID: <2393ba5c-853b-1b09-00f4-0b81d17bebe4@intel.com>
Date:   Mon, 22 May 2023 08:19:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [ndctl PATCH 0/6] cxl/monitor and ndctl/monitor fixes
Content-Language: en-US
To:     "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>
Cc:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
References: <20230513142038.753351-1-lizhijian@fujitsu.com>
 <931ad127-4ff5-20b3-d551-9a144b3cd7c8@intel.com>
 <29c0e53f-689e-62d3-dcf7-bcf0ca88d919@fujitsu.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <29c0e53f-689e-62d3-dcf7-bcf0ca88d919@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 5/21/23 11:25 PM, Zhijian Li (Fujitsu) wrote:
> 
> 
> On 20/05/2023 01:47, Dave Jiang wrote:
>>
>>
>> On 5/13/23 7:20 AM, Li Zhijian wrote:
>>> It mainly fix monitor not working when log file is specified. For
>>> example
>>> $ cxl monitor -l ./cxl-monitor.log
>>> It seems that someone missed something at the begining.
>>>
>>> Furture, it compares the filename with reserved works more accurately
>>>
>>> Li Zhijian (6):
>>>     cxl/monitor: Fix monitor not working
>>>     cxl/monitor: compare the whole filename with reserved words
>>>     cxl/monitor: Enable default_log and refactor sanity check
>>>     cxl/monitor: always log started message
>>>     Documentation/cxl/cxl-monitor.txt: Fix inaccurate description
>>>     ndctl/monitor: compare the whole filename with reserved words
>>>
>>>    Documentation/cxl/cxl-monitor.txt |  3 +-
>>>    cxl/monitor.c                     | 47 ++++++++++++++++---------------
>>>    ndctl/monitor.c                   |  4 +--
>>>    3 files changed, 27 insertions(+), 27 deletions(-)
>>>
>>
>> Please cc linux-cxl@vger.kernel.org as well for future revs since this impacts CXL CLI.
> Yeah
> 
> I have double confirmed recipient in this repo by 'git grep @', look we have to document it
> in the CONTRIBUTING.md as well :)

Please feel free to submit a patch and rectify this. :)
