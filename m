Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A02C61DA3
	for <linux-cxl@archiver.kernel.org>; Tue, 21 Feb 2023 17:23:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234762AbjBURXI (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 21 Feb 2023 12:23:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234224AbjBURXH (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 21 Feb 2023 12:23:07 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152B56188
        for <linux-cxl@vger.kernel.org>; Tue, 21 Feb 2023 09:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677000173; x=1708536173;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2bASnVZjyZBBIQKCtbnfgI7YfZzKvTnORyQXnFEKi0U=;
  b=S5awCppkmgF+fa0L6mUydIrO9kosRgm+71PLbzJ5OJ3OJwGA4YTvx+eJ
   EXjwYv2cEhwrlNeSuxG5ncu7EN5gFEsHSWf2d3j/oOm4fCoh78Bl59aE+
   HB8XZe0cuoDtVvtXM8YpH5sHV1TVUqCcYEQW5nQN3KUewu6J+XvVqLxJw
   buvIzWiJyxgCw1X07LMfpclkMClfg5Z1My5M9K6+PkzyvYFt7Qz65YZC9
   H+UBest3D60Vfr2Df2pYddVE3D5I7QttRF2aZDECwan2oZOoLK5ykjYaC
   z3NP9Cuxpu0K6yLE05tmxGgypZScvt9kpp7CglEIWY47UYqFJuX07S2Kn
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="332700003"
X-IronPort-AV: E=Sophos;i="5.97,315,1669104000"; 
   d="scan'208";a="332700003"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 09:22:52 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="621579418"
X-IronPort-AV: E=Sophos;i="5.97,315,1669104000"; 
   d="scan'208";a="621579418"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.251.28.85])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 09:22:52 -0800
Date:   Tue, 21 Feb 2023 09:22:50 -0800
From:   Alison Schofield <alison.schofield@intel.com>
To:     Vishal Verma <vishal.l.verma@intel.com>
Cc:     linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
        Dave Jiang <dave.jiang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH ndctl 3/3] test/cxl-security.sh: avoid intermittent
 failures due to sasync probe
Message-ID: <Y/T96khZVa7Oo6uU@aschofie-mobl2>
References: <20230217-coverity-fixes-v1-0-043fac896a40@intel.com>
 <20230217-coverity-fixes-v1-3-043fac896a40@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230217-coverity-fixes-v1-3-043fac896a40@intel.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Feb 17, 2023 at 05:40:24PM -0700, Vishal Verma wrote:
> This test failed intermittently because the ndctl-list operation right
> after a 'modprobe cxl_test' could race the actual nmem devices getting
> loaded.
> 
> Since CXL device probes are asynchronous, and cxl_acpi might've kicked
> off a cxl_bus_rescan(), a cxl_flush() (via cxl_wait_probe()) can ensure
> everything is loaded.
> 
> Add a plain cxl-list right after the modprobe to allow for a flush/wait
> cycle.

Is this the preferred method to 'settle', instead of udevadm settle?

> 
> Cc: Dave Jiang <dave.jiang@intel.com>
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---
>  test/security.sh | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/test/security.sh b/test/security.sh
> index 04f630e..fb04aa6 100755
> --- a/test/security.sh
> +++ b/test/security.sh
> @@ -225,6 +225,7 @@ if [ "$uid" -ne 0 ]; then
>  fi
>  
>  modprobe "$KMOD_TEST"
> +cxl list
>  setup
>  check_prereq "keyctl"
>  rc=1
> 
> -- 
> 2.39.1
> 
> 
