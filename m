Received: from sender4-pp-o90.zoho.com (sender4-pp-o90.zoho.com [136.143.188.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF9534EF06;
	Fri, 16 Jan 2026 09:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768557278; cv=pass; b=baLEAHB4va0uckHTNE2pNXDKz6RD8MJmU12Dnfcn4MV5gBAHman4qG9uWurQFNw+HFUr3Y0VDdNezCwCxpm2OCV0h19D23Bj4hbT4iD8EjiOTSNccflPM7TtI/2nJOW0M5I303uqBIAXcU1D97a6AklscNRBEcVLDtNq5tANYbw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768557278; c=relaxed/simple;
	bh=82FYS+eU0JRK8CEK/tk6SUHZ33h7u6GakzlYmLL28+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kQl7zP8g/tvZuiqAwLyZrIOUnlvOwgDgy+2pSA4P1X6J8ESXoFxGmIBnHG254Nnorr3WLPT6f68kwgZNoERmONX8bEgBRl7i/SsfEHIewHG0Rp0VuepriCf8KAv1UD17ofFg4yOq1Cl/gCojs/P9p8Hc+0O+LR2yauv4FmqpTIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=fRvmdfyP; arc=pass smtp.client-ip=136.143.188.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="fRvmdfyP"
ARC-Seal: i=1; a=rsa-sha256; t=1768557262; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=gshfeEsYNXhQZrQadl/SAyGSaoJnDHLU2R1lT37kjTntJZ9EcxZqK1cia7reO/u9lCcWIA4+xRzlzdykodNHedCwiQWXK8x5Q9M2N1ex1SI4wMQ0mi7bQS8FTAzbrcAI7IhpgOpGWBilce0xCkpJ44Mrjv9q0r0YHiFpQhQno74=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1768557262; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=AOeet5nGYtMbSgDhtlNqWBBN3az/eEOMlXjjByK0LoA=; 
	b=Mu261Lh+z66/bCmrH0Hne0VzlH4UwPvEd1bz7KdfmJY2yRGnBzb1XcN+MPgYqgx718JrSo8LcwPW2r7TdrDmF/F3YmcPzIN9m/5rfZRl68S0G/EXBuz/O1BbBnwzMjSFPYFntK9SOvIrPZfaDfyvgwY5g99XJNtU3IBLmNltmJ0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1768557262;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=AOeet5nGYtMbSgDhtlNqWBBN3az/eEOMlXjjByK0LoA=;
	b=fRvmdfyPEAcdYk89NW6R3X4cnNHPo14I1x5bFRdPhVPLiUb+8CNYQC/l8ooJoIAZ
	gCtumiUA3X31MwLBLcppv3bBxDsIKWeOqoCnw2zAlqwa57XDVAbpYNq9n9cJ845pkpz
	S/09+cuvNDje6QXr+LDe12NTmwON4oNgK0bVqHi0=
Received: by mx.zohomail.com with SMTPS id 176855725911215.335389538202776;
	Fri, 16 Jan 2026 01:54:19 -0800 (PST)
Message-ID: <1442ea88-ae86-4ffa-9c79-13879d729bd8@zohomail.com>
Date: Fri, 16 Jan 2026 17:54:13 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] cxl/acpi: Fix using extra xormaps for address
 translation
To: Alison Schofield <alison.schofield@intel.com>, dave.jiang@intel.com
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, vishal.l.verma@intel.com,
 ira.weiny@intel.com, dan.j.williams@intel.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260115131648.620177-1-ming.li@zohomail.com>
 <aWkqVFud7UA5CRie@aschofie-mobl2.lan>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <aWkqVFud7UA5CRie@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: rr080112270face617c71c016672f74d4e0000cf990ee462b93a308e7edc6f7fb863612669be22e34f90dfc2:zu08011227caa645bdac943e9887904e560000c93edcb58ef5ece1a20d0a76a4112ca0497429204a2ee64a8e:rf0801123296eed98d6967dcb12be42b9c0000753968cd2b53043ebef8f11fe8e18fb4abdb5c1c2435037ff6dac97c95319368ef7314c7:ZohoMail


在 2026/1/16 01:56, Alison Schofield 写道:
> On Thu, Jan 15, 2026 at 09:16:48PM +0800, Li Ming wrote:
>> CXL r3.1 Table 9-22 defines a fixed number of XOR maps for interleave
>> arithmetic based on the number of interleave ways, as reflected by
>> hbiw_to_nr_maps[].
>>
>> The current implementation applies all XOR maps during address
>> translation, but it should use the spec-defined number of XOR maps
>> derived from the number of interleave ways.
>>
>> Fixes: 3b2fedcd75e3 ("cxl: Restore XOR'd position bits during address translation")
>> Signed-off-by: Li Ming <ming.li@zohomail.com>
> Ming,
>
> I previously sent similar patch and then recalled it for the reason
> described in this thread.
> https://lore.kernel.org/linux-cxl/26c7ca6f-eb5f-4f20-8dba-e62e43e3e1b5@intel.com
>
> The above was all before
> 	"4fe516d2ad1a6 cxl/acpi: Make the XOR calculations available for testing"
> where I added input param checking and introduced nr_maps_to_apply.
>
> I don't think it is necessary to use nr_maps_to_apply in the
> for loop once the params have been validated. So maybe this patch
> is a cleanup on commit 4fe516d2ad1a6 rather than a fix.
>
> Please take a look again and let me know if I'm wrong again ;)
>
> --Alison

Hi Alison,


Thanks for pointing it out, you are right, it is not a bug. After 
reviewing cxl_parse_cxims(), the cxmisd->xormaps stores the correct 
number of xor maps based on the interleave ways. In fact, 
nr_maps_to_apply is equal to cximsd->nr_maps in cxl_do_xormap_calc(), So 
it is not needed to change it.


Hi Alison and Dave,


Please ignore this patch, apologies for the noise.


Thanks

Ming

>
>> ---
>>   drivers/cxl/acpi.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
>> index 77ac940e3013..5f84d01e7d39 100644
>> --- a/drivers/cxl/acpi.c
>> +++ b/drivers/cxl/acpi.c
>> @@ -61,7 +61,7 @@ u64 cxl_do_xormap_calc(struct cxl_cxims_data *cximsd, u64 addr, int hbiw)
>>   	 * bits results in val==0, if odd the XOR result is val==1.
>>   	 */
>>   
>> -	for (int i = 0; i < cximsd->nr_maps; i++) {
>> +	for (int i = 0; i < nr_maps_to_apply; i++) {
>>   		if (!cximsd->xormaps[i])
>>   			continue;
>>   		pos = __ffs(cximsd->xormaps[i]);
>> -- 
>> 2.34.1
>>
