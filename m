Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IPLR4Z+9"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946BA10C9
	for <linux-cxl@vger.kernel.org>; Tue, 12 Dec 2023 12:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702414301; x=1733950301;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+qxDBblb4yNToA21H66EUez1y9T8slRiC5+HGJTnCgo=;
  b=IPLR4Z+9tIGDNhRKYGM9/nJKg/26U7g17sMLuOI+UzYiTJVP9HcHyxUs
   qAoWlNvIZFWqxpMAZWjGod9AFKly+3miswaupWXEcG6dsI9vAEvhXqMzF
   lFn75zxR/jYCdG1WU+yFpcRCIxYZNcWztNjELwU156xGDz1JezsuzoW9y
   +SOh/R3NmPy0APzmGwFR4EdQGcaeVCExDRZ0a++oDm2F1bJrcJcb1SI4w
   9kvajKWiXaTBz0e0sHL9eoPs6vk5q/VLZi+VgOky35CpPZApSMeOdhDdf
   ifSOKbazIyNCr56OPuax7hx2YpP6inDfw3mxZCpL8bcXAI50YcxP5T3Mn
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="392043317"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="392043317"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 12:51:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="897046226"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="897046226"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.111.12])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 12:51:35 -0800
Date: Tue, 12 Dec 2023 12:51:34 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Li Zhijian <lizhijian@fujitsu.com>
Cc: nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org
Subject: Re: [ndctl PATCH v2 1/2] test/cxl-region-sysfs.sh: use '[[ ]]'
 command to evaluate operands as arithmetic expressions
Message-ID: <ZXjH1o1rq/Un/X0w@aschofie-mobl2>
References: <20231212074228.1261164-1-lizhijian@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212074228.1261164-1-lizhijian@fujitsu.com>

On Tue, Dec 12, 2023 at 03:42:27PM +0800, Li Zhijian wrote:
> It doesn't work for '[ operand1 -ne operand2 ]' where either operand1 or
> operand2 is not integer value.
> It's tested that bash 4.1/4.2/5.0/5.1 are impacted.

So, when validating the endpoint decoder settings the region_size and
region_base were not really being checked. With this syntax fix, the
check works as intended.

Please include such an impact statement.

Alison

> 
> Per bash man page, use '[[ ]]' command to evaluate operands as arithmetic
> expressions
> 
> Fix errors:
> line 111: [: 0x80000000: integer expression expected
> line 112: [: 0x3ff110000000: integer expression expected
> line 141: [: 0x80000000: integer expression expected
> line 143: [: 0x3ff110000000: integer expression expected
> 
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
> V2: use '[[ ]]' instead of conversion before comparing in V1
> ---
>  test/cxl-region-sysfs.sh | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/test/cxl-region-sysfs.sh b/test/cxl-region-sysfs.sh
> index 8636392..6a5da6d 100644
> --- a/test/cxl-region-sysfs.sh
> +++ b/test/cxl-region-sysfs.sh
> @@ -108,8 +108,8 @@ do
>  
>  	sz=$(cat /sys/bus/cxl/devices/$i/size)
>  	res=$(cat /sys/bus/cxl/devices/$i/start)
> -	[ $sz -ne $region_size ] && err "$LINENO: decoder: $i sz: $sz region_size: $region_size"
> -	[ $res -ne $region_base ] && err "$LINENO: decoder: $i base: $res region_base: $region_base"
> +	[[ $sz -ne $region_size ]] && err "$LINENO: decoder: $i sz: $sz region_size: $region_size"
> +	[[ $res -ne $region_base ]] && err "$LINENO: decoder: $i base: $res region_base: $region_base"
>  done
>  
>  # validate all switch decoders have the correct settings
> @@ -138,9 +138,9 @@ do
>  
>  	res=$(echo $decoder | jq -r ".resource")
>  	sz=$(echo $decoder | jq -r ".size")
> -	[ $sz -ne $region_size ] && err \
> +	[[ $sz -ne $region_size ]] && err \
>  	"$LINENO: decoder: $i sz: $sz region_size: $region_size"
> -	[ $res -ne $region_base ] && err \
> +	[[ $res -ne $region_base ]] && err \
>  	"$LINENO: decoder: $i base: $res region_base: $region_base"
>  done
>  
> -- 
> 2.41.0
> 
> 
