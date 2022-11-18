Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 688C2C4332F
	for <linux-cxl@archiver.kernel.org>; Fri, 18 Nov 2022 00:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232330AbiKRAvP (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 17 Nov 2022 19:51:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240604AbiKRAvO (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 17 Nov 2022 19:51:14 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0F174CF4
        for <linux-cxl@vger.kernel.org>; Thu, 17 Nov 2022 16:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668732673; x=1700268673;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=g+Vn1yHKB2Uuaq8jiyGZHi2dxKJlfO/lPkotgcENZb0=;
  b=S+Tr99jdYJpnVUuC2K8WaBX+C5EYdjaT/KrBVVmabRk8CYY21+TzNl/l
   7z6mke/7ppl2EEmXeyESnlG6gGU4L7FG9dREgd6dyKMMk8jBwE4WrQQg+
   SHf5ONi/g00aGM3qkMtos/79uht9qPEiEzSvxRkfFbGmXfJqZxMdmHR7T
   2t888yo6HdihvhIaYZUhlOVlKX/UqgOTS7ldHo0wQ3/+pGEjCb2thDUrW
   qNt7xyQA/8j5kJrdnKYhw+64lL4nQv/IwX+fAmnD78dUf9MbUL9uK1TyQ
   0fqVjLanYYiIq7ptFfo2UQ8ZiPjt2KKKWfD70n5/ysJAteF1PvPJiv3cH
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="375151179"
X-IronPort-AV: E=Sophos;i="5.96,172,1665471600"; 
   d="scan'208";a="375151179"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 16:50:58 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="814724845"
X-IronPort-AV: E=Sophos;i="5.96,172,1665471600"; 
   d="scan'208";a="814724845"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.84.12])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 16:50:58 -0800
Date:   Thu, 17 Nov 2022 16:50:56 -0800
From:   Alison Schofield <alison.schofield@intel.com>
To:     Marek Bykowski <marek.bykowski@gmail.com>
Cc:     linux-cxl@vger.kernel.org
Subject: Re: trace events
Message-ID: <Y3bW8CLw8xcbrfav@aschofie-mobl2>
References: <20221114202242.5f9023d3@ubuntu.armcompdev.pub.tds.tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221114202242.5f9023d3@ubuntu.armcompdev.pub.tds.tieto.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Nov 14, 2022 at 08:27:57PM +0000, Marek Bykowski wrote:
> Hello cxl mailing list,
> 
> I just started a project for validating the RTL of the CXL root bridge
> from Intel. One of my first goals is to better understand the
> SW/protocol flows, so that we better validate it. I'm going to use
> the tracpoints for it and possibly lttng. Are you considering adding
> some of it shortly? If not would you be interested into the patches for
> it?
> 
> On the list I'm seeing include/trace/events/cxl.h but on the repository
> kernel/git/cxl/cxl.git seeing none for example with:
> 
>  git cat-file -e origin:include/trace/events/cxl.h

Hi Marek,

There are a few patchsets under review that are using trace events
in CXL. I'm working on one for CXL Poison Retrieval.

There is also tool support, the monitor patchset, making its way
upstream for ndctl that uses the trace events.

I haven't looked at lttng.

Can you share more about your project?

Thanks,
Alison

> 
> Thanks,
> Marek
