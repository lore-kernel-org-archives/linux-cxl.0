Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E731EA7C2
	for <linux-cxl@vger.kernel.org>; Thu, 15 May 2025 02:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747275477; cv=none; b=iZHN0xsRQOA5SxsGzwzuENB2+yCOWN1my7CL0ZGoBxVm8pnBGDca0ClH099WP5ZWgNinSLRXjY3K9tUNfXlfTWMOVWDoKDuj9KYcxTSiKZSHw0Rv5EBC02j2DJRXbclc6USYglZIYuq0a+qYL3CvM6Xh9FQ2DtgtHtBxRndR0lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747275477; c=relaxed/simple;
	bh=tfw8zsMwGXtaSny6fvX/ec13kqYkzMfWrjcWnFJUdDg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K38lHcDzn37oPv9Zs6Tag2ie9dOKtEoAR1m1rnlOJucXAxsMqHb66Mm79POxDS7LWoF/Qahf6oTeqC05XKlSmzbz5OMjWICX3fcSmLyHNb3MVPXj5y1jzvkgmVvX+KgtBI4PVbFDa/KP+4wRWvQ4IToGRarGzLdVDP5uZ5ZWcAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UuIUN/nN; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UuIUN/nN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747275476; x=1778811476;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=tfw8zsMwGXtaSny6fvX/ec13kqYkzMfWrjcWnFJUdDg=;
  b=UuIUN/nNKUrvfJ+z0sNUA1kO2/rbp3ZFZ8Rpq6iXaSHpRLae9rHAZ8dz
   XNirTm44GmSarjD5r6X1v/eMbXWyE6MprBQJegwne0E+x+Kmm/9qsh6As
   a/FYLQIacTGS7NQ8kKRHUjjVMu+FHlyc5DWZtY6vGUZWAZRu4MgkCH+Ln
   WIQXw/qAiBCyBwD+aJAVpn75bVMMo7/Y8wxw7UqNC5EsqIwbGZVggkPQ/
   3waN8yeuzUyX2h/J798mVtQP7xqb1sfCA1eDxJku4TsqTVjmrTmFKQsCb
   8pVuqX/EFw5WQFI7y0Hz6ZjbnBAVZ5JwLKKtDmXvBZOMiwZusTH8oHmKY
   A==;
X-CSE-ConnectionGUID: Jsh+miYMQQyyMyAJG+l+7w==
X-CSE-MsgGUID: UzCEV6L1RF6r+8yViqiOjg==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="66749936"
X-IronPort-AV: E=Sophos;i="6.15,289,1739865600"; 
   d="scan'208";a="66749936"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 19:17:53 -0700
X-CSE-ConnectionGUID: i8eCsDggQS+ZqOQcxqMVLg==
X-CSE-MsgGUID: c1eLZHsUTKmIMuiMNQ1lHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,289,1739865600"; 
   d="scan'208";a="138724650"
Received: from unknown (HELO hyperion.jf.intel.com) ([10.243.61.29])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 19:17:49 -0700
From: marc.herbert@linux.intel.com
To: linux-cxl@vger.kernel.org,
	nvdimm@lists.linux.dev,
	alison.schofield@intel.com
Subject: 
Date: Thu, 15 May 2025 02:14:44 +0000
Message-ID: <20250515021730.1201996-1-marc.herbert@linux.intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <aCKWR4DdzdUh1VN6@aschofie-mobl2.lan>
References: <aCKWR4DdzdUh1VN6@aschofie-mobl2.lan>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Major changes in v2:
- The old $SECONDS variable is dropped from journalctl. Which allows:
- ... dropping the very short-lived COOLDOWN proposed in version 1.
- A new, optional NDTEST_LOG_DBG code which allows "stress testing"
the approach and proving that it is safe.

I tested and compared for many hours $SECONDS versus the NDTEST_START
approach that Alison submitted a few months ago and the conclusion is
very clear:
- $SECONDS does require a ~1.2 cool down between every test. As it was
  done in v1.
- NDTEST_START requires zero cool down.

So that is why I dropped $SECONDS and the cool down.


> Split them into a patchset for easier review and then I'll take a
> look. Thanks!

There are 3 logical changes in the main commit:

A1) Dropping $SECONDS, replaced with NDTEST_START

A2) The new NDTEST_LOG_DBG which was/is critical for:
   - proving that $SECONDS required a "cool down" (with version 1)
   - proving NDTEST_START does _not_ require any cool down, safe
     even without any.

B) The new, _harden_ journalctl check in check_dmesg() and its
   kmsg_fail_if_missing and kmsg_no_fail_on. The main feature!


- B) requires A1) because $SECONDS is too imprecise. With B) only, the
  tests fail.

- The A2) test code achieves nothing without B), it cannot prove
  anything without B).

- A1) and A2) are logically independent but their code are fairly
  intertwined and very painful to separate. Plus, B) would have to sit
  in the middle: A1->B->A2


Long story short:

- while they could be logically separate, these changes are tightly
  coupled with each other.

- breaking down that (relatively small) commit is theoretically
possible but would be very labor intensive. I know because I just went
through a similar "git action"  to compare $SECONDS versus
NDTEST_START for COOLDOWN reasons and it was not fun at all.

