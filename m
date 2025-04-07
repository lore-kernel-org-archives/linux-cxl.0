Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D27DDD3
	for <linux-cxl@vger.kernel.org>; Mon,  7 Apr 2025 06:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744006415; cv=pass; b=tvKV9ggdIjISS7ijN1SWPHKdogFhpOxtFADo4MZ4xPCt8lx2cM5u4TBuBpRYUdZsgHdt4fZykrfR9dapAylIA5/ficegouyZaazz7rg4Ww86ZqKuxcbx6opuqVt2EaRssDQvy/BjjImI22UuTZscZDfrogHtAZGjLtdZxa+y2B0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744006415; c=relaxed/simple;
	bh=db3mpE7RJ/XFDEeWo5jjh9LagWOhyzmDDpoDHiOWHT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bAjvubc8MhS9cGs+uY1WvYsOaeGMAbkR2v2H/4fnUligoTt2OdCmITIUx8I7+auhKLoF2cy8RYG7zpDWuJT8SK2mPeXDTc6tEVy/+bDKLyafkzmRxmRmBbs3RLfFrjYhIm2QA94RVi0mGkE7LwGh9/+zsAg5HSIzCIqsWesdTZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=ExFRY8Ps; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="ExFRY8Ps"
ARC-Seal: i=1; a=rsa-sha256; t=1744006281; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=hH05TQxBTV9RvKdF1QNz85dv+f6Br/ykVD1sx5Psyf3cyvbXnpGoPxPPszxj91neQN91yqSNL/Z3wT+4fWoVqTEsm1SASjQQcPs6N1ArxtGmrSYWeOpV6wUZXsgYbvvlRRyetmtWE9q1BuRe9U6xZE6Iyet+A0I68SsIRa+MZEs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1744006281; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=db3mpE7RJ/XFDEeWo5jjh9LagWOhyzmDDpoDHiOWHT8=; 
	b=V58qA9NJqllZJjeRwFlVuwShUWNSTNxWaB1G38knOWJ1tD5nT2lArrD9K8ueOWHzjEO+nn0PVgv9wF2dicS9Msx9gYmULBR0ZnJcBpmzGlpvAMJZM5YevTtDzwsWaERO5Xf0GvEugY7oT6ouf0u7NkwzlssPuxNSjUJebRq2W4k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1744006281;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=db3mpE7RJ/XFDEeWo5jjh9LagWOhyzmDDpoDHiOWHT8=;
	b=ExFRY8PsYMRbgeZsakNXiJCj6i/fyh1fyuEuGLVl5VFwJl5qqIts4bOWnBaIEDSO
	Ivwp6BT2rp1Z7+ldB87Eo/9MoaG3NLx1Qfq8PvHQMXVQXQhuPg7LnqJzd37deRnnztv
	SElgWZGGTM34TVEQpj/uCgLm4H8wL4Zoc5aCMf28=
Received: by mx.zohomail.com with SMTPS id 1744006279800428.239031917189;
	Sun, 6 Apr 2025 23:11:19 -0700 (PDT)
Message-ID: <a64bf6ed-2c21-4531-a15c-da5fc9b68166@zohomail.com>
Date: Mon, 7 Apr 2025 14:11:16 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl: Remove always true condition for
 cxlctl_validate_hw_command()
To: Dave Jiang <dave.jiang@intel.com>
Cc: jonathan.cameron@huawei.com, dave@stgolabs.net,
 alison.schofield@intel.com, ira.weiny@intel.com, danj.williams@intel.com,
 kernel test robot <lkp@intel.com>, linux-cxl@vger.kernel.org
References: <20250404165418.3032414-1-dave.jiang@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20250404165418.3032414-1-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr080112274c4261eacd98966b14c3025c00008bb799134e44dd0b603c703f13387bf54bf3cbc4a0d4c0197f:zu080112274b8265c0301116b6885aa6fd00005ef24c6bd6ee88ccecedc6bf4abac1064a8df398cb0675f9e0:rf0801122d7718706171934ad21086e5d200003184c58b97ba3f8c2bd693851d008c465249362454fb928af960bb758b4fa0:ZohoMail
X-ZohoMailClient: External

On 4/5/2025 12:54 AM, Dave Jiang wrote:
> smatch warnings:
> drivers/cxl/core/features.c:441 cxlctl_validate_hw_command() warn: always true condition '(scope >= 0) => (0-u32max >= 0)'
>
> Remove the check entirely as it has no effect. Expectation is both of these
> operations should be allowed for all check levels. They are read only and
> have no change effects.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202504041033.2HBboAZR-lkp@intel.com/
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
