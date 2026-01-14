Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76D52F39B8
	for <linux-cxl@vger.kernel.org>; Wed, 14 Jan 2026 18:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768415598; cv=none; b=tUh+0YtrqB8wLCbNHoq4I4jYeVOpaOAiCi65mdmpcVaEh4nIFVs/pkMjWPkEyNw5u1N1Ta/H6wUX8mtzNdRHooUfSGeqHrHsNniypee3PnxkhA6kl6H0M9pXJLEXQqkrcFbxeVMk4xB3ZRWfKDPPbIibz1Mze8RCatLvU1lsOuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768415598; c=relaxed/simple;
	bh=QKOgtWbImrLVv2Bo9HZryzZ8rSN1xsmqhuyNdJkS7as=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KRRngy9+aX+1Eh65bgv9klSLJflkszlBFeKW7inwlMbYiyfxesWUqBkq1p8qs3tqYIWPa12ZVDLqka5gOR10t1pGvJxVytkNsRcna7D7RaRqT4eHTOP7hfpDbs3lJEnvdFCveI02K8Q3KdMgNjA+1AdsZVP12f198uXqncegjv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AbY9anZJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AbY9anZJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768415592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZY+iK/xWDDzRyJmPT2o/1BMVk/VL8rgD5rFFpStv1yI=;
	b=AbY9anZJc7gggldXLJ/4Fgw8bHIqhp1ze+piQwP1iIuL9yLE7HkxMTmNHtwM4LdTlFxUVK
	AM0zFpYXqvzjDl89/q49SGIuPQFCI5tHT+bOo8t6RNrHhxCeSTy+M9o2Am/bNQJvld8hY+
	3gCyl/kfQToEPWux2tLXcpwcfGkBca0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-673-hoIEY-dWMz6z65vXGIkY4g-1; Wed,
 14 Jan 2026 13:33:07 -0500
X-MC-Unique: hoIEY-dWMz6z65vXGIkY4g-1
X-Mimecast-MFC-AGG-ID: hoIEY-dWMz6z65vXGIkY4g_1768415586
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EEC25195608E;
	Wed, 14 Jan 2026 18:33:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.32])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 44BBF1956056;
	Wed, 14 Jan 2026 18:33:05 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id DA0DA21E692D; Wed, 14 Jan 2026 19:33:02 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Michael Tsirkin <mst@redhat.com>,  <qemu-devel@nongnu.org>,
  <shiju.jose@huawei.com>,  <armbru@redhat.com>,  <linuxarm@huawei.com>,
  <linux-cxl@vger.kernel.org>,  Ravi Shankar <venkataravis@micron.com>
Subject: Re: [PATCH qemu v3 4/5] hw/cxl/events: Updates for rev3.2 DRAM
 event record
