Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8076B1BD9C9
	for <linux-cxl@vger.kernel.org>; Wed, 19 Feb 2025 07:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739949969; cv=pass; b=emBizF4u5gbJEz6bVjzkuNsSgNpQucNJF1ZjXeymOvRxFiN74ZCNrYpuDGYU9ST19GJ1p7v4DJ3JTlWIwAXsG/SpCw0Eta5LzFaatQTl6f3kPDuML/yjR9cxqKI7kqQWik5dERytipqeyexlHSrlZZ8D1inmiA+0XeGyVWjmn0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739949969; c=relaxed/simple;
	bh=42qSv5hoQSNpAq0+5E17/QBxn1dU/5Nc1ZbnD9EgQac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ltpjG9PSt+wfLcCtBFDD3JqOGtP/bCbrDE7Y/3culXHwrQ944ZdIxLs8ZCd0o3yXD4vcmX7CzvpwjR1pbKOWyc+YibPgUQZL5Q/JzohdL/j7j8ntehg51Xg9wx0hLicFNqSz51ZWopsEYjdydk6nIBiHC41ch1IdLogX0FQKZeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=J9E9Sw9n; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="J9E9Sw9n"
ARC-Seal: i=1; a=rsa-sha256; t=1739949950; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=OmtrBvhyamJyK/4Ld7ECMfCzED24Uja4flZF0DFl0lX9gHiNiTCzccR7nvRUQZdSdBGTvX2yz5+m75rUFIFQctlegutNG3ss/k4iakmHzXUtHKv68io2xmwOM4Ai/5rkcFwo20kABvoCJ+AaGt3UGbXu8/XsMFQYZFgx8E5Zd8I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1739949950; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=42qSv5hoQSNpAq0+5E17/QBxn1dU/5Nc1ZbnD9EgQac=; 
	b=dkwm74mdaCsrxLy7NCYQQ85s6myxs0nJ/UuulLZoOF9964Cn2pj2wJJ3EHZRujRaP8ZCAyjqZAMtLvn91PwgHKkqZQpYmC785/PX1B/gwCX1dkcQkZN0T1X3opAkf0hym+7sPro6N7b79tQgZKlNPb9LVkPhn+1pmUMO8LrQdLc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1739949950;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=42qSv5hoQSNpAq0+5E17/QBxn1dU/5Nc1ZbnD9EgQac=;
	b=J9E9Sw9nuHa0kdnwl8tXpK7JfcSdwQ6jsgwak59eWItT+S5JsyDdO8/IqD6OW/q5
	rqmov1xhYmQGWvluG3exqvO9bITinANsFFSxnkUbvdKP2SnPDecVIqUtUWNCOa6jHUl
	ktUPGSs+Y9rAaEWpinaRFVuHbbiVBwFIUNviKwNk=
Received: by mx.zohomail.com with SMTPS id 1739949947171379.3128739497323;
	Tue, 18 Feb 2025 23:25:47 -0800 (PST)
Message-ID: <993681f6-f914-4097-b9cb-9ac593439f86@zohomail.com>
Date: Wed, 19 Feb 2025 15:25:45 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 07/14] cxl: Add FWCTL support to CXL
To: Dave Jiang <dave.jiang@intel.com>
Cc: dan.j.williams@intel.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, Jonathan.Cameron@huawei.com, dave@stgolabs.net,
 jgg@nvidia.com, shiju.jose@huawei.com, saeed@kernel.org,
 linux-cxl@vger.kernel.org
References: <20250218225721.2682235-1-dave.jiang@intel.com>
 <20250218225721.2682235-8-dave.jiang@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20250218225721.2682235-8-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr08011227bebd73835a6e375997710ad80000f7d301dd7df1762e1079c99e641c87102a09a849c6078918ac:zu080112279fa40a1a04e276693014865e0000d566e1d37b5dd40176f0d449a6a1a747902f5fba0ad8092ccb:rf0801122d719086424578fc0d84111a3900001765cbf506c58d573a0362231d770d7c8facc262c3d26da47782acd1190b9e:ZohoMail
X-ZohoMailClient: External

On 2/19/2025 6:54 AM, Dave Jiang wrote:
> Add fwctl support code to allow sending of CXL feature commands from
> userspace through as ioctls via FWCTL. Provide initial setup bits. The
> CXL PCI probe function will call cxl_setup_fwctl() after the cxl_memdev
> has been enumerated in order to setup FWCTL char device under the
> cxl_memdev like the existing memdev char device for issuing CXL raw
> mailbox commands from userspace via ioctls.
>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
