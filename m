Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320C426296
	for <linux-cxl@vger.kernel.org>; Mon, 10 Feb 2025 06:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739169916; cv=pass; b=pzdHfVOaRKtGTghLtT7hspbOMUcOHdRvGZRQkSY5MH8Uh06gAnQxBD56WnGHCgfok5i1YgXeIVsNBtec3YcbCt1+a4BuU6KANtrq3Hj5e7AImgFZtzwmtm4xDNW3iEV447iU6OmX3SszAUBHglNUI6bgC9s1mkRHE35f228qgwg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739169916; c=relaxed/simple;
	bh=dSna6r4zr2NPFUZrxu9ix+03dwF7p99CC6EQWkpppz0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b/KdSBbfFrAaPH1eKchEUecYdaXC0crv8aMD5LF/dlJ8rXe5bxWDd37Q0otfju+gydY0RYMEeAOzmU/ppdbmts/8jQE8HzA3KxInQs+Cdq0jrR/mMiC/2uj9pR+QgHooI6moQLoiBaYTeZR4l8da1QupXAzRg9RI8Sn6fVk8yc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=PsSC7XfU; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="PsSC7XfU"
ARC-Seal: i=1; a=rsa-sha256; t=1739169900; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=TudKTuMzmERt0xSDv+QrB2ySPVSfI0AK7vhT1SctTpohbwfuq+Q7GSld7bwiQ7OJlvMzsr2eEHhdYOgklCIuTiMwxM0QvAt8TWv/urSRfJdnw5JlLfJI78xdui1DB8UBFDaLjf7KyWvYEej5Hfqj6xp2uUPIQIPxX9PhwVfrd9M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1739169900; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=dSna6r4zr2NPFUZrxu9ix+03dwF7p99CC6EQWkpppz0=; 
	b=aVftNOoNtkdOv8PqjRhRa2DDIA0ROxbjZB51JBvwClszVtvqx4rogV1zuFGfulCNDAH9mwd0SVqPlVi4jxI1EtJqqLRARwiUGi9XEJgRV2vfokyr1sHUDpRofQsQgQDdpQMbCBxdlAIR/8Xyej6L4scWmEjFDB3wjzXZKKd2dxo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1739169900;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=dSna6r4zr2NPFUZrxu9ix+03dwF7p99CC6EQWkpppz0=;
	b=PsSC7XfUdcKXE/DFpmv9odWy0g9eOKYeiYn1JGMY99iR76zhfuoi4cJiZr9k5jzD
	ElSF9OKTRmkfKrWBDfuMnhuckq7+p3euxiAleqF0FicwMEVB5Vij960+p3gDyCpSEOZ
	MdOzTcbsU5SSR0p3asgZv2OoV/iU5vw3qFdouVhk=
Received: by mx.zohomail.com with SMTPS id 17391698981001020.5938351078634;
	Sun, 9 Feb 2025 22:44:58 -0800 (PST)
Message-ID: <2d08b259-e160-4170-b863-78337942cf83@zohomail.com>
Date: Mon, 10 Feb 2025 14:44:54 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/15] cxl/test: Add Set Feature support to cxl_test
To: Dave Jiang <dave.jiang@intel.com>
Cc: dan.j.williams@intel.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, Jonathan.Cameron@huawei.com, dave@stgolabs.net,
 jgg@nvidia.com, shiju.jose@huawei.com, linux-cxl@vger.kernel.org
References: <20250207233914.2375110-1-dave.jiang@intel.com>
 <20250207233914.2375110-15-dave.jiang@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20250207233914.2375110-15-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr08011227571744e056d8175a2c8b28d40000244c34195061bbd343425480a3d2bee5aec32f22653b105b2a:zu080112278cc6234723e9f5a2c8c4b7250000bdf8c864946f3e72ce8dfb7e1143b1827818a616b62bc797c2:rf0801122d540cb5336a2de4b68db8843a00009f3a06796b05eb6032ae1c60190684c15cab99e36b241fc0959b7e300acaac:ZohoMail
X-ZohoMailClient: External

On 2/8/2025 7:37 AM, Dave Jiang wrote:
> Add emulation to support Set Feature mailbox command to cxl_test.
> The only feature supported is the device patrol scrub feature. The
> set feature allows activation of patrol scrub for the cxl_test
> emulated device. The command does not support partial data transfer
> even though the spec allows it. This restriction is to reduce complexity
> of the emulation given the patrol scrub feature is very minimal.
>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
