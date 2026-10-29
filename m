Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.181.3.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793278460;
	b=TdKQS5dSz6wvNhGjSFFy/guwozGgIK+l+yQAQUd8r4hkyKSjCEOCYYxvkEoh/ZL+L+Ti
	 fjebwqZw3kycKmkBG1+kKAEYilvOlb1iqUEFsl/IKwIAGrdxPRQAj1DssMxZe5nlTHhmI
	 u7SETo+SCiN1R1lkxUqN+zDDGaGwEH711GXlEcFAwR5kJSXam9kbjW4PCP+uzeSKmsOiW
	 2zFlMjkafoJWAU4hulcOf9tATAfF4KwHfdPHNd4/XMlCO2HqRm3zO1iflruGiwACTAN5m
	 St4aZjdiz94xxdqJGa/DdyqOMbXUNkUYU6tRzU4Mc6KPWBczevGaJMxxpIQ8+VnmEmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793278460;
	h=DMARC-Filter:X-MD-Sfrom:X-MD-SrcIP:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:DKIM-Signature;
	bh=FtU8Inpw+jVWYTylDfqR88WUy4Wf3QCqAYa7s1yMIlY=;
	b=jxiLNPAFjZew7yzmEOJvahuh6uwJvo5WZTFBP/MIAbQJnRQL55bcCC9JUavtFiCsVT3z
	 +Q1fGpQGfr8ZpeiQc9WitFS6lY7011kkW8u3QWQOjH6HGPEVi08/k8XKTUxDQjpb6xxzb
	 oUUDX6jrX1UrXgbDGJqq4xEAxFZawi88Usu99K3sjg26x9TO2JQHIRmfihHqj2dgwSLrJ
	 u29Q3uNFR6RROwvbTuhOrmVe86VFNJJG1saIPXLhIhjgJjpfiRXC28hUspkubJG5mtYFs
	 TEQ34pbRLfVaPQ0C+AvaZ+z7V7LNcD9ltN/DUj7E74hXS8C4Lw5N2yRR/IJqjo5RcBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baidu.com;
	spf=pass smtp.mailfrom=baidu.com;
	dkim=pass header.d=baidu.com header.i=@baidu.com header.a=rsa-sha256 header.s=selector1 header.b=jE7zi1yP;
	arc=none smtp.remote-ip=220.181.3.101
Received: from outbound.baidu.com (mx14.baidu.com [220.181.3.101])
	by smtp.subspace.kernel.org (Postfix) with SMTP id BC59B606A321;
	Thu, 29 Oct 2026 12:54:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC59B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baidu.com header.i=@baidu.com header.a=rsa-sha256 header.s=selector1 header.b=jE7zi1yP
X-MD-Sfrom: zhangyili01@baidu.com
X-MD-SrcIP: 172.31.51.15
From: Yili Zhang <zhangyili01@baidu.com>
To: <benjamin.cheatham@amd.com>
CC: <alison.schofield@intel.com>, <dave.jiang@intel.com>, <dave@stgolabs.net>,
	<djbw@kernel.org>, <jic23@kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shijujose2008@gmail.com>,
	<vishal.l.verma@intel.com>, <zhangyili01@baidu.com>
Subject: Re: [PATCH v3] cxl/edac: Fail ECS threshold read for reserved encodings
Date: Thu, 29 Oct 2026 20:54:00 +0800
Message-ID: <20261029125400.84466-1-zhangyili01@baidu.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <d65d524d-49a0-4b5a-8df0-68ef63a0b1af@amd.com>
References: <d65d524d-49a0-4b5a-8df0-68ef63a0b1af@amd.com>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc4.internal.baidu.com (172.31.3.14) To
 BJKJY-Exc19.internal.baidu.com (172.31.51.15)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1793278448;
	bh=FtU8Inpw+jVWYTylDfqR88WUy4Wf3QCqAYa7s1yMIlY=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=jE7zi1yPCbVSE7nWky2SGuEz0NTLa634ipNnIk24IwHjqfJW6zHd4cwlVTrzoMfjU
	 Bhba0cvh5HLNbv1k2tDU6frpPZUPd0mNkkAQWkPr5imFphHAb1rv5v1oNZhf+CgaGD
	 dE7pG02ss1YqgKY7wLE8yIz7aRhc0CXZ2lZz9MgTso1oaVb8W8SAKVE3CgEgk+R80c
	 D9U9rgOXnDcqCPEFl60L/lf/+fJuB6XsHQ4/XP4Tbrf01TGwtE1UF+SOLlBqUSQB0K
	 xM3oXuaiuwfWmiCT7xTtk23cZHmW9s4KM7SHye5gPsNYOTo417E7T2xHoiedGXD5YA
	 PuvWiBg38GIfw==

Hi Ben,

Thanks for the review, and thanks Jonathan for sorting out the
documentation question.

On 2026-10-28 09:18, Cheatham, Benjamin wrote:
> On 10/27/2026 8:16 PM, Jonathan Cameron wrote:
> > On Fri, 23 Oct 2026 16:05:27 -0500
> > "Cheatham, Benjamin" <benjamin.cheatham@amd.com> wrote:
> > 
> >> On 10/21/2026 10:20 AM, Yili Zhang wrote:
> >>> cxl_get_ecs_threshold() extracts a 3-bit index (0-7) from the
> >>> device-supplied ECS config word and uses it to index  
> >>
> >> Nit: Should probably spell out ECS here for people (like myself) who don't
> >> know what it means.

Will do. v4 will spell out "Error Check Scrub (ECS)" in the first
paragraph, matching the wording in Documentation/ABI/testing/sysfs-edac-ecs.

> 
> Cool, then this looks good to me. For Yili:
> 
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> 
> And thanks for the response Jonathan!
> 
> Thanks,
> Ben
> 

v4 will also drop the Suggested-by tag, per feedback on the v2 thread.
The diff itself is unchanged, so unless anyone objects I'll carry your
Reviewed-by over to v4.

Best regards,
Yili

