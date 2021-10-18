Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A34FC433EF
	for <linux-cxl@archiver.kernel.org>; Mon, 18 Oct 2021 00:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79A9760FF2
	for <linux-cxl@archiver.kernel.org>; Mon, 18 Oct 2021 00:15:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344831AbhJRARo (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 17 Oct 2021 20:17:44 -0400
Received: from mga07.intel.com ([134.134.136.100]:25267 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344846AbhJRARn (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Sun, 17 Oct 2021 20:17:43 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10140"; a="291620149"
X-IronPort-AV: E=Sophos;i="5.85,380,1624345200"; 
   d="scan'208";a="291620149"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2021 17:15:32 -0700
X-IronPort-AV: E=Sophos;i="5.85,380,1624345200"; 
   d="scan'208";a="593600043"
Received: from schoukse-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.135.20])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2021 17:15:32 -0700
Date:   Sun, 17 Oct 2021 17:15:31 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org, Chet Douglas <chet.r.douglas@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [RFC PATCH 00/27] CXL Region Creation / HDM decoder programming
Message-ID: <20211018001524.2wlexyctbxfzlsgf@intel.com>
References: <20211016051531.622613-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211016051531.622613-1-ben.widawsky@intel.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 21-10-15 22:15:04, Ben Widawsky wrote:
> CXL region creation

[snip]

One thing I left out. Several patches in the region verification and programming
are broken up into discrete steps. This was because this is how they were
developed and I believe it makes them easier to review. My preference is to keep
them broken out like this so the history reflects the development of this fairly
complex part of CXL driver development, however I do suspect review feedback
will suggest I squash several of the last patches. Ultimately I won't put up a
fight here.

Thanks.
Ben

