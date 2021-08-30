Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B985C432BE
	for <linux-cxl@archiver.kernel.org>; Mon, 30 Aug 2021 19:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3299460C3F
	for <linux-cxl@archiver.kernel.org>; Mon, 30 Aug 2021 19:06:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbhH3THN (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 30 Aug 2021 15:07:13 -0400
Received: from mga04.intel.com ([192.55.52.120]:9862 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233062AbhH3THN (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Mon, 30 Aug 2021 15:07:13 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10092"; a="216485286"
X-IronPort-AV: E=Sophos;i="5.84,364,1620716400"; 
   d="scan'208";a="216485286"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2021 12:06:16 -0700
X-IronPort-AV: E=Sophos;i="5.84,364,1620716400"; 
   d="scan'208";a="530548163"
Received: from lopezale-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.130.82])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2021 12:06:15 -0700
Date:   Mon, 30 Aug 2021 12:06:13 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH 1/3] cxl: Fixed defined but not used warnings
Message-ID: <20210830190613.2zn47o4d44p3ud5k@intel.com>
References: <20210830171726.2342558-1-ben.widawsky@intel.com>
 <CAPcyv4grX3ppzs9gO991s56pbMokU-G75gkV2y+9Cv8ET7d2Xw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4grX3ppzs9gO991s56pbMokU-G75gkV2y+9Cv8ET7d2Xw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 21-08-30 11:49:05, Dan Williams wrote:
> On Mon, Aug 30, 2021 at 10:17 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
> >
> > This fixes unused-const-variable warnings emitted by gcc when cxlmem.h
> > is used by pretty much all files except pci.c
> >
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > ---
> >  include/uapi/linux/cxl_mem.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
> > index f6e8a005b113..1236dd9ffe23 100644
> > --- a/include/uapi/linux/cxl_mem.h
> > +++ b/include/uapi/linux/cxl_mem.h
> > @@ -50,7 +50,7 @@ enum { CXL_CMDS };
> >  #define ___C(a, b) { b }
> >  static const struct {
> >         const char *name;
> > -} cxl_command_names[] = { CXL_CMDS };
> > +} cxl_command_names[] __maybe_unused = { CXL_CMDS };
> 
> Since this is a uapi header does this need to be the raw
> "__attribute__((__unused__))"?

Good catch. I grepped uapi dir and interestingly didn't find other examples of
unused... Feeling a bit special snowflake now.
