Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com [139.138.37.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EBA6FB8
	for <linux-cxl@vger.kernel.org>; Fri, 15 Mar 2024 02:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.37.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710469758; cv=none; b=op5/bBj0Rd7Ka6YDcPINsCzKEdT1jSQii4MFZZESYgaSKzx5RtVeKRTBw7Z2dkkMZYY0Z4JwFJI50Ua8y8jxUfPrder0u3gBvCKAHbjmH0Q5WrYgQjPrwlPX/oEgUcLWmJHcV1ePGLw/UeV42myOnRQbQ4RmGksJ2h2jH+JiF7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710469758; c=relaxed/simple;
	bh=9hZ9QgaNYwoI99lUQxp/3ftJBswYg/gLMcRjg38Y3Ng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=og4Okxs9vsR4MaTX8qKGku/LN7be6VGJissfTSyAI6VhKN9N7vjd+9F3VEu4wZwhvoZXcIK96WhKRnboz7D0pMIogQvMJRUbvT78wpOFtPxpRIG7rKaVQFIbo5/s4h3zh05dTpi1VoV7NGdQ47lRkCk1Hl6xypObZ4CHTzlPxrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=Furgq4UT; arc=none smtp.client-ip=139.138.37.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="Furgq4UT"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1710469754; x=1742005754;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9hZ9QgaNYwoI99lUQxp/3ftJBswYg/gLMcRjg38Y3Ng=;
  b=Furgq4UTfrdba7JKrh6+XN0O2VoCylwYoY3gOoPf+1XO0e4V8LCzg0Zg
   VVV6ewp5w6kuBzQor3romXEVcaCdssPJeGTugcR5XAV2sjnnoAXK9czY4
   Hwn7blCZHhJlRbFcIjDpMf90Dw/gP0u/TXbmjSOLmQW+zsBm0l1xD8UAZ
   vGhfw0UzSdY6Ic+uDQ8ywqcBIcdACjKhqZXZG8XpbwufR/KaWYUGRT/VQ
   KajbWiE8ElLh3q+/OXuyNT+fKomSVb7zV5M8e366mJ00fAt6LKwyjcTJJ
   OvnA0wyuq4OVsXjd6uefF1l/B3COLrYjx5ustbeqidu1G8v/aDuTOYnD+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="131634858"
X-IronPort-AV: E=Sophos;i="6.07,127,1708354800"; 
   d="scan'208";a="131634858"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 11:29:11 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
	by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 37A67C6905
	for <linux-cxl@vger.kernel.org>; Fri, 15 Mar 2024 11:29:09 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 775E4D5604
	for <linux-cxl@vger.kernel.org>; Fri, 15 Mar 2024 11:29:08 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 04FBD411A3
	for <linux-cxl@vger.kernel.org>; Fri, 15 Mar 2024 11:29:08 +0900 (JST)
Received: from [192.168.50.5] (unknown [10.167.226.114])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 6D72A1A006C;
	Fri, 15 Mar 2024 10:29:07 +0800 (CST)
Message-ID: <48223415-8466-480d-86e1-8b9945782c0c@fujitsu.com>
Date: Fri, 15 Mar 2024 10:29:07 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 5/5] cxl/core: add poison injection event handler
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org, dan.j.williams@intel.com
References: <20240209115417.724638-1-ruansy.fnst@fujitsu.com>
 <20240209115417.724638-8-ruansy.fnst@fujitsu.com>
 <20240213165150.00006d9a@Huawei.com>
From: Shiyang Ruan <ruansy.fnst@fujitsu.com>
In-Reply-To: <20240213165150.00006d9a@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28252.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28252.004
X-TMASE-Result: 10--21.396700-10.000000
X-TMASE-MatchedRID: 5U6uFEJz7+qPvrMjLFD6eJTQgFTHgkhZ2q80vLACqadlEv6AItKWFy/6
	oQ/dDcvKy38TH6dNchXJPxJtAmAiU2tppRWiT/6uZAV3hs6etPpNLPQl0QAltNbZhgeyVPQj0cb
	Kh4SdBY7G9WPCYEtgIpcltWa2cevGRdvJFOk47xeuW2+UBGEpHTVEnbrqmBw7OQ/k0Ia5E6hkcT
	XUAfcQrznpSV66h8LN2r3f3jyDzpOJ/ssfpZm9q95x7RpGJf1awBi8lRTMyBoUnySvXGc7qro8P
	QV15rjgpBGZFKPZXG2nnGms2c1SHC+5NdfXUqybjrVn4cme+w59LQinZ4QefNQdB5NUNSsiDrBA
	jvbPhh50HSe131POnpBlLa6MK1y4
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0



在 2024/2/14 0:51, Jonathan Cameron 写道:
> 
>> +
>> +void cxl_event_handle_record(struct cxl_memdev *cxlmd,
>> +			     enum cxl_event_log_type type,
>> +			     enum cxl_event_type event_type,
>> +			     const uuid_t *uuid, union cxl_event *evt)
>> +{
>> +	if (event_type == CXL_CPER_EVENT_GEN_MEDIA) {
>>   		trace_cxl_general_media(cxlmd, type, &evt->gen_media);
>> -	else if (event_type == CXL_CPER_EVENT_DRAM)
>> +		/* handle poison event */
>> +		if (type == CXL_EVENT_TYPE_FAIL)
>> +			cxl_event_handle_poison(cxlmd, &evt->gen_media);
> 
> I'm not 100% convinced this is necessary poison causing.  Also
> the text tells us we should see 'an appropriate event'.
> DRAM one seems likely to be chosen by some vendors.

I think it's right to use DRAM Event Record for volatile-memdev, but 
should poison on a persistent-memdev also use DRAM Event Record too? 
Though its 'Physical Address' feild has the 'Volatile' bit too, which is 
same as General Media Event Record.  I am a bit confused about this.

> 
> The fatal check maybe makes it a little more likely (maybe though
> I'm not sure anything says a device must log it to the failure log)
> but it might be Memory Event Type 1, which is the host tried to
> access an invalid address.  Sure poison might be returned to that
> error but what would the main kernel memory handling do with it?
> Something is very wrong
> but it's not corrupted device memory.  TE state violations are in there
> as well. Sure poison is returned on reads (I think - haven't checked).
> 
> IF the aim here is to say 'maybe there is poison, better check the
> poison list'. Then that is reasonable but we should ensure things
> like timer expiry are definitely ruled out and rename the function
> to make it clear it might not find poison.

I forgot to distinguish the 'Transaction Type' here. Host Inject Poison 
is 0x04h. And other types should also have their specific handle method.


--
Thanks,
Ruan.

> 
> Jonathan
