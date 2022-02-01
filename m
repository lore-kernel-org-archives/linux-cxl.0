Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3EA9C433F5
	for <linux-cxl@archiver.kernel.org>; Tue,  1 Feb 2022 18:29:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbiBAS3h (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 1 Feb 2022 13:29:37 -0500
Received: from mga11.intel.com ([192.55.52.93]:5707 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233406AbiBAS3g (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Tue, 1 Feb 2022 13:29:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643740176; x=1675276176;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=tYlmM1GbUp47uaDOK1PMsKk8/Sy5+Hf1SpapmRs/2P8=;
  b=Zs15RA239FAbVxQW51GXqeOGqos4jIMwq3T4FhzYlLer2mWAT5usoS7S
   hwNVr6eDPJLIwDEXsAD+EU3Xn9yhOwkM5wcsIND47a9KSv23mBz105lV1
   FlA7QHUdcIj1zLfxLvTWrFqAy91v0WSM4euu7C8HnlcmPpCIW8mr/0Bt5
   +ke8e50FIgbyMrNuB2PxKKEP6lW/k+HjyAdUwWN5hoJ1yJDArtFV2bSaO
   Tm2iOvIK9rrG5Q5w0u+Hf2MClwI9wt8fuChk5vI8hAit7mfMHURYbVSmX
   GDEwKUr3oEUlvpctHQTeL17hujJI25h22kZRvLQgrkWeGmpIKk+hk/kIq
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10245"; a="245352110"
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="245352110"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 10:29:36 -0800
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="698500887"
Received: from rashmigh-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.132.8])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 10:29:36 -0800
Date:   Tue, 1 Feb 2022 10:29:34 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        linuxarm@huawei.com,
        Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH] cxl/regs: Fix size of CXL Capability Header Register
Message-ID: <20220201182934.jjvavjsf4h7oqngv@intel.com>
References: <20220201153437.2873-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220201153437.2873-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 22-02-01 15:34:37, Jonathan Cameron wrote:
> In CXL 2.0, 8.2.5.1 CXL Capability Header Register: this register
> is given as 32 bits.
> 
> 8.2.3 which covers the CXL 2.0 Component registers, including the
> CXL Capability Header Register states that access restrictions
> specified in Section 8.2.2 apply.
> 
> 8.2.2 includes:
> * A 32 bit register shall be accessed as a 4 Byte quantity.
> ...
> If these rules are not followed, the behavior is undefined.
> 
> Discovered during review of CXL QEMU emulation. Alex Bennée pointed
> out there was a comment saying that 4 byte registers must be read
> with a 4 byte read, but 8 byte reads were being emulated.
> 
> https://lore.kernel.org/qemu-devel/87bkzyd3c7.fsf@linaro.org/
> 
> Fixing that, led to this code failing. Whilst a given hardware
> implementation 'might' work with an 8 byte read, it should not be relied
> upon. The QEMU emulation v5 will return 0 and log the wrong access width.
> 
> The code moved, so one fixes tag for where this will directly apply and
> also a reference to the earlier introduction of the code for backports.
> 
> Fixes: 0f06157e0135 ("cxl/core: Move register mapping infrastructure")
> Fixes: 08422378c4ad ("cxl/pci: Add HDM decoder capabilities")
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Alex Bennée <alex.bennee@linaro.org>

oops.
Reviewed-by: Ben Widawsky <ben.widawsky@intel.com>

[snip]

