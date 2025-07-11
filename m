Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D483FC7
	for <linux-cxl@vger.kernel.org>; Fri, 11 Jul 2025 02:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752200879; cv=pass; b=gjgiNAKIdKKEy690qzVIjPCBzwODfP54SHizE8/kFDL+hembY3jXnk7ohwSfNcpDEnhuAQ81fQ2XUIwf7OZ1SC+NFXkNPdnlM+OuMhs1Tod/c9qO3Kxc5Hh49TMxB2d6cR208ISlpab+q2pIu14BNgXDp2TJBLmXiuz7GKA2rCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752200879; c=relaxed/simple;
	bh=OMbqAZRh5OpyjgF3ZDDZyMBL1h5isPdWqbWGYjodO4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rdDYxPz+GJ0bmTw+eTE1RzPvr1VlMti0WTWNfuX8nsb3Q9MQgxCSfevhvby42h/okqPE1S4LWJ9LlD/eP2J6VKALMcQw/HcXBr84f2A44Ld9X6SGw0Y9m+9TZdonY17k068rtOprprcWIg+LUy2HO5PgSqneYc6uYm0W/IgqfaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=P3QxpN/8; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="P3QxpN/8"
ARC-Seal: i=1; a=rsa-sha256; t=1752200868; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=PVXZltPrZTs+r8vFhlXPBb5ZimXIXJ+/UyY9OwWzGkGd8cTyenvI7wqDGOQK9dxF+pvMeeNNL006JQ69vBK8BGd521ntgWUjt79HvEC5NJ3fyATlskHBvznl61fvPMrv/Bl+qCAftlSjeHcRhpyIejElIW7fX8FfzXiI7EcJv/k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752200868; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=OMbqAZRh5OpyjgF3ZDDZyMBL1h5isPdWqbWGYjodO4I=; 
	b=BiuJVf/8QV6u5+yCFwIwubg2IuW3cjO7U7yC1XnFlF1O6EyBjveUtQDnfC0NcIOmTnJqV+UfrJ9dcPvAGaBqgl/BoBqdDY2uiwTE3sylj6R3cPJtl5VJKD8j+YxR+72nDNUErUZkddiwNxMMtQQTv1U4dPUrQB2xS8oi8W6F4oM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752200868;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=OMbqAZRh5OpyjgF3ZDDZyMBL1h5isPdWqbWGYjodO4I=;
	b=P3QxpN/819iVs2U7ZfoPjkpUYLGsc+fjO1HTrh9kRmfrGaOqywUev0z6IUbNKPnu
	SyVtzgsSggh4WYd02l87WIMGVFSuAYOtThuEQRAl3k5f/Way5vzoZqn2YFgQpzXIEk+
	CxMENUAHn2+krbTf2mI0zXLkVb0NANLvIuhuKH5s=
Received: by mx.zohomail.com with SMTPS id 1752200865111270.0570375553343;
	Thu, 10 Jul 2025 19:27:45 -0700 (PDT)
Message-ID: <bc68f691-aed8-42a0-bc12-0cd6f3f54cf0@zohomail.com>
Date: Fri, 11 Jul 2025 10:27:41 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 10/10] cxl: Remove devm_cxl_port_enumerate_dports()
 that is no longer used
To: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com
References: <20250709203619.2607133-1-dave.jiang@intel.com>
 <20250709203619.2607133-11-dave.jiang@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20250709203619.2607133-11-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr080112273f3a58603355976213933037000066ec6d37a2d42dc4222d056d4393b03bc2465ce3294ce22654:zu0801122722944b59107dc35def5dcaec000065e4e8b538f6d18cdebaa11b02f6bc3189164cf9b3fbe09ff8:rf0801122dc0d73422db561cc7ca88e2ac0000f776a379278c47eae8409a2e37521e318a27d6796d6b2927763a422c1bda69:ZohoMail
X-ZohoMailClient: External

On 7/10/2025 4:36 AM, Dave Jiang wrote:
> Delete function devm_cxl_port_enumerate_dports() which is no longer being
> used anywhere. Also remove cxl_test support.
>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Li Ming <ming.li@zohomail.com>

[snip]

