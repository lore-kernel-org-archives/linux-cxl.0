Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04487C433FE
	for <linux-cxl@archiver.kernel.org>; Wed, 16 Nov 2022 22:23:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbiKPWXB (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 16 Nov 2022 17:23:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234299AbiKPWXA (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 16 Nov 2022 17:23:00 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1732C6A69C
        for <linux-cxl@vger.kernel.org>; Wed, 16 Nov 2022 14:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668637380; x=1700173380;
  h=message-id:date:mime-version:from:to:cc:subject:
   content-transfer-encoding;
  bh=ZzTYmJjMiKsOBmeMipwH/7JGpbSJPgk7RhIbR+sNUWk=;
  b=leIC+nzDf5powiuRF2MsJrhtnXekcpWq3GNIiApW1IugL0hD84mvE4m9
   Z8qCPah6NO4GJKqxb2UDZmwTIJ7eRR6yX9aU9BDAFrOsRwv+b+ANsOaOb
   GzbX2f1ZCB2xHUMQjK+Vp32DuCOKv7EP1/FAK0UCoKJ9TOQRe8fELilDD
   yHPmGq4ZEEJ5nLw0mZLwQl2CA3yS/rUqkTfACPKwTUprGddOv2deSWxyD
   BRjIvj/ssH0UzyqpefM/OnVm0ZobIRRGSup35ufSbZFJ9FhycgXRQQo++
   YOeV4HRBAH4Smv2IVRLT1xwbi6Tgl0wQvbeyPksjAnuIy4VDOcpQA/ZjU
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="296049090"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="296049090"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 14:22:59 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="884588484"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="884588484"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.212.31.244]) ([10.212.31.244])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 14:22:58 -0800
Message-ID: <775fd36b-1945-b286-b911-ea41371b1f94@intel.com>
Date:   Wed, 16 Nov 2022 15:22:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.1
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
To:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: RFC: Seeking to collect CXL spec v3.0 questions and clarifications
 against implementation
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hi All,
As Jonathan suggested [1], we should start a discussion thread to gather 
up questions / clarifications from the process of implementing CXL 
software against spec 3.0 so they can be fed back to the CXL SSWG.

I'll start with some from the implementation of persistent memory 
security commands:

CXL memdev Passphrase Secure Erase:
1. Command sent with master passphrase, but master passphrase disabled. 
While in v3 8.2.9.8.6.3 Disable Passphrase, it states clearly that "When 
the master passphrase is disabled, the device shall return invalid Input 
for the Passphrase Secure Erase command with the master passphrase", 
this sentence could be duplicated under 8.2.9.8.6.6 Passphrase Secure 
Erase to provide better clarity of device behavior.

2. Command sent with user passphrase, but user passphrase disabled. 
Needs clarification in 8.2.9.8.6.6 on device behavior. Under the 
"current passphrase" it indicates the field is ignored. Does this mean 
the secure erase proceed same as a "secure erase" command? This behavior 
is different than the master passphrase scenario above.

[1]: https://lore.kernel.org/linux-cxl/20221116113724.00006171@Huawei.com/
