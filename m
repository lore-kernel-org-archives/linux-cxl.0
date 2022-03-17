Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 189CAC433EF
	for <linux-cxl@archiver.kernel.org>; Thu, 17 Mar 2022 17:49:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235168AbiCQRvC (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 17 Mar 2022 13:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiCQRvB (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 17 Mar 2022 13:51:01 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 390211F6356
        for <linux-cxl@vger.kernel.org>; Thu, 17 Mar 2022 10:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647539385; x=1679075385;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2kWgYtUetTL+GPHmOTLp5Jz4yB/ob1G/OQuIZ2wc+/E=;
  b=Gu+8puV8ruI3mxLVqAa3628Dhn1NVxO1zEpUpCjHfVBb7+rmCqJOLaOB
   iD1MO0LyzlMEnmFbKqjvcgfPxVOM9BqD6OWi3upQ2vh8VN8mzWRCvJSYm
   aYPS0CCCfJByFOx4LEN7n6tFhEGo46h+A4sxtTDDm6q6Ulv6PWV1T3KU4
   6E9syqrBOUrul4eRRio8vcC3dQRdJVO8cOUplSdsluUd7ZeecD1TVED5L
   kMMo+7vwl8NbOp4DnnKH/nvdoeqCWmAqnPL11Z8rGSzFiyAVIoqBnMMAd
   ORNVhhXkiRB/124EqX+6bFnLnpustK5Xx3dLuYPW/LtauPrQq6aPVdv5y
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="281729827"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="281729827"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 10:49:44 -0700
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="516857004"
Received: from dshkut-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.132.229])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 10:49:44 -0700
Date:   Thu, 17 Mar 2022 10:49:37 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com
Subject: Re: [PATCH v2 3/6] cxl/mem: Make cxl_dvsec_range() init failure fatal
Message-ID: <20220317174937.oo7susttkesbjymy@intel.com>
References: <164730733718.3806189.9721916820488234094.stgit@dwillia2-desk3.amr.corp.intel.com>
 <164730735324.3806189.4167509857771192422.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164730735324.3806189.4167509857771192422.stgit@dwillia2-desk3.amr.corp.intel.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 22-03-14 18:22:33, Dan Williams wrote:
> In preparation for the cxl_pci driver to continue operation after
> cxl_dvsec_range() failure, update cxl_mem to check for negative error
> codes in info->ranges. Treat that condition as fatal regardless of the
> state of the HDM configuration since cxl_mem needs positive confirmation
> that legacy ranges were not established by platform firmware or another
> agent.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Ben Widawsky <ben.widawsky@intel.com>
