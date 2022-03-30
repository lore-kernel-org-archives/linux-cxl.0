Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02638C433EF
	for <linux-cxl@archiver.kernel.org>; Wed, 30 Mar 2022 19:12:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350661AbiC3TOa (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 30 Mar 2022 15:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350814AbiC3TOX (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 30 Mar 2022 15:14:23 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C3D33EA4
        for <linux-cxl@vger.kernel.org>; Wed, 30 Mar 2022 12:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648667551; x=1680203551;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0uNLiwv12DQnKqTOblBC4Go2qIQOA0cwe6ZtZ0JdM3A=;
  b=NEvzPr2BtWWXiDhKdHr41t26pHZNzqz0MFQZ8xIcaUNLSCdZHCbSXK5l
   7Av/DE7/b0rJ5Uj9H/yy3GkeJq0A3CjSLNQPeRcwscQVl8SCDDPl/1+bK
   2nTbRZ9tmeLCPr7YPGd2flrKVzbzdVyM30H0tVPcxi58yrzRvS3yvJDds
   NFqRu2ckDp39gW2zylbRgQIB15iZ9YO5/lZFik+T3cvq3Phnex1hvKDYM
   WI8bc2ChSJhEL4wBzwf3DLDh1FpxUTV99HQbsaahK0idCf4JGbn6t1cdj
   L92CwFadC/cKfuaIVu1ko3s1cBULYHvzgaNDSbYo4z9T6CLejZNirWle+
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="346060444"
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="346060444"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 12:12:31 -0700
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="546981304"
Received: from alison-desk.jf.intel.com (HELO alison-desk) ([10.54.74.41])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 12:12:30 -0700
Date:   Wed, 30 Mar 2022 12:14:54 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-cxl@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v4 5/9] cxl/mbox: Remove dependency on cxl_mem_command
 for a debug msg
Message-ID: <20220330191454.GA1177056@alison-desk>
References: <cover.1648601710.git.alison.schofield@intel.com>
 <1a1ebb7181b8be9fb746da48b41c02e54bee513e.1648601710.git.alison.schofield@intel.com>
 <CAPcyv4gaZsFQYnFQtWBni67NYLoBxN+Hc=Y96OtPTPu5sRXfnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4gaZsFQYnFQtWBni67NYLoBxN+Hc=Y96OtPTPu5sRXfnA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Mar 29, 2022 at 09:50:17PM -0700, Dan Williams wrote:
> On Tue, Mar 29, 2022 at 6:28 PM <alison.schofield@intel.com> wrote:

snip

> >
> >         dev_dbg(dev,
> >                 "Submitting %s command for user\n"
> >                 "\topcode: %x\n"
> > -               "\tsize: %ub\n",
> > -               cxl_command_names[cmd->info.id].name, mbox_cmd.opcode,
> > -               cmd->info.size_in);
> > +               "\tsize: %zx\n",
> > +               cxl_mem_opcode_to_name(mbox_cmd.opcode),
> > +               mbox_cmd.opcode, mbox_cmd.size_in);
> 
> Looks ok, although it's just a debug statement so the raw opcode would
> also be acceptable to me to meet the goal of dropping the
> cxl_mem_command usage.

I thought the opcode_to_name helper might be overkill, until
it came in handy in a later patch. It gets used again to find
the command name when a payload is not allowed. 

> 
> Either way you decide to go:
> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
