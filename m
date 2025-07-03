Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A2817BA3;
	Thu,  3 Jul 2025 05:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751520821; cv=pass; b=GPC4WMcS3Ov/0+mijvdHDan/w4FIg8T7DavDrmn5WjE6si1lo8Wt3cuKXOqQo8rE8fvPOfKA89zEiqFBxoi3GJQtHwXdZ5oP6fCPCnc2ZLyAb6HNpYpYYmCSJC4vDCTVaDYBUeVp81SEWU5fuvlEjcZj5IrvBYhYcTSybF88UA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751520821; c=relaxed/simple;
	bh=SkDf+anFkf2F3h9PG3jhngVOvhOzINDS7zZalUsnbZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PYHyQJsWKZLi3x56WC8Rxt3KtpNBcj033u5JYovXPfH08jNVWBrlhMD9Y3NiU1qmv1ywdywL3wlBjSYSFqXs5a7V9SxXEPqDm6XWrj/81M3ucoILwVj088llWdqXN9QwF2EyTLBO/IjEWIPqJPM93U1zZgKthDzWOW6qXcMEIEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=UBdqWnfJ; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="UBdqWnfJ"
ARC-Seal: i=1; a=rsa-sha256; t=1751520803; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=mHFpYOwB6hj/NdB4untDcMRpRIuaHrvj408xqt9/WdNR0DSfyZGY9HyCxpM9XuF6+8TxSOpRHXORQ9y1sAAfxdUTze9Cc48fth9PS/sVTgGEby9rXjAWq62CaYEaCV14jMGa4G9+AtlDjKGLINH6hSxzpL2JkYDVgvdXQtuDtGM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1751520803; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=SkDf+anFkf2F3h9PG3jhngVOvhOzINDS7zZalUsnbZY=; 
	b=O8Xz8FLjTou4o/M9QHa56b0BU7SJOLTFNfy2DC7+e9t//m9ULzJpv/5BNCIqDivcVoWnPRNUbGCQZG3o+gLDUEhuFdnOWF8Ii60o9SwHtr5M0sNa5HtC2ltzoNEzwhVl5m3WnnAAuvYyc2o8Rzskrl/NUZCjm3g9A5i57BwKvJ8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1751520803;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=SkDf+anFkf2F3h9PG3jhngVOvhOzINDS7zZalUsnbZY=;
	b=UBdqWnfJlLsXj4+m+Nq9rCwpX0GKCv5PmVZk3Q+CQ5qTeoZUYlNpHok2V7RvMdLT
	02As0ePlZpISCbwJf+Xl2So6eHsjGPlGRV2v6iN3OTKD9KBhqZfwTRIkcIuFs4eWYrB
	/u73eKoQoVJZXsx1i5hVVlZTWT5AEo32BxyPfSd4=
Received: by mx.zohomail.com with SMTPS id 1751520801292135.64297352997426;
	Wed, 2 Jul 2025 22:33:21 -0700 (PDT)
Message-ID: <af28a873-1c72-4389-a6c8-98f4ef6ad475@zohomail.com>
Date: Thu, 3 Jul 2025 13:33:16 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] resource: Introduce a new helper
 resource_contains_addr()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: akpm@linux-foundation.org, bhelgaas@google.com,
 ilpo.jarvinen@linux.intel.com, dave@stgolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, shiju.jose@huawei.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250702072008.468371-1-ming.li@zohomail.com>
 <aGTsD4uFyvavYLnO@smile.fi.intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <aGTsD4uFyvavYLnO@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr0801122724341268c65f3347fd76f7f50000b227b36e3b98cf51f738d552b86a01e676f8c2451717d69fea:zu08011227588d1bca68dcbd2e1de451f900001857f68d7abccd3a6e8df976bb24f3ef3206b8e2fe2102c92b:rf0801122d70fc35e80f76385143eaf5e10000d1296cfc6153f768051316b3a4616ee8f7fa92e472e63a1e89c5c578723f71:ZohoMail
X-ZohoMailClient: External

On 7/2/2025 4:21 PM, Andy Shevchenko wrote:
> On Wed, Jul 02, 2025 at 03:20:06PM +0800, Li Ming wrote:
>> In CXL subsystem, many functions need to check an address availability
>> by checking if the resource range contains the address. Providing a new
>> helper function resource_contains_addr() to check if the resource range
>> contains the input address.
> Hint: Use cover letter when you submit more than one patch. It will help a lot
> in understanding what's going on. For example, I have a script [1] to submit
> patches which makes me sure not to avoid that. Or you can try `b4 relay`...
>
> [1]: https://github.com/andy-shev/home-bin-tools/blob/master/ge2maintainer.sh
>
Sure, I will add cover letter in next version, thank you.


Ming

