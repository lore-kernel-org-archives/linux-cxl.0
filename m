Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA1D17D7;
	Mon,  7 Jul 2025 04:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751861987; cv=pass; b=T4AbaXV283jKVPTNmSlb7qrr0TExtROlO16i3OPZOoHTUX+OQxKB3ajuwby8xBxV9j95vta2L4dM4N8cj84g7hruRJR3k2CzRaOqY5U00nQ1niySNyHavoUpXAb59atnQHDn1zjzcJXLTa+yjttOZtroTczwfCuZPW7w0TAi+ig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751861987; c=relaxed/simple;
	bh=RwWMB34g9rCDbHLn8yPIkjSMr+CnI3ap3bodc9XNZjI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PrvbuyFGvQ+efswmMIvnOkwssJRPDktRFEI8gfYbWjQ3rkvsY+p8+LjaAXgB4+iO59Tx0KkQzRASMHJ5NcTqiuL2sRuO+xQCccn7EZ38JPJpgedbVWsddBUy+GYnJsRul36cklGPgk0YjuLMR11ytlDSU92Xjws3vxiyY2L8CeU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=TFW9e93L; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="TFW9e93L"
ARC-Seal: i=1; a=rsa-sha256; t=1751861966; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Xaqw8eOXAasJ00ef5a0Zunhe+G9/vsb50c3YSNn7IymK+azQDjT7ZTynCjbQ9VFWzW/Vc4FlsA5qJsFh2xEdYupsPUojywD5TBZd/M9a5Q3x/GWigf9CounTQL5G0iwoYqXIbC39+6OutCeqESjNegsmGagjox8aVJN88lRx8GU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1751861966; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=aW8X6gMZ1SdNLc0VFO/rTDF1BmkZo3BS9DL00iqSFhQ=; 
	b=YRicHWqtc/+Uj+Jz5eXRWu19g0aVw2CS17kd4dTrrgYo6iddPxUnJI6o/Jo1RNggGyxv3pcwekzDbSwJhMdfyOJ+9DQB9ReimFaa5dqJXzM4A6gIK1ZbJ9Guwgq9Qs1QDmhOmVJm50FFzVgoFhj4glr94ux/azr+1npTpwdKMRg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1751861966;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=aW8X6gMZ1SdNLc0VFO/rTDF1BmkZo3BS9DL00iqSFhQ=;
	b=TFW9e93LkDqxB+ksmApsTExnoOV+ekl69lvXM5aNuGxzd0iiJMhYF1vT4VWf4se2
	T7mUjiHU1w9+4/NoSY27TZgDlGj5q07h3mAq9dVBtma667vSB+0OlnZ2+BgOJ+xhBuz
	NDKUTVJjmVO5UARN+z7yAg2G+4Tua0bTp6tGY/2k=
Received: by mx.zohomail.com with SMTPS id 1751861963845592.6745254606707;
	Sun, 6 Jul 2025 21:19:23 -0700 (PDT)
Message-ID: <ac55632a-2484-45dc-82f8-c1b4020cc4b4@zohomail.com>
Date: Mon, 7 Jul 2025 12:19:20 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] resource: Introduce a new helper
 resource_contains_addr()
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
 Alison Schofield <alison.schofield@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 akpm@linux-foundation.org, bhelgaas@google.com,
 ilpo.jarvinen@linux.intel.com, dave@stgolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com, vishal.l.verma@intel.com,
 ira.weiny@intel.com, dan.j.williams@intel.com, shiju.jose@huawei.com,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250702072008.468371-1-ming.li@zohomail.com>
 <aGTq5MKCYBO3H9Gg@smile.fi.intel.com> <aGWFdwla54b-98-x@aschofie-mobl2.lan>
 <aGZN6EFMLp-pL6JB@surfacebook.localdomain>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <aGZN6EFMLp-pL6JB@surfacebook.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr08011227bfced6fb00e4ff42f87bcb950000ecfe8f9c4e421fbd165dd65455114b4f76954a8675f0b87518:zu080112271674cf3d4e122a257b56d1e60000d42db1d3ce4c71e97e5cf850efcebffd29497ece3869790943:rf0801122d9f8a7e00e469a156117245ba0000ef6485b0ae239b8d0d39ccc0f83a5ee5c24b243fbe7edbef8103465df2ce31:ZohoMail
