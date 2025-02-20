Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF29524F
	for <linux-cxl@vger.kernel.org>; Thu, 20 Feb 2025 05:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740029528; cv=pass; b=Gw9JgVKRmKpBrojOHs1LcZkf6LTWuvmi3XokB/yaH4uiJv31BgY4PUfaEjzs7zP3AwqrPvCc1wRlIpPc1a722G5PFunxeVbM+YR6HmC85UQlDd1kyHjo7xO0aBFYZH0LGuFA8COGS1IXTYJQnv0y3/cSfmEe0yVGJQ8JX5/K6Gg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740029528; c=relaxed/simple;
	bh=jqzhoSDPR07fDaj3fw5etWQkPPWYHfm0dQr5F7OxAro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pyCLcmoGcSqWHao4MNcfar1hXVMcInoIRr6+UJP0ny/yxFJWdQ7hVbcFGiBogOCpEmSN9IbYVAvmHjgncoljov0OkTsiLd45douX7HiGgb4F1dEOfuJmezPrOVhkQj2qhI7XebRg5ef/5gEO5111HduloB6FHVjCiAcire7P4ig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=EMQ+36Hu; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="EMQ+36Hu"
ARC-Seal: i=1; a=rsa-sha256; t=1740029517; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=nCaiGGV3Spv+IKnYTqpqVP6RiTiolHm9AgHJoFaGU+CTf8z2KLWcSRSKv2TfL1Fa/xZMwBqVcI/b+81b5HK87p1T6molcmQvuQBJ9Q8XcLLeicgksMfY1Bls1Ija9YE38MffUi5LcfMVevlk1TJIMo/KOq5CoASq7GveYHrVBl8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1740029517; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=jqzhoSDPR07fDaj3fw5etWQkPPWYHfm0dQr5F7OxAro=; 
	b=O8gadsvULAqOeo82wbG0XnmFlx1i3Tex3hh+0O10BgUIh7eewmFp4jSdosYy8FGrKT7Gk+kA4PQaR2b5CuCt/SBEIYphJ8r0LocLKE1I7qYBIdJsQPvuLGI5wdwrafJ7u6Zow7/dzl4d1g+ZaNq3QWoTZ04z88/DOLh6kded0og=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1740029517;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=jqzhoSDPR07fDaj3fw5etWQkPPWYHfm0dQr5F7OxAro=;
	b=EMQ+36HuUNB1/WGUHMTilKAzn6yJUIWbLX9AFMi6JIo9VrnR+qXFSJn1Y2AVEl2U
	X58penDYofDbMXZyIld4U5NgP1A6euvG1nyYlGGRSe3XrAEV9MEKrOJamg0QkaXHaLE
	ZBct9jOZD1iD0NNSk4J+L9QwMSl9pdSJUpeG1oN8=
Received: by mx.zohomail.com with SMTPS id 1740029515328664.0949191407489;
	Wed, 19 Feb 2025 21:31:55 -0800 (PST)
Message-ID: <336c7133-62e8-489b-ba74-aaed551d8df1@zohomail.com>
Date: Thu, 20 Feb 2025 13:31:53 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] cxl: Plug typos in ABI doc
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: dan.j.williams@intel.com, Jonathan.Cameron@huawei.com,
 ira.weiny@intel.com, alison.schofield@intel.com, linux-cxl@vger.kernel.org,
 dave.jiang@intel.com
References: <20250218224853.67457-1-dave@stgolabs.net>
 <20250218224853.67457-2-dave@stgolabs.net>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20250218224853.67457-2-dave@stgolabs.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr080112275813fd919a222f912027e9ab0000e681ee10e84982dc24b12b701a4d3cad721274267ac0b44caf:zu080112276a5fa839a93bc8e7c8242b8400009497eef3ec1c47e970bb2260a1aaadd15d6538fb3bf06a16d6:rf0801122d3d3b609c182ffcb18f6cbaa90000b79ccae95f3702726c9ec3e656802bb7b216495cf3da48c44f2fb9b1a4d9ba:ZohoMail
X-ZohoMailClient: External

On 2/19/2025 6:48 AM, Davidlohr Bueso wrote:
> Trivially update where necessary.
>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Li Ming <ming.li@zohomail.com>
