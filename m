Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F04C433EF
	for <linux-cxl@archiver.kernel.org>; Fri,  7 Jan 2022 19:50:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233521AbiAGTu4 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 7 Jan 2022 14:50:56 -0500
Received: from mga02.intel.com ([134.134.136.20]:33045 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232248AbiAGTu4 (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Fri, 7 Jan 2022 14:50:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641585056; x=1673121056;
  h=date:from:to:subject:message-id:references:mime-version:
   in-reply-to;
  bh=TbrSIOX+KFbOuadh3uaV5XYoKdWfz8KB2vx65GzLMT0=;
  b=FgjXz3hEPaEUv/rnwhvVqdnE3AThYU7Ux0FpoLZo1O4NIeZRh9j2olXy
   HOW4NJITySnRMToidxkdkuQo9MSVimpks8GKUNJrgR7Du1dxxQS6XTrG8
   ltlYz8H4lcWy87CwQ+7GgC39+y0GBzKbXOiAzuLD+//9P/owyw1LZnCi9
   RugVkVzpjonryn3J+ExFeihM4oZ94XHWBHarczgE/mv3z0/By86g4OmMG
   E8J4Y9zUvPxSj1Yq+OCORyxGL4RoY9tSrbpB76bl9HUskWNZcR2jtXgK2
   bULdZzQU9mGJ8aMZHqwRqV8pF1rfqt8DzeN6ir/olllM/wCA4aXCvOyzM
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10220"; a="230272365"
X-IronPort-AV: E=Sophos;i="5.88,270,1635231600"; 
   d="scan'208";a="230272365"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 11:50:55 -0800
X-IronPort-AV: E=Sophos;i="5.88,270,1635231600"; 
   d="scan'208";a="557363951"
Received: from alison-desk.jf.intel.com (HELO alison-desk) ([10.54.74.41])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 11:50:55 -0800
Date:   Fri, 7 Jan 2022 11:56:05 -0800
From:   Alison Schofield <alison.schofield@intel.com>
To:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org
Subject: Re: [ndctl PATCH 1/7] libcxl: add GET_PARTITION_INFO mailbox command
 and accessors
Message-ID: <20220107195605.GB803588@alison-desk>
References: <cover.1641233076.git.alison.schofield@intel.com>
 <9d3c55cbd36efb6eabec075cc8596a6382f1f145.1641233076.git.alison.schofield@intel.com>
 <20220106201907.GA178135@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220106201907.GA178135@iweiny-DESK2.sc.intel.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Thanks for the review Ira!

On Thu, Jan 06, 2022 at 12:19:07PM -0800, Ira Weiny wrote:
> On Mon, Jan 03, 2022 at 12:16:12PM -0800, Schofield, Alison wrote:
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > Add libcxl APIs to create a new GET_PARTITION_INFO mailbox command, the
> > command output data structure (privately), and accessor APIs to return
> > the different fields in the partition info output.
> 
> I would rephrase this:
> 
> libcxl provides functions for C code to issue cxl mailbox commands as well as
> parse the output returned.  Get partition info should be part of this API.
> 
> Add the libcxl get partition info mailbox support as well as an API to parse
> the fields of the command returned.
> 
> All fields are specified in multiples of 256MB so also define a capacity
> multiplier to convert the raw data into bytes.
> 
Will do. Thanks.

> > 

snip.
 
> I also wonder if the conversion to bytes should be reflected in the function
> name.  Because returning 'cap' might imply to someone they are getting the raw
> data field.

Agree. Will s/cap/bytes

>

Some additional comments were addressed by Dan & Vishal responses.

