Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F2A221FBD
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jun 2026 16:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780675215; cv=pass; b=gVtSbTdCxr0pHmXkAPDyh/w0es+cURDsX1x5j7gjizxGiv6FzyPNpfCi5V7JZK2ZBHx+l5t+egxdxxH4rZBJxb0xNdQ8fkXNqulH/IQqRX3k33O5cynpHzSGatRTDHRDiu8sgADLoJUfr3SyRYy1M1TWyVSyDggIZB+TwGoKXJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780675215; c=relaxed/simple;
	bh=tjI3GNTIpJ2ZS2TYhtwv/UinCsWgiBXMF3kJ8iwkTaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mpHqBrYCMqAzScjQ8lE8xuC3G0YLTULsE1U6s1kXNDJXmTXL6GiY5vmX2X0a5AVCr4kfH0FKcVle+sQC3+SImKHiUd2Xi/CCkpQ/cs2lTT/Feceob3ICY7Wg9JLm4a0eewnE48s08pCp2h9+/7KE4piDRGuW93eFSTik3X38Ayg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=C85lJ+Op; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="C85lJ+Op"
ARC-Seal: i=1; a=rsa-sha256; t=1780675205; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=FS9904Xjjx/h7fWIGDXPryIXzCiVKtVZ2l1HEtcgpvbUwY6Q9HdEp7LNFYrRlzSQIpR3YlBpPj0sAlGIXIKqjCeI2y/ynN/wXVP0o8+vTMBB0iLlkjLgeRBsoYlcgSWISfPkxTOud+r59KURorbjJ7xQ2v1eELdCzMekUPBiLi4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1780675205; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=tjI3GNTIpJ2ZS2TYhtwv/UinCsWgiBXMF3kJ8iwkTaY=; 
	b=cJYTRnk8qGL5ItAHtB7cpRtbZPX0e8cCr+3U4GDTh9C2nN8o6FoxQahB/EzBUeBNlPKH5VVmMLVdcnbjKLNVf4g3S278e09QWa+npzcKblKmb9DfUtvm+dbRb9vkxDLKRt5hXNjIiMuVxu05rOxdcez8SXFbHRmi7xYYiDOTjIQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1780675205;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=tjI3GNTIpJ2ZS2TYhtwv/UinCsWgiBXMF3kJ8iwkTaY=;
	b=C85lJ+OpyOnp/QOQlhybiY4IgW42UIzWnNxaQgEumY26ZeEhtMQ4HMRutvl6OTye
	8ff9N8q3hKVYiOulyn9VMpuR7H6zqkZYcZxA+7zh3+Bkwt5pavWepcL92Qg7SYZcYcD
	xkR37WuPWCUAtzjXHgS165rjY6/xql1oUSeMMHc0=
Received: by mx.zohomail.com with SMTPS id 1780675201617820.7421924054617;
	Fri, 5 Jun 2026 09:00:01 -0700 (PDT)
Message-ID: <028a9a32-51f1-47b4-985f-177502c40965@zohomail.com>
Date: Fri, 5 Jun 2026 23:59:55 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/region: Avoid variable shadowing in region attach
 paths
To: Alison Schofield <alison.schofield@intel.com>
Cc: linux-cxl@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>,
 Dan Williams <djbw@kernel.org>
References: <20260605040504.865728-1-alison.schofield@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20260605040504.865728-1-alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: zu080112278ba1297c03f2b4f9603eaf8c0000f44fbc2d31efeffef235b3b786f4fa2f1f6e482dd54a93a91b:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External


在 2026/6/5 12:05, Alison Schofield 写道:
> A couple of symbol declarations shadow earlier variables in the region
> attach paths. Shadowing makes it harder to tell which object is being
> referenced and can obscure future bugs.
>
> Reuse the existing 'cxld' variable in cxl_port_attach_region() and
> rename the endpoint decoder iterator in cxl_region_attach() to avoid
> shadowing the function parameter.
>
> No functional change.
>
> Found with sparse.
>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
