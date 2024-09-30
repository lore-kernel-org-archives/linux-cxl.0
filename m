Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DABF9DF;
	Mon, 30 Sep 2024 00:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727657803; cv=none; b=RLIAOP1Z2Qxe9+4Or9ibl5nYE1J/yIORa6zEFIAzBonsgVf4nk1aZUSCFGADkUBkUPfZQv7AuisYY/5E/X0xISeCvzYjyAtVYyvZ4PwpXXN3S8PHTEKsCPycbyrpMT5s0GOnub1gd2AZGKKasEpgp0+W8eZKMNyLr70fpbfZ6lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727657803; c=relaxed/simple;
	bh=OZoIIPzPzC9PONOLbEkOi98SbES+quudNHFDQQL7TQQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aQCjphCl22y+x51KvTXpYjZeozdZGKvHnbVuOatD8+l20VSIukllfIewYLRVjsFKrqxuNPFZYHz2bQG5I5ONAGdvytfzXwUTiybIvfLibfl8Hw0UD6mWI/t0ZftzAmbGdUBhYO4J3SNYPVqkrpy8+V6VCHf31xs1yaCBjZkgDFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=drYfvmq7; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="drYfvmq7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727657801; x=1759193801;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=OZoIIPzPzC9PONOLbEkOi98SbES+quudNHFDQQL7TQQ=;
  b=drYfvmq7aIpI877JS+2a0ERFaQY3+dP+qROzrVthi45Ua3TDBjA4soey
   PoOpm5zIERRpUOFzesnelv2xQYUc6eqCD+ak+TLcSUr7lBr9kydM8cYhK
   bsh4432VYGAeIM4ikWGM08AqZZNe+BbFIJQyc99xEW9hxt6ZjM7xW8pOj
   LBr7wV/dO+1sppMlcJTm3gnZNiQr87setwJi/D6VM2vwXRqE3KtwjtmuB
   KhAMWuKZoDnJVlEoh1ElX2WDD2Ra0oWyAg7MZyDmNGaf89vdF+kpBZgrs
   j2ALYVxmx19PbA4bHa82LpT+obhcLSwDuM7azDLaSjEp4uXB+YIU6rPJV
   Q==;
X-CSE-ConnectionGUID: SCQyzXDSQ76OAno+lBi3qg==
X-CSE-MsgGUID: N9Pmy/oKSpmjScbCmWMbRg==
X-IronPort-AV: E=McAfee;i="6700,10204,11210"; a="26606280"
X-IronPort-AV: E=Sophos;i="6.11,164,1725346800"; 
   d="scan'208";a="26606280"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2024 17:56:41 -0700
X-CSE-ConnectionGUID: gBM+tIWLQZmfWCHEa3Vt4g==
X-CSE-MsgGUID: HXKx1IP0TQ6m3A8jth5EeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,164,1725346800"; 
   d="scan'208";a="73520402"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2024 17:56:37 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Kees Bakker <kees@ijzerbout.nl>
Cc: Andrew Morton <akpm@linux-foundation.org>,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org,  linux-cxl@vger.kernel.org,  Dan Williams
 <dan.j.williams@intel.com>,  David Hildenbrand <david@redhat.com>,
  Davidlohr Bueso <dave@stgolabs.net>,  Jonathan Cameron
 <jonathan.cameron@huawei.com>,  Dave Jiang <dave.jiang@intel.com>,  Alison
 Schofield <alison.schofield@intel.com>,  Vishal Verma
 <vishal.l.verma@intel.com>,  Ira Weiny <ira.weiny@intel.com>,  Alistair
 Popple <apopple@nvidia.com>,  Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>,  Bjorn Helgaas <bhelgaas@google.com>,
  Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH -v3 3/3] resource, kunit: Add test case for
 region_intersects()
In-Reply-To: <9c9586ab-0426-46c1-bcc6-6ee2927b7a86@ijzerbout.nl> (Kees
	Bakker's message of "Sun, 29 Sep 2024 21:45:46 +0200")
References: <20240906030713.204292-1-ying.huang@intel.com>
	<20240906030713.204292-4-ying.huang@intel.com>
	<9c9586ab-0426-46c1-bcc6-6ee2927b7a86@ijzerbout.nl>
Date: Mon, 30 Sep 2024 08:53:03 +0800
Message-ID: <87ldzaotcg.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Kees Bakker <kees@ijzerbout.nl> writes:

> Op 06-09-2024 om 05:07 schreef Huang Ying:
>> [...]
>> +static void resource_test_insert_resource(struct kunit *test, struct resource *parent,
>> +					  resource_size_t start, resource_size_t size,
>> +					  const char *name, unsigned long flags)
>> +{
>> +	struct resource *res;
>> +
>> +	res = kzalloc(sizeof(*res), GFP_KERNEL);
>> +	KUNIT_ASSERT_NOT_NULL(test, res);
>> +
>> +	res->name = name;
>> +	res->start = start;
>> +	res->end = start + size - 1;
>> +	res->flags = flags;
>> +	if (insert_resource(parent, res)) {
>> +		kfree(res);
>> +		KUNIT_FAIL_AND_ABORT(test, "Fail to insert resource %pR\n", res);
> Isn't this a user-after-free?

Good catch!  Thanks for pointing this out.  I should be more careful for
the error path.  
>> +	}
>> +
>> +	kunit_add_action_or_reset(test, remove_free_resource, res);

This may cause use-after-free if failed to allocate memory for
add_action.  Will fix this too.

>> +}
>>

--
Best Regards,
Huang, Ying
