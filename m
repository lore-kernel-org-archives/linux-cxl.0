Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0323C433F5
	for <linux-cxl@archiver.kernel.org>; Thu, 17 Mar 2022 17:33:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236934AbiCQRfI (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 17 Mar 2022 13:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236933AbiCQRfI (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 17 Mar 2022 13:35:08 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D85D1CDB
        for <linux-cxl@vger.kernel.org>; Thu, 17 Mar 2022 10:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647538432; x=1679074432;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5PO4TvKSahAQUhYWVY3VmbK524c1K9JN5HXHK2cWD8s=;
  b=kWF8DL30y2QAX6706aXphNIWuaXSndWVdqK7R3FYFYjeR24vRpmAo5Cw
   pG7VC70nfqt1LCjCg7bWLx3+sOlZjBzl6epWNTWYn9i7e2kNN+DpNOSol
   rrtCfj8aHUHiEFVpij0O2L4jgirEyHF1Jr2HKtDNrX+uQ8i1bN3ZJ6UHT
   vHNb5veey/1EwR2aMtxt723PPdvmirO8mx2OK6/rIgltlyUh9uD15QJqY
   Y/GAOo9jYrQSyPiDc7LTRcaMDZxJznkVfGN7v0wuR1SU/4aEAno5vuVJG
   LFnGfUh6yc1jsng+NqJSap9Ipb7HE3CocK2u5sE/mzMpfk6WIS4DrlCzr
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="237545155"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="237545155"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 10:33:51 -0700
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="614070050"
Received: from dshkut-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.132.229])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 10:33:51 -0700
Date:   Thu, 17 Mar 2022 10:33:44 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com
Subject: Re: [PATCH v2 1/6] cxl/mem: Drop DVSEC vs EFI Memory Map sanity check
Message-ID: <20220317173344.ub2zacvjbql2553j@intel.com>
References: <164730733718.3806189.9721916820488234094.stgit@dwillia2-desk3.amr.corp.intel.com>
 <164730734246.3806189.13995924771963139898.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164730734246.3806189.13995924771963139898.stgit@dwillia2-desk3.amr.corp.intel.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 22-03-14 18:22:22, Dan Williams wrote:
> When the driver finds legacy DVSEC ranges active on a CXL Memory
> Expander it indicates that platform firmware is not aware of, or is
> deliberately disabling common CXL 2.0 operation. In this case Linux
> generally has no choice, but to leave the device alone.
> 
> The driver attempts to validate that the DVSEC range is in the EFI
> memory map. Remove that logic since there is no requirement that the
> BIOS publish DVSEC ranges in the EFI Memory Map.
> 
> In the future the driver will want to permanently reserve this capacity
> out of the available CFMWS capacity and hide it from
> request_free_mem_region(), but it serves no purpose to warn about the
> range not appearing in the EFI Memory Map.
> 
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Ben Widawsky <ben.widawsky@intel.com>
