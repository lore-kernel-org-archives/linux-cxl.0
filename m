Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795020761;
	b=DBLEuZKfJMX8xxcs/1q1Ga3CjYDtdXgrTcJZYOAkRm+LEHbscsMFCZVshBDWQS58TDY7
	 7fvDd90gqjuYilKyuuLrPZQ121s5HfVqd7DhksjMrzV+SCXzcz1RT2JwvYGbDD68SswhW
	 lTtAnOs4YcN6nYSUWWnvniK2F+m04A3/GjYVvWQxBGQaTSOdi3dG9yZNlPjDHH2n9H1po
	 /wPLfy2xBuxQQ+bZV0GNErrNeIuCqQFc0ba0bPDOmTjLTEMRZ7fOo3jf8sXOM5BHAqIH3
	 W3mGu7Lumkl2geO1YkmKPw4mF5rYP98lkL/YSmClJZ8guVlkdkUgbIfhjngEo61rpSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795020761;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=3dYZQ1LYQzTzzsD3ycYzLMa36Epjs0JbN76QTiIJMDc=;
	b=L5Zuz4M5WjwTgt64kGk9m7GaqM7EzYtwkvuTkPUGsV6Ttn4Pv2LwpD2/dObTHkqKjg7O
	 D4avTxuDFlNzyze14ucn7zrE3Xv+okiFSTh5XtP8odFQRyP1WH7oW/lOX4i8rmyG6FxWh
	 vMNSnxiHPiJxBEy6Eg4YhCjzwva7+78ZbcWsN2JTwGnBjFkzyFioCDqFYuVlxlcI78k82
	 AS6j6USSYNf4iea7CIO4TdcDRrmn83JtGF6/OXVdyEshW+uHWr9n/v0P3JfjSrK16JYb6
	 hC8r49vPw2vg4eNQJLWUU2lVcQv5hhs5lBFBFSWEx1l3LhlhT8Dljc+P3KcCiM343tQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VV7RIBDE;
	arc=none smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FF560A3822
	for <linux-cxl@vger.kernel.org>; Wed, 18 Nov 2026 16:52:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1FF560A3822
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VV7RIBDE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795020761; x=1826556761;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dJMN12nGFE5Rpy5ZdhHdZeSZOYI490fHozrpqd2Ah/k=;
  b=VV7RIBDEoje3YYgYrxWtpP+f4B6eJaE4U25XbJ4IA5M7r/z4aBcGWaFP
   QixDe7+J/GRmFcrVpAeH0OYLw926KdHNND0UKqn7JfDQHALT7ASnqKjJe
   QB6t62BhKzP+QkL+aPgcbrLTyutiZ7yBfJd6mzsLmVAGw62mzqaUdPn5G
   erfxEDs6N8mXZ1A9nARyH/wAVJOgcx9FkhruiMReLlvExiqY8YHKJTPOK
   0X+9ZoZWfovZ6qWvoXaziADRToxhSfpPeriEFKXIUR6scnep9LJbldN2N
   XKKIK12b/o/YpvviFXTKNTkovgyJJYntPgYTJ8t2KENt0No86aQotFksV
   w==;
X-CSE-ConnectionGUID: e6TU4axFRCChE++oA0bQGA==
X-CSE-MsgGUID: CrIYLV3cQ66CRwCFvXcHjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3831966"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3831966"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 08:52:03 -0800
X-CSE-ConnectionGUID: 0/UWPS/kTy2XiWaKF6sIMA==
X-CSE-MsgGUID: NUsm7NhCTwyxggEZKl82Ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="10073476"
Received: from jjgreens-desk24.amr.corp.intel.com (HELO [10.125.109.2]) ([10.125.109.2])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 08:52:02 -0800
Message-ID: <4ef4b551-7c03-4835-a274-5f3c9c6a1587@intel.com>
Date: Wed, 18 Nov 2026 09:52:01 -0700
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ndctl PATCH v2] test/cxl-region-sysfs.sh: test a repeat write of
 a region target
To: Alison Schofield <alison.schofield@intel.com>, nvdimm@lists.linux.dev
Cc: linux-cxl@vger.kernel.org
References: <20261026162419.584201-1-alison.schofield@intel.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20261026162419.584201-1-alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/26/26 9:24 AM, Alison Schofield wrote:
> A CXL driver fix making its way upstream[1], makes a repeat write of an
> endpoint decoder to the region targetN attribute that already holds it
> succeed without changing the region. Without the fix, that write fails,
> leaves the region half detached from the endpoint's ports, and a later
> write can crash the kernel.
> 
> Add a test case to backstop that fix. Write target0 twice on a partially
> populated region and check that the second write succeeds and leaves the
> region's decoders attached.
> 
> [1] https://lore.kernel.org/linux-cxl/920d80735a449f93a1f17a8bca4c25e4b302cb42.1792989098.git.alison.schofield@intel.com/ 
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
> 
> Changes since v1:
> - Expect a repeat write to succeed, as the v2 kernel fix makes it a no-op
> 
> 
>  test/cxl-region-sysfs.sh | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/test/cxl-region-sysfs.sh b/test/cxl-region-sysfs.sh
> index db1a163efb30..cb5e6ba53e71 100644
> --- a/test/cxl-region-sysfs.sh
> +++ b/test/cxl-region-sysfs.sh
> @@ -87,9 +87,19 @@ do
>  						     select(.mode == \"pmem\") | .decoder")
>  done
>  
> -# attach all endpoint decoders to the region
> -pos=0
> -for i in ${endpoint[@]}
> +# a repeat write of an attached endpoint decoder must succeed and leave
> +# every decoder between it and the root attached
> +echo "${endpoint[0]}" > "/sys/bus/cxl/devices/$region/target0"
> +nr_attached=$(cat /sys/bus/cxl/devices/decoder*/region | grep -cx "$region")
> +if ! echo "${endpoint[0]}" > "/sys/bus/cxl/devices/$region/target0"; then
> +	err "$LINENO: repeat write of ${endpoint[0]} to target0 failed"
> +fi
> +nr=$(cat /sys/bus/cxl/devices/decoder*/region | grep -cx "$region")
> +[ "$nr" -ne "$nr_attached" ] && err "$LINENO: $nr of $nr_attached decoders still attached"
> +
> +# attach the remaining endpoint decoders to the region
> +pos=1
> +for i in ${endpoint[@]:1}
>  do
>  	echo $i > /sys/bus/cxl/devices/$region/target$pos
>  	pos=$((pos+1))

