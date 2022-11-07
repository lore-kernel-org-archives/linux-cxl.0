Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5415BC433FE
	for <linux-cxl@archiver.kernel.org>; Mon,  7 Nov 2022 22:36:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbiKGWgN (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 7 Nov 2022 17:36:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232398AbiKGWgM (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 7 Nov 2022 17:36:12 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817A72AC5D
        for <linux-cxl@vger.kernel.org>; Mon,  7 Nov 2022 14:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667860571; x=1699396571;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qAUPfcmd3J5y3mktetxgadKeIcDhzl+PhpTuqdKlFz8=;
  b=eH5fuU4RTYhWjCyCtffidgSrJQJ02EW1ESXiywVZY1IZmzZTh26sZtXT
   OWzX2wT3jFUCHGbbajT3wN/WIMr8loCJ7xvOsv+JlNfR4NUJ0oSNwlxyU
   JumTA3aQ6wB3HqHzAL+5TCM1acQFGDXCPd86iqaMFcDnRmCop6pLM1uCH
   cBuoFgk8yG4oGV+Qd2WtH67LI+hjgBLO2EL8jRDnbdovAs4zat/QjcCkc
   V8FItPrldedK5xnNF9mTZr83731saSYGtwE79xSxWgzfa+wsEcbTaRPae
   qFyZIMZ+Prua1oBVLYP5JpGf98ERQ/irY26BTf0B1u3FHrzGGuGN1YHpI
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="290262506"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="290262506"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 14:36:11 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="587145717"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="587145717"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.100.77])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 14:36:10 -0800
Date:   Mon, 7 Nov 2022 14:36:09 -0800
From:   Alison Schofield <alison.schofield@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     vishal.l.verma@intel.com, linux-cxl@vger.kernel.org,
        nvdimm@lists.linux.dev
Subject: Re: [ndctl PATCH 15/15] cxl/test: Test single-port host-bridge
 region creation
Message-ID: <Y2mIWcQFvCCyVBwm@aschofie-mobl2>
References: <166777840496.1238089.5601286140872803173.stgit@dwillia2-xfh.jf.intel.com>
 <166777849300.1238089.2412172532718881380.stgit@dwillia2-xfh.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166777849300.1238089.2412172532718881380.stgit@dwillia2-xfh.jf.intel.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Sun, Nov 06, 2022 at 03:48:13PM -0800, Dan Williams wrote:
> The original port decoder programming algorithm in the kernel failed to
> acommodate the corner case of a passthrough port connected to a fan-out
> port. Use the 5th cxl_test decoder to regression test this scenario.
> 
> Reported-by: Bobo WL <lmw.bobo@gmail.com>
> Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Link: http://lore.kernel.org/r/20221010172057.00001559@huawei.com
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Tested-by: Alison Schofield <alison.schofield@intel.com>

> ---
>  test/cxl-create-region.sh |   28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/test/cxl-create-region.sh b/test/cxl-create-region.sh
> index 82aad3a7285a..47aed44848ab 100644
> --- a/test/cxl-create-region.sh
> +++ b/test/cxl-create-region.sh
> @@ -110,6 +110,34 @@ create_subregions()
>  	done
>  }
>  
> +create_single()
> +{
> +	# the 5th cxl_test decoder is expected to target a single-port
> +	# host-bridge. Older cxl_test implementations may not define it,
> +	# so skip the test in that case.
> +	decoder=$($CXL list -b cxl_test -D -d root |
> +		  jq -r ".[4] |
> +		  select(.pmem_capable == true) |
> +		  select(.nr_targets == 1) |
> +		  .decoder")
> +
> +        if [[ ! $decoder ]]; then
> +                echo "no single-port host-bridge decoder found, skipping"
> +                return
> +        fi
> +
> +	region=$($CXL create-region -d "$decoder" | jq -r ".region")
> +	if [[ ! $region ]]; then
> +		echo "failed to create single-port host-bridge region"
> +		err "$LINENO"
> +	fi
> +
> +	destroy_regions "$region"
> +}
> +
> +# test region creation on devices behind a single-port host-bridge
> +create_single
> +
>  # test reading labels directly through cxl-cli
>  readarray -t mems < <("$CXL" list -b cxl_test -M | jq -r '.[].memdev')
>  
> 
