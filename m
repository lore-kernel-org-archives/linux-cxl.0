Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3DEEEAA
	for <linux-cxl@vger.kernel.org>; Wed, 19 Feb 2025 07:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739950066; cv=pass; b=mHt+WKBxO1ahRLT9s1RNLggmUv719WSrVkVL+ZoGWr8xz5bOLj7SSQFTl+Q2PxGEDE8ecFpeXHtDzbbjbrnVgK0s9Z9Mmfki96/sgo8w/JxE4kJrjHcLw86F11yuF6KCez+qI1BygmGwZa5L4w06phf0FZYM6rqXAS0Oemv4yP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739950066; c=relaxed/simple;
	bh=UmuRzwv2/BnjmYiklcgYamWjQGSPp2WkhRA5v3fctBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z7FggLc4r0y7CqtoFQoKXPDPX19vcgSCHx2jZbl2VFebJczzq7sAVkLBM+5l/Nx+4CtqzXyV21ohbU6+O6gWUKeNss2MQT9ud7KdQb/TcQ5BJENC7felCc3MX6SCrS/tNhvKdVxNKmijA/5w0OcBqiHr2WHPVsxY5BIxlU+nBBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=RcayL6CM; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="RcayL6CM"
ARC-Seal: i=1; a=rsa-sha256; t=1739950052; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=hXDJpg6jEqF51N7hUHSMU85KBNjtZ7bFGgKZm2U9qU8QsXVUkmqppd6pzgyq/ffPftAkk5JQpBuqQQhoFYmjKe51xz71NUwqypeU1c80rIRpddtGMVRu92T4IyJHKeEp9Dldk21i5FcpZG8Gwgb9d3Slp9ZU/K84SG3b2yx+mmI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1739950052; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=UmuRzwv2/BnjmYiklcgYamWjQGSPp2WkhRA5v3fctBY=; 
	b=VM5S5vWI3b3qolc4bMsVnzmmTCDbA7pyhvIH+3e0/o2GsT1fFQM4fQrGyEnvd9tdAVTGTX4e5nCX32RF4w6zCwvf6OQngJUv7kuT8YHHJZNiteUDyz2XVi/Ko5DBa1eQmR+93NaCTYLvEzk2+HFf5wVkeU+9TuTtaXR7ipVkCrU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1739950052;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=UmuRzwv2/BnjmYiklcgYamWjQGSPp2WkhRA5v3fctBY=;
	b=RcayL6CMKs1E33LtSd15nXB19jcaZXXwTtKEz1/EAJd+A6TiFdWdNdElpTMl2+VJ
	+GwV6Nso9L7dxDUHxf8AF1Jqb5B5OPaFOkCFeCTYLfN8X4rGGKS5m7sHLz9eY+Cpj8u
	yDTZkR9d5QGqzDVHc4SSNCU0rzv8k2i3NiTXw7EQ=
Received: by mx.zohomail.com with SMTPS id 1739950049503885.8796489984959;
	Tue, 18 Feb 2025 23:27:29 -0800 (PST)
Message-ID: <bba2fe8d-0bb6-47fd-a81b-8e7edb734eb3@zohomail.com>
Date: Wed, 19 Feb 2025 15:27:27 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/14] cxl: Add support for fwctl RPC command to enable
 CXL feature commands
To: Dave Jiang <dave.jiang@intel.com>
Cc: dan.j.williams@intel.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, Jonathan.Cameron@huawei.com, dave@stgolabs.net,
 jgg@nvidia.com, shiju.jose@huawei.com, saeed@kernel.org,
 linux-cxl@vger.kernel.org
References: <20250218225721.2682235-1-dave.jiang@intel.com>
 <20250218225721.2682235-10-dave.jiang@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20250218225721.2682235-10-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr080112272a932d09b5126f8e3d99d6bb0000c59cf4905c04afab527bd7b4b65119eb887486f959d98a55b3:zu08011227b0041f13ebfceafeec4e027d00007938ff9e0594add0108a9909c197845f7485c1595c4a7aab90:rf0801122d38cf846d524a2e0b0b0866ca0000b5660a80cc12f80c2244d8ebfeb2f2797664f85f78b095741e99d3be739f6a:ZohoMail
X-ZohoMailClient: External

On 2/19/2025 6:54 AM, Dave Jiang wrote:
> fwctl provides a fwctl_ops->fw_rpc() callback in order to issue ioctls
> to a device. The cxl fwctl driver will start by supporting the CXL
> Feature commands: Get Supported Features, Get Feature, and Set Feature.
>
> The fw_rpc() callback provides 'enum fwctl_rpc_scope' parameter where
> it indicates the security scope of the call. The Get Supported Features
> and Get Feature calls can be executed with the scope of
> FWCTL_RPC_CONFIGRATION. The Set Feature call is gated by the effects
> of the Feature reported by Get Supported Features call for the specific
> Feature.
>
> Only "Get Supported Features" is supported in this patch. Additional
> commands will be added in follow on patches. "Get Supported Features"
> will filter the Features that are exclusive to the kernel. The flag
> field of the Feature details will be cleared of the "Changeable"
> field and the "set feat size" will be set to 0 to indicate that
> the feature is not changeable.
>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
