Received: from bout3.ijzerbout.nl (bout3.ijzerbout.nl [136.144.140.114])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F30119047D;
	Mon, 30 Sep 2024 17:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.144.140.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727717794; cv=none; b=MCVqm84G0yHgRGtoOYW5dIYPlNk2Q0UC0WBZG06wA/0xb+sHjOpmmcDymtjuGt0lzEPDTWiPO3dpvin0Z+qCGmextoT3wiQN0WQHGeB7SgSpTLwJ9C60bf21SQMrHMVkm1NJXtV8VO83QjggKgXwU2QBEgT2ni83DdRIbe353MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727717794; c=relaxed/simple;
	bh=kvASDgQEQw5COW6XOE41pHOgcpsYuEybcRPjzMwQzLc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IKN4vybNIwklW/JyeFP3zwo9ISaHh34sxVBiD5IFvIQmMqmrv/BNXojMVkHuIz/coTJoiGCH2G1PW3RMk2Y8lQG32iJ85r5DK8qDIIxr764pDwHC9VNNCXJ87Vq4t8GVxYt7mJ9MamrnQx4ylfjdd3cEoGQWfKM2/7qXeiKx/qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ijzerbout.nl; spf=pass smtp.mailfrom=ijzerbout.nl; dkim=pass (4096-bit key) header.d=ijzerbout.nl header.i=@ijzerbout.nl header.b=P9poVHKA; arc=none smtp.client-ip=136.144.140.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ijzerbout.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ijzerbout.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=ijzerbout.nl header.i=@ijzerbout.nl header.b="P9poVHKA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ijzerbout.nl; s=key;
	t=1727717786; bh=kvASDgQEQw5COW6XOE41pHOgcpsYuEybcRPjzMwQzLc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=P9poVHKA0uTfgvfDOBiaRKqMAXGv9b8de482/+ymVmD66DUbGEaazt+TI+htdt1x+
	 e/M/IAiVj/7/GhxG5HGL7eD1CmQ2vDvj7b+1yIZps0lB0cJ0VcRIh+wocQm9Lj3ymo
	 MoJ6ktUmqyVmmAONSpWu7ao03HEsEZJ7IbsMWPPgv7sw6CuTi0bzo703ThZ7XUUKpd
	 7sxP4Ld+iyY31f4ffRMzpUxNn87r1p/H1QM+DU54r5W/p1xCy6pnugbwWNGI8TLIcI
	 l45klgPdMSWrSPMkmv1dLb/f7FtNHjNtQ1dh3T1CCLwctDTBD5CQPxm6te41+bNK6P
	 oY8zqbFBM0K8a3M7+1FEtM0Cu2g+DNroERMEeDVbcaKupHx22QtTgPKX2f6fflKtO7
	 lrOQ8iMuO96TQf26tZiTfgHCZP0Ba7MWwubBWRRWuZg2CutDMWpX9bjdhW2q9O7IjI
	 9OvIXMcC4Ppg49ql51XFWsJ/6kH0djIG+h7cQEJ9ICr0U3xcHL8ouBxSUDDKBdo09e
	 Wf1ilcV0TEY8w+ox+KCNKgptj5GUgDfZ5I7x5nYd+EYj9qco9PVbabK2bwaT8EilAN
	 LGJSqeK7AMJ249PvCuXBju1yFYu2vVhT+V91psYUfvH4cTqH8hhD6UvkGBhAxSkmGT
	 hmKipLn735Mq0NAYZAG/28IM=
Received: from [IPV6:2a10:3781:99:1:1ac0:4dff:fea7:ec3a] (racer.ijzerbout.nl [IPv6:2a10:3781:99:1:1ac0:4dff:fea7:ec3a])
	by bout3.ijzerbout.nl (Postfix) with ESMTPSA id 5B0BD167DD8;
	Mon, 30 Sep 2024 19:36:25 +0200 (CEST)
Message-ID: <35130b82-0b6f-4468-83a2-084f188fcf5d@ijzerbout.nl>
Date: Mon, 30 Sep 2024 19:36:22 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -v3 3/3] resource, kunit: Add test case for
 region_intersects()
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
 Dan Williams <dan.j.williams@intel.com>, David Hildenbrand
 <david@redhat.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Alistair Popple <apopple@nvidia.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Baoquan He <bhe@redhat.com>
References: <20240906030713.204292-1-ying.huang@intel.com>
 <20240906030713.204292-4-ying.huang@intel.com>
 <9c9586ab-0426-46c1-bcc6-6ee2927b7a86@ijzerbout.nl>
 <87ldzaotcg.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Language: en-US
From: Kees Bakker <kees@ijzerbout.nl>
In-Reply-To: <87ldzaotcg.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Op 30-09-2024 om 02:53 schreef Huang, Ying:
> Kees Bakker <kees@ijzerbout.nl> writes:
>
>> Op 06-09-2024 om 05:07 schreef Huang Ying:
>>> [...]
>>> +static void resource_test_insert_resource(struct kunit *test, struct resource *parent,
>>> +					  resource_size_t start, resource_size_t size,
>>> +					  const char *name, unsigned long flags)
>>> +{
>>> +	struct resource *res;
>>> +
>>> +	res = kzalloc(sizeof(*res), GFP_KERNEL);
>>> +	KUNIT_ASSERT_NOT_NULL(test, res);
>>> +
>>> +	res->name = name;
>>> +	res->start = start;
>>> +	res->end = start + size - 1;
>>> +	res->flags = flags;
>>> +	if (insert_resource(parent, res)) {
>>> +		kfree(res);
>>> +		KUNIT_FAIL_AND_ABORT(test, "Fail to insert resource %pR\n", res);
>> Isn't this a user-after-free?
> Good catch!  Thanks for pointing this out.  I should be more careful for
> the error path.
I have to honest, it wasn't me who found this. It was Coverity.
>>> +	}
>>> +
>>> +	kunit_add_action_or_reset(test, remove_free_resource, res);
> This may cause use-after-free if failed to allocate memory for
> add_action.  Will fix this too.
>
>>> +}
>>>
> --
> Best Regards,
> Huang, Ying

