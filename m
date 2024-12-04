Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF35802;
	Wed,  4 Dec 2024 02:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733278070; cv=none; b=PPPv2nLrHpCE6T+sq/rVntVmpJtLS2E03+7k74B25o1xuV4eLnRx3IdfAQ/SB7CjrUCvfML/YXFnz/CCK1F1ZltoMwmnVyshu4qYnavdbtuR2oA4dVo0AgvvSoAg862G/ziS7V2RW2RHneHZcs6cEzKG0riEj7L3Ks5uUdoPxHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733278070; c=relaxed/simple;
	bh=j9/8en4k0z7ZOt5Ac3cEuqOl1rpE26CkdKKvFLbjyi8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BPegKnDpbyqstgDybzDxGbXatLvt64i0/Cdh2VWR5qHprh3tqaNdVr3h/zSQ2Ai3fcDgxPdA+/Pjg9Sg9jGFoLjEA7/bs1KqIM4Q2h+Yy9nzX+eFFchG/ioy+pzcbsRL1SGgjG7o849IbWB2ZlrTeFb7AxyDTHc3Wr/UoAcJq7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=RLg14YH6; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="RLg14YH6"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733278065; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=20il1jHvB1Q1OdtdS8d6Zxhc05oWCgHhA7oH7Iu+aJA=;
	b=RLg14YH6dfzD9ticF5XyZljwRKNhfPN5/XX0/lKGivdW/ew3VUOswhzVknj9a567AzUP+os4RbJ+qp5D1J0z1r4wvg2WT0ewqafiow+0U0kcec33jrvLwnGLPazGQsQTiWa4S5lBYWRDbgtR9dbfQtppkwNyjp0IYRJWWXbFmOc=
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0WKoEPSt_1733278037 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 04 Dec 2024 10:07:43 +0800
From: "Huang, Ying" <ying.huang@linux.alibaba.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Raghavendra K T <raghavendra.kt@amd.com>,  linux-kernel@vger.kernel.org,
  linux-cxl@vger.kernel.org,  bharata@amd.com,  Andrew Morton
 <akpm@linux-foundation.org>,  Dan Williams <dan.j.williams@intel.com>,
  David Hildenbrand <david@redhat.com>,  Davidlohr Bueso
 <dave@stgolabs.net>,  Jonathan Cameron <jonathan.cameron@huawei.com>,
  Dave Jiang <dave.jiang@intel.com>,  Alison Schofield
 <alison.schofield@intel.com>,  Vishal Verma <vishal.l.verma@intel.com>,
  Ira Weiny <ira.weiny@intel.com>,  Alistair Popple <apopple@nvidia.com>,
  Bjorn Helgaas <bhelgaas@google.com>,  Baoquan He <bhe@redhat.com>,
  ilpo.jarvinen@linux.intel.com,  Mika Westerberg
 <mika.westerberg@linux.intel.com>,  Fontenot Nathan
 <Nathan.Fontenot@amd.com>,  Wei Huang <wei.huang2@amd.com>
Subject: Re: [RFC PATCH] resource: Fix CXL node not populated issue
In-Reply-To: <Z08KiPwwiw72Vo9R@smile.fi.intel.com> (Andy Shevchenko's message
	of "Tue, 3 Dec 2024 15:41:28 +0200")
References: <20241202111941.2636613-1-raghavendra.kt@amd.com>
	<87frn5wac3.fsf@DESKTOP-5N7EMDA> <Z08KiPwwiw72Vo9R@smile.fi.intel.com>
Date: Wed, 04 Dec 2024 10:07:16 +0800
Message-ID: <87iks06w17.fsf@DESKTOP-5N7EMDA>
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

> On Tue, Dec 03, 2024 at 02:26:52PM +0800, Huang, Ying wrote:
>> Raghavendra K T <raghavendra.kt@amd.com> writes:
>
> ...
>
>> > git bisect had led to below commit
>> > Fixes: b4afe4183ec7 ("resource: fix region_intersects() vs add_memory_driver_managed()")
>> 
>> This breaks you case, sorry about that.  But this also fixed a real bug
>> too.  So, it's not appropriate just to revert it blindly.
>
> Linus was clear about this recently. Even if it fixes a bug, regression is
> still regression and might (*) lead to a revert.
> https://lwn.net/Articles/990599/
>
> (*) in general fixes are better than reverts, but depends on the timing in
>     the release cycle the revert may be the only option.

I don't think that the timing is so tight that we should not work on
proper fix firstly.  I'm trying to work with the reporter on this.

BTW, the commit b4afe4183ec7 ("resource: fix region_intersects() vs
add_memory_driver_managed()") fixed a security related bug.  The bug
weakened the protection to prevent users read/write system memory via
/dev/mem.  So, IMO, we need to be more careful about this.

---
Best Regards,
Huang, Ying
