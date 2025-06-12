Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D82D245008
	for <linux-cxl@vger.kernel.org>; Fri, 13 Jun 2025 00:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749772803; cv=pass; b=WcQ4Pr5fqDp4YCOTf6lxkS0+YRxGl3zrhsxnzmgfAi6fOaLcsfXdZvAFOIzBnnOr9U5ssQnZJo0wcRQHY8pj3gmS84Pk0ok2qbcn957iWTqw97AQI1Cyz98d9QfuRf0Lb5fzve/OzzN+oV6ultM3C3UDZnJFAZwc3/CeDB1q1E0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749772803; c=relaxed/simple;
	bh=hMeJRoCwwA157ezv3keup6qJAiSLrxwA9X7rNAe7MZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vAkrKW6nhpkPWGYkKDe8wX85LvwfZoiP7kvrHOCvnmtERjyfjEX8gPTZo4SU+zS2eaZArA29d9qcEqoh2Oc45mRwJjy04K6BkamcK7go0gpo+OMOF8Fe3jFhZa5lKFLHW5ip13kyS5KdR6RqRTNNJ17Fb9pDfBPME1+7Fs5jmAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=QoZ0ePQ1; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="QoZ0ePQ1"
ARC-Seal: i=1; a=rsa-sha256; t=1749772796; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=i2g/J5G/M7+Mc5xeIqnB7rhXJtw36ueHwl++PuWYtlxE4IAUqsHmtmNIsBfrc0Zto4g0Pb3cVUbS8YKuBnrPirIpeqnUWQn6uEjavwM4e7/SOKL1OL6pRDTLWF54cy+gsMh2+FZw7jqC4dj2rnqqfdKpBRzFzBxB3+zmvYtTdnM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1749772796; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=axdh91wTiTLDpcnpHTGFBgsUWFmgG9HsszxRSLzeSS0=; 
	b=PNe/hdBLap77V5LYCsu/URVKdXq0x0RUMRtaxTozfeImK3GKT/mWDovjckzXFfl2bqB8Q6/ZrPiSlQOFJYW+qrNOcPSWXr4aBn29uoSSKkrU9SNF5h05UB1Ir4V3z5rF7dBoDbfPF+9+pKNaGUkndXQFZ9OkVZDseCv2DTnworY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1749772796;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=axdh91wTiTLDpcnpHTGFBgsUWFmgG9HsszxRSLzeSS0=;
	b=QoZ0ePQ144+K0xbg+ENFglJg+3DMkMr8GIcaWBKmNcUoAxmbXdewseVDLdgX20jg
	aBGN0JFYd6s5yrOM4eA5nV8TZCiaM2DkA3LepNBd6mTtAETA7EmGW04RNnBHlAf2b0E
	l9e+tuJuvPnZ3LOE0YFPjkfRYz4TuKIbf9FsJugY=
Received: by mx.zohomail.com with SMTPS id 1749772795624718.7433487418218;
	Thu, 12 Jun 2025 16:59:55 -0700 (PDT)
Message-ID: <d3d4fb47-f3d4-42c7-958f-31e7a0feb489@zohomail.com>
Date: Fri, 13 Jun 2025 07:59:52 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cxl/ras: Fix CPER handler device confusion
To: Dan Williams <dan.j.williams@intel.com>, dave.jiang@intel.com
Cc: linux-cxl@vger.kernel.org, Terry Bowman <terry.bowman@amd.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, Tony Luck <tony.luck@intel.com>,
 Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
References: <20250611171721.2048408-1-dan.j.williams@intel.com>
 <20250612192043.2254617-1-dan.j.williams@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20250612192043.2254617-1-dan.j.williams@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr080112276f093a4357ae9f59f1953bc3000079f018cb8ce37b00d89e9a8314de1bd81a871d3c77e6096974:zu08011227ca87ef5187320fb7f05908de0000762b0d764ff91f271e65792bd79814a9a901b7f214ab5b383f:rf0801122dc6fd2c35354bada2ed9d4f320000f6e9dcb09df9281e59737a133992d09d7f792fd4107d694093257407005e2f:ZohoMail
X-ZohoMailClient: External

On 6/13/2025 3:20 AM, Dan Williams wrote:
> By inspection, cxl_cper_handle_prot_err() is making a series of fragile
> assumptions that can lead to crashes:
>
> 1/ It assumes that endpoints identified in the record are a CXL-type-3
>    device, nothing guarantees that.
>
> 2/ It assumes that the device is bound to the cxl_pci driver, nothing
>    guarantees that.
>
> 3/ Minor, it holds the device lock over the switch-port tracing for no
>    reason as the trace is 100% generated from data in the record.
>
> Correct those by checking that the PCIe endpoint parents a cxl_memdev
> before assuming the format of the driver data, and move the lock to where
> it is required. Consequently this also makes the implementation ready for
> CXL accelerators that are not bound to cxl_pci.
>
> Fixes: 36f257e3b0ba ("acpi/ghes, cxl/pci: Process CXL CPER Protocol Errors")
> Cc: Terry Bowman <terry.bowman@amd.com>
> Cc: Li Ming <ming.li@zohomail.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Tony Luck <tony.luck@intel.com>
> Reviewed-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
