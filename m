Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C6B17991;
	Fri,  6 Sep 2024 01:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725585081; cv=none; b=EIF4zgjALU34owKw4NjlpHTwM20JKbDKZyMWWV/uR6yXBa+UGfYzHycdw9G/gnbY6OquMemgCSo7EsKQN4Be+VDfYCFEU3lxS7Bs4KhW8rsNkR/Cv3atIQPmzE32MJ4bgNnwQOrEt5IwV58Mce2Vip7YB4+G549LbUjUjaE1yqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725585081; c=relaxed/simple;
	bh=8S+jXpwt85dGZWnEqivLD598BH0yX52AmDkn7Gkw3Is=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q4GFsP9s5vkhrKNw8ybFs+tkHJcdYOtbZ4z7xtxYsnqI3FeJaKJ+/rkAF7P1coadXyvZSGI2OEdZg8Fo1DXKGijaUFw6enwvhdKmdfEcLVf6ge6raBLMvZZL1cbqTAYWrAqUav8RjH1OOAZG07JGXvcOurklAaiuMAIs78f60fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DKI1cBhJ; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DKI1cBhJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725585080; x=1757121080;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=8S+jXpwt85dGZWnEqivLD598BH0yX52AmDkn7Gkw3Is=;
  b=DKI1cBhJJsSDJUi7ZTBV/HcaGHShLyl4Xvll8VtwDetUKr35vKWFjIko
   3cqVfoqj+wkbWBNoOcCdUyUPOZOwXA0KKMvaydXQbsKAMRPcYHB/37EFB
   RNs50aTHiq+tcjwGirOwSmjfmKf1DlUnOuTjyZr5l3/hFgNr3UJnVoLEU
   pPVORo26LjxHvUA5WK9CyOPVFjoPglmzW14900KJKb53tLKDHSHg33K2D
   jWbNzaXp8oN8kEclwO+g/5AoLieVL/6HFqR2fG94FpNkcfMQQKK0hErNi
   a18b6hWmyk158ur724w1/ueeE0GEonyVeGOcoWwt8v7XxJO8VKE5yXO9/
   Q==;
X-CSE-ConnectionGUID: LDZJzpqYTOmLUH6ed9mN1Q==
X-CSE-MsgGUID: yZThUJrSRUyjJy30g+avJg==
X-IronPort-AV: E=McAfee;i="6700,10204,11186"; a="23891490"
X-IronPort-AV: E=Sophos;i="6.10,206,1719903600"; 
   d="scan'208";a="23891490"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 18:11:19 -0700
X-CSE-ConnectionGUID: zPIbzNPWSweJ6Zcr2THlJA==
X-CSE-MsgGUID: 0g+abiOrSLeuAFE4eFRXCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,206,1719903600"; 
   d="scan'208";a="96523282"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 18:11:15 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  <linux-mm@kvack.org>,
  <linux-kernel@vger.kernel.org>,  <linux-cxl@vger.kernel.org>,  "David
 Hildenbrand" <david@redhat.com>,  Davidlohr Bueso <dave@stgolabs.net>,
  "Jonathan Cameron" <jonathan.cameron@huawei.com>,  Dave Jiang
 <dave.jiang@intel.com>,  Alison Schofield <alison.schofield@intel.com>,
  Vishal Verma <vishal.l.verma@intel.com>,  Ira Weiny
 <ira.weiny@intel.com>,  Alistair Popple <apopple@nvidia.com>,  Bjorn
 Helgaas <bhelgaas@google.com>,  Baoquan He <bhe@redhat.com>, Philip Li
 <philip.li@intel.com>
Subject: Re: [PATCH -v2] Resource: fix region_intersects() for CXL memory
In-Reply-To: <ZtmOTYF9EWPeLg5u@smile.fi.intel.com> (Andy Shevchenko's message
	of "Thu, 5 Sep 2024 13:56:13 +0300")
References: <20240819023413.1109779-1-ying.huang@intel.com>
	<ZsL-wfDYsUmWKBep@smile.fi.intel.com>
	<874j6vc10j.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<66d8f41cb3e6_3975294f9@dwillia2-xfh.jf.intel.com.notmuch>
	<ZtmOTYF9EWPeLg5u@smile.fi.intel.com>
Date: Fri, 06 Sep 2024 09:07:41 +0800
Message-ID: <87v7z91teq.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

> On Wed, Sep 04, 2024 at 04:58:20PM -0700, Dan Williams wrote:
>> Huang, Ying wrote:
>> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
>
> [..]
>
>> > > You may move Cc list after '---', so it won't unnecessarily pollute the commit
>> > > message.
>> > 
>> > Emm... It appears that it's a common practice to include "Cc" in the
>> > commit log.
>> 
>> Yes, just ignore this feedback, it goes against common practice. Cc list
>> as is looks sane to me.
>
> It seems nobody can give technical arguments why it's better than just keeping
> them outside of the commit message. Mantra "common practice" nowadays is
> questionable.

Cc list is used by 0day test robot to notify relevant developers and
maintainers in addition to the author when reporting regressions.  That
is helpful information.

--
Best Regards,
Huang, Ying
