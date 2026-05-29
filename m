Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509983D3CEC;
	Fri, 29 May 2026 16:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780071450; cv=none; b=tbVmJ/EnoRC0S+xV4asV9EAoqRJ4c42nk+OMSpUU068URrSwIO+fNF9Kax3rccnNl6PEkphwt6hqGXgQys52mOQDgzJFaqVfACflLaZuGu2nWdBweng+FXWK46zxZLTPCoSng2sKxoKO/G2fABgRZJ8/h1gH1mEm8tJ9Yj6g1BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780071450; c=relaxed/simple;
	bh=Nr5dLp8HzyOAwRHCmWt0it+g1IuyNYFmtDpOJuALNqc=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=KEyDiCgQMpP788jJOiqv8bLOZ1F9WWe1gKLOJ5VF22u1AWKRP5uev77Ytq6uqmuBhVc/mMEHdWyBTrf1Am6PeVBf9N+XhMg6bwTxeFlxepYobWzei7UbA/WjfYDtHOKVsoPmCE3yhIU3SL7u6WJwJ/T0ujo2mGU7z+YKlBedtTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TG8yTvhz; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TG8yTvhz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780071448; x=1811607448;
  h=message-id:date:mime-version:to:cc:from:subject:
   content-transfer-encoding;
  bh=Nr5dLp8HzyOAwRHCmWt0it+g1IuyNYFmtDpOJuALNqc=;
  b=TG8yTvhzyZNNomTXWHafcANoPrqzItLa4EthNpZ7gQCx4eGSkaAEIfdm
   UICnqSVRn/LKD800JkDNskgk35kbA2SqRraG+wROPpfT5f+x2mSM06BkS
   0VpNuQpSKB5WjhunRE3OOHJ+qY1IlPN2WMBmAubK0whaGtSF2qET2VSIn
   kKkT1FQEWTrCxC3/8mIV4yU8j/uk16Vo6ov+7WRNzbMFp3OBT2jK8vJ8I
   vvHDYe+karf3WiYdoV99sqL5rH5g30Xzms+hz91JOmCt9f/R6vhh8y3nS
   KoV0OlE67FuuQkoKpDYDUVXeLBMFUxv3bwBEwJ+6NABzjkaLXipI8/5DK
   g==;
X-CSE-ConnectionGUID: BluZI3uARbKG7SquGmOrDQ==
X-CSE-MsgGUID: Za6wH10vTZ6uh7Zqr5Hd6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11801"; a="91611189"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="91611189"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 09:17:26 -0700
X-CSE-ConnectionGUID: Lb2cwvieSxOL0td3/lWfSQ==
X-CSE-MsgGUID: 204b1Wi2TdiRKp+AxUWuRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="246897864"
Received: from gabaabhi-mobl2.amr.corp.intel.com (HELO [10.125.111.151]) ([10.125.111.151])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 09:17:25 -0700
Message-ID: <483677d6-0119-4c07-8cb1-3fa9cf7c42a3@intel.com>
Date: Fri, 29 May 2026 09:17:24 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dan Williams <djbw@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Davidlohr Bueso <dave@stgolabs.net>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 Alison Schofield <alison.schofield@intel.com>, Ira Weiny
 <iweiny@kernel.org>, Vishal Verma <vishal.l.verma@intel.com>,
 linux-kernel <linux-kernel@vger.kernel.org>
From: Dave Jiang <dave.jiang@intel.com>
Subject: [GIT PULL] Compute Express Link (CXL) Fixes for 7.1-rc6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus, please pull from:

git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-fixes-7.1-rc6

...to receive a CXL fix for cxl_test module. The fix has been in -next for couple
days with no reported issues.

---

The following changes since commit e7ae89a0c97ce2b68b0983cd01eda67cf373517d:

  Linux 7.1-rc5 (2026-05-24 13:48:06 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-fixes-7.1-rc6

for you to fetch changes up to d90f236f8b9e354848bd226f581db27755ab901d:

  cxl/test: Update mock dev array before calling platform_device_add() (2026-05-26 13:54:17 -0700)

----------------------------------------------------------------
cxl fixes for v7.1-rc6

cxl/test: Update mock dev array before calling platform_device_add()

----------------------------------------------------------------
Li Ming (1):
      cxl/test: Update mock dev array before calling platform_device_add()

 tools/testing/cxl/test/cxl.c | 105 ++++++++++++++++++-------------------------
 1 file changed, 43 insertions(+), 62 deletions(-)
