Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9437CEC2
	for <linux-cxl@vger.kernel.org>; Fri,  7 Feb 2025 05:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738907539; cv=pass; b=aILGTFaTucQdqxANXkRSmceip98BQaNBRDF+5qVw9q61T8Rb55eekdRwFurYongcfFgMbt4ucHrHPQgPezRBDRvT5DU/62EezM5m8NUHt3swvgyBAihCArHE7CjDiYnKBwYviWwrzqLZ+Dc/aoXF/r757pfk8n1s7feWw5axAMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738907539; c=relaxed/simple;
	bh=JiaubyvNimCLNLrn4lK+V3Yx6cQpUTkjMLqvyWKDZsU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X6pOw8lDo3yGFXWq6Jfrj79rLI/z4dQFxxJAu6pWm4/FCBhHCOA3D7JoRSmAEOLacgT3OJ3QNzI4IQ3OjczOQevI/gpIBqpNfbHfgsfQg8aphdmZn/M0imW1c1ZWtjUF77ljcV3Qua2r88SvlStzchNRlJKD9N1LJtNGXqwlcXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=euCXfw91; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="euCXfw91"
ARC-Seal: i=1; a=rsa-sha256; t=1738907520; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=SBB1aFFcLHhlpV0n6VxWT0u8VcSfGYhDzWB8d05yGFIBEcEObwGiJcgN6p1MrTq59WxCbMlzhnuJQs/gEzjO/5dqJOYZaeIUlp9Ges5kFjS8A2cMmMV2vcE0yJqQU5m+/Ka8nTG1g2OnSEsWFgTEKnp5bj4tx2xIPU2e7tio/hU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1738907520; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=JiaubyvNimCLNLrn4lK+V3Yx6cQpUTkjMLqvyWKDZsU=; 
	b=DuA50q1khWRBbcRMLIrjMkE5fn99dM8xWK/ysSfJ7HrvMt6dPKR6tqku4WWhfPgO4vLZWDziolXaq2cn8s8YAHi1HhgVvDX2m99IMcn4Ds81W7eDp7Y9X5D2lIne6BbzpOusJj6all2mPurFI03Y1Kd8F3HU80cHLPAbjFWx6pk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1738907520;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=JiaubyvNimCLNLrn4lK+V3Yx6cQpUTkjMLqvyWKDZsU=;
	b=euCXfw91VhHwrPCXkjubemiYgGkgi99j8lysWBXhuvU3G9L9Ub9/ceXsLPDf322v
	93PTnioYjxDDHFUuD02ZJk5u4/I0K+HEYTOCp+jzPuQExKls4zfMPA5D88lPUXSTues
	F+L3D3XzrrEkoDlJ8V16UVIweu5BZ8QJ3zH058mc=
Received: by mx.zohomail.com with SMTPS id 1738907518200504.56470323299664;
	Thu, 6 Feb 2025 21:51:58 -0800 (PST)
Message-ID: <ebb73293-efd3-4ae5-a60d-bf0aff06da26@zohomail.com>
Date: Fri, 7 Feb 2025 13:51:57 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/16] cxl/test: Add Get Supported Features mailbox
 command support
To: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, Jonathan.Cameron@huawei.com, dave@stgolabs.net,
 jgg@nvidia.com, shiju.jose@huawei.com
References: <20250204220430.4146187-1-dave.jiang@intel.com>
 <20250204220430.4146187-5-dave.jiang@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20250204220430.4146187-5-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr08011227879eb25cb55ff57ae670e66d000048d20e344ce5b920f0495c93b20924b1d65d0c560f4c479069:zu080112273bdce47b95019464fc013d91000059b18a746d72252ae97cc4c678eafe45a95c7bf1e64ede26a3:rf0801122de03e59babd8f0c55044800350000eb732d5929a46891833c44695823ea08564a6586b6094dc11b56207ac203ae:ZohoMail
X-ZohoMailClient: External

On 2/5/2025 6:03 AM, Dave Jiang wrote:
> Add cxl-test emulation of Get Supported Features mailbox command.
> Currently only adding a test feature with feature identifier of
> all f's for testing.
>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Acked-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Li Ming <ming.li@zohomail.com>

