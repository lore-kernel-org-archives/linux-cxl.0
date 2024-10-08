Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630091EA85;
	Tue,  8 Oct 2024 02:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728356139; cv=none; b=nIjpZTZwpnNmybSHDNv8T0SHT/g4ZXnHB6a7YIltbv8p8pDUrG7NBou/pvg3AqnGZKd1rHeQRhBKMKjgXwB0VV+Q+HE8miBc8mEB24cJ6zWka9I09TAZuH5ymDdz+QcF2TND03+0WngZARXFopZMCumpzjbQt/y0gLwG/CDq6ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728356139; c=relaxed/simple;
	bh=WrTkIHMFfCLO7jqg+VNb+B5jnuWf8ahndb3hKGIOY6I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O0rycBnwYI2n3rFHwqb4OMVhYPDD6f4+2CRHSZzMxeOLnigCzn4bkR34W2Xxn8+Db8v1XjktpimQqtnI8aIbJNXfmFTgX/lSr0zPZEg/dcE+dQhPZQDH70F08F/QLIy6b8bZZP+yq6jkhNj2mk8YxBAX8kcRr5YlANHeFsSU2eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YXSs93Gf; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YXSs93Gf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728356138; x=1759892138;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=WrTkIHMFfCLO7jqg+VNb+B5jnuWf8ahndb3hKGIOY6I=;
  b=YXSs93GfLQKKaxL5kc33gRuOOVD1xEMSE9onx5cGDcFldPljru3WMpD3
   xbTErDzStd9hNEGjfu8Luqe2aAD9ST9gjOR46sbilumq7kUiNuxZw5qhN
   uxsXzk06uRu0nLty4q0vY5ut1VMU/Gj4Vg7RgaqL4Ax38twarrV8JpLOT
   3gfNt695ZZ3NSeswFzz4zhAoVS/DjO9MhpiMQ7v1VZIXb0bKK1/zjbOQp
   PF7ja0ztdL2rNnQ7l62hRJhqlMY9DNRxhMxBjgEFycCEzOFURDtuBRVFi
   rUz3mkPegDbJOJzA6Ivr2l+dTcZjquTwmrHnprt4TyiHXwyVasOiwJMzp
   A==;
X-CSE-ConnectionGUID: PkS58HQOTaG90o9N1XSgGg==
X-CSE-MsgGUID: fH3GrCUfT9KdtuTLKPtaig==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="27337176"
X-IronPort-AV: E=Sophos;i="6.11,185,1725346800"; 
   d="scan'208";a="27337176"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 19:55:37 -0700
X-CSE-ConnectionGUID: FVD5BrfKRZiiCM7wq3s7Jw==
X-CSE-MsgGUID: umiBusvhQ3a+WEwvaZXVZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,185,1725346800"; 
   d="scan'208";a="99018084"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 19:55:33 -0700
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
 Helgaas <bhelgaas@google.com>,  Baoquan He <bhe@redhat.com>,  Philip Li
 <philip.li@intel.com>
Subject: Re: [PATCH -v2] Resource: fix region_intersects() for CXL memory
In-Reply-To: <ZwPsYqkLF0eWUb9e@smile.fi.intel.com> (Andy Shevchenko's message
	of "Mon, 7 Oct 2024 17:12:50 +0300")
References: <20240819023413.1109779-1-ying.huang@intel.com>
	<ZsL-wfDYsUmWKBep@smile.fi.intel.com>
	<874j6vc10j.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<66d8f41cb3e6_3975294f9@dwillia2-xfh.jf.intel.com.notmuch>
	<ZtmOTYF9EWPeLg5u@smile.fi.intel.com>
	<87v7z91teq.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZwPsYqkLF0eWUb9e@smile.fi.intel.com>
Date: Tue, 08 Oct 2024 10:52:00 +0800
Message-ID: <871q0rnw6n.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

> On Fri, Sep 06, 2024 at 09:07:41AM +0800, Huang, Ying wrote:
>> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
>> > On Wed, Sep 04, 2024 at 04:58:20PM -0700, Dan Williams wrote:
>> >> Huang, Ying wrote:
>> >> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
>
> [..]
>
>> >> > > You may move Cc list after '---', so it won't unnecessarily pollute the commit
>> >> > > message.
>> >> > 
>> >> > Emm... It appears that it's a common practice to include "Cc" in the
>> >> > commit log.
>> >> 
>> >> Yes, just ignore this feedback, it goes against common practice. Cc list
>> >> as is looks sane to me.
>> >
>> > It seems nobody can give technical arguments why it's better than just keeping
>> > them outside of the commit message. Mantra "common practice" nowadays is
>> > questionable.
>> 
>> Cc list is used by 0day test robot to notify relevant developers and
>> maintainers in addition to the author when reporting regressions.  That
>> is helpful information.
>
> I'm not objecting Cc email tags, I'm objecting having them in the commit messages!
> Can you explain, how useful they are when they are placed as part of commit message
> bodies?

The result of regression bisection is the first bad commit.  Where we
use the Cc list in commit message to help find out whom we should send
the report email to.

--
Best Regards,
Huang, Ying
