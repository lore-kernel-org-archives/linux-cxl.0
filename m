Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D28142AB4
	for <linux-cxl@vger.kernel.org>; Fri,  7 Feb 2025 06:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738909152; cv=pass; b=OAcvWyx/PFezTw9eVs/CmzVgVJIpOZwyzCW+D4rxKMtIJkeyFxzyZUyMI6UlWyQvXIpekW081+xUXYcZ54luv40alKKZTijmn3veQMNUtFrREXWtohbyJDncY+3StgwFz9BiPSf8KYjs31sSCDM7eNyf0AS099cpR6jT6pCuov4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738909152; c=relaxed/simple;
	bh=ZJKyvl2bFZx8/cCz1kCsUkjxv7CLdtEdmqj6U837q58=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pOQstu0h7vWxAUTmV9/HxqwVj8MO/CtegrA5VQ1c6lA4gr7DuCyLm8DANFYApmw4/1XinzCKcy4P6juNSYkMuVunE8fMk5ahvLhCn1dQw85yhA8NYzTWZ35xvz0KZ6qW4Y/bpGR2TYbqeu4zOEYEV/0vYujN750PFs8YeuQGf+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=LI0rviY7; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="LI0rviY7"
ARC-Seal: i=1; a=rsa-sha256; t=1738909135; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=WgsHexypFAJTgDP/89ZYexUH/bIAboPvBvZTlJNm3sfvf07Efo2CzmSyrTRi3KGBPUE4b35MqDGp1jrNwDzw34jiK1C8eO/ZBQYfspVfEFvgqeFX29HzAPiOwngc2PBL76y3mUvd7KYrP+VZ0W08DUkz91vrFNKLGJZZqUbHbaM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1738909135; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ZJKyvl2bFZx8/cCz1kCsUkjxv7CLdtEdmqj6U837q58=; 
	b=byoU5M1tPKsX0wvxeyowtXW1OII55HtntIts37ychSLnmbZDYGFIZcUqK25GxYJpY/RjcC5Qtagv+JWD1aeOjQO0ZK1CT2q9QTZkurDdAp7KrPV4qCwnog1Tb3TMoGy8qdv9epEIjd2xe2heuIBq6YxmWUVXMJ3RWfbv31Zgqk4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1738909135;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=ZJKyvl2bFZx8/cCz1kCsUkjxv7CLdtEdmqj6U837q58=;
	b=LI0rviY7KzhY0KMdFkQPNdaWY9APBpZRRCWKdRrHnK9hMDESyyaKGL/pV5IW/w1E
	WtkjroYReRulAd1dhlfptOo17ocebsf6eZjiZervK9imdteeRvOYcNpIbQCZ1/ZvWHm
	GN/nDmDx8BkSSRgntN34Ct5OGDOClsFm/dvCIFMk=
Received: by mx.zohomail.com with SMTPS id 1738909132825605.2947795681735;
	Thu, 6 Feb 2025 22:18:52 -0800 (PST)
Message-ID: <0f01fe45-c975-42e3-94a5-e4130d133233@zohomail.com>
Date: Fri, 7 Feb 2025 14:18:44 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/16] cxl/mbox: Add GET_FEATURE mailbox command
To: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, Jonathan.Cameron@huawei.com, dave@stgolabs.net,
 jgg@nvidia.com, shiju.jose@huawei.com
References: <20250204220430.4146187-1-dave.jiang@intel.com>
 <20250204220430.4146187-6-dave.jiang@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20250204220430.4146187-6-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr08011227c69e3458fe26957544145b800000192d9b6968b90fc4c4bed6bdf98bfbe42f2ee4cd9a3180c157:zu0801122751189be8c762964403cf5a1700002ecab9b81a6349d2eb01a391f963bb1730dcdf8b7938e9f19b:rf0801122d92972635cb1e6be03799e4cb00008bc61d1636018eeae1fc2b2274451925b4a88889c4159b45da827318343e57:ZohoMail
X-ZohoMailClient: External

On 2/5/2025 6:03 AM, Dave Jiang wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
>
> Add support for GET_FEATURE mailbox command.
>
> CXL spec r3.2 section 8.2.9.6 describes optional device specific features.
> The settings of a feature can be retrieved using Get Feature command.
> CXL spec r3.2 section 8.2.9.6.2 describes Get Feature command.
>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>

