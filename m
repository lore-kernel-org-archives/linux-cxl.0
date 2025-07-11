Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100C7BA33
	for <linux-cxl@vger.kernel.org>; Fri, 11 Jul 2025 02:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752200581; cv=pass; b=OLPIgJNlTTrKUMpydX6/ffiXEQ5yynioGOVQyYxUpymqy1JB+tUbc+A0HOqxf01MXBJ7VLTAkZyu6wX70CpF6pjvezaud7cK66hY7cgkwRlf/ziKqnEdC6G6P2au2CzM/k8x6DQpnvXlPznOJbv3A5o30ITnFWd7ZKuUTWx/KtM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752200581; c=relaxed/simple;
	bh=i/lcxYuyiney49E4E0gK7DzfwS42pl6pC0/5jKiuXkw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M9bfCV2nJhqnxsZcPnkjPjPp2qwuAmzb5cuhGjhkJI02UIxKoeKrs2q6yuZ2Dv/bYM6YC6rKrEpa5SAo4IU6cLMHMykEoKxfwcsTvPLemVuxSfCKrm6MZPdM5qwrh/Mq1yUnw3WxS8JTHpJPVXmj7DPGc8zX7dX9aX7aqzs2GrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=aFvKOAOP; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="aFvKOAOP"
ARC-Seal: i=1; a=rsa-sha256; t=1752200570; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=dk385Mh75uQwgYWX+3C+isHcfowRnIha+W0MmWDTli2Wcs+lwz16gmUOb5pqMjA/nq3pv2A4InedAWX2cQBDSY7CSjrTdePCjm0kQ4tm11jv+L5VHdxePasQNixldl30UZxDBE0Ycu9MPynHQTF2pqidjola57eyklUsE+5/phw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752200570; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=i/lcxYuyiney49E4E0gK7DzfwS42pl6pC0/5jKiuXkw=; 
	b=Lbgq6db+y6GS+ImmjnAkC28HRJgrbw00Pl8BciM3ytq2RKww+3F7SwHy0v7QUG4/FWpCHKQZ5d3tEK5l+CYMCoBUgrwiJnUasEr7rbLO7/djWin2dzleV5nEf07UadC0PwRTV4Vhe+KHL+3yNef90eokkc1WNfG6zNukXqwF6nY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752200569;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=i/lcxYuyiney49E4E0gK7DzfwS42pl6pC0/5jKiuXkw=;
	b=aFvKOAOPTJv8huaeVrlLspozWIPftRPQbsgTy46EO9LRR8i9lYlqX8G0cjb8gdBE
	oM+xBoT6dWB2wHC2k+Q8AoK7UZfijbUHxxzyVMwG3bdeCwL2sHKIzgPwzwQ1Wfh5lhV
	2zFKl5ypQZgjip6/KvxHnD4TjAeub1TolM62CuHo=
Received: by mx.zohomail.com with SMTPS id 1752200568217888.4281230501025;
	Thu, 10 Jul 2025 19:22:48 -0700 (PDT)
Message-ID: <e186c01a-78b0-470b-b7cc-56f6ab11b5ca@zohomail.com>
Date: Fri, 11 Jul 2025 10:22:44 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 05/10] cxl/test: Add cxl_test support for
 cxl_port_update_total_ports()
To: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com
References: <20250709203619.2607133-1-dave.jiang@intel.com>
 <20250709203619.2607133-6-dave.jiang@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20250709203619.2607133-6-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr08011227442f0e38a351d06a4d5ec3df0000ad9570cc902bc7142405767ca9a691fb88331f919c7ec7c2c3:zu08011227772dab6f15f00a6c77ba61200000703b0ffc730de2356fdeef2ffd62ef2731e640dd1bdbe78056:rf0801122d201626a7527a28bfc75a61c70000a4f7315770124d84ef045ae0dd062ca7a0f6e765294d25820fdd1ddfbcdc53:ZohoMail
X-ZohoMailClient: External

On 7/10/2025 4:36 AM, Dave Jiang wrote:
> In the delayed dport allocation scheme, the total number of dports
> need to be discovered during port probe. Add the mock function
> that does it for cxl_test.
>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
[snip]
