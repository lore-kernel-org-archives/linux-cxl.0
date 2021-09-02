Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE0B3C83029
	for <linux-cxl@archiver.kernel.org>; Thu,  2 Sep 2021 17:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A05E3610C8
	for <linux-cxl@archiver.kernel.org>; Thu,  2 Sep 2021 17:09:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346482AbhIBRKf (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 2 Sep 2021 13:10:35 -0400
Received: from mga01.intel.com ([192.55.52.88]:53579 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234534AbhIBRKf (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 2 Sep 2021 13:10:35 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10095"; a="241469000"
X-IronPort-AV: E=Sophos;i="5.85,262,1624345200"; 
   d="scan'208";a="241469000"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2021 10:09:36 -0700
X-IronPort-AV: E=Sophos;i="5.85,262,1624345200"; 
   d="scan'208";a="689219419"
Received: from kappusam-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.143.117])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2021 10:09:35 -0700
Date:   Thu, 2 Sep 2021 10:09:33 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH 3/3] cxl/docs: Remove undocumented references
Message-ID: <20210902170933.emi4justeyel5elf@intel.com>
References: <20210830171726.2342558-1-ben.widawsky@intel.com>
 <20210830171726.2342558-3-ben.widawsky@intel.com>
 <CAPcyv4iA9CywmxsT9GbOVhNcpdM1Bc4XNe69FuPLFiTuQvL+HQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4iA9CywmxsT9GbOVhNcpdM1Bc4XNe69FuPLFiTuQvL+HQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 21-09-01 12:18:59, Dan Williams wrote:
> On Mon, Aug 30, 2021 at 10:17 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
> >
> > When the core pmem and regs implementation was added, there were no
> > structured comments added. This change allows docs to be generated
> > without warnings.
> >
> 
> Hmm, might be better to go the other and fix this with patches to add
> documentation. At least devm_cxl_add_nvdimm_bridge() would benefit and
> regs.c has some kernel-doc annotations, just needs the header section
> added.

That'd be my preference, but I'll leave that to you if that's okay.
