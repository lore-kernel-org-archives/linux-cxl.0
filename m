Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DE7174ED0
	for <linux-cxl@vger.kernel.org>; Tue, 15 Oct 2024 05:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728968412; cv=none; b=niUbkF01xZVPWurbl2l2S3OTWHq9D53UYbwQ//zksdTzut44cETtkisxoTcrDRXJo0qAQD2b1e2PFEzF8wBOJaojK+04cei/qgGWzl1EoNQna7P0/ph0j9JoiLX7u9FZg61qIcawgWSh7pJ3sw9dcZ6anV2Vs7NgZVxdB6PIpzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728968412; c=relaxed/simple;
	bh=PH6DD452D0KtN7pKZIV8eGdN09BKzyO8KF+HFMg6OCg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=u0wRgyhpYDerSU923w7CxltlQjnjSIMAGxMqP9QJhGS1zwW9if2mKPhCfRMwjQy5H0LmBOs/npXV7danIy5ylN2ug5/gfEw2P4RLBHSDnbWR2kkz3ORTpoiNdbIscNU8iZPq+uEN3PQwdog74egBozQaV1do733HQyxnyG8knJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QJHKp3N1; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QJHKp3N1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728968411; x=1760504411;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=PH6DD452D0KtN7pKZIV8eGdN09BKzyO8KF+HFMg6OCg=;
  b=QJHKp3N1tf1EVaoJ2QfbnwxjhqCUXl55kKeobVUyowq7t0IoUA0nea8s
   mpqcn5SvQjMYEwiDuzp2DRNUdTSobllunpjgwzIecgyR64lh4zZWDm+ru
   wdJTl4phxSWxmVazkfWIyXAhcgQqRvV47f1YR2ucHWamgfbYWozLEfYl9
   CqYR1Yw9CJyRogdmFcCQK3Jar3/vTqeAKLBmBk0h3Ooxn8S/xQuAcEcoG
   VRjFJu5YfPey/dParQqIAUER+8Q7Ojkq77piAAR3r9PX2Fah8UvE08VLj
   WuCxPyUQPbAB3TenbFYbeonku5OrBcBEG7UO8QMrlg1oClyTAYrd5oDow
   A==;
X-CSE-ConnectionGUID: sAZImItxRde/eogOXN8Eyg==
X-CSE-MsgGUID: s1fGjy8FQFWFirDLiWrNuw==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="31217229"
X-IronPort-AV: E=Sophos;i="6.11,204,1725346800"; 
   d="scan'208";a="31217229"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 22:00:10 -0700
X-CSE-ConnectionGUID: dkDL3LKcTrWPST6iLEN+/w==
X-CSE-MsgGUID: hftaNpfQQIerSy207slj6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,204,1725346800"; 
   d="scan'208";a="78596399"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 22:00:08 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>,  linux-cxl@vger.kernel.org, Ira Weiny
 <ira.weiny@intel.com>
Subject: Re: KASAN error when insmod cxl_test
In-Reply-To: <670de32847e6d_3f1429473@dwillia2-xfh.jf.intel.com.notmuch> (Dan
	Williams's message of "Mon, 14 Oct 2024 20:36:08 -0700")
References: <87y12w9vp5.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<670de32847e6d_3f1429473@dwillia2-xfh.jf.intel.com.notmuch>
Date: Tue, 15 Oct 2024 12:56:35 +0800
Message-ID: <87cyk27ym4.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Dan Williams <dan.j.williams@intel.com> writes:

> Huang, Ying wrote:
>> Hi, Dave,
>> 
>> When I tried to test v6.12-rc2 with cxl_test in qemu, the below error is
>> reported.  Revert commit a5ab0de0ebaa ("cxl: Calculate region bandwidth
>> of targets with shared upstream link") can eliminate the error.
>> 
>> Can you take a look at it?
>
> Does the same reproduce with "modprobe cxl_test"?

I used "modprobe cxl_test" to test.

> I worry that direct
> 'insmod' usage results in cases where it proceeds with the wrong
> dependencies. I.e. I never test with insmod, only modprobe, and my
> v6.12-rc2 testing so far has not hit this.

One possible reason is the difference in .config.

--
Best Regards,
Huang, Ying
