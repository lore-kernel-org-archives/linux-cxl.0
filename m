Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD9324BCE8
	for <linux-cxl@vger.kernel.org>; Wed,  6 Aug 2025 09:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754472085; cv=none; b=dpgxru3XbzGuVKYMJDSnoeYsNzycq/j2ZwP5b2eqpnwjbI83OFh8NwGjkvjvaHiNYHAbxt4u8l8INQsiPz1uXAZzucwmM64I9nldvqTytyMJFIwcfvqHMKo21XwzZHIqWIy/ljlbD3lTxWI1TY0mL0Ilhru66KW1fzgZU1GU6g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754472085; c=relaxed/simple;
	bh=bUImrPxc9uduZok1zKsAiWk5UdeFGs472AJr6aApmiQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BNvyzEcE3UqmXkfalbY6xCDNER1BwmB+tmKeBli16FWdl8puy0rcSAPyCXgkdv5MZeFiqJ4s4q8vzzCQBEprWy/xIja2xWReDwnfkVlGX09z88NVSZvOMPGd6fl0GEs0F35P+L0ZvZOI9WWX7cI+dVGc2/EpfvZPUrOcJh7CDKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bxl9137Z7z6H6sh;
	Wed,  6 Aug 2025 17:19:01 +0800 (CST)
Received: from frapeml100006.china.huawei.com (unknown [7.182.85.201])
	by mail.maildlp.com (Postfix) with ESMTPS id 7C42214038F;
	Wed,  6 Aug 2025 17:21:19 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100006.china.huawei.com (7.182.85.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 6 Aug 2025 11:21:19 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Wed, 6 Aug 2025 11:21:19 +0200
From: Shiju Jose <shiju.jose@huawei.com>
To: Markus Armbruster <armbru@redhat.com>, shiju.jose--- via
	<qemu-devel@nongnu.org>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, "fan.ni@samsung.com" <fan.ni@samsung.com>,
	"dave@stgolabs.net" <dave@stgolabs.net>, Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH qemu v4 2/7] hw/cxl/events: Updates for rev3.2 general
 media event record
Thread-Topic: [PATCH qemu v4 2/7] hw/cxl/events: Updates for rev3.2 general
 media event record
Thread-Index: AQHb+mQPxQ/H0Fd6t0WcgTOSj0gwtLRVWvqmgAAWGNA=
Date: Wed, 6 Aug 2025 09:21:19 +0000
Message-ID: <13bd805817af44268da6ab63513045dd@huawei.com>
References: <20250721172228.2118-1-shiju.jose@huawei.com>
	<20250721172228.2118-3-shiju.jose@huawei.com> <87ms8cq3ug.fsf@pond.sub.org>
In-Reply-To: <87ms8cq3ug.fsf@pond.sub.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

>-----Original Message-----
>From: Markus Armbruster <armbru@redhat.com>
>Sent: 06 August 2025 08:58
>To: shiju.jose--- via <qemu-devel@nongnu.org>
>Cc: linux-cxl@vger.kernel.org; Jonathan Cameron
><jonathan.cameron@huawei.com>; fan.ni@samsung.com; dave@stgolabs.net;
>Shiju Jose <shiju.jose@huawei.com>; Linuxarm <linuxarm@huawei.com>
>Subject: Re: [PATCH qemu v4 2/7] hw/cxl/events: Updates for rev3.2 general
>media event record
>
>shiju.jose--- via <qemu-devel@nongnu.org> writes:
>
>> From: Shiju Jose <shiju.jose@huawei.com>
>>
>> CXL spec rev3.2 section 8.2.10.2.1.1 Table 8-57, general media event
>> table has updated with following new fields.
>> 1. Advanced Programmable Corrected Memory Error Threshold Event Flags
>> 2. Corrected Memory Error Count at Event 3. Memory Event Sub-Type 4.
>> Support for component ID in the PLDM format.
>>
>> Add updates for the above spec changes in the CXL general media event
>> reporting and QMP command to inject general media event.
>>
>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
>
>[...]
>
>> diff --git a/qapi/cxl.json b/qapi/cxl.json index
>> c1fe8319c8..e8060d16f7 100644
>> --- a/qapi/cxl.json
>> +++ b/qapi/cxl.json
>> @@ -82,6 +82,19 @@
>>  # @component-id: Device specific component identifier for the event.
>>  #     May describe a field replaceable sub-component of the device.
>>  #
>> +# @is-comp-id-pldm: Flag represents device specific component identifie=
r
>> +#     format is PLDM or not.
>
>Awkward phrasing.  Before I can suggest a better one, I have a question.
>The type is uint8, which isn't a flag.  What are the possible values?
Thanks Markus for the comments.

'is-comp-id-pldm' is flag with possible values 0 and 1.
I will use type bool instead of uint8?
>
>> +#
>> +# @cme-ev-flags: Advanced programmable corrected memory error
>> +#     threshold event flags.
>> +#     See CXL r3.2 Table 8-57 General Media Event Record.
>
>The line break will not make it into generated HTML (it's all one wrapped
>paragraph).
>
>We commonly wrap like this:
Will fix.
>
>   # @cme-ev-flags: Advanced programmable corrected memory error
>   #     threshold event flags.  See CXL r3.2 Table 8-57 General Media
>   #     Event Record.
>
>If you want a line break in generated documentation, you need to start a n=
ew
>paragraph like this:
>
>   # @cme-ev-flags: Advanced programmable corrected memory error
>   #     threshold event flags.
>   #
>   #     See CXL r3.2 Table 8-57 General Media Event Record.
>
>Same below.
Will fix.
>
>> +#
>> +# @cme-count: Corrected memory error count at event.
>> +#     See CXL r3.2 Table 8-57 General Media Event Record.
>> +#
>> +# @sub-type: Memory event sub-type.
>> +#     See CXL r3.2 Table 8-57 General Media Event Record.
>> +#
>>  # Since: 8.1
>>  ##
>>  { 'command': 'cxl-inject-general-media-event', @@ -91,7 +104,10 @@
>>              'dpa': 'uint64', 'descriptor': 'uint8',
>>              'type': 'uint8', 'transaction-type': 'uint8',
>>              '*channel': 'uint8', '*rank': 'uint8',
>> -            '*device': 'uint32', '*component-id': 'str' } }
>> +            '*device': 'uint32', '*component-id': 'str',
>> +            '*is-comp-id-pldm':'uint8',
>> +            '*cme-ev-flags':'uint8', '*cme-count':'uint32',
>> +            'sub-type':'uint8' } }
>>
>>  ##
>>  # @cxl-inject-dram-event:
>

Thanks,
Shiju
