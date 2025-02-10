Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B534B1991A9
	for <linux-cxl@vger.kernel.org>; Mon, 10 Feb 2025 06:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739169833; cv=pass; b=KYU+WnuULHQJxksCvGrBxXFU17zbmIuBPexJiyN3XG4L3Tsm4a7KVq3A/b+xp2ryn1+f4kCXggeXvlsk4Rub0DWs2wuo1uQGFyYaR2kItIo/4jHjOI4HJTsw1ApJ6Sqr4JtR03SD4AgM6xbhNgroxGzBcgnL/5+YfygmN0F5RbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739169833; c=relaxed/simple;
	bh=Be7r5vP+H5MszNxW0ckYVmsvk2XczEGV/qTs4Rx+0kA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f7GoU8UWCkyp9zih8XcydqBm626Hym0RK6Yau+tGYUnUWBeUdO4U7hAU7BX5P9cXb3HxO2oBX5pwjA9LbhTCBmiq8gS3/Ndp9shW2EhcIaF7xt3dEVeDmu3XMpluQx+xeEBy++LwNh6i4MHi4xOXtX3VXzqEnYm2dksRMFDk6QU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=RNTfKFBK; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="RNTfKFBK"
ARC-Seal: i=1; a=rsa-sha256; t=1739169814; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=j+Kp8asEP5TA+Y23hyfOxgIV6iHxmcF92ZIKu96U9PbVqINoH+M2m1T6nQnBdoKDshSk+OW6eKzV2R/PtVQ1dnduLxf/t1VcvSclcUBU6a5OXQ4OEo2H1y08ZDe9pVUIfq7z7nLLG8x6d0aOw3uROtxlBh/w/sG3fZEFeu+Pseg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1739169814; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Be7r5vP+H5MszNxW0ckYVmsvk2XczEGV/qTs4Rx+0kA=; 
	b=IGhjuUmgQwbcXW24ljCl4tO3o47gHGA85WA2ih+j4E3pwmbq49BXunM2qvRsrjgkKXeFURZ1jfRrMkF3L6Qj7vw337tDHnXxxRg6+xadFClZBdFUBaBsyJUghXme2EUYKMacpcRW4SSv3KQQRysCZIwx+MPf68NfTnl+y9Z6GBA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1739169814;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=Be7r5vP+H5MszNxW0ckYVmsvk2XczEGV/qTs4Rx+0kA=;
	b=RNTfKFBKBFZvQS7ilPEkVjkKnZs1Dkiba2AXsFmrMqPuZG8Y+THIanPyJZuOIp9I
	kGL381kxO60BzhVhP+VG7HZnVdL4Fbvv8PlDg2w4i/fOrdogbQZk5j40TwqhgzdjvJJ
	ePSwAurTpWCzvTRaGnIAPmkbr/p4aBM3wmTeJdMI=
Received: by mx.zohomail.com with SMTPS id 1739169810570874.4249206333056;
	Sun, 9 Feb 2025 22:43:30 -0800 (PST)
Message-ID: <295f0208-118a-40de-b1b4-3ca466d4705f@zohomail.com>
Date: Mon, 10 Feb 2025 14:43:25 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/15] cxl: Add support to handle user feature commands
 for set feature
To: Dave Jiang <dave.jiang@intel.com>
Cc: dan.j.williams@intel.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, Jonathan.Cameron@huawei.com, dave@stgolabs.net,
 jgg@nvidia.com, shiju.jose@huawei.com, linux-cxl@vger.kernel.org
References: <20250207233914.2375110-1-dave.jiang@intel.com>
 <20250207233914.2375110-13-dave.jiang@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20250207233914.2375110-13-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr08011227ca6c911bcdad53f1c39a4dcd00004942ce71eeea357aaddb0e653e9b9f3ab83e72e804d3e1018d:zu08011227024049b4412824c86c498eb6000015b26e320298331dc7ebb337f64062101060911b8f6c70bb06:rf0801122d05ddd71ce009704b8319cd75000009b91dc057d94ac236125df96dd2ce9bfddd20ce64a9bf6656461be7a2f23f:ZohoMail
X-ZohoMailClient: External

On 2/8/2025 7:37 AM, Dave Jiang wrote:
> Add helper function to parse the user data from fwctl RPC ioctl and
> send the parsed input parameters to cxl_set_feature() call.
>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
