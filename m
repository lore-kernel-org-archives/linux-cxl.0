Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E8F2147E5
	for <linux-cxl@vger.kernel.org>; Sat,  8 Aug 2026 05:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786168241; cv=pass; b=I7jGSkzcLo5EruKvZN6TOjLtlDD7YqhWrswQnXEjw1IFCuV0kU5Edz3zYGv5qIc5zOlvx7czcG9Y5ToD+UyypMbOaOgEI5aar2KWsTxU0/toBExv0KRBc/oOrQc/eHUiZTIKiILSCL7k9491I0SNpq1xwlCxHTQr+lAgtFFPN2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786168241; c=relaxed/simple;
	bh=o03wGr23EvmgLlQ6/0qcSmeaLPMbg1ESS+Tm1j6aiZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U6MSR8NZVSfcU6ahnoQQAOILnsn/XaRS1RwZi85hWYpf8tmbeqvbRDq5NnRuNkSVdKIMO9mBs8AeXH5ZV3nwVEuYTgdPSZ5Hq3fPNuARO3vzFMhws5A6UqwNAJc22eSufT6SIwX0dGE4I9BUhRtDWMaES7tbL3XQ+ktnR+KLwEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=esPLQmW+; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="esPLQmW+"
ARC-Seal: i=1; a=rsa-sha256; t=1786168230; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=M7LCIt5s2C+On/5BikJzPHKXYpo8U5E8o4F3GTDXxTj08P6R11x1B98mEYG06tk/mKmkzM862NUjrS8cmaJ4Fy+xNWRmZ5L74uAhtaGJYNz+Rwq9MzWuo2cml9MoOhAN2ubIvlW/5szXXusVr2y2rBVXL3WYuHnMlrShGQuYzjs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1786168230; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=o03wGr23EvmgLlQ6/0qcSmeaLPMbg1ESS+Tm1j6aiZQ=; 
	b=NVcqPAG2V1ucMcO007+gSnU7HIoOZS5FR1XMIrNjkEzAqKBNzop3JczXqQ7aMbnqDGOH2Zhkm/3CbL+fSP7LQmqpyQmd5jYZLioyGL2jcdiyg64BIWqZO0zty/u04CR4AaVifL3zXw3X4MPOHTAHUZq+JPjCRgLFsXh1KO39b4I=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786168230;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=o03wGr23EvmgLlQ6/0qcSmeaLPMbg1ESS+Tm1j6aiZQ=;
	b=esPLQmW++XhVYMpIgfk+2fGn4/LgKlfN//5d2g2iWDDI53zqD8QvGnbqLdPRIUpG
	RBViVt9WMwa5mp7riK2RKYEcQKG9zQ4pOo/090OEQWntznfJCeK/wEyoxylM2xE1bVZ
	kx/mRhvHjTQ5Vlc7CpGMpODPBJ6MXqpmUriJr4sE=
Received: by mx.zohomail.com with SMTPS id 1786168227381861.2689244566336;
	Fri, 7 Aug 2026 22:50:27 -0700 (PDT)
Message-ID: <1d51c126-1c1c-4c7f-8d59-5b3e103cf948@zohomail.com>
Date: Sat, 8 Aug 2026 13:50:22 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/4] cxl/hdm: Reject switch decoder interleave ways
 that overflow targets
To: Alison Schofield <alison.schofield@intel.com>
Cc: linux-cxl@vger.kernel.org, Srirangan Madhavan <smadhavan@nvidia.com>,
 Richard Cheng <icheng@nvidia.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>
References: <cover.1786143520.git.alison.schofield@intel.com>
 <af094094813d7f51d86cbf608936270b7d85526e.1786143520.git.alison.schofield@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <af094094813d7f51d86cbf608936270b7d85526e.1786143520.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: zu0801122756a088ff7edda1a3e4ef326e0000c9443df2bbdf3d6f880c3f20e13ffc13bb357cb7c8446696c6:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External

On 8/8/2026 8:05 AM, Alison Schofield wrote:
> Switch decoder enumeration validates that the interleave ways encoding
> is legal, but not that the resulting number of ways fits the available
> targets. This can overrun the target array (target_list.target_id[])
> during enumeration of 12 or 16 way interleaves.
>
> Bound the target count where it is established rather than at each use.
> Reject an HDM capability whose reported target count is zero or exceeds
> the target list register capacity, and reject a zero target switch
> decoder allocation in cxl_switch_decoder_init(). Enumeration is then
> left with a single check: reject a decoder whose interleave ways exceed
> the targets it has.
>
> Add a clarifying comment that target_count is a direct count, not
> 0-based like decoder_count.
>
> Link: https://sashiko.dev/#/patchset/20260711180755.1779002-1-alison.schofield@intel.com?part=1
> Fixes: d17d0540a0db ("cxl/core/hdm: Add CXL standard decoder enumeration to the core")
> Tested-by: Davidlohr Bueso <dave@stgolabs.net>
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
> Reviewed-by: Richard Cheng <icheng@nvidia.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
