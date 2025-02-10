Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BE81990CD
	for <linux-cxl@vger.kernel.org>; Mon, 10 Feb 2025 06:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739168515; cv=pass; b=DxVUOQ0d24pirj0rd9kAtXlRTYPvtsN5lTetxTl+iuA+CkkHmErHInbrbfkmjv72OYL9JpprtIvPlFVQAfb88fy20VCyIHYG06siZmtM8G0gQUc2PGNx54v+slzx4nJ7col7Di7pcxCuriJmgzt5ZR2ydssOJl/en/gjI/5zzVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739168515; c=relaxed/simple;
	bh=GXWZvNRb5dbpClsX007Vhy1Qq/kRGRhizkCl+Vrw7eE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jMdIq2FxWQwhT6mXS4IZXpc2JSab1dchg4RGo2hn+D4RVeKh8+qWVIBpZL7tVrRNpRiP0hP0uNrO11Ou7y9lurKjywEciNrQo6QJGbKX+BdH5dbNO2mqT2QQCzA6dK4NStxhNmv99hpTvjx8pS27j9pnwFEzzu9G7yDnWE13mc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=ZLPtB8Rn; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="ZLPtB8Rn"
ARC-Seal: i=1; a=rsa-sha256; t=1739168494; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=iO5d8JcQO1wxqDXEF4/QjkhVyNPbK4oaEQqkboJM1bhWzR5UBW1LTvp+qmTTbSbqaFf7gQImLAISloxy/8ywq4V7aSumFaKILuFyoDk381TpyxcATdZYEdGdvEanmIJ/C3jQw0i61lIqMyqcKMFayptkm0ddHV0omWy66/x2jcE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1739168494; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=GXWZvNRb5dbpClsX007Vhy1Qq/kRGRhizkCl+Vrw7eE=; 
	b=Ovf0xJFs+oGb792nKn22tpUHlTE5ADZ9VLXGj67i2YM3K5xRFeJ3sfMgdwrACd9BMnkGGXqiJG2Cm4jmMSJn6hlWKzjXF205nk2VCjdfXW1oTxi1QjK561dfEvoukU+zD9gqOgbu+0p3iFqVU2NKeTKEYQt/NaI3NjM78A2W3hs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1739168494;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=GXWZvNRb5dbpClsX007Vhy1Qq/kRGRhizkCl+Vrw7eE=;
	b=ZLPtB8Rnj7lb5ONqWymDpVuDCdgkPLugc97WS/7oja8r0HCfAwSmCBhleTx0lICj
	iagfK9e80AEg9ORtGkRsIsbIf8+R6ruuPo8m34UUbHkOMnP59/R7I4mzyvxve3sd/Kx
	1zFFt9wWA2gfocOrpdk65ncK+jqsxEt9sTaSrODc=
Received: by mx.zohomail.com with SMTPS id 1739168492249308.71380450002005;
	Sun, 9 Feb 2025 22:21:32 -0800 (PST)
Message-ID: <812c7adf-dcec-48c7-aeda-6b6379fcf833@zohomail.com>
Date: Mon, 10 Feb 2025 14:21:28 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/15] cxl: Add support for FWCTL get driver
 information callback
To: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, Jonathan.Cameron@huawei.com, dave@stgolabs.net,
 jgg@nvidia.com, shiju.jose@huawei.com
References: <20250207233914.2375110-1-dave.jiang@intel.com>
 <20250207233914.2375110-9-dave.jiang@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20250207233914.2375110-9-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr0801122757691dc250ead385df3b07db00009f9d9bb75c3cd00cb850e98620b70cbf69fb7bb108adb9737e:zu0801122730d41e25d0cb9568e75c420200006f4031c1a7eb7248bc13016c29639f4def511d5fc7ddd5b1da:rf0801122d193d38a9c1e6a67d898ed5be00006e738e53f27b9f2758796ccde320a18044334c8bbd8d3092b94ad9695333f1:ZohoMail
X-ZohoMailClient: External

On 2/8/2025 7:37 AM, Dave Jiang wrote:
> Add definition for fwctl_ops->info() to return driver information. The
> function will return a data structure with a reserved u32. This is setup
> for future usages.
>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
