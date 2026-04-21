Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A3A3B6C00;
	Tue, 21 Apr 2026 10:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776768535; cv=pass; b=NldZGx9ejdCf+RpZPhpThY0jCyc08n5xqtanc2Sq9n/qqHvRaIob52QK34+ZJwlyV+xlD3jZsPIsqY/sWJhRjUnQUoCAZDrs4iCbaaH6VurNFs8aCM/k5KQprjaE7jiSDYXT+mrlfPpDw9Itj4I3CSNfH/1saI3SlzFOP70RYbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776768535; c=relaxed/simple;
	bh=QXeXJxwR4AAain/grzb6VTedX2LJK87P722v0plWi8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EDWJtPTWzifchsnw3FWTogMM76fWL5tEY/oUDe3waoyhKpsXWk5zNmnwMTzC5k6vgkjfl5W9y6JNCWLPCrj9vxAaO97H2JflOGOac0hhz2fa/J0J1uk/Ssg2jp5d+8sZgk9GOmk2FAI2QbIHhZufRY6qAMfnf/gxXZbdCJ0TTuA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=CXwyeCV3; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="CXwyeCV3"
ARC-Seal: i=1; a=rsa-sha256; t=1776768516; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ADmiVXrqFg8Pudfbv4gHsuCgjoBxYWO9x7PcIN8uJCp4k3yQ8eT3KhOMguJBwUCXWkr+AGHDMtq5RqMm6MCdA2pYosbCKfiPqZv2c3GGQ8NSIIdKrqs7lOhEWglLTuo7ruQEjCVHcX21EduVc+MEab64q+x6kak7FeNxK3ptgSI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1776768516; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=QtUSpS5xgMacdNEe4xOf2Z4l0paD0rzRkJfr1DJn9Ho=; 
	b=Fk6C98y8Br2SfThu5Y62scef/RMiHQM9mgG8QdKpYTKaqWUcZ2/LLJlmnYXpxE2/XReDIBv11Lq1ajRSYUQ6U3i0+nLCKNrdei9f0+++5WrMu/4++SbTHryccWfQGxPMLCP5GzL3Mb28EvsXVsLK9Ex68Zgjgd3WVdWHkY7N5VQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1776768516;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=QtUSpS5xgMacdNEe4xOf2Z4l0paD0rzRkJfr1DJn9Ho=;
	b=CXwyeCV3L++l/RfSD4ZKau6jse2KqTHVErtym8NdaBjspZBN7JSPsXWIe45VY9Hq
	f1QiygQvX7AScbcy31Mya/m2p3fe4vNodv8OeX0F6PEYeY2u9JLqNKgHgYYL0NHmUi/
	WRwfC90WJSL35Zi/sD+UCHalDgJa/3yK9bY/ur9c=
Received: by mx.zohomail.com with SMTPS id 1776768512771721.4392572083452;
	Tue, 21 Apr 2026 03:48:32 -0700 (PDT)
Message-ID: <778c8dc5-b65e-4b1f-be13-8bfb960cefc3@zohomail.com>
Date: Tue, 21 Apr 2026 18:48:21 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] cxl/memdev: Hold memdev lock during memdev poison
 injection/clear
To: Dave Jiang <dave.jiang@intel.com>
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-cxl@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Ira Weiny <ira.weiny@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Danilo Krummrich <dakr@kernel.org>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ben Cheatham <benjamin.cheatham@amd.com>, Dan Williams <djbw@kernel.org>
References: <20260314-fix_access_endpoint_without_drv_check-v2-0-4c09edf2e1db@zohomail.com>
 <20260314-fix_access_endpoint_without_drv_check-v2-2-4c09edf2e1db@zohomail.com>
 <c784d84c-e8ac-4c87-abec-3d4e64f074a2@intel.com>
 <d2ed94ec-e5c7-4b6b-9fe8-68f22bd632ad@zohomail.com>
 <dfc0979a-b01a-4c90-8bc8-7a60fb795dc7@intel.com>
 <69da9fa696d0f_6c31a100e8@djbw-dev.notmuch>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <69da9fa696d0f_6c31a100e8@djbw-dev.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: zu08011227cfef9a97a59ddb595874eb010000dc9efed156263c5b4e6893bca069031c7de30715a95f280bf9:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External


在 2026/4/12 03:23, Dan Williams 写道:
> Dave Jiang wrote:
>>
>> On 3/18/26 4:59 AM, Li Ming wrote:
>>> 在 2026/3/17 23:00, Dave Jiang 写道:
>>>> On 3/14/26 12:06 AM, Li Ming wrote:
>>>>> CXL memdev poison injection/clearing debugfs interfaces are visible
>>>>> before the CXL memdev endpoint initialization, If user accesses the
>>>>> interfaces before cxlmd->endpoint updated, it is possible to access an
>>>>> invalid endpoint in cxl_dpa_to_region().
>>>>>
>>>>> Hold CXL memdev lock at the beginning of the interfaces, this blocks the
>>>>> interfaces until CXL memdev probing completed.
>>>>>
>>>>> The following patch will check the given endpoint validity in
>>>>> cxl_dpa_to_region().
>>>>>
>>>>> Suggested-by: Dan Williams <dan.j.williams@intel.com>
>>>>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>>>>> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
>>>>> Signed-off-by: Li Ming <ming.li@zohomail.com>
>>>> Hi Ming, I dropped this patch with Dan's comments [1] and updated cxl/next. Please check and make sure everything looks ok to you. Thanks!
>>>>
>>>> [1]: https://lore.kernel.org/linux-cxl/69b8b81621e16_452b100e@dwillia2-mobl4.notmuch/
>>> Hi Dave,
>>>
>>> I think there is no change needed in this patch, just need a independent patch for holding memdev lock in cxl_region_debugfs_poison_inject/clear.
>>>
>>> Or you want to review this patch again?
>> No. Maybe I misunderstood the comment from Dan. So we should keep this patch?
> tl;dr: yes, this patch is *now* valid.
>
> As originally structured having patch2 before patch3 added no value.
> Going forward I would say do not structure a series such that a new lock
> taken in patch N starts being useful in patch N+1.
>
> I assume that is what:
>
> "The following patch will check the given endpoint validity in
> cxl_dpa_to_region()."
>
> ...is trying to say, but when commits are applied to the tree it is
> difficult to see that this commit was from a series.
>
> So do pick this one up, but the changelog needs adjusting. Something
> like:
>
> "cxl_dpa_to_region() assumes that it is running a context where it is not
> racing changes to "cxlmd->dev.driver". Acquire the memdev device lock in
> the debugfs entry points to preclude debugfs usage racing cxl_mem driver
> detach."
>
> With that you can add:
>
> Reviewed-by: Dan Williams <djbw@kernel.org>

Hi Dave,

Will you pick this patch with changes from Dan's comment? Or I need to 
send out a new version?


Ming

