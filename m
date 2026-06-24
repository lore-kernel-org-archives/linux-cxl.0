Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E1A3845C1
	for <linux-cxl@vger.kernel.org>; Wed, 24 Jun 2026 06:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782281558; cv=none; b=d3tWr2OdrlEE5JO9n9DIx1r+3LfZBCWfEQQkBFNPjMIphBV9gFHh4D5OZWsE8SVFBshrqpm8pfK2aP7pZexE2ephDy5a6RXdymLbwJAxkiYEbT7nmCcDnaV13RrKb+BLAqsqaw6gyUbozSpU06oTeGmMV0qH2n0pZ3FO6LMwF7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782281558; c=relaxed/simple;
	bh=ZSVr9Egr6ypjajhcXCckv+4xsGhUqTrg9LYYkcwVdeg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=Q5RmBKvy8StNgLBxXZumnMqAnuvCNr6tNNu8bKVLH3OwQGkbeV2/TcMQ10hipHGg92KJbi69bl99wy4AQZmziWlyomYwISibzvNvE147r2TuoYOUfZdWGa1VSzTgwhgfM0MeknzrG+06g5s+gBapvzg/Uq2DIVVROJYA7BqYoqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=oh3W1FeP; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="oh3W1FeP"
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20260624061232epoutp01716dc2afb7894cfc9296edc891671546~776EfcKdU1640716407epoutp01P
	for <linux-cxl@vger.kernel.org>; Wed, 24 Jun 2026 06:12:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20260624061232epoutp01716dc2afb7894cfc9296edc891671546~776EfcKdU1640716407epoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1782281552;
	bh=kY/dxQYx/wRPEf2qC748CpGM1a3g+t0/zv46gOr+qAY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oh3W1FePv07XnqAelEFW8Q1pHVwG+ADlorSBlcPlORMD+FT9ETvo7JJEYRgXh7OZY
	 /8KS9rzeonXIOS8vWBeBr7bHSXW+q18fNtzf6aBmnAbpJyAafwRAeeA714I6TT2nZh
	 ENonRAj6ASBEBOBgjGdLNn0mfaUlhLPOjKRQm05I=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20260624061232epcas5p43790b4403384ebc55187f2fb90e34c6c~776DwZAjB0689606896epcas5p4N;
	Wed, 24 Jun 2026 06:12:32 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.89]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4glWnC1CKLz3hhTD; Wed, 24 Jun
	2026 06:12:31 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20260624061230epcas5p419894dd4d2e612f7712f1ec7ae940ce0~776ChX7yz3046330463epcas5p4b;
	Wed, 24 Jun 2026 06:12:30 +0000 (GMT)
Received: from arun-B560M-DS3H-V2 (unknown [107.99.41.170]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260624061228epsmtip1b208377c679fed6ea71d1c7e754271e5~776ACMl-O2928929289epsmtip1P;
	Wed, 24 Jun 2026 06:12:27 +0000 (GMT)
Date: Wed, 24 Jun 2026 19:31:03 +0530
From: Shrihari E S <shrihari.s@samsung.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
	qemu-devel@nongnu.org, cpgs@samsung.com, arun.george@samsung.com,
	vikash.k5@samsung.com, s.neeraj@samsung.com, dongjoo.seo1@samsung.com,
	dave@stgolabs.net, gost.dev@samsung.com
Subject: Re: [RFC 1/8] hw/pci: Refactor flitmode from PCIESlot to PCIEPort.
Message-ID: <20260624140103.thavawn667tfs4tg@arun-B560M-DS3H-V2>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260616142730.7fb0a465@jic23-huawei>
X-CMS-MailID: 20260624061230epcas5p419894dd4d2e612f7712f1ec7ae940ce0
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----LzjFyProJtBlqpjpUA7CxzsXX7e_8S7ToqyYf_kYrViRiBfb=_5314c_"
CMS-TYPE: 105P
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260609104503epcas5p12628cd89d0ef9210c856d2518dc790cb
References: <20260609105836.3702787-1-shrihari.s@samsung.com>
	<CGME20260609104503epcas5p12628cd89d0ef9210c856d2518dc790cb@epcas5p1.samsung.com>
	<20260609105836.3702787-2-shrihari.s@samsung.com>
	<20260616142730.7fb0a465@jic23-huawei>

------LzjFyProJtBlqpjpUA7CxzsXX7e_8S7ToqyYf_kYrViRiBfb=_5314c_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

>> diff --git a/hw/pci-bridge/cxl_root_port.c b/hw/pci-bridge/cxl_root_port.c
>> index 0ee18ef5c3..df69c5200f 100644
>> --- a/hw/pci-bridge/cxl_root_port.c
>> +++ b/hw/pci-bridge/cxl_root_port.c
>
>>  static void cxl_rp_dvsec_write_config(PCIDevice *dev, uint32_t addr,
>> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
>> index 1de0b1e4fd..d452199d85 100644
>> --- a/hw/pci/pcie.c
>> +++ b/hw/pci/pcie.c
>> @@ -217,7 +217,7 @@ static void pcie_cap_fill_slot_lnk(PCIDevice *dev)
>>          /* the PCI_EXP_LNKSTA_DLLLA will be set in the hotplug function */
>>      }
>>
>> -    pcie_cap_fill_lnk(exp_cap, s->width, s->speed, s->flitmode);
>> +    pcie_cap_fill_lnk(exp_cap, s->width, s->speed, s->parent_obj.flitmode);
>
>I think we should use a cast to the parent object type rather than going directly
>into s->parent_obj.  PCIE_PORT(s)->flitmode.

Hi Jonathan,

Got your point and it makes sense, will change that in the next version of this patch series. Thanks for the suggestion.

>
>>  }
>

------LzjFyProJtBlqpjpUA7CxzsXX7e_8S7ToqyYf_kYrViRiBfb=_5314c_
Content-Type: text/plain; charset="utf-8"


------LzjFyProJtBlqpjpUA7CxzsXX7e_8S7ToqyYf_kYrViRiBfb=_5314c_--
