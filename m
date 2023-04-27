Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7CB5C77B73
	for <linux-cxl@archiver.kernel.org>; Thu, 27 Apr 2023 19:46:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344022AbjD0Tq0 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 27 Apr 2023 15:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231563AbjD0TqX (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 27 Apr 2023 15:46:23 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BC91FE5
        for <linux-cxl@vger.kernel.org>; Thu, 27 Apr 2023 12:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682624782; x=1714160782;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4MYdotkKvpBCQfxY/euXGg2W8ESy+SUbWOKeEC17vaQ=;
  b=gCIyZrpV10CLeccUO20fUIF1bF7ZpF8Z3KnQh0sX8lnKPDzKIO5jUVex
   25/XXj6dccdRsYXrJMyf6qv8bTfRZNnB8HIwn8QSfKn0DmF4lX8Cxd7GN
   xDkeM03tdz15whvOaJYu+CwWhui4ghVtFUm5nTjYCALEweB/b1rpvU0nj
   6AZumD4FA/VcKZi9+O1PXAEe5MPKJChOXhdB/DgUaNM/IWvULkbyemyeU
   YNpNPBSgowAOHGBELK9hv8Ri0xFG7inHslITX3l2QCew8JtmsJTn1Jr7l
   FzBz9nM0ac2CDTGt99h4F8bUv9IQcZ9iT9VHqkfBdo7YjDbdaeKGBNEXy
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="410612135"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="410612135"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 12:46:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="940789343"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="940789343"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.57.248])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 12:46:21 -0700
Date:   Thu, 27 Apr 2023 12:46:20 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Raghu H <raghuhack78@gmail.com>
Cc:     linux-cxl@vger.kernel.org
Subject: Re: [STYLE v1 0/3] Fixing check patch styling issues
Message-ID: <ZErRDPS6f0UKgsyI@aschofie-mobl2>
References: <20230419111443.231151-1-raghuhack78@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230419111443.231151-1-raghuhack78@gmail.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Apr 19, 2023 at 11:14:40AM +0000, Raghu H wrote:

Hi Raghu,

Thanks for the cleanup patches.
Sometime maintainers don't want cleanup, but these look good, and
hopefully they can get queued, after you send a v2.

I see Ira already commented to drop the tab reformatting, so drop
that in a v2 of this set.

I notice only 'me' in the 'To;' list here. The cover letter needs
to get the same maintainer list as your patches.

Each patches commit log (now 2 patches) should say 'Issue found with
checkpatch', or something similar. We like to know what tool to credit,
and like that to be in the git history/changelog, not just the cover
letter.

> The following patches are cleanup or fixing the styling issues found
> using checkpatch
> 
> In cxl/core/mbox.c, in case of null check failure, returning errno or
> -ENOMEM in this case is good enough, removing the redundant dev_err
> message.
> 
> In cxl/core/port.c, there is line of spaces in the definition which
> violates checkpatch coding sytle, restructured the definition to use
> tabs
> 
> In cxl/core/region.c, the else is not required after the return
> statement, cleaned it up.
> 
> Verified the build and sanity by booting the guest VM using the freshly
> built components.
> 
> Raghu H (3):
>   cxl/mbox: remove redundant debug msg
>   cxl/core/port: Use tabs to fix styling errors
>   cxl/core/region:Remove else after return statement

Assumes you are dropping the port changes.

Do this:

$git log --oneline mbox.c
$git log --oneline region.c

Your commit messages 'look' different than the existing message.
Please fix their formatting, in addition to the reword I mention
in patch 1 reply.

Thanks,
Alison

> 
>  drivers/cxl/core/mbox.c   |  4 +---
>  drivers/cxl/core/port.c   | 18 +++++++++---------
>  drivers/cxl/core/region.c |  7 +++----
>  3 files changed, 13 insertions(+), 16 deletions(-)
> 
> -- 
> 2.39.2
> 
