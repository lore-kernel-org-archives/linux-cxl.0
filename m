Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C3DC433F5
	for <linux-cxl@archiver.kernel.org>; Fri, 19 Nov 2021 01:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86AC361AE3
	for <linux-cxl@archiver.kernel.org>; Fri, 19 Nov 2021 01:48:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233384AbhKSBv1 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 18 Nov 2021 20:51:27 -0500
Received: from mga05.intel.com ([192.55.52.43]:59967 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231696AbhKSBv1 (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 18 Nov 2021 20:51:27 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10172"; a="320549804"
X-IronPort-AV: E=Sophos;i="5.87,246,1631602800"; 
   d="scan'208";a="320549804"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2021 17:48:25 -0800
X-IronPort-AV: E=Sophos;i="5.87,246,1631602800"; 
   d="scan'208";a="455584089"
Received: from dmkresin-mobl1.amr.corp.intel.com (HELO intel.com) ([10.252.138.155])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2021 17:48:24 -0800
Date:   Thu, 18 Nov 2021 17:48:22 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Shreyas Shah <shreyas.shah@elastics.cloud>
Cc:     Saransh Gupta1 <saransh@ibm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: Follow-up on the CXL discussion at OFTC
Message-ID: <20211119014822.j247ayrsdve4yxyu@intel.com>
References: <OF255704A1.78FEF164-ON0025878E.00821084-0025878F.00015560@ibm.com>
 <20211117165719.pqig62t5z2grgjvv@intel.com>
 <20211117173201.00002513@Huawei.com>
 <OF164E5BA6.E927FE73-ON00258791.0078E206-88258791.007ABBAD@ibm.com>
 <BY5PR12MB4179A47F68A9A15E5888D074E89B9@BY5PR12MB4179.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY5PR12MB4179A47F68A9A15E5888D074E89B9@BY5PR12MB4179.namprd12.prod.outlook.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 21-11-18 22:52:56, Shreyas Shah wrote:
> Hello Folks,
> 
> Any plan to add CXL2.0 switch ports in QEMU? 

What's your definition of plan?

> 
> Regards,
> Shreyas

[snip]
