Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NfeTlo2a"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9F5128
	for <linux-cxl@vger.kernel.org>; Fri,  1 Dec 2023 11:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701459586; x=1732995586;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7UPIiHJgJmtM+nm5/YEOgDUXunWKv9Cy31I4tcMldKA=;
  b=NfeTlo2aPkMZgVQDi/QCK3d1AjXYIbrSdgQIyyBgDdNE6Qiq1CP2HvTX
   QiimMG4MSWVCkw6OvGe6+hvwZgRGFxnBECKsMoVPN9ZHGslAQn4HpWpMu
   nl0ku1CCMFzzHthlvW8UJWhRfdVnQvoduFZP0cFVPwEz4rN7gJTBQKg1C
   17fDefS1pzSiSCtEXoOd20Mvr3i+5vxFagGBQ7qOUcvaDCeMY0nHNmp5M
   4D2n3ALqFfS9H0Mr37tVn4IxNkdyMGBahFsU41TK7gCXsFYhT6bgGFuGK
   dt5hplizHjWW1UwWq/ZiNlk6nOkiCOdb/EX5jOpwFOAmjlyn3KJr/SCo4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="383937756"
X-IronPort-AV: E=Sophos;i="6.04,242,1695711600"; 
   d="scan'208";a="383937756"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2023 11:39:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="1101398489"
X-IronPort-AV: E=Sophos;i="6.04,242,1695711600"; 
   d="scan'208";a="1101398489"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.193.224])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2023 11:39:45 -0800
Date: Fri, 1 Dec 2023 11:39:43 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Ira Weiny <ira.weiny@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH ndctl RESEND 1/2] ndctl/test: Add destroy region test
Message-ID: <ZWo2f2eWVtsJrYD9@aschofie-mobl2>
References: <20231130-fix-region-destroy-v1-0-7f916d2bd379@intel.com>
 <20231130-fix-region-destroy-v1-1-7f916d2bd379@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130-fix-region-destroy-v1-1-7f916d2bd379@intel.com>

On Thu, Nov 30, 2023 at 08:06:13PM -0800, Ira Weiny wrote:
> Commit 9399aa667ab0 ("cxl/region: Add -f option for disable-region")
> introduced a regression when destroying a region.
> 
> Add a tests for destroying a region.
> 
> Cc: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
>  test/cxl-destroy-region.sh | 76 ++++++++++++++++++++++++++++++++++++++++++++++
>  test/meson.build           |  2 ++
>  2 files changed, 78 insertions(+)
> 
> diff --git a/test/cxl-destroy-region.sh b/test/cxl-destroy-region.sh
> new file mode 100644
> index 000000000000..251720a98688
> --- /dev/null
> +++ b/test/cxl-destroy-region.sh
> @@ -0,0 +1,76 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2023 Intel Corporation. All rights reserved.
> +
> +. $(dirname $0)/common
> +
> +rc=77
> +
> +set -ex
> +
> +trap 'err $LINENO' ERR
> +
> +check_prereq "jq"
> +
> +modprobe -r cxl_test
> +modprobe cxl_test
> +rc=1
> +
> +check_destroy_ram()
> +{
> +	mem=$1
> +	decoder=$2
> +
> +	region=$($CXL create-region -d "$decoder" -m "$mem" | jq -r ".region")
> +	if [ "$region" == "null" ]; then
> +		err "$LINENO"
> +	fi
> +	$CXL enable-region "$region"
> +
> +	# default is memory is system-ram offline
> +	$CXL disable-region $region
> +	$CXL destroy-region $region
> +}
> +
> +check_destroy_devdax()
> +{
> +	mem=$1
> +	decoder=$2
> +
> +	region=$($CXL create-region -d "$decoder" -m "$mem" | jq -r ".region")
> +	if [ "$region" == "null" ]; then
> +		err "$LINENO"
> +	fi
> +	$CXL enable-region "$region"
> +
> +	dax=$($CXL list -X -r "$region" | jq -r ".[].daxregion.devices" | jq -r '.[].chardev')
> +
> +	$DAXCTL reconfigure-device -m devdax "$dax"
> +
> +	$CXL disable-region $region
> +	$CXL destroy-region $region
> +}
> +
> +# Find a memory device to create regions on to test the destroy
> +readarray -t mems < <("$CXL" list -b cxl_test -M | jq -r '.[].memdev')
> +for mem in ${mems[@]}; do
> +        ramsize=$($CXL list -m $mem | jq -r '.[].ram_size')
> +        if [ "$ramsize" == "null" ]; then
> +                continue
> +        fi
> +        decoder=$($CXL list -b cxl_test -D -d root -m "$mem" |
> +                  jq -r ".[] |
> +                  select(.volatile_capable == true) |
> +                  select(.nr_targets == 1) |
> +                  select(.size >= ${ramsize}) |
> +                  .decoder")
> +        if [[ $decoder ]]; then
> +		check_destroy_ram $mem $decoder
> +		check_destroy_devdax $mem $decoder
> +                break
> +        fi
> +done

Does this need to check results of the region disable & destroy?

Did the regression this is after leave a trace in the dmesg log,
so checking that is all that's needed?


> +
> +check_dmesg "$LINENO"
> +
> +modprobe -r cxl_test
> diff --git a/test/meson.build b/test/meson.build
> index 2706fa5d633c..126d663dfce2 100644
> --- a/test/meson.build
> +++ b/test/meson.build
> @@ -158,6 +158,7 @@ cxl_xor_region = find_program('cxl-xor-region.sh')
>  cxl_update_firmware = find_program('cxl-update-firmware.sh')
>  cxl_events = find_program('cxl-events.sh')
>  cxl_poison = find_program('cxl-poison.sh')
> +cxl_destroy_region = find_program('cxl-destroy-region.sh')
>  
>  tests = [
>    [ 'libndctl',               libndctl,		  'ndctl' ],
> @@ -188,6 +189,7 @@ tests = [
>    [ 'cxl-xor-region.sh',      cxl_xor_region,     'cxl'   ],
>    [ 'cxl-events.sh',          cxl_events,         'cxl'   ],
>    [ 'cxl-poison.sh',          cxl_poison,         'cxl'   ],
> +  [ 'cxl-destroy-region.sh',  cxl_destroy_region, 'cxl'   ],
>  ]
>  
>  if get_option('destructive').enabled()
> 
> -- 
> 2.42.0
> 
> 
