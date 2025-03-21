Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B52A1E2307;
	Fri, 21 Mar 2025 06:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742540164; cv=pass; b=Hqhe1YVQjTZer33xnE7qka8xpceXrOJbQr3oxVQPVtbVJJ/4j0UU//2jAzYen65l9RfAbhy9F9sSuvoiwzQRyN9wfFBSzO6X8itcRqUfnrIG+oUHlBQ0FFbNPdsZ8wMmJ1e2PqX1EHBZSEInGi5fF74rGF6BI5fZ1vYNi42FOQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742540164; c=relaxed/simple;
	bh=/VHiiCxto2R/1KXLhH7ajRusAesxdycWpINakHbyPGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qVkLn4En743Lk6Mr2uSipPUEg/92qOybXupSIhTA21biwy+ixAkUWya6WzX2FYQoUihAEYc0SNxG7YIbh23wQo//lRSsnMSTGYuqmhnNCCQJOY+GVVLLJXdtwONfgn37qkd2TdAoRZabV3PtzoGCrvr9eMOpmPJdEIH6gr9mNi0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=avGi0Eod; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="avGi0Eod"
ARC-Seal: i=1; a=rsa-sha256; t=1742540148; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Vq7DyEqvTzwiLcLwZlDNrr27V6I4ZT9WOGiia9BEBgoZp99x7AuC3ksL6Fy02egLgCHwovUCqw5qy7zpdyaERaLzCfzcC0RidSGU78G7Yh/a1YTuh/cFpKFILppx+2gqn7qdu8FXVUguBO2qEhLn8osz2xmRwmYxiigjmhlYlvc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1742540148; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=/VHiiCxto2R/1KXLhH7ajRusAesxdycWpINakHbyPGA=; 
	b=lPyN//MlV27g3kqyMQnmpWvGqnF0uOxKnSGUnmsJor4j1QwLEbon605kTAfNUQQWoRVihIx4s+ekTBQ9+YT5p09gvzFw/WhgmBmfasXoJyG8Bo+F4TJZ2eO9Cuhim52K7/hUeD4/xsOJpswMsJhG0TH/Bgu6MtAypoI9Bmyqzs0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1742540148;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=/VHiiCxto2R/1KXLhH7ajRusAesxdycWpINakHbyPGA=;
	b=avGi0Eod/ZXVtz7liJelj5xS/dwrw8rzqrI+9uv+fQmSuznCCh6AFIDC7VgNgaZZ
	lomeN6zT5VY6FBecGLejZJXcxbmQbtsW8WQ74dbs4eUdXwcO96AV2Xweh1HxA+d4Huf
	ogD+FxdRwUd4l2E6i9HJ1N52Jl0bAMSzdEiFtfAQ=
Received: by mx.zohomail.com with SMTPS id 1742540146147283.0692621506083;
	Thu, 20 Mar 2025 23:55:46 -0700 (PDT)
Message-ID: <0f537373-7a71-49a5-a4d3-8adb0ef41349@zohomail.com>
Date: Fri, 21 Mar 2025 14:55:42 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC Patch v1 0/3] Fix using wrong GPF DVSEC location issue
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250319035516.222054-1-ming.li@zohomail.com>
 <20250321021441.vdmo5txhvb6kya3a@offworld>
 <20250321035918.yyicfmvmpm7selin@offworld>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20250321035918.yyicfmvmpm7selin@offworld>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr08011227b8598aaed87a2442afdbd40a000089009ff252a1ab62d16b961283879ccd1e9e8ba5c34710dbbf:zu080112274cbd8febf8063b8b78bf32e300007b97fa915085bc952e7701093a5e2bc918f1dc8255d389390a:rf0801122de1475c61b64a9c83d262a66a000081ec13efe6ad891b2dc2875cd906ef2e9f6a96774c0816d8239583908b38ef:ZohoMail
X-ZohoMailClient: External

On 3/21/2025 11:59 AM, Davidlohr Bueso wrote:
> On Thu, 20 Mar 2025, Davidlohr Bueso wrote:
>
>> On Wed, 19 Mar 2025, Li Ming wrote:
>>
>>> But I am not sure if all dports under a same port will have same
>>> configuration space layout, if yes, that will not be a problem. If I am
>>> wrong, please let me know, thanks.
>>
>> Yes, when caching the dvsec was suggested, it was my assumption that the
>> config space would be the same.
>
> Ultimately I don't know what the expectation is here, but your updates
> do allow more flexibility from vendors, I guess(?). It's a bit late
> in the cycle, unfortunately, so if these are to go in for v6.15, they
> would be considered a fix imo, otherwise perhaps they are wanted for
> v6.16 or not at all (patch 3 does look useful regardless)?

My understanding is that the expectation of the patchset is to avoid using a wrong GPF DVSEC in case of dports under a same port have different config space layout. And I think the change is more closely to the description of CXL spec.

If the case(dports under a same port have different config space layout) would not happen, maybe add a comment in cxl_gpf_port_setup() is another option.

Yes, if patch 1 & 2 are considered to be merged, they are worth a fix tag. And patch 3 is an obvious cleanup change.

>
> Based on some of the topologies listed in qemu, I did some testing (and
> this was also why the same dvsec config layout) and see things working as
> expected.

Thanks for testing.


Ming

[snip]

