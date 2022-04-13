Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1780C433EF
	for <linux-cxl@archiver.kernel.org>; Wed, 13 Apr 2022 20:29:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236134AbiDMUbg (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 13 Apr 2022 16:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237243AbiDMUbf (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 13 Apr 2022 16:31:35 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7E483B0B
        for <linux-cxl@vger.kernel.org>; Wed, 13 Apr 2022 13:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649881753; x=1681417753;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yOS/EPUxPRSt+C8NfWWQUJVP+IifrAp5Uoy60VdfKmg=;
  b=l1+/tWGc1dvabKmOTGCAibyR26p9WmUU+p/dloOOPgoSvzFBeoHrqK1G
   hfw9F1cQ8B3XoesmHOtcfNo3G7KfCtK4aBadQ4unWtVBbzSEXy82Xjikn
   2eSFpV5czkZzrkW9313HGonzGP+rbqRfp9YBxM7lHl0o3BmA6XgQToAtl
   Mrz6tI5YzUyx4YIEvIo9axeWEU4i6Z9F44K1z8xsR4CRi0Yeq8EvQyFOs
   vtVhrSsJz4xRsUCpaVRacLwP5TsJP5PmOvJqTkqwlWMfy7cgiXD/bcGCp
   8gjH3QQycCdAVJAqIKIAbJLfwfjgqL2e+GgrbwRP98L4JsKkfBIixAmk3
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="250055514"
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="250055514"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 13:29:09 -0700
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="508116589"
Received: from dhruvish-mobl2.amr.corp.intel.com (HELO intel.com) ([10.252.132.94])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 13:29:08 -0700
Date:   Wed, 13 Apr 2022 13:29:02 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     alison.schofield@intel.com
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-cxl@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v2] cxl/mbox: Restore signedness to a mailbox payload
 variable
Message-ID: <20220413202902.bpyczvz56pxlhgkq@intel.com>
References: <20220413191311.1242361-1-alison.schofield@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220413191311.1242361-1-alison.schofield@intel.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 22-04-13 12:13:11, alison.schofield@intel.com wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> A mailbox command output size value of (-1) means that a device
> may return a variable sized output to that command. The device
> defines a maximum payload size, so the driver will allocate enough
> memory to receive that maximum payload for variable size mailbox
> commands.
> 
> A recent code refactoring discarded the signedness on 'out_size'
> before checking it, thereby breaking the handling of mailbox
> commands with variable sized output. Pass along both in_size and
> out_size with signedness, and only discard the signedness when
> building the cxl_mbox_cmd structure.
> 
> Smatch warn: unsigned 'out_size' is never less than 0
> 
> Fixes: be0d0ce77aa3 ("cxl/mbox: Move build of user mailbox cmd to a helper funct
> ions")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Per internal discussion, do we want to change in_size also? I'm in favor of
fixing the ABI.

[snip]

