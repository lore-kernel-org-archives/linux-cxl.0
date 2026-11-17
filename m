Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794931165;
	b=CjSwGoSCsZqTiBOuqXI5Gnq19Tf0aTMXB6cmjUV81Ez12UfBpJScLenyW1YrMEqx+aCk
	 et4IangdLRjDG4gtRxZ7MGLHUEFYjm4pU9mHsONIvUQDs8u9oG4zno7JzgrN3j4yyylwo
	 ed3L/5gTE7qQUx2Kz5lHqzWuiugO62c3FBv5s/4aH7/hyr87yr35tFAiJh7VYfT8ukaUQ
	 gF8DKCn/W+Qcq4JHu+ZNVOc0miVbDJNHEHRmbKC1RXS1lIQ7Q4zxxoDD0so5YlFzZeVmQ
	 AltMRu5Hd/HjPOm839rsuXKPMfbSAlkrKS9F7h46a/l8FY8l9YSe+m0wUWpPO2HqQBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794931165;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:From:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=YypkpBuyhL9dkHTrRbeJD6BhONEUH8pYfUeHChLNI3g=;
	b=PSXRhaGcm6N4cKifPD3jeztM3cBgKG+5uloWNlBo5UxcIRy8fSJ1E7wp1Vbtk7VccFYV
	 N/0llgrWVUARMfCx28yLVk22q14cG9OUcwwJratbXPr2goCMS9tjPmdT0cQpjTqM6HyVl
	 sgRa39S25i3uQq6wZcXYe6nNKRRXozAD3lIS4vjbbhI80xipH32pJaa3H6HdpzjhYZWfH
	 ebsMhSZaw/YFaX881gRBcZ2T/RW6JYwzdqUaVsgwp1mXiLHdSyVfGQByc0PnisqHNNJZp
	 Lwi7BtE54Z9umpdJTBvoNMMY7Nh0gZM74Lsct9e9zK7PMcaRe6Jm9KwIztOUennj36A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Sinf22cM;
	arc=none smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C565606A32F;
	Tue, 17 Nov 2026 15:59:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C565606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Sinf22cM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794931166; x=1826467166;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=n3kfNhIdhEM+BQFIt3SdD7wP9oh9WcPI4TP50uGLnPI=;
  b=Sinf22cMXN2vmVNUTU9WEL2W+z/AkHKCxO89vQQ1rOPddyTC5AP9xT4i
   YEqr+qCGjoyEack/CcxExFRW356DbOggApZPaF9VQnKD9KgTa7Gfcxqd6
   JJL2x0+VzzhNGq69PQOxQHFeEJ+m1k5UgOm99m0/iaLQowLyXjeOtJeaD
   +4jnf6PopahVyyMwZnGw6W2Jg4Gq09+0cCudtfv5vT3kFUiwSSO0q7yx8
   5M5eA2m+Rd1qvmQBenQb0+bzlGbrl1uBVW39FICZKZ5Rt2gp/lpIYuxP7
   lCdjoYvB1cU8n2neACpvPOHsdzZE21bziKH7THk5C1VNRBkb5+0IPLfK5
   A==;
X-CSE-ConnectionGUID: 0HoLc/+QTXy88AsFj7vHqw==
X-CSE-MsgGUID: sWC1LDh6QuyBQqUgQr8iqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3625202"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3625202"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 07:58:31 -0800
X-CSE-ConnectionGUID: TCcbTATzTvC0weQ/ntfcqg==
X-CSE-MsgGUID: whCV/8IjT6mJhbAi1io87A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="9930970"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.108.197]) ([10.125.108.197])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 07:58:29 -0800
Message-ID: <7eb35fa7-3830-4da9-9fe2-40e905285363@intel.com>
Date: Tue, 17 Nov 2026 08:58:28 -0700
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
Subject: Re: [PATCH] MAINTAINERS: Add CXL reviewer Ben Cheatham
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ben Cheatham <benjamin.cheatham@amd.com>
References: <20261104175003.297974-1-dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20261104175003.297974-1-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/4/26 10:50 AM, Dave Jiang wrote:
> Adding Ben as a reviewer for the CXL subsystem.
> 
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Ben Cheatham <benjamin.cheatham@amd.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Applied to cxl/next:
3b8ccbf93f58

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2a955a626784..edaf70961cba 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6729,6 +6729,7 @@ M:	Vishal Verma <vishal.l.verma@intel.com>
>  R:	Ira Weiny <iweiny@kernel.org>
>  R:	Li Ming <ming.li@zohomail.com>
>  R:	Richard Cheng <icheng@nvidia.com>
> +R:	Ben Cheatham <benjamin.cheatham@amd.com>
>  L:	linux-cxl@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/driver-api/cxl
> 
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
> prerequisite-patch-id: 57bdcea37c2a480531ec5d1022422748e462077a