In-Reply-To: <20260114142713.617806-5-Jonathan.Cameron@huawei.com> (Jonathan
	Cameron's message of "Wed, 14 Jan 2026 14:27:12 +0000")
References: <20260114142713.617806-1-Jonathan.Cameron@huawei.com>
	<20260114142713.617806-5-Jonathan.Cameron@huawei.com>
Date: Wed, 14 Jan 2026 19:33:02 +0100
Message-ID: <87sec8yrhd.fsf@pond.sub.org>
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

> From: Shiju Jose <shiju.jose@huawei.com>
>
> CXL spec rev3.2 section 8.2.10.2.1.2 Table 8-58, DRAM event record
> has updated with following new fields.
> 1. Component Identifier
> 2. Sub-channel of the memory event location
> 3. Advanced Programmable Corrected Memory Error Threshold Event Flags
> 4. Corrected Volatile Memory Error Count at Event
> 5. Memory Event Sub-Type
>
> Add updates for the above spec changes in the CXL DRAM event
> reporting and QMP command to inject DRAM event.
>
> In order to ensure consistency update all specification references
> for this command to CXL r3.2.
>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> v3: Update all spec references for this command to 3.2 for consistency
>    (Markus)
> ---
>  qapi/cxl.json               | 31 +++++++++++++++++++++------
>  include/hw/cxl/cxl_events.h |  9 ++++++--
>  hw/mem/cxl_type3.c          | 42 +++++++++++++++++++++++++++++++++++++
>  hw/mem/cxl_type3_stubs.c    |  7 +++++++
>  4 files changed, 81 insertions(+), 8 deletions(-)
>
> diff --git a/qapi/cxl.json b/qapi/cxl.json
> index c159687f849c..630c37d64eed 100644
> --- a/qapi/cxl.json
> +++ b/qapi/cxl.json
> @@ -131,21 +131,21 @@
>  ##
>  # @CXLDRAMEvent:
>  #
> -# Event record for a DRAM Event (CXL r3.0 8.2.9.2.1.2).
> +# Event record for a DRAM Event (CXL r3.2 8.2.10.2.1.2).
>  #
>  # @dpa: Device Physical Address (relative to @path device).  Note
> -#     lower bits include some flags.  See CXL r3.0 Table 8-44 DRAM
> +#     lower bits include some flags.  See CXL r3.2 Table 8-58 DRAM
>  #     Event Record, Physical Address.
>  #
>  # @descriptor: Memory Event Descriptor with additional memory event
> -#     information.  See CXL r3.0 Table 8-44 DRAM Event Record, Memory
> +#     information.  See CXL r3.2 Table 8-58 DRAM Event Record, Memory
>  #     Event Descriptor for bit definitions.
>  #
> -# @type: Type of memory event that occurred.  See CXL r3.0 Table 8-44
> +# @type: Type of memory event that occurred.  See CXL r3.2 Table 8-58
>  #     DRAM Event Record, Memory Event Type for possible values.
>  #
>  # @transaction-type: Type of first transaction that caused the event
> -#     to occur.  See CXL r3.0 Table 8-44 DRAM Event Record,
> +#     to occur.  See CXL r3.2 Table 8-58 DRAM Event Record,
>  #     Transaction Type for possible values.
>  #
>  # @channel: The channel of the memory event location.  A channel is an
> @@ -169,6 +169,21 @@
>  # @correction-mask: Bits within each nibble.  Used in order of bits
>  #     set in the nibble-mask.  Up to 4 nibbles may be covered.
>  #
> +# @component-id: Device specific component identifier for the event.
> +#     May describe a field replaceable sub-component of the device.
> +#
> +# @is-comp-id-pldm: This flag specifies whether the device-specific
> +#     component identifier format follows PLDM.
> +#
> +# @sub-channel: The sub-channel of the memory event location.
> +#
> +# @cme-ev-flags: Advanced programmable corrected memory error
> +#     threshold event flags.
> +#
> +# @cvme-count: Corrected volatile memory error count at event.
> +#
> +# @sub-type: Memory event sub-type.
> +#
>  # Since: 8.1
>  ##
>  { 'struct': 'CXLDRAMEvent',
> @@ -177,7 +192,11 @@
>              'type': 'uint8', 'transaction-type': 'uint8',
>              '*channel': 'uint8', '*rank': 'uint8', '*nibble-mask': 'uint32',
>              '*bank-group': 'uint8', '*bank': 'uint8', '*row': 'uint32',
> -            '*column': 'uint16', '*correction-mask': [ 'uint64' ]
> +            '*column': 'uint16', '*correction-mask': [ 'uint64' ],
> +            '*component-id': 'str', '*is-comp-id-pldm':'bool',
> +            '*sub-channel':'uint8',
> +            '*cme-ev-flags':'uint8', '*cvme-count':'uint32',
> +            'sub-type':'uint8'
>             }}
>  
>  ##
   # @cxl-inject-dram-event:
   #
   # Inject an event record for a DRAM Event (CXL r3.0 8.2.9.2.1.2).

Should we update this reference as well?

   # This event type is reported via one of the event logs
   # specified via the log parameter.
   #
   # Since: 8.1
   ##
   { 'command': 'cxl-inject-dram-event',
     'data': 'CXLDRAMEvent' }

[...]

