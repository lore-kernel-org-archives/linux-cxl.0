Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7572AE6A;
	Thu, 20 Feb 2025 00:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740012220; cv=pass; b=pBo0EB2CW5wlLJJ/yfomrhXTvTRcR1X35qswNGS8iJfSTueRFky2PmR0DtduYuk6maRF6tWS2/vkf2ADd2cP9cY0RnxozrokEnPY7X5wpiy2GkMi+cRHm2h6iCTwWxpx1N7eTgw3vHbLYOhkVdVwgJy1gNl8DSk81v9cZg+ZVQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740012220; c=relaxed/simple;
	bh=U0gVlj+iCEw+dVy2968HB1D+X9dLArZ6qqVaMh9h8xo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y+9kWaUiRCmd08Z029dLVVdqsHRshpQxUjDa6kgZxe/smJj1kfZuGcnOB1uyLcJM6pBQFvb8X2UtxD0THsiYqbUW4dPoXvnvzp77Q4Ce3QXZpVUHxCzMTTKRFrEG/vLKL+zrKnaPu6pfYWSCN9f0zzeDv1J/H9ZDmLt72cmWthM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=RPKL5Faa; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="RPKL5Faa"
ARC-Seal: i=1; a=rsa-sha256; t=1740012204; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=hlQE2P/S0nWodvTsDk/EmbirdEIuv7zb9dyAjbToFvnfpluX63hnOff6b/tZIaRaL0vUUj9Uqbb9/MdEhT/Z69/E78FpLIuSI7lwTxYTzf3nrnzYRzwgg9e7tb1ALa70JkKq0nToI3+y0SDhzpLnN/lOPOS1I6haZ3lFPpk6tlA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1740012204; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=U0gVlj+iCEw+dVy2968HB1D+X9dLArZ6qqVaMh9h8xo=; 
	b=IOylOM/vqRr366fnsr4u21fLCF4phsP6WAOgTTyQBLukDEtMoUBhGLQ7aBziDYMTePPRFoFeEvxWUAcKy+7Fg8jvj2AG7ck1dmv3pjIQdcPyk0dLhPZF0Cr1+Naithxj3E7AXkZGkMNDt2dJQd7vdbsmojKmy9CZXH08VzM24xc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1740012204;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=U0gVlj+iCEw+dVy2968HB1D+X9dLArZ6qqVaMh9h8xo=;
	b=RPKL5FaaLOCQOLNsS0wYUq9piKr5fu7P5E1BiSoISYlgiBCJNqIWK/51aaPWBTST
	hY/VRIS950I5s1or60Wtk3B34J2vY1EfJ+f+JACiPKrhbJhZId1NPn05gZg6+hKgx6J
	SOZkfkQyZGnoMesIYHolsyWotuEVq1R/DRoddh8s=
Received: by mx.zohomail.com with SMTPS id 1740012202707209.0923034936219;
	Wed, 19 Feb 2025 16:43:22 -0800 (PST)
Message-ID: <58269f53-03a0-4cd4-9335-686c770b1f60@zohomail.com>
Date: Thu, 20 Feb 2025 08:43:21 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] Use guard() instead of rwsem locking
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 dave@stgolabs.net, jonathan.cameron@huawei.com, vishal.l.verma@intel.com,
 ira.weiny@intel.com, dan.j.williams@intel.com, alison.schofield@intel.com
References: <20250217144828.30651-1-ming.li@zohomail.com>
 <07d8bd01-ed09-4106-81fb-0e7b6793e3aa@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <07d8bd01-ed09-4106-81fb-0e7b6793e3aa@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr08011227f881d169d98f44a974826f0b0000786a47c29c3264d0ced742f64105cc13a5fc6c8b66eef8645c:zu0801122761aa9d1e0fa7c399a31e1ad60000ef55fb2281806115fdd9c035e727f61e1698cfb684f6bfc747:rf0801122d35abf1defa27ac5c35b1c21b000033a49f76b2b797019133d66d675539999d4004667260bd182c4cdb839b62ed:ZohoMail
X-ZohoMailClient: External

On 2/20/2025 5:09 AM, Dave Jiang wrote:
>
> On 2/17/25 7:48 AM, Li Ming wrote:
>> Use scoped resource management to replace open-coded locking operation
>> is recommended. CXL subsystem still remains some down_read()/up_read()
>> and down_write()/up_write() which can be replaced by guard() simply.
>>
>> This patchset includes simply using guard() instead of some
>> down_read()/up_read() and down_write()/up_write() cases. Besides, it
>> also includes some function code cleanup after using guard().
>>
>> base-commit: a64dcfb451e254085a7daee5fe51bf22959d52d3 (tag: v6.14-rc2)
>>
>> v2:
>> - Drop some local variables. (Jonathan)
>> - Rename __construct_region() to construct_auto_region(). (Jonathan and Dave)
> Hi Ming,
> Can you please do me a favor and rebase this against cxl/next for a v3? I think there are some conflicts against the DPA cleanup that's not easily resolved. Thanks!
>
> DJ

Sure, will do that.


Ming

