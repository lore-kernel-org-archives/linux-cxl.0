Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8532DC433DB
	for <linux-cxl@archiver.kernel.org>; Fri, 26 Feb 2021 20:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46D1F64F0E
	for <linux-cxl@archiver.kernel.org>; Fri, 26 Feb 2021 20:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbhBZU4V (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 26 Feb 2021 15:56:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbhBZU4T (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 26 Feb 2021 15:56:19 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE99DC061788;
        Fri, 26 Feb 2021 12:55:38 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lFk90-0019jq-Ld; Fri, 26 Feb 2021 20:55:26 +0000
Date:   Fri, 26 Feb 2021 20:55:26 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, ben.widawsky@intel.com,
        dan.j.williams@intel.com, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cxl: Make loop variable be 'i' instead of 'j'
Message-ID: <YDlgPpoW86GCkhQE@zeniv-ca.linux.org.uk>
References: <20210226204552.45399-1-konrad.wilk@oracle.com>
 <20210226204552.45399-2-konrad.wilk@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210226204552.45399-2-konrad.wilk@oracle.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Feb 26, 2021 at 03:45:52PM -0500, Konrad Rzeszutek Wilk wrote:
> .. otherwise people spend extra cycles looking for the
> inner loop and wondering 'why j'?
> 
> This was an over-sight when initial work was rebased
> so lets fix it here.
> 
> Fixes: 583fa5e71cae ("cxl/mem: Add basic IOCTL interface")
  ^^^^^

34 days too early; otherwise, that's a damn good contender...
