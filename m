Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71594C3A5A7
	for <linux-cxl@archiver.kernel.org>; Thu,  8 Dec 2022 04:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiLHESH (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 7 Dec 2022 23:18:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiLHESG (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 7 Dec 2022 23:18:06 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E54C2EF1C
        for <linux-cxl@vger.kernel.org>; Wed,  7 Dec 2022 20:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670473082; x=1702009082;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zpHLzCbhPOlw37nRiDO7RSgzAwixrPRZhtX3/Mwr2A4=;
  b=maDH9MLudTSHekGW+1F1mFuwSnHxJ2emkICVq0+rbyFBB6ofU7YUdQ8b
   2vv8mBJBRKqz/qyygX3TpVT89PQWc+cmQnnjbR8swcA8Kfvp7jD5IHmB4
   iUsYqlE8XfT6Vs+UGyQ/2KW3h1g631fGyzQ3vSpkea/H5l9FY/l9EXHEI
   VD7kp0O1d7TYVFIHE/smqA1gqzKn6dz+ccOcil5WF8aHRcfG7UR1oR7Ki
   UcNex48ds/0aX08z291F0CHGBds+k0rPMccj0Y/C8JK/3+LmasA95S71U
   PoQvasCUtEcvz58Wzf/062gmv73Mb47fbiv6kTmqFEoud0wkGb7bkPHQA
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="379235296"
X-IronPort-AV: E=Sophos;i="5.96,226,1665471600"; 
   d="scan'208";a="379235296"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 20:18:02 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="679382666"
X-IronPort-AV: E=Sophos;i="5.96,226,1665471600"; 
   d="scan'208";a="679382666"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.198.95])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 20:18:01 -0800
Date:   Wed, 7 Dec 2022 20:17:59 -0800
From:   Alison Schofield <alison.schofield@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 1/5] cxl/memdev: Add support for the Inject Poison
 mailbox command
Message-ID: <Y5FldziLVtOfblz2@aschofie-mobl2>
References: <cover.1669781852.git.alison.schofield@intel.com>
 <3c260749c833f51d5cad9ae3912debcdf8b82753.1669781852.git.alison.schofield@intel.com>
 <d1d89d52-1153-1c13-f4be-2641e3cffd7b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1d89d52-1153-1c13-f4be-2641e3cffd7b@intel.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Dec 01, 2022 at 10:26:16AM -0700, Dave Jiang wrote:
> 
> 
> On 11/29/2022 9:34 PM, alison.schofield@intel.com wrote:
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > CXL devices optionally support the INJECT POISON mailbox command. Add
> > a sysfs attribute and memdev driver support for injecting poison.
> > 
> > When a Device Physical Address (DPA) is written to the inject_poison
> > sysfs attribute send an inject poison command to the device for the
> 
> A comma between attribute and send would make this read better.
> 
> > specified address.
> > 
> > Per the CXL Specification (8.2.9.8.4.2), after receiving a valid
> 
> spec v3?
> 
> > inject poison request, the device will return poison when the address
> > is accessed through the CXL.mem bus. Injecting poison adds the address
> > to the device's Poison List and the error source is set to injected
> 
> comma before 'and'.
> 'the' before 'injected'
> 
> > error. In addition, the device adds a poison creation event to its
> > internal Informational Event log, updates the Event Status register,
> > and if configured, interrupts the host.
> > 
> > Also, per the CXL Specification, it is not an error to inject poison
> > into an address that already has poison present and no error is returned
> 
> comma before 'and'.
> 
> DJ

Thanks Dave!
> 
snip
> >
