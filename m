Received: from esa2.hc1455-7.c3s2.iphmx.com (esa2.hc1455-7.c3s2.iphmx.com [207.54.90.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFED4C60E
	for <linux-cxl@vger.kernel.org>; Tue, 30 Jan 2024 06:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706597372; cv=none; b=Wdd4/DpobcClV2iROCqUtaOxnm79IlFCjR+QoKZe7vIk+SEiOlF8ShUwHMzbXbDsqmBM+UwFGNnIRxJ+KI8px7idMqQZxpLaH7VH3qCs6q5i3ybdPnwcGiKPZBkFTApp8US4STcj0yXWYkj990lFe/YGk6hUZjUrJWoNCmdLbfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706597372; c=relaxed/simple;
	bh=7KT+i5ReFfZp/qRvWgdipNjYbv3ivQhGppZ9uTNZCiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l77xWc6SGuyA5ZsIxigkz1VUGojQt3C3RLgpDNrNpYAdFqgOpwjqhOAsnnYgKRmS/iAF31DKW9u88XsRyjjAgMBY3BKPHgMjLLtncon9BvBr+b0CW2KX+ET8D71TOtGZ9B3ZQ6E87N443K72jlvlleXAqIIMkGT1l3NUQPtTuPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=QwXRwhta; arc=none smtp.client-ip=207.54.90.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="QwXRwhta"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1706597369; x=1738133369;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7KT+i5ReFfZp/qRvWgdipNjYbv3ivQhGppZ9uTNZCiQ=;
  b=QwXRwhta6QgFLiVbM7AsaQAoHAQfmcZP1nHEGt/iff1oJIryp8C/4/Gt
   dOPdEyGRWgqd/1SdZk0NfIAOLkVAF1e/8FdT9UDlQP0nO0o3kiv3LEQ0K
   9/LhPrTMh1tL+XhzEzj4mrFW09yOgMGutYRiOOVvv0vU+ONLffwnZySf8
   cL+QRaLjKuCERe17c7QC/P7Cc5Yqp4oa1O5Ymp27BAm6EEpHBLFAs1fSI
   l875e/dEMLHTtXyfmpTRLlLU+89znOyZImOs7j9DDywTMcN+iY7EPZuAR
   uEDbMxY4XdFlmJTKEAjjcLTgCy+97MRYEsIIeodbnhpwTkMX+ZSZUPJ7B
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="147755925"
X-IronPort-AV: E=Sophos;i="6.05,707,1701097200"; 
   d="scan'208";a="147755925"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa2.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 15:49:20 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
	by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 06D78430F0
	for <linux-cxl@vger.kernel.org>; Tue, 30 Jan 2024 15:49:18 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 45E67F9B3
	for <linux-cxl@vger.kernel.org>; Tue, 30 Jan 2024 15:49:17 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id CDA11200A571F
	for <linux-cxl@vger.kernel.org>; Tue, 30 Jan 2024 15:49:16 +0900 (JST)
Received: from [10.167.220.145] (unknown [10.167.220.145])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 483D91A006A;
	Tue, 30 Jan 2024 14:49:16 +0800 (CST)
Message-ID: <f6e27ebc-1a78-065e-18bb-6642386e63aa@fujitsu.com>
Date: Tue, 30 Jan 2024 14:49:15 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] cxl/hdm: Enhance handling of invalid decoders
To: Dan Williams <dan.j.williams@intel.com>, dave.jiang@intel.com,
 vishal.l.verma@intel.com
Cc: linux-cxl@vger.kernel.org
References: <20240130060517.19942-1-caoqq@fujitsu.com>
 <65b898a491e76_5902829419@dwillia2-mobl3.amr.corp.intel.com.notmuch>
From: =?UTF-8?B?Q2FvLCBRdWFucXVhbi/mm7kg5YWo5YWo?= <caoqq@fujitsu.com>
In-Reply-To: <65b898a491e76_5902829419@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28150.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28150.005
X-TMASE-Result: 10--9.832900-10.000000
X-TMASE-MatchedRID: 4y9/ylYYqyaPvrMjLFD6eKpLARk+zpBZC/ExpXrHizw0tugJQ9Wdw2nX
	UUBQ4UsQbn+bq+W8j6W5/woTY0aN39t0USrWkHT6TuctSpiuWyUUi4Ehat05499RlPzeVuQQjXo
	1v7B3XhCndn/LfNMv31ilB8WsQcQFd5Ro8KJ/dm33dt27LH8hnATHaede/M0j1tmGB7JU9CNbVE
	WYN/4Idqwglxty6Z/EKao4mTYQoAKfkYK9/ujydWLwWlwtbx1gajzNTFMlQCNs1Ir4NZzFmrTLc
	NrcH2Gr4vM1YF6AJbZFi+KwZZttL7ew1twePJJB2KDPNsqphTL6C0ePs7A07cjHchynrO5bmNks
	Z072TajXdFUuRlu85Cx8dpFddu2OxpvRr8QkY2s=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0


> Quanquan Cao wrote:
>> Add the condition check "base + size < base", enhanced
>> handling of invalid decoders. This check ensures the
>> decoder's address range calculation won't overflow.
>>
>> Signed-off-by: Quanquan Cao <caoqq@fujitsu.com>
>> ---
>>   drivers/cxl/core/hdm.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
>> index 7d97790b893d..b8978d1c7a24 100644
>> --- a/drivers/cxl/core/hdm.c
>> +++ b/drivers/cxl/core/hdm.c
>> @@ -816,7 +816,7 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>>   
>>   	if (!committed)
>>   		size = 0;
>> -	if (base == U64_MAX || size == U64_MAX) {
>> +	if (base == U64_MAX || size == U64_MAX || base + size < base) {
> 
> The U64_MAX checks were added for a device that returned all
> 0xffffffffffffffff on read. That happens to match the common expectation
> that a device or a bus in an error state starts returning that value to
> MMIO cycles. So this was less about validating that those values were
> sane and more about having a convenient point to detect that the device
> is returning the common indicator for MMIO failure.
> 
> Otherwise a device that reports an overflow condition is definitely
> broken, but it will be caught by other address validation code. So, I
> do not think this is suitable otherwise it would open the door for many
> other device validation checks.
> 
> I would change my mind if there was an example of this breakage in the
> wild causing real end user pain that is too late for the device hardware
> vendor to fix.
> 
Thanks, I got.
