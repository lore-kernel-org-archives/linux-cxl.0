Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CDA137E
	for <linux-cxl@vger.kernel.org>; Sat,  8 Feb 2025 06:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738994450; cv=pass; b=F3kJGTBwdTClKjqBw43Vmwo/M65sLDXvw1sAI1d3BdkIPM6XjzZcqNh1w7lIQ2xpc32fTWYlTfWaciOfNKFXqwnhp31neXblVPtYVhTkgQZHRUGebskPRFyiuUJIFchUy1Gz8MSjO0JPihOwIq/esuOe4QHIfv/VfQfKyCgkny8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738994450; c=relaxed/simple;
	bh=tciJJrEJiLlhXcHSEfeO13XKQVOOFmDU8u4DmB1o+Yo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bxvl7a95Vuqxt34PWTYOZqU8wwBYt9wEaVLVaUgAYdF2aBXwRHZDB4dS7pJ0hXRIQklj0GMk8/HVQHVnK79Bmbfk0dtrbnJliVxMZNxY7W1CrRnN5Bq6vKflB3K+L1HEopyccJrGWiHk4IbmXVmTIZYa9fJ+R78YPhQj53zMUfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=MNX4Rp2B; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="MNX4Rp2B"
ARC-Seal: i=1; a=rsa-sha256; t=1738994431; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=mLnXr4yrLpuxWzPKygjRVsUDIYEjf/BBtM0juAFjKn0R8f0rO+BIFgcg66m1S0blh6ChRF23fsJHNlIzedI/Iz6/lPyvMgJo6Zb6hPt+c/NdjKNCsNC5L373nYHq7dHKBEdIvokr7T7OZb3UkDDuRurwMtPocA7DKhZwlt9Pjg0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1738994431; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=tciJJrEJiLlhXcHSEfeO13XKQVOOFmDU8u4DmB1o+Yo=; 
	b=GKSro9JOS2SZFi2QN7UUMhBRrFXNhv0TUBDWZeWGzE1pfcsi/eJ9PQikXpPFxf50lBLzZmtF0/ltEdiijGGLJSoJgvCkRZnDdp+kLZwpU4AGRQ9ZkA2FwUUMRYrPnl5pb4qQkhOhWZNJkZBXjCGyP/dZoERHFKnmg6Z3P+SVsOc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1738994431;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=tciJJrEJiLlhXcHSEfeO13XKQVOOFmDU8u4DmB1o+Yo=;
	b=MNX4Rp2BGwkEPOmsZvErhu35BF5rrmOxpB3Fd/e8xHweh+eNt6X3pCr+DU8m2d5X
	vEEpa8rp3ewfHQWmo10/lWvGvqjCxINIbTvqmimOzj6LrOgiAF5xHtTJDhXPKGUe2TW
	J+D/7ZYtvoeEfVuV7D4gPb/0a4BV9u79yTOloYh0=
Received: by mx.zohomail.com with SMTPS id 1738994427731814.617865607357;
	Fri, 7 Feb 2025 22:00:27 -0800 (PST)
Message-ID: <e98c96fd-03d5-4e11-8730-680c4155b262@zohomail.com>
Date: Sat, 8 Feb 2025 14:00:26 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/15] cxl: Enumerate feature commands
To: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, Jonathan.Cameron@huawei.com, dave@stgolabs.net,
 jgg@nvidia.com, shiju.jose@huawei.com
References: <20250207233914.2375110-1-dave.jiang@intel.com>
 <20250207233914.2375110-2-dave.jiang@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20250207233914.2375110-2-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr0801122711cd81d4f34b6795ada67a0e00009164753e8380d3e8669a7113eb2983672ebf5f81f438b1acb0:zu080112274490f32fbe323b3b1201acdb0000dc0941c506784ac95b96863567e32f720307a7c2dbfef4ded4:rf0801122dd7b453a96e2ee6a841971b4b000097ceabc47be90823feff4be9eb9cf5e44e0ad81a0f31ba993168ebf4a3c6b6:ZohoMail
X-ZohoMailClient: External

On 2/8/2025 7:37 AM, Dave Jiang wrote:
> Add feature commands enumeration code in order to detect and enumerate
> the 3 feature related commands "get supported features", "get feature",
> and "set feature". The enumeration will help determine whether the driver
> can issue any of the 3 commands to the device.
>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
