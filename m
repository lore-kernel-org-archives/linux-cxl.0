Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D54B0C433EF
	for <linux-cxl@archiver.kernel.org>; Wed, 27 Oct 2021 22:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD12A60EBD
	for <linux-cxl@archiver.kernel.org>; Wed, 27 Oct 2021 22:43:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbhJ0Wpv (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 27 Oct 2021 18:45:51 -0400
Received: from mga03.intel.com ([134.134.136.65]:14391 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229993AbhJ0Wpu (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Wed, 27 Oct 2021 18:45:50 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10150"; a="230228895"
X-IronPort-AV: E=Sophos;i="5.87,188,1631602800"; 
   d="scan'208";a="230228895"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2021 15:43:22 -0700
X-IronPort-AV: E=Sophos;i="5.87,188,1631602800"; 
   d="scan'208";a="447414496"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2021 15:43:21 -0700
Date:   Wed, 27 Oct 2021 15:43:21 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH 0/9] CDAT/DSMAS reading and cleanups
Message-ID: <20211027224321.GA3538886@iweiny-DESK2.sc.intel.com>
References: <20210617221620.1904031-4-ira.weiny@intel.com>
 <20211027224043.3551125-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211027224043.3551125-1-ira.weiny@intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Oct 27, 2021 at 03:40:34PM -0700, 'Ira Weiny' wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> This really should be 2 series and a single patch for the cxl_mem change.
> 
> But for internal review I'm just going to throw it out on email to see what
> others think.

Sorry for the noise.  Somehow the public email got in my to list.  These should
be coming out soon.  But there are still a couple of questions and the series
should be 3 sets not 1.

Ira