X-ZohoMailClient: External

On 7/3/2025 5:31 PM, Andy Shevchenko wrote:
> Wed, Jul 02, 2025 at 12:16:07PM -0700, Alison Schofield kirjoitti:
>> On Wed, Jul 02, 2025 at 11:16:36AM +0300, Andy Shevchenko wrote:
>>> On Wed, Jul 02, 2025 at 03:20:06PM +0800, Li Ming wrote:
>>>> In CXL subsystem, many functions need to check an address availability
>>>> by checking if the resource range contains the address. Providing a new
>>>> helper function resource_contains_addr() to check if the resource range
>>>> contains the input address.
>>> resources are about ranges and not addresses. At bare minimum naming #####
>>> here. Also there is no symmetry with the intersection API. But I would argue
>>> to use resource_contains() and just provide necessary parameter with both
>>> start and end to be set at the same value.
>>>
>>> 	struct resource r = DEFINE_RES...(addr);
>>>
>>> 	if (resource_contains, res, &r)
>>> 		...do stuff...
> (1) ^^^
>
>> Thanks for the review. Two alternative approaches were considered:
>>
>> 1) A CXL-only helper with direct comparison:
>> This duplicates range checking logic that's already common in the
>> resource API. We'd end up with CXL specific when the resource API
>> already provides the semantic framework for containment checks.
>> 2) A CXL helper using temporary resource + resource_contains():
>> While this maintains API consistency, it's unnecessarily heavyweight.
> How is it? It's mostly matter of stack usage. Do I miss anything?
>
>> Creating a temporary resource struct just to check if a single address
>> falls within a range feels like overengineering.
>> (This is your suggestion above.)
> I don' think so. This won't create anything, it will declare the resource
> data on a stack.
>
> ...
>
>> This patch proposes, a new helper in ioport.h, provides a clean, reusable
>> API that follows the existing resource_contains() pattern while being
>> optimized for the single address case. I guess I can agree with the lack
>> of symmetry with the existing API, but that's only if one thinks an API
>> cannot be extended. The new helper actually complements resource_contains()
>> nicely: one checks resource vs resource containment, the other checks
>> address vs resource containment.
> The point is _there is no address_ in the resources! There is a _range_.
>
>> Revisited the name, I can see how extending an existing name, like 
>> resource_contains() is a poor choice because then one might expect the
>> pair to be resource_contains_resource() and resource_contains_addr()
>> which it is not.
>>
>> Do either of these fit better, or something else?
>> - resource_includes_addr() 
>> - resource_has_addr()
> That's why (see above) naming sucks. Doing it local to CXL makes it clearer as
> CXL knows the semantic of the range, struct resource doesn't and shouldn't.
> (Yeah, I know that we have something there that relies on the range being an
> address range, but those APIs provide more and TBH I would rather split them
> to a separate header)
>
>> The new helper would immediately be used 7 times in the CXL subsystem.
>> What are you thinking the bar is for adding to ioport.h?
> It's only a single subsystem, find 3+ more outside and we can reconsider.
> Also for the symmetrical API,
>
Hi Andy,

Thanks for your review. After checking other module code, there are more than 5 modules/subsystem using similar code to check if a resource contains an "address".

But as you said, struct resource is not only used for address range management, like pci_ecam_map_bus() in drivers/pci/ecam.c, it checks if an resource contains an bus id. So resource_contains_addr() is not a good implementation for all resource type, I will implmement it inside cxl subsystem in next version.


Thanks

Ming

