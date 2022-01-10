Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C8FC433EF
	for <linux-cxl@archiver.kernel.org>; Mon, 10 Jan 2022 21:33:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344991AbiAJVdB (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 10 Jan 2022 16:33:01 -0500
Received: from mga01.intel.com ([192.55.52.88]:16584 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344989AbiAJVdB (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Mon, 10 Jan 2022 16:33:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641850381; x=1673386381;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=brF3Tq3zcjUx/PTED0CDpHaBOQSHSlt3Gb1lZ7GTOvg=;
  b=jF9oMdLlw9N/LyGTrT3td0R+932ayGXiY1TVmOqnU9RqoGuQLcHBV/i/
   qA+0UOGtudWJfP8dBswaaiHBsCnpPK505x3Bxr48IJld6J1sPhfILdNL/
   x+YAT1NFYuOYXSEbya0zvdEDaDc87+8DlBrsKXIiN+FyFFQae/TjN2F4F
   iX55WOoiXUL7ekRicrfxzpw/8bh2iCT2WsAZl46vzKB+4CCtrriD+yhlx
   XvAaanbDSqSb1Q7XX2gsJKWRyFYHmEvaASrUSchQV2vw9yEQO1oLO5vgA
   ueo8CkzDgFvwUj5lP9rtlB5pDCCciABavHAfujm7X3vhY3MnFsbd4wcye
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10223"; a="267659195"
X-IronPort-AV: E=Sophos;i="5.88,278,1635231600"; 
   d="scan'208";a="267659195"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 13:31:57 -0800
X-IronPort-AV: E=Sophos;i="5.88,278,1635231600"; 
   d="scan'208";a="669579275"
Received: from alison-desk.jf.intel.com (HELO alison-desk) ([10.54.74.41])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 13:31:57 -0800
Date:   Mon, 10 Jan 2022 13:37:01 -0800
From:   Alison Schofield <alison.schofield@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-cxl@vger.kernel.org
Subject: Re: [ndctl PATCH 7/7] cxl: add command set-partition-info
Message-ID: <20220110213701.GA817188@alison-desk>
References: <cover.1641233076.git.alison.schofield@intel.com>
 <fd590fbbc2f1abaeca1fd368d26c4e90c3a89d69.1641233076.git.alison.schofield@intel.com>
 <CAPcyv4gYjDo7vuFYqJgUL6mvOKosrzLRMxTA8tB0v86s08f_VA@mail.gmail.com>
 <20220107224515.GA804232@alison-desk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220107224515.GA804232@alison-desk>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Jan 07, 2022 at 02:45:15PM -0800, Alison Schofield wrote:
> On Thu, Jan 06, 2022 at 02:19:08PM -0800, Dan Williams wrote:
> > On Mon, Jan 3, 2022 at 12:11 PM <alison.schofield@intel.com> wrote:
> > >
> 
> snip
> 
> > 
> > One of the conventions from ndctl is that any command that modifies an
> > object should also emit the updated state of that object in JSON. For
> > example, "ndctl reconfigure-namespace" arranges for:
> > 
> >                 unsigned long flags = UTIL_JSON_DAX | UTIL_JSON_DAX_DEVS;
> >                 struct json_object *jndns;
> > 
> >                 if (isatty(1))
> >                         flags |= UTIL_JSON_HUMAN;
> >                 jndns = util_namespace_to_json(ndns, flags);
> >                 if (jndns)
> >                         printf("%s\n", json_object_to_json_string_ext(jndns,
> >                                                 JSON_C_TO_STRING_PRETTY));
> > 
> > ...to dump the updated state of the namespace, so a similar
> > util_memdev_to_json() seems appropriate here. However, perhaps that
> > can come later. I have work-in-progress patches to move the core of
> > cxl/list.c to a cxl_filter_walk() helper that would allow you to just
> > call that to dump a listing for all the memdevs that were passed on
> > the command line.
> 
> Will add. Thanks!
Oops...should've said - 'Will wait for helper.'

