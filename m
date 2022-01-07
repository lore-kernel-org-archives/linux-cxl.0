Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB863C433EF
	for <linux-cxl@archiver.kernel.org>; Fri,  7 Jan 2022 20:22:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiAGUWk (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 7 Jan 2022 15:22:40 -0500
Received: from mga03.intel.com ([134.134.136.65]:26421 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230115AbiAGUWk (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Fri, 7 Jan 2022 15:22:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641586960; x=1673122960;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rxrhjotZlnaVpdS0AlmIFNYo3EwfFDwqHBWA/soSYBA=;
  b=U5MNm5KanvWLSJy8aC53vb0del2Uvn+/EVbOlH6mCtEjfBHDYbgHUdhY
   wuxz4GbiIiT64U60nIaXeWnKtExrBrxtxATZTYQuVKe+6ROodRyXcwglx
   Aie09SzeartP6uM8p27+W9I+yKEQ+3BodI+kTaGUIUkfOZ2x25/glu580
   dCZXV90W5JMJnulqzZ/T+6OR0mzyeALGLFEmxaiDeC3LwHhyH8RrCARy7
   0qRop8pKN009wBqjh3skKb8AdrGTELww30rjN04uyyjuVJUPk5SkEpwgn
   amO64PiZIz1aw3yxtn2CF4QuEUyQEl9UprKipr0n0PEnnAUngiqrgasxA
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10220"; a="242888604"
X-IronPort-AV: E=Sophos;i="5.88,270,1635231600"; 
   d="scan'208";a="242888604"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 12:22:21 -0800
X-IronPort-AV: E=Sophos;i="5.88,270,1635231600"; 
   d="scan'208";a="668875052"
Received: from alison-desk.jf.intel.com (HELO alison-desk) ([10.54.74.41])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 12:22:20 -0800
Date:   Fri, 7 Jan 2022 12:27:30 -0800
From:   Alison Schofield <alison.schofield@intel.com>
To:     "Verma, Vishal L" <vishal.l.verma@intel.com>
Cc:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "Widawsky, Ben" <ben.widawsky@intel.com>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [ndctl PATCH 1/7] libcxl: add GET_PARTITION_INFO mailbox command
 and accessors
Message-ID: <20220107202730.GD803588@alison-desk>
References: <cover.1641233076.git.alison.schofield@intel.com>
 <9d3c55cbd36efb6eabec075cc8596a6382f1f145.1641233076.git.alison.schofield@intel.com>
 <20220106201907.GA178135@iweiny-DESK2.sc.intel.com>
 <CAPcyv4h4_V+fugcbU0f_+ZJ9sALdDqAtgovoVhpjzd6cYiBHgA@mail.gmail.com>
 <a964f28b2541168b94ed732f658980fc87954391.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a964f28b2541168b94ed732f658980fc87954391.camel@intel.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Jan 06, 2022 at 01:57:59PM -0800, Vishal Verma wrote:
> 
> Just one nit here about the double verb 'get'. In such cases,
> get_partition_info can just become 'partition_info'
> 
> e.g.: cxl_cmd_partition_info_get_active_volatile_cap(...
> 

Will do - thanks Vishal!

Combiningg w Ira's feedback, it'll be:
cxl_cmd_partition_info_get_active_volatile_bytes(...

> >
> 
