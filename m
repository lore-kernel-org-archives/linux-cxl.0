Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E45C433EF
	for <linux-cxl@archiver.kernel.org>; Sun, 31 Oct 2021 18:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE07C60FBF
	for <linux-cxl@archiver.kernel.org>; Sun, 31 Oct 2021 18:41:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbhJaSoa (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 31 Oct 2021 14:44:30 -0400
Received: from mga12.intel.com ([192.55.52.136]:51518 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230041AbhJaSoa (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Sun, 31 Oct 2021 14:44:30 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10154"; a="210960132"
X-IronPort-AV: E=Sophos;i="5.87,197,1631602800"; 
   d="scan'208";a="210960132"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2021 11:41:53 -0700
X-IronPort-AV: E=Sophos;i="5.87,197,1631602800"; 
   d="scan'208";a="637597286"
Received: from jwcarin-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.132.129])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2021 11:41:51 -0700
Date:   Sun, 31 Oct 2021 11:41:50 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, "Weiny, Ira" <ira.weiny@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH] cxl/core: Convert to EXPORT_SYMBOL_NS_GPL
Message-ID: <20211031184150.blkw7ioxo3ln6hkk@intel.com>
References: <163555506776.2553440.17247681249660176777.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20211031183123.m6wors3hizsbm7cd@intel.com>
 <CAPcyv4i7iakV7drgPwVjBRgB-j4EhahtQn6B0mhGaAx9RKOWpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4i7iakV7drgPwVjBRgB-j4EhahtQn6B0mhGaAx9RKOWpg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 21-10-31 11:35:11, Dan Williams wrote:

[snip]

> 
> I can't see any reason to have plain EXPORT_SYMBOL_GPL() for these, we
> *want* other users to declare the CXL namespace.

Why do we care if they declare CXL namespace?
