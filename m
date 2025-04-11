Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F180427BF99
	for <linux-cxl@vger.kernel.org>; Fri, 11 Apr 2025 03:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744340766; cv=pass; b=WUPqPm+3oiEd3O7ZXQJRuXBm6ievVTVDo8Uj2yckjW4+ZInhhOL6V68uvQ5S5LWiWP8KC0itfToQlc9JtWEt12IZGgwfh95Z4qG0yiWI25You3xYTMYFfFnjz97vgmdxMDGPCkdry3b3w+iGMq8xf91LMg5YzM2rav+6zDdLUnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744340766; c=relaxed/simple;
	bh=0sxL9MclnSTd23YL8PJC1XKYbPGgUnRwBOjbhJ9G4f4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ArhhoO1/c7wzlQnMLij/oL2ROsDGKD0fem7S21GuuMuMW47480c2o/2Gp0+hgSyS6wM5+dIaZ2ME5MXAqc+9nLdT6Ja5T9PnfHFzAYGz0ZwbA3YUw4zs9ZV9W1bKv4tAM28BIfdNfn1JFp4Bz6qYupr+b0jlYFsqJaurZR7WI6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=XSFn9F85; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="XSFn9F85"
ARC-Seal: i=1; a=rsa-sha256; t=1744340751; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=FK519aIw2KV8XG5fckiNnzfipoIyJc0+ViNhsgYygF+2MvoHFDcUpGLb2gdQ7xBRDVBHRQCxc1+Z2OCspGE5k5BCANU4rEI07r0hRDXmsSRKST8JNScQm8ueUqDVozpER57iUQLodO057Ug8b6eDR/smp81undpf31LoY/66wLI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1744340751; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=0sxL9MclnSTd23YL8PJC1XKYbPGgUnRwBOjbhJ9G4f4=; 
	b=lbAOihJO85a7zEd3Wu3qIxGpAdzpgpDP15qhYaxE2Uq0ILTrtam2X+o3hB1BNmPdEdUPaRlzMnrLXxHgMreTXVkZiq7HBVchFpY7O0fSc+k92oJyjcAMm1uBhsq8quCpkzP+gk2oXhIE7f4/ZsBwAKOkBHTrJK6V3xl/AexRHtI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1744340751;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=0sxL9MclnSTd23YL8PJC1XKYbPGgUnRwBOjbhJ9G4f4=;
	b=XSFn9F85ztXYRhZfmcTLgmLeCY3N/2FgOr6ClyFNp/x2n8c+Jw8yFJAOSlM/pg7Z
	eowiZWKuOeCa51P4gb0MdSGyO3dkMN0cP0XdpZidC0dCRQkCXWcpgXC1YD/pxqlUBrx
	uhdvZYCRVEJi61pO5DgzPnB5W0KWFZqpgVU71kTU=
Received: by mx.zohomail.com with SMTPS id 1744340748498654.5924944307541;
	Thu, 10 Apr 2025 20:05:48 -0700 (PDT)
Message-ID: <ecc9fca5-5166-4516-9eda-2562a0350378@zohomail.com>
Date: Fri, 11 Apr 2025 11:05:46 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] cxl: Delay HB port and switch dport probing until
 endpoint dev probe
To: Dave Jiang <dave.jiang@intel.com>
Cc: dan.j.williams@intel.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, ira.weiny@intel.com, rrichter@amd.com,
 linux-cxl@vger.kernel.org
References: <20250404230049.3578835-1-dave.jiang@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20250404230049.3578835-1-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr08011227513ef3a07f820c5bf947ebd500004391384dbd2b8daef60069cfc4c4a972ba960192e6d0c751c6:zu08011227ac31a0a286b8cd538d50ec6900003cc87ad86b94eeebefdb45400a5ca01bc71b0f080d289f7b6a:rf0801122d387a3a1b0ae49a3c0faeb5eb0000355e411715217846e4f9f3269848a87609a0acc551ac669a73202be05af26c:ZohoMail
X-ZohoMailClient: External

On 4/5/2025 6:57 AM, Dave Jiang wrote:
> This series attempts to delay the setup of dports and Host Bridge (HB) register
> probing until when the endpoint device (memdev) is being probed. At this point,
> the CXL link is established and all the devices along the CXL link path up to
> the Root Port (RP) should be active.
>
> And hopefully this help a bit with Robert's issue raised in the "Inactive
> downstream port handling" series [1]. Testing would be appreicated. Thank you!
>
> [1]: https://lore.kernel.org/linux-cxl/67c8a0cc23ec_24b64294f6@dwillia2-xfh.jf.intel.com.notmuch/

Hi Dave,

Thanks for that, you can also mention the patchset is also a long term solution for the issue[2]

[2]: https://lore.kernel.org/linux-cxl/6712b7bf2c1cd_10a03294b3@dwillia2-mobl3.amr.corp.intel.com.notmuch/


After going through the implementation, Setup component registers is triggered on root port and HB when the first endpoint under them attaching, then component registers information are cached. But the information will not be reset after the last endpoint under the root port and HB removed. So the information will be resued when an new endpoint is re-attached to the root port and HB.

I am not sure if component registers information on hardware side is possible to be changed in above case. Just want to know if we need to consider about it?


Ming

