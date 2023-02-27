Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F49BC64ED6
	for <linux-cxl@archiver.kernel.org>; Mon, 27 Feb 2023 03:25:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjB0DZz (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 26 Feb 2023 22:25:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjB0DZy (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 26 Feb 2023 22:25:54 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD35E1ADFB
        for <linux-cxl@vger.kernel.org>; Sun, 26 Feb 2023 19:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677468353; x=1709004353;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sLam01+AN21jJXy7qMycSvAVM6UY09JNZYNkrt+ptsw=;
  b=jlGpA1Wpt5BdSnGpyP0MkAAg52UH8NqfY+864NpyxufZghtuv4j2L4H0
   5ia2sRfsb9LRPKZ2jDWEELvL4MNFmAI9tpnkRqlQt+q6OozDdvxjmRbkJ
   cwG5LTV3PfcfqsDhtG32cySBCSvlwwAeRYOFSjE8x0krxK4ekCXk8abdB
   Ncw+osoOc+PfU9rDKHN3NWWYozWTD9SLsio9nOrQmy4JDu24CRGnjHraB
   3xa8Kmci74zVg4DGfnLgpZKLAeP4pxPHDOnVYYdE8ZIc1xuNwwZ+7JdDd
   KM2rjrXSNvPZQ3EYkndAvwVlxuyED1oAIRdQrVUZdojuXdC/hl5XOmbvr
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10633"; a="322012606"
X-IronPort-AV: E=Sophos;i="5.97,330,1669104000"; 
   d="scan'208";a="322012606"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2023 19:25:53 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10633"; a="783136227"
X-IronPort-AV: E=Sophos;i="5.97,330,1669104000"; 
   d="scan'208";a="783136227"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.83.169])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2023 19:25:52 -0800
Date:   Sun, 26 Feb 2023 19:25:50 -0800
From:   Alison Schofield <alison.schofield@intel.com>
To:     Junhyeok Im <junhyeok.im@samsung.com>
Cc:     linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, bwidawsk@kernel.org
Subject: Re: [ndctl 2/3] cxl: add inject-poison command to cxl tool
Message-ID: <Y/wivgTuKuxvB2jt@aschofie-mobl2>
References: <20230220045709.94027-1-junhyeok.im@samsung.com>
 <CGME20230220045608epcas2p11d40339e7401f5bf99a9e97308058fec@epcas2p1.samsung.com>
 <20230220045709.94027-3-junhyeok.im@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230220045709.94027-3-junhyeok.im@samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Feb 20, 2023 at 01:57:08PM +0900, Junhyeok Im wrote:
> Add new command to cli tool, to inject poison into dpa(-a) on the
> memory device.
> 
> DPA written in sysfs attribute(inject_poison) is converted by
> kstrtou64 with 0 base by 'inject_poison_store' of CXL driver, so if
> it begins with 0x the number will be parsed as a hexadecimal
> (case insensitive), if it otherwise begins with 0, it will be parsed
> as an octal number. Otherwise it will be parsed as a decimal.
> 
> Since the validity verification of the dpa would be done in
> 'cxl_validate_poison_dpa' of CXL driver, no additional logic
> is added.
> 
> Also since it is expected no use case of injecting poison into the
> same address for multiple devices, this command targets only one
> memdev, like write-labels command.
> 
>  usage: cxl inject-poison <memdev> -a <dpa> [<options>]
> 
>     -v, --verbose         turn on debug
>     -S, --serial          use serial numbers to id memdevs
>     -a, --address <dpa>   DPA to inject poison
> 

Upon successful completion of the command, display the --media-errors
list for that device.

<snip>

