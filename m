Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F5CCC678D4
	for <linux-cxl@archiver.kernel.org>; Fri, 13 Jan 2023 18:03:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjAMSDo (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 13 Jan 2023 13:03:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjAMSCK (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 13 Jan 2023 13:02:10 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9877462CA
        for <linux-cxl@vger.kernel.org>; Fri, 13 Jan 2023 09:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673632594; x=1705168594;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8AoNubCxV8QATo7GoGNTAFM149XOR7IH+9tkOEwnG+U=;
  b=PTHqiVYF0zoFyV0GNNG3zBF/eKCz9wxDKY3G+qWDBXj/ieEl9w5qDQFX
   SDp7pH6X0SJvGqNRQ6CwQIK+fKGjthSFpNEXBpwoV1PtpKTwJ7sfxrg+y
   MD8xlzL78zlvekLUgkBbPFmbjoFr0k8XHpQkmy+dbn7rWGe4oyQ58ZvkH
   Nzh+r224Um/qWTR+3CJwUWUFPbagq9dX21gDSqm+tpTb6Z2uYcpZ1NymT
   uMAXfNsLpQOFf05xKNEhk8Qkd3qNlmjcXWb/lfVs9wSuAkGZNPNEyHAAf
   K+SUgiEZGm51Fxz/rH3kro/SPWp0c3CuXsTfo66KQ7N9q2WycqnG/Wc4B
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="307602016"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="307602016"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 09:56:26 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="782235293"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="782235293"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.225.67])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 09:56:26 -0800
Date:   Fri, 13 Jan 2023 09:56:24 -0800
From:   Alison Schofield <alison.schofield@intel.com>
To:     Vishal Verma <vishal.l.verma@intel.com>
Cc:     linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev
Subject: Re: [PATCH ndctl] test/cxl-xor-region.sh: skip instead of fail for
 missing cxl_test
Message-ID: <Y8GbSNR5Kbvn7HR0@aschofie-mobl2>
References: <20230112-vv-xor-test-skip-v1-1-92ddc619ba6c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230112-vv-xor-test-skip-v1-1-92ddc619ba6c@intel.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Jan 13, 2023 at 10:16:21AM -0700, Vishal Verma wrote:
> Fix cxl-xor-region.sh to correctly skip if cxl_test is unavailable by
> returning the special code '77' if the modprobe fails.

Thanks Vishal!

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

> 
> Link: https://github.com/pmem/ndctl/issues/229
> Fixes: 05486f8bf154 ("cxl/test: add cxl_xor_region test")
> Cc: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---
>  test/cxl-xor-region.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/test/cxl-xor-region.sh b/test/cxl-xor-region.sh
> index 5c2108c..1962327 100644
> --- a/test/cxl-xor-region.sh
> +++ b/test/cxl-xor-region.sh
> @@ -4,7 +4,7 @@
>  
>  . $(dirname $0)/common
>  
> -rc=1
> +rc=77
>  
>  set -ex
>  
> @@ -15,6 +15,7 @@ check_prereq "jq"
>  modprobe -r cxl_test
>  modprobe cxl_test interleave_arithmetic=1
>  udevadm settle
> +rc=1
>  
>  # THEORY OF OPERATION: Create x1,2,3,4 regions to exercise the XOR math
>  # option of the CXL driver. As with other cxl_test tests, changes to the
> 
> ---
> base-commit: b73e4e0390aae822bc91b8bf72430e6f0e84d668
> change-id: 20230112-vv-xor-test-skip-3ae4f5d065e4
> 
> Best regards,
> -- 
> Vishal Verma <vishal.l.verma@intel.com>
> 
