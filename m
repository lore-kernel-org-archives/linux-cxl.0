Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D3A23FC4C
	for <linux-cxl@vger.kernel.org>; Wed,  6 Aug 2025 10:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754475810; cv=none; b=pOGZr7esb4ll1uerjBq4orCHMiWHXZK5niCTlPOtrAI7eVAyyUEHkmyTLW/WrZMB0fUCmlkRDtB7/fJL+x4ma2QyUSVTakeGA5qUTUOKKrmsvo8I0qdKT5mdmfDia6E77Uwr2JXkY5q535YSfTRXal488qSXztsWY6kqoHALlKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754475810; c=relaxed/simple;
	bh=n3knFwAR1xDOiQESVu8kBFSTp+3lkJw0CLnsRmfzW4g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cNeBvJsUwY0L+Daygp58llx27PBo1FPBm0+EFOy+SDtM570pR3JZlMyrjBZ8PI3ujfflazJ6MpqfqaVaAMsNxPsX304qL/6+q5ovkeK/inQQIN6KFqFUt01A4plRh4PxWRaJUNb4pXZ9Cu3vEDX4GYqMptyGr3ZWUQjJXLA+MRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Oe5LicXQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oe5LicXQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754475806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IJ+zJ/yZ5yKJT/1RqpkTJyRojwEgcT0Z65kF8AQNcjU=;
	b=Oe5LicXQld2JMl8gdatbVtwPWc+TMVZivV3kOhflFylE+0B/DVzozdsWmjXef4w+Z/EQUm
	b+yLHXVgumaAowAIJ/jPvijJ9TnR4acHmP7WMQYVayH8/iEidtaE+xYJYrmlJ3QwQzdL2a
	Anw+yJPpZ6ELV8GUrcB7K2KheZx5Ba8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-275-TvKlYAeHNIaH5HMsqnyUaQ-1; Wed,
 06 Aug 2025 06:23:21 -0400
X-MC-Unique: TvKlYAeHNIaH5HMsqnyUaQ-1
X-Mimecast-MFC-AGG-ID: TvKlYAeHNIaH5HMsqnyUaQ_1754475800
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 90F7F180036E;
	Wed,  6 Aug 2025 10:23:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AA02A180035C;
	Wed,  6 Aug 2025 10:23:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id C85FB21E6A27; Wed, 06 Aug 2025 12:23:15 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Shiju Jose <shiju.jose@huawei.com>
Cc: shiju.jose--- via <qemu-devel@nongnu.org>,  "linux-cxl@vger.kernel.org"
 <linux-cxl@vger.kernel.org>,  Jonathan Cameron
 <jonathan.cameron@huawei.com>,  "fan.ni@samsung.com" <fan.ni@samsung.com>,
  "dave@stgolabs.net" <dave@stgolabs.net>,  Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH qemu v4 2/7] hw/cxl/events: Updates for rev3.2 general
 media event record
In-Reply-To: <13bd805817af44268da6ab63513045dd@huawei.com> (Shiju Jose's
	message of "Wed, 6 Aug 2025 09:21:19 +0000")
References: <20250721172228.2118-1-shiju.jose@huawei.com>
	<20250721172228.2118-3-shiju.jose@huawei.com>
	<87ms8cq3ug.fsf@pond.sub.org>
	<13bd805817af44268da6ab63513045dd@huawei.com>
Date: Wed, 06 Aug 2025 12:23:15 +0200
Message-ID: <87h5ykn3zg.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Shiju Jose <shiju.jose@huawei.com> writes:

>>-----Original Message-----
>>From: Markus Armbruster <armbru@redhat.com>
>>Sent: 06 August 2025 08:58
>>To: shiju.jose--- via <qemu-devel@nongnu.org>
>>Cc: linux-cxl@vger.kernel.org; Jonathan Cameron
>><jonathan.cameron@huawei.com>; fan.ni@samsung.com; dave@stgolabs.net;
>>Shiju Jose <shiju.jose@huawei.com>; Linuxarm <linuxarm@huawei.com>
>>Subject: Re: [PATCH qemu v4 2/7] hw/cxl/events: Updates for rev3.2 general
>>media event record
>>
>>shiju.jose--- via <qemu-devel@nongnu.org> writes:
>>
>>> From: Shiju Jose <shiju.jose@huawei.com>
>>>
>>> CXL spec rev3.2 section 8.2.10.2.1.1 Table 8-57, general media event
>>> table has updated with following new fields.
>>> 1. Advanced Programmable Corrected Memory Error Threshold Event Flags
>>> 2. Corrected Memory Error Count at Event 3. Memory Event Sub-Type 4.
>>> Support for component ID in the PLDM format.
>>>
>>> Add updates for the above spec changes in the CXL general media event
>>> reporting and QMP command to inject general media event.
>>>
>>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
>>
>>[...]
>>
>>> diff --git a/qapi/cxl.json b/qapi/cxl.json index
>>> c1fe8319c8..e8060d16f7 100644
>>> --- a/qapi/cxl.json
>>> +++ b/qapi/cxl.json
>>> @@ -82,6 +82,19 @@
>>>  # @component-id: Device specific component identifier for the event.
>>>  #     May describe a field replaceable sub-component of the device.
>>>  #
>>> +# @is-comp-id-pldm: Flag represents device specific component identifier
>>> +#     format is PLDM or not.
>>
>>Awkward phrasing.  Before I can suggest a better one, I have a question.
>>The type is uint8, which isn't a flag.  What are the possible values?
> Thanks Markus for the comments.

You're welcome!

> 'is-comp-id-pldm' is flag with possible values 0 and 1.
> I will use type bool instead of uint8?

Yes, please!

[...]

