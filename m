Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F479848E;
	Tue,  3 Sep 2024 00:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725324455; cv=none; b=cliQd4HewZyO2C6VgDCGalKvYNCcbwaqvVlJmzq3g9sW/eDgVoCaUKgBdBpjLccyEdxc77Er8yhSMJbD8KGdPfqz/WrHRvHARso+VISmuLevd0w4YUDMQdG2cQwKcjBOLRBeDmo2nCo6jelSS8FAqgNXE9SUmsvkHzDq5/XT1WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725324455; c=relaxed/simple;
	bh=8jH7+zPGHzSLqt3NjILmlJ3dyjoBt1jzqzGCSKdY33I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oe0mCEI6nsOaKCaxPT5/pItR1gRvuumdbG4PuuBrQqh/Dwt2jJwjek4BpJ0Kx+dVOOocH9uSP8xOV1AY3ZyM7BWFOS43NQxozJS/T7BpmkPQzIQUqFXe5SjP6XlQWsebNUufdtM3Y1RO0C5Gm+CsAxQLRSgZ+bUpeecBR9+rgKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TIUZnDSu; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TIUZnDSu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725324453; x=1756860453;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=8jH7+zPGHzSLqt3NjILmlJ3dyjoBt1jzqzGCSKdY33I=;
  b=TIUZnDSulwPRE40UNiF1pbpEQ9PmCnAfW8gAo2jAbnbZm5a8wrpTRwfw
   mjr3jfxuUwtkIU5zpx4bIusaNU2ws5kUQkIswWn+/xrpD7alySga7MJ+N
   mMtdYhnpZDx1PjJx4MgKqOTQX9A4g7j6jaQ0jW5NenEznKJy29qB78RCQ
   ehquwI9rbMq515Ju4qqWH4B4XU/3GzAsk2lG2uFMUmMFtj3GSacv5kBh1
   CDMFuKxxxcMXhNp3p6ndJuZEKvFiv0u8zs73l0OkbQIxIKqh2ERHB5f+u
   U96riZLxfhhPwwc1WZEbH50TB3izy3DjlmQ455YtT1UWaZRfglqC6BO9C
   A==;
X-CSE-ConnectionGUID: 9XiE1puPSVWm8BQIarHlxA==
X-CSE-MsgGUID: 26kBXNjpQ2CUiKu/luPscw==
X-IronPort-AV: E=McAfee;i="6700,10204,11183"; a="24058656"
X-IronPort-AV: E=Sophos;i="6.10,197,1719903600"; 
   d="scan'208";a="24058656"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 17:47:32 -0700
X-CSE-ConnectionGUID: RGU/IMGwTaW0oSShIqfwNQ==
X-CSE-MsgGUID: VIchrrutTJ+0nEO/rNqDHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,197,1719903600"; 
   d="scan'208";a="69371773"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 17:47:29 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Dan Williams
 <dan.j.williams@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,  <linux-mm@kvack.org>,
  <linux-kernel@vger.kernel.org>,  <linux-cxl@vger.kernel.org>,  Davidlohr
 Bueso <dave@stgolabs.net>,  Jonathan Cameron
 <jonathan.cameron@huawei.com>,  "Dave Jiang" <dave.jiang@intel.com>,
  Alison Schofield <alison.schofield@intel.com>,  Vishal Verma
 <vishal.l.verma@intel.com>,  Ira Weiny <ira.weiny@intel.com>,  Alistair
 Popple <apopple@nvidia.com>,  Bjorn Helgaas <bhelgaas@google.com>,
  Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH] Resource: fix region_intersects() for CXL memory
In-Reply-To: <ZtWn7rVhwcOUwvfM@smile.fi.intel.com> (Andy Shevchenko's message
	of "Mon, 2 Sep 2024 14:56:30 +0300")
References: <20240816020723.771196-1-ying.huang@intel.com>
	<66bedd0f746ab_1c18294b5@dwillia2-mobl3.amr.corp.intel.com.notmuch>
	<87y14wj4ju.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<66c69470ae357_7605294ab@dwillia2-mobl3.amr.corp.intel.com.notmuch>
	<87r0a2g64n.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZtWn7rVhwcOUwvfM@smile.fi.intel.com>
Date: Tue, 03 Sep 2024 08:43:56 +0800
Message-ID: <87ed61ftwz.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Hi, Andy,

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

> On Mon, Sep 02, 2024 at 10:07:52AM +0800, Huang, Ying wrote:
>> Dan Williams <dan.j.williams@intel.com> writes:
>> > Huang, Ying wrote:
>> >> Dan Williams <dan.j.williams@intel.com> writes:
>> >> > Huang Ying wrote:
>
> [..]
>
> Looking at how many troubles touching kernel/resource.c may lead to, here is
> the question(s):
> 1) do we have a test cases in general for this library?
> 2) can this change be coupled with an addition/update of the test cases?

Yes.  This is reasonable.  As far as I know, Dan has plan to add some
unit tests for region_intersects().

Hi, Dan,

Have you started working on the unit tests?  If needed, please let me
know so I can assist.

--
Best Regards,
Huang, Ying
