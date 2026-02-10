Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A15327210;
	Tue, 10 Feb 2026 11:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770724606; cv=pass; b=ATGJFSigndml+mNOk5cLAQXjX7NO/JwUi2lKWGOGWsnYpDCVtHLJ70/Lbes6+fBp6jSdlaf4W73CDehL1T449P7r9pIojZJ+zKRHPyC6oU5mq/G3He9Kv4XHGAWU2F7Nfw1QaAu2Y4yHg4JzPgg2+nfv3ZnSUkSIogqUGd+KJbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770724606; c=relaxed/simple;
	bh=N2j2fhY39N9vVXqXbdneoMI1Ym9zkDrftrqyqoykJmw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NZ+t0LAi+hLlGpLphyp0hGilQ8tBdkdZQoF6rRXgRGHu2abkTJhi2/fVIOfV87Zl7cyk8nJPcuN7QQGVHym2MRuyaahuliI3nWL0qV+AL7iifWgyGKMJ/5YD1TchC/RGfyy1WuwcZ6Th2qMQKfTwdEr+TLldseTXYZbaW01v3fw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=EajKmbZF; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="EajKmbZF"
ARC-Seal: i=1; a=rsa-sha256; t=1770724591; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=XOhn4qfTc2y8hJ59XPrHqr1SY+qfziBPRQ7j8XhFMQYx2kofTseiAS3UfBn91KxwvrAjebS3RpD7lDCcZM8st+jE9qKsJ/yZR8d8X131VHQ/6RDibLEEUAwzTU7sXYUTlvu4bH2XS1DccsNrS6JUU95v6o3OAFDxRqy/Nl1mWuM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1770724591; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=md0lTYAb+qGdkvpDkDDxJScgrJUcJh8HAc5g7Z7Wi3Y=; 
	b=Ozo6ZYoeH/hffo2NeUauZaBJuTAaKKTR6fYvSV5U5cj9Is3r5inQSIO5p0FPvaVQQnYqs4NhzJkdagXPsmvOymQf3C67y5q7tTTvOs8MoYwvQitdVSXrfPrPHrb0EOn1fmxwTNlSu+7wOHshBS5r7D0sJfvjmsz9J9H1Q9aW9pU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1770724591;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=md0lTYAb+qGdkvpDkDDxJScgrJUcJh8HAc5g7Z7Wi3Y=;
	b=EajKmbZFwKjlEWRmbufec0riFD9qZcxYzawBXlyETHySVtP4VGfINPjF28gTNxe7
	fK+fkKD0xQ7yAIBUuWQHvtMrv+r6w38KLXfTwc5r31lDOlYFq1SNalTesOaksluL/yw
	nm3bkRQAV/kIuQyna2yY5/KmD5Q6jrNYKXy1Y81E=
Received: by mx.zohomail.com with SMTPS id 1770724589805398.99036330701927;
	Tue, 10 Feb 2026 03:56:29 -0800 (PST)
Message-ID: <4eefdae3-125e-4c80-9968-8d20648f33bd@zohomail.com>
Date: Tue, 10 Feb 2026 19:56:20 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Fix port enumeration failure
To: Alison Schofield <alison.schofield@intel.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260207133512.306128-1-ming.li@zohomail.com>
 <aYqgQ3QgaedMhNny@aschofie-mobl2.lan>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <aYqgQ3QgaedMhNny@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: rr08011228b4a3dff33a60ecda590f6b3d00002b00731ea79931f4221ec9df3a3bd89c1d8dd9eb7c09d6752f3c:zu08011227072c99b65f491c8bb4eaabfc00009d2e577c92417015a19881bcc27757b024adb3aa512ab14447:rf0801122def361016299db313429730e10000f3355d2a97ab72efbe53d42b6c777c49925389c6d25fe3bfd45f4aaffe373e:ZohoMail
X-ZohoMailClient: External


在 2026/2/10 11:04, Alison Schofield 写道:
> On Sat, Feb 07, 2026 at 09:35:10PM +0800, Li Ming wrote:
>> I ran CXL mock testing with next branch, I usually hit the following
>> call trace.
> Hi Ming,
> I started hitting this after you first posted, however it takes me a
> long time to hit it. Do you have a method to reproduce that is better
> than running on repeat as I do? Thanks!
> -- Alison
>
> snip

Hi Alison,

My environment is a VM with 2 CPUs, maybe you can try it.

I use a script to run "meson test --suite=cxl" again and again in the VM.

I can typically reproduce it within 30 minutes, I have also encountered 
cases where it fails to reproduce even after one or two hours.


Ming

