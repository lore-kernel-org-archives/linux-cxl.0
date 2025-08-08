Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C66420F069
	for <linux-cxl@vger.kernel.org>; Fri,  8 Aug 2025 18:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754677133; cv=none; b=LIMhfvLTjROV8skTldxumF57+VfdLOd2/sBo06sAv1kjH0l/qd4U5eNAp2uSieFX0jODWX/jomZfo8t6pGwVN6oQVnxyNUg9ef4lnxLHgW3cH6suzGMe0MxOXGWag51Hwe/waCQ4UmmyHBUnNPmsdA76Zxt1wj3Ks+MD6xNuvNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754677133; c=relaxed/simple;
	bh=DmfHeDNGsjJl1z/u4Gg9ElQ7XW+TOD82x9Ty0iGVifo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KWbfWL491bmI9tXDmtjLWxXlATTuEA4ZG6KS1zgU0lndokKWKMsY3welWqBZWN5NE5/zDeC50f1YUZK6RHjgAyUdZYgeQGyYnS5jcYA0tYBgtTLcijxm70+SoWYRUXDhcbRpBHooURJ5HEop/XlPLk7cqxBI05FdwShRZsyFSpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eThoWC0C; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eThoWC0C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754677130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sDv1ZkVjhvp2pwDWnu+yg1ns4eVqnFwa3FltznPcVbo=;
	b=eThoWC0CwzeBZBS4Owpkgq5PNOdsSagUcG5hPYr69Cobln/T0qFctBEAA8USRZiPZGgEBA
	dziOAZEBqG/Cjp+6ydtJYzIYRZ3yI5JiEn5r2JYOFnekuH2CCb2EM4ydCYzw8J69MY4rk/
	erqpTWQ3SkdYKFopOj22DCtuO1g7/gA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-439-wr-HfqDKN6CpiyPbtJVgmA-1; Fri,
 08 Aug 2025 14:18:45 -0400
X-MC-Unique: wr-HfqDKN6CpiyPbtJVgmA-1
X-Mimecast-MFC-AGG-ID: wr-HfqDKN6CpiyPbtJVgmA_1754677124
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F3BAC19560B0;
	Fri,  8 Aug 2025 18:18:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 17F4A195419D;
	Fri,  8 Aug 2025 18:18:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 61F6D21E6A27; Fri, 08 Aug 2025 20:18:40 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,  <ira.weiny@intel.com>,
  <alucerop@amd.com>,  <a.manzanares@samsung.com>,
  <linux-cxl@vger.kernel.org>,  <qemu-devel@nongnu.org>,  "Michael S.
 Tsirkin" <mst@redhat.com>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
  Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH 1/4] hw/pcie: Support enabling flit mode
In-Reply-To: <20250808164216.0000196b@huawei.com> (Jonathan Cameron's message
	of "Fri, 8 Aug 2025 16:42:16 +0100")
References: <20250806055708.196851-1-dave@stgolabs.net>
	<20250806055708.196851-2-dave@stgolabs.net>
	<20250808164216.0000196b@huawei.com>
Date: Fri, 08 Aug 2025 20:18:40 +0200
Message-ID: <87ldntsmm7.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:

> On Tue,  5 Aug 2025 22:57:05 -0700
> Davidlohr Bueso <dave@stgolabs.net> wrote:
>
>> As with the link speed and width training, have ad-hoc property for
>> setting the flit mode and allow CXL components to make use of it.
>> 
>> For the CXL root port and dsp cases, always report flit mode but
>> the actual value after 'training' will depend on the downstream
>> device configuration.
>> 
>> Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> Hi Davidlohr,
>
> This looks a bit like an interface that evolved, but in the end
> you seem to have something that is a simple boolean property.
> As such you can avoid a fair bit of complexity.
> Look for disable-acs for an example.
>
>
> I don't know if it is desirable to make it an explicit type or not,
> but my gut says boolean is fine here.
>
> +CC A few potentially relevant people to answer that question more
> definitively.

[...]

>> diff --git a/qapi/common.json b/qapi/common.json
>> index 0e3a0bbbfb0b..da047fbf874f 100644
>> --- a/qapi/common.json
>> +++ b/qapi/common.json
>> @@ -140,6 +140,20 @@
>>  { 'enum': 'PCIELinkWidth',
>>    'data': [ '1', '2', '4', '8', '12', '16', '32' ] }
>>  
>
> Hmm. Not sure why these are here rather than pci.json.

Pretty sure there was a good reason back then.  Less sure there is a
good reason now :)

>> +##
>> +# @PCIELinkFlit:
>> +#
>> +# An enumeration of PCIe link FLIT mode
>
> Bit odd having an enumeration for 'on' vs 'off'

Indeed.  Please stick to bool.

>> +#
>> +# @off: the link is not operating in FLIT mode
>> +#
>> +# @on: each FLIT is a fixed 256 bytes in size
>> +#
>> +# Since: 10.0
>
> That was a while back.
>
>> +##
>> +{ 'enum': 'PCIELinkFlit',
>> +  'data': [ 'off', 'on'] }
>> +
>>  ##
>>  # @HostMemPolicy:
>>  #

