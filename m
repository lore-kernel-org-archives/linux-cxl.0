Received: from sender5-pp-o92.zoho.com (sender5-pp-o92.zoho.com [165.173.182.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55F52931F1
	for <linux-cxl@vger.kernel.org>; Wed, 16 Sep 2026 01:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.182.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789522144; cv=pass; b=JWbCThDZyvJmsMAb8XcrxunFYAXdYCT315Q2+5rBKEAb0KV9rnqiuQZCuiO2g4i2JG1384WqHr1mrWPQn9Sw9aEan91afj2/miZiiu2YPZzi2QZUdleuu/qWxUW4hZWOvcuG0ieHz5fugQ9N1a152xY4eQHGqJNufkOZkQJaJs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789522144; c=relaxed/simple;
	bh=iYuK5laNmB3R9ZrDe1DuZHK7tCXUTXRB1inGKt4AHS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MNXvxLhQTGgzPApE1eFDmhGIJMHT3xXByCgz9SFcToPYRF9aw2uGmE2qx2l9UlCFdx8hqzIpGJOKiGhbbfn0jC/9kmgYY7NWHr07EmyauXxEDEdBYSlmGWwXVeI/KEPL7QmEAPydREDJIk8DmWqKXQ0Zg6J+0ssO4VjMD7lMx44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=ZmZRxmMP; arc=pass smtp.client-ip=165.173.182.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="ZmZRxmMP"
ARC-Seal: i=1; a=rsa-sha256; t=1789522129; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=OqGWcFd+U/US4TFqD0wcakolSCQiS1XX7OQc42Xd7m5zsN4rNbxPXM7EP1yJsMrw69e4GbbsIOfalZABKoTAft8w8CH58S/5FwyIVQ7NuVkbl6sozrvShv8sa7ejF5IAo6Nr44bBH+TxD6tJXno0OUmoV0ngLR90KKQclvcRT34=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1789522129; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=3xjCuS0jU6CDw706HB7sPYjIOi3Q5pnS4V//GRJzJtY=; 
	b=T86uT05QKFLJtgmDRG/s/XrXl7QZx541cbpmmd5PTDbH3rmdx3y0+KnZn0RCOxgJKiCzrv8cLkfPio5HHf2a+UgF8TdBsUqdZKXkfxygtjJOu17CVJWpDy1nPmw9SfXGg8aWz3+xVbMQeG6tobaXJIe+CuJYuEr3H7BZDnJ1RCg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789522129;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=3xjCuS0jU6CDw706HB7sPYjIOi3Q5pnS4V//GRJzJtY=;
	b=ZmZRxmMPJ2ancq1NBefxD0vBJ5jDEL8X9ptatAIvWoiO/VCo6u0Nd0tpcaKpBDyC
	y1g5SQh2GJpvZM5vPCreLcLgFGlfklmPM/eZghLn6ptcYlUVxe7LOqA3eArYptQvi6q
	yzHAci7ZNT21r5ug4qzk6BpCQ83cC/ISFdDoILAA=
Received: by smtp.zohomail.com with SMTPS id 17895221275891018.7139781494759;
	Tue, 15 Sep 2026 18:28:47 -0700 (PDT)
Message-ID: <7d3cafb1-0ef0-47c9-92c7-05cb37e920d4@zohomail.com>
Date: Wed, 16 Sep 2026 09:28:43 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 02/10] cxl/pci: Add BI topology enable/disable
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: dave.jiang@intel.com, jic23@kernel.org, alison.schofield@intel.com,
 icheng@nvidia.com, benjamin.cheatham@amd.com, alucerop@amd.com,
 linux-cxl@vger.kernel.org
References: <20260909170302.1550680-1-dave@stgolabs.net>
 <20260909170302.1550680-3-dave@stgolabs.net>
 <7501f4d8-2241-4bf6-8eb7-ca94318b08f4@zohomail.com>
 <20260915201705.euqusiybd6vxy5of@offworld>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20260915201705.euqusiybd6vxy5of@offworld>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: zu08011227eb161f36c38d28cdbe35e4a60000527f167ea9c8128ca347ac311d74ea14b4785e0b60098e72d4:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External


在 2026/9/16 04:17, Davidlohr Bueso 写道:
> On Thu, 10 Sep 2026, Li Ming wrote:
>
>>> +static int cxl_bi_commit_dport(struct cxl_dport *dport)
>>> +{
>>> +    struct cxl_port *port = dport->port;
>>> +    int rc;
>>> +
>>> +    if (pci_pcie_type(to_pci_dev(dport->dport_dev)) !=
>>> +        PCI_EXP_TYPE_DOWNSTREAM)
>>> +        return 0;
>> Missing check to confirm if the dport is a PCI_EXP_TYPE_ROOT_PORT 
>> here? I think the function is still used for rp.
>
> So root ports call into this function yes, but they do not get past
> this check which filters them out - root ports do not do commit
> (Table 8-156), but I will add a comment.

Oh, you are right, good to know that, thanks.


Ming

[...]

