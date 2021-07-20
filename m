Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A2DC636C8
	for <linux-cxl@archiver.kernel.org>; Tue, 20 Jul 2021 18:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81E256120D
	for <linux-cxl@archiver.kernel.org>; Tue, 20 Jul 2021 18:14:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbhGTReS (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 20 Jul 2021 13:34:18 -0400
Received: from mga12.intel.com ([192.55.52.136]:29132 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232118AbhGTReE (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Tue, 20 Jul 2021 13:34:04 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10051"; a="190888403"
X-IronPort-AV: E=Sophos;i="5.84,255,1620716400"; 
   d="scan'208";a="190888403"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2021 11:14:27 -0700
X-IronPort-AV: E=Sophos;i="5.84,255,1620716400"; 
   d="scan'208";a="632402235"
Received: from lesliemu-mobl1.amr.corp.intel.com (HELO intel.com) ([10.252.136.56])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2021 11:14:27 -0700
Date:   Tue, 20 Jul 2021 11:14:22 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH v2 1/6] cxl: Move cxl_core to new directory
Message-ID: <20210720181422.gcnmkydx6hz6dzdu@intel.com>
References: <CAPcyv4gbiNyKtzKkp2FgM5+k=FuodP0wKdNgh4ohH=E8fxQXwA@mail.gmail.com>
 <20210720180742.89992-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210720180742.89992-1-ben.widawsky@intel.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 21-07-20 11:07:42, Ben Widawsky wrote:
> CXL core is growing, and it's already arguably unmanageable. To support
> future growth, move core functionality to a new directory and rename the
> file to represent just bus support. Future work will remove non-bus
> functionality.
> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---
> v2: Create new Makefile for core (Dan)
> 
Dan, there's some minor conflicts as a result of this change. Let me know if
you'd like me to resend the series.

[snip]


