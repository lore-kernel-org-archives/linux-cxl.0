Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0624BC433EF
	for <linux-cxl@archiver.kernel.org>; Wed, 27 Oct 2021 15:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCA0061090
	for <linux-cxl@archiver.kernel.org>; Wed, 27 Oct 2021 15:04:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237529AbhJ0PHC (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 27 Oct 2021 11:07:02 -0400
Received: from mga12.intel.com ([192.55.52.136]:52586 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235373AbhJ0PG5 (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Wed, 27 Oct 2021 11:06:57 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10150"; a="210262584"
X-IronPort-AV: E=Sophos;i="5.87,187,1631602800"; 
   d="scan'208";a="210262584"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2021 08:04:31 -0700
X-IronPort-AV: E=Sophos;i="5.87,187,1631602800"; 
   d="scan'208";a="597390938"
Received: from rtrevest-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.136.107])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2021 08:04:31 -0700
Date:   Wed, 27 Oct 2021 08:04:29 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     YE Chengfeng <cyeaa@connect.ust.hk>
Cc:     "alison.schofield@intel.com" <alison.schofield@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-cxl@vger.kernel.org
Subject: Re: drivers/cxl: suspected null pointer dereference in core/bus.c
Message-ID: <20211027150429.ofg4vnwmnkj4aiky@intel.com>
References: <TYCP286MB1188F633AE0B7A52EB6917478A859@TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYCP286MB1188F633AE0B7A52EB6917478A859@TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 21-10-27 11:35:25, YE Chengfeng wrote:
> Hi,
> 
> https://github.com/torvalds/linux/blob/master/drivers/cxl/core/bus.c#L98
> 
> We notice that in multiple call sites, the return pointer of to_cxl_decoder is not null-checked, could it be a potential null-pointer-dereference problem?
> 
> This is detected by our experimental static analysis tool, it could be false positive, we manually check and report those we think may be true issues. Would you like to have a look at them?
> 
> Thanks so much,
> Chengfeng

add linux-cxl...

If NULL is returned, it's a driver bug. The WARN_ON and subsequent NULL deref
oops is desirable.
