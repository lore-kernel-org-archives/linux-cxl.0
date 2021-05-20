Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64421C43460
	for <linux-cxl@archiver.kernel.org>; Thu, 20 May 2021 10:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 320F4610CB
	for <linux-cxl@archiver.kernel.org>; Thu, 20 May 2021 10:54:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238757AbhETKzV (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 20 May 2021 06:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239235AbhETKwu (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 20 May 2021 06:52:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1271BC06137B
        for <linux-cxl@vger.kernel.org>; Thu, 20 May 2021 02:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=s5r1lOz0PYZ76pCLkA2QJgDqfvF/vkSu0F1WJ4ZUR48=; b=YRXb4BNhsD4SUVV+5FCFLKvxpH
        sFakO8EDZi0fQCrWISbmzqWJO+h3rONbgQhUANNWcoaQyCExGKdH+9rWpw2GOoB+dtHlV3i2czQcL
        3m+UC78Ozy4nWrrYr/aokk71TAvdI/B0b6+WEr+Yzz9f09SpEnvlIXYFE9Gl369N1weFUkj8XPXcW
        Yd2dHgmLiEmYYhJUaJhpT3FPOrBn0sunOVsIKLTnF9bST4STnBBFf7nNtfjA6G2QOXZplSHw2qJUZ
        //RubEWtf0pt/dUZ5VZj6jsRcCq5xLRAj3fPbJJcewXmfAEopDt3fvx8VGIeuczz7hgNRLYv9iMFu
        nuevt2Ww==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1ljfMw-00FnXg-Tp; Thu, 20 May 2021 09:53:50 +0000
Date:   Thu, 20 May 2021 10:53:30 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Ariel.Sibley@microchip.com
Cc:     linux-cxl@vger.kernel.org, Ahmad.Danesh@microchip.com,
        cpetersen@fb.com, mahesh.natu@intel.com, dan.j.williams@intel.com,
        Vincent.Hache@microchip.com, Sanjay.Goyal@microchip.com,
        scolee@microsoft.com, jhinkle@lenovo.com,
        guru.anbalagane@microsoft.com, kevin.marks@dell.com,
        bhirano@micron.com, chet.r.douglas@intel.com, dcaracci@micron.com,
        jgroves@micron.com, andy.rudoff@intel.com
Subject: Re: CXL Vendor Specific Capabilities
Message-ID: <YKYxmpzIHdc3yI5X@infradead.org>
References: <MN2PR11MB36459D88FEB3BB66E5844DE7882B9@MN2PR11MB3645.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR11MB36459D88FEB3BB66E5844DE7882B9@MN2PR11MB3645.namprd11.prod.outlook.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

> 
> The default/recommended value of the CONFIG_CXL_MEM_RAW_COMMANDS Kconfig knob will block passthrough of vendor defined mailbox commands.  If this Kconfig knob is enabled, passthrough of vendor defined commands will still taint the kernel.

Please fix your mailer, this badly wrapped wall of text is completely
unreadable.
