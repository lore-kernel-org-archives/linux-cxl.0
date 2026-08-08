Received: from sender6-pp-o94.zoho.com (sender6-pp-o94.zoho.com [165.173.180.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE68282F24
	for <linux-cxl@vger.kernel.org>; Sat,  8 Aug 2026 05:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.180.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786168302; cv=pass; b=myLa/AdMVDjyWxbrcHCys9Re58GjX6jAKzjgNalXVOm+yy2pYCiZKVvpnDp/lHkHLEy+szS597Psa3KzMijaInZMzoJoDHqvMz7b3PBskskvPCF4BubBAAp/wbISZVEGv9rw22HCdIDR0iTWoPrAkZL+n/qyhjL5XK2Ymmsnp48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786168302; c=relaxed/simple;
	bh=gsGBd7ybkdLmlmM/g+fZcdhmkH1Rkk+l0oPiIhS1sfY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=moRM2jc0k3hh7DF/PI7mHeak6uG28gWnPM9mthwcJ2R3pG8E1GHMz97XUizGN/+XONpRxW+fIpcBVoO7e+hZZm4iHByo41pSZX//xmbrWIIt95EoOPE6gTapCh1CmJGPclyD2PLLZ9+D9JCf+gkMvO7llodHBhIH84qqg1peG/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=ZIAsDDhC; arc=pass smtp.client-ip=165.173.180.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="ZIAsDDhC"
ARC-Seal: i=1; a=rsa-sha256; t=1786168292; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=l8gdPx0oEbDAR4a7ZbkSTBjDAe0wb8nnaYBe0djbaqCj+WXtXqpZSaitaojwPa/f30RyfNtPCe5D8fg23jg+LZcxysx1tBSF4XKDOEQc8RNI9GhoVuRXzRsBeB/YPi7HUUrC79F49HcQxRmpw/OFpjhz/9XAQoNwmUDwzcRTFWc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1786168292; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=gsGBd7ybkdLmlmM/g+fZcdhmkH1Rkk+l0oPiIhS1sfY=; 
	b=YCpizhqm4ghqe2eKAFVPq5ts1mj3186ALApB7sD3tFO5rYRDpQj63znvxZ1PuA/CauTFfmgh6kK30HpcwgBD7G6yyIFWXgHqAzpUqD/6j+kS1yqeirqCWvhnaUjDWkgQRgC6ElnT8c6lKsDzuy9+lAV4AbT6DjpA/ecwiKo0jtg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786168292;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=gsGBd7ybkdLmlmM/g+fZcdhmkH1Rkk+l0oPiIhS1sfY=;
	b=ZIAsDDhCNzzyMKMCK+KdaJsgXXcZBd4fWOItUzfBfesNHE3+JtafUPIMn162iUXF
	NbvTqgMjc8QirP7w3SbapJaQbePSO072CjxLbcyx/hbUs4a6XgsshJQHPA9B4tiyFRW
	Q8az+B8TkzsbixbQWRjWon3ZupLgZAMvX+KQPCqg=
Received: by mx.zohomail.com with SMTPS id 1786168289303607.6549654827279;
	Fri, 7 Aug 2026 22:51:29 -0700 (PDT)
Message-ID: <99802ed3-8141-4e3a-87f4-a71e4e4ffde0@zohomail.com>
Date: Sat, 8 Aug 2026 13:51:23 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/4] cxl/hdm: Make switch decoder target parsing
 endian-safe
To: Alison Schofield <alison.schofield@intel.com>
Cc: linux-cxl@vger.kernel.org, Srirangan Madhavan <smadhavan@nvidia.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <iweiny@kernel.org>
References: <cover.1786143520.git.alison.schofield@intel.com>
 <b0526825b3c3ffdb78837563e178d9aa27b6bbb8.1786143520.git.alison.schofield@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <b0526825b3c3ffdb78837563e178d9aa27b6bbb8.1786143520.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: zu08011227cd02b8ca31e5b4300061dea300002ce9cad940ddf2dc52f385540f5bf22d50c447d811e13400e1:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External

On 8/8/2026 8:05 AM, Alison Schofield wrote:
> Switch decoder target IDs are stored one per byte, starting with
> target 0 in the least significant byte. The current code accesses
> those bytes in memory order, which only matches register order on
> little-endian hosts.
>
> On big-endian hosts, the target IDs are reversed and the decoder is
> associated with the wrong downstream ports.
>
> Place the register values in a byte array in little-endian order and
> index the target IDs from there, so the target mapping is independent
> of host endianness.
>
> Fixes: d17d0540a0db ("cxl/core/hdm: Add CXL standard decoder enumeration to the core")
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
