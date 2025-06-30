Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475654A11;
	Mon, 30 Jun 2025 04:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751259433; cv=pass; b=TTxvomKpGIlwtPHL5Xo+gHreUim23Xb4YPm04SImEZj920I546io8yTBSfWhOGDav7gj9RTZuRtwM6Ejr+0Ogn4Z0eLPtT/QpmsIblHqf2ddbvKpMsJ6IWbE9ijsqaVa/pDuu5jBGZ8QLwy0aXWbzHJswrIuXxGg5qEJ02SL52o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751259433; c=relaxed/simple;
	bh=tsPzHoTP69t7UQGuZNF5lccrCFCkO2R+bQABb5/VYo0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fzXGJtkfPo36ynLLS59/rag9RLXcADLt23QxjK9nAozMDXuLgrJS9C5SAKwK4tjUj2H0wXllTP6WD5azLCY6hyWU0v4yhSMEimmgNM+A6zY+P6eGg1q4i5BPMJBMUo1b64sswJ7BP8MLKzCs4mNfcWE4U8mHOcE13zlIAI+UXsE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=BUp2IR4d; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="BUp2IR4d"
ARC-Seal: i=1; a=rsa-sha256; t=1751259412; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=aNBxOG9MrqP8RezOUv56vdKKnG+C7aGLjygJSDs8fV72lMpDlEIZIJ4jYydgaPgLWGfYfX/rV9AxWxSkKUOd1RxzgvKLkQcRhPa0ojrzq2wpQC0HbDnpXvDdJc0ZJOUH4Y2zU+RXXOAXjmqjD7VFTTwyLifimToRDYTYXUVpjsY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1751259412; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=jGKWoTpD7SxWUMBPwQaXaTR3Gama9L+E0Wl4eK3bRmU=; 
	b=YCld4xI1WsRJfRG1mlbAeiH5M73pInTi36MyA8fQS4CC3GgrZfJzQIqqLgrrPo68/rA/I2Flzh+t7+MmyRhRxbkZ+IHbtg/4tslQOAwycqmv/Bs6Ajp1Bacb+dLxHZkKqWpU/OOeQw3014KwwROmbwuFbKntCblsXDBuWF2jHqs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1751259412;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=jGKWoTpD7SxWUMBPwQaXaTR3Gama9L+E0Wl4eK3bRmU=;
	b=BUp2IR4dGhIeW2SchfspdU2qvt19KLKhDgaW/ZCMFAGvfk+WvxPG1P9kfJDQjEYA
	N91Aebty7vhdehflrhuTxKYMKdkXPCEDg6Lial2TiYUlsdT/wU1ZQB98+m6kr9u2YrI
	FXTz+0BIAxtHVF9a+xahxlkLUXNrcTyRF+0jIXoQ=
Received: by mx.zohomail.com with SMTPS id 1751259411024461.30494157265355;
	Sun, 29 Jun 2025 21:56:51 -0700 (PDT)
Message-ID: <03c83257-defd-4083-970b-9b803442e792@zohomail.com>
Date: Mon, 30 Jun 2025 12:56:48 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] cxl/core: Add a helper function to check dpa
 availability
To: Alison Schofield <alison.schofield@intel.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 shiju.jose@huawei.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250629082042.256123-1-ming.li@zohomail.com>
 <20250629082042.256123-2-ming.li@zohomail.com>
 <aGHrSVX7ce96nTmt@aschofie-mobl2.lan>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <aGHrSVX7ce96nTmt@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr080112279800526b93a969bfa6dd1fa300003ab9feb424604d0d1bf076f71a6a5b5ced1a2ce74130e6a15d:zu080112273f5149f167ad1fe50fdde0570000acde40cc24b4bc4df2b4ae94173601471b183924a58d120e8e:rf0801122dc953c5b6d4687a0ae5f19f6a000020a6b9e4d434071a42d47b58c3f86f693ce01caaa9ac6b2363b3a8ce2f3a8b:ZohoMail
X-ZohoMailClient: External

On 6/30/2025 9:41 AM, Alison Schofield wrote:
> On Sun, Jun 29, 2025 at 04:20:42PM +0800, Li Ming wrote:
>> In CXL subsystem, many pieces of code that need to check dpa
>> availability in case using wrong dpa. Add a helper function called
>> is_valid_dpa() for dpa availability checking.
> Does this have anything DPA special about it. Could it be done in
I think no special DPA here, my understanding is that all DPA should be included in cxlds->dpa_res.
> in a new helper like resource_contains_addr() for all to employ.
> In CXL, we'd use it in at least one more place, checking for HPA
> in a region resource. 
That is a good idea, I will add it into include/linux/ioport.h
>
> -- Alison
>

Ming

[snip]

