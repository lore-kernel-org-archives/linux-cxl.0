Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4015A1FB3
	for <linux-cxl@vger.kernel.org>; Fri,  9 May 2025 00:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746752127; cv=pass; b=C8jkG+5EtJBwuaDcVqCNh8bbb+L5RieRp+gKBkUcPhWsBbssVVMgpGmKT4Vi/+Y1LCSY2fHB2pVxzgyzXHmJytOwLt6BI5WUTk7H19QloMLRwzxGx3MujmtheryYt7qP0qZjhIYniffnRkmipnyQzktogqfDo708D0FDjE5hTqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746752127; c=relaxed/simple;
	bh=FVxpgb+gYWLQlwp2cCTfHKkZr3GLd7CzJL1tDHmrQqI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nUTwDSLoka9rvg1b4pP53Q9MQbB4WBc1aeFGLtK4Dc/1WAhvFoMU17yx/PdccU1rJ+6iphEzhz9dDNbgDolAHjqcwVC52zlzUhPdmku4PQn73qRQPQpDKfweQ4IP0L5zTXFc2OU0Cd8X3xLMO/QQWuRq0crTFXPG5mP2olMaEPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=Rh+B/imG; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="Rh+B/imG"
ARC-Seal: i=1; a=rsa-sha256; t=1746752112; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=HHVP7IsQETTv0xOa1JBv0J0/dx8ELKe0oV9OMF28joIAtBge+P6KM9XWjjUdfG/P6MetWBYOzExuKro676G6WLU+Sv5lDrpHq0kRRvnR1X239/nBnu8QpJ/L+GJShJEVmqT1r30jM4GF1x5MyKX0OxscWQtU4349KWx33RNAXTU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1746752112; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=FVxpgb+gYWLQlwp2cCTfHKkZr3GLd7CzJL1tDHmrQqI=; 
	b=g3wlEqz3keBrNh3XaHQOd5/GLaa8rUeIgz0+vMQm7fUni64ml7OcPLXNtt6pMG2QZnfstJ9YPspzMaecPL99EF856AOFD5VJYqMRbyQp+EmjZNxE6EfaiGsu4JYze6eFgxCMQVAhVslJ29xZ94rEvVGFahAVBXsh1CXRzIqiyE4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1746752112;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=FVxpgb+gYWLQlwp2cCTfHKkZr3GLd7CzJL1tDHmrQqI=;
	b=Rh+B/imGwRl8YlyxcQG/sz3+gz2yEbny7iZU0tG2x/SbTAJ7nZ05rw9J0m/00yA2
	QwDkc4JhQN6oocxqKTcE5rYjPwRkuLoeWVy2UBMsZHi0dvLa/eHOOOuvZakjmEW1bpb
	ktSViPFk8N+ytmik+zHbTJxXl77Ftj50hygHLpl4=
Received: by mx.zohomail.com with SMTPS id 1746752109950706.4513538987578;
	Thu, 8 May 2025 17:55:09 -0700 (PDT)
Message-ID: <1ca5dc65-2091-4723-9f7e-44fac9aba57a@zohomail.com>
Date: Fri, 9 May 2025 08:55:06 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/10] cxl/region: Add decoder check to
 check_commit_order()
To: Dave Jiang <dave.jiang@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 ira.weiny@intel.com, rrichter@amd.com, linux-cxl@vger.kernel.org
References: <20250507004310.3536991-1-dave.jiang@intel.com>
 <20250507004310.3536991-2-dave.jiang@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20250507004310.3536991-2-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr080112273d0ae4ad998e8e25620beb3300001d41596e7adc9fe61356e84801cab777c2dffbab800c1f244f:zu080112275e3585a370414c3cf62c94770000d16ff894f30517451af07dfaa31499cc68e7f85f4a2e437305:rf0801122ddb2fe4da1e9f3f9bb42261f600000d5f69841a22b10037d5baff0f3fc5492f020e01cd1a16382933c611519f58:ZohoMail
X-ZohoMailClient: External

On 5/7/2025 8:43 AM, Dave Jiang wrote:
> check_commit_order() attempts to convert a device to a decoder without
> making sure the device is a decoder. So far this has been working due
> to pure luck. Issue discovered while doing deferred dport probing when
> child ports are now in the midst of decoders due to ordering change
> of child port additions. Add a check before attempting to do decoder
> conversion.
>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
