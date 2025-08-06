Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F9E22068D
	for <linux-cxl@vger.kernel.org>; Wed,  6 Aug 2025 08:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754467558; cv=none; b=Mc2p2xF2Wr65H/q+JeHF8lekWGulOCsXFOwQlQzoB80B3DHJKe7EQWkZYyBqTjSR2D1TzRukC6fBhgdI2nL7ZqF/ral1fHT1GWYFBc7B7KgtT88A1CPN4b5hk97vYeSA1yyJmMqXRvtfKPjTGsH8w89zZYE4y+CuIot1HfDav+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754467558; c=relaxed/simple;
	bh=+Yh1uZiKmo5Irp/wQnjz0hh7LzjXyCOY57sGxV48ObA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TU7WaV4iHnaluUSuq8jzhA0rNNKV+KdWfqaaWUdX1BEnmR+2H2GKIZHJCCok7+M8eg6EjILva55FbhUzTWj0X9YujT269QGTpa1sw6gppgK4n77EW7WnPMLQVmXLgd0Nn95wLFY9ZuPAaE8DFwU8JhzXPUEpOTsHMi3dMZbwN/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YjCOL+bE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YjCOL+bE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754467555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8Lu8xE/SKruqDeHet1rwEfgvoXFmRy/MrurIkXgOx3c=;
	b=YjCOL+bExt5LdKh8K3sjr20aLso3fjXCdsAcfB1zEVWa6xcTRRuwS70LHTRTvWJVJ43p5g
	EQegze8I2ufJWyO1IOJZIaT5RYXBOFKeupTWw7OWNKndm8sYiw/x6T/Z7zos3UuZeyWeU/
	A/XW3Lk/N4vC1JYa4baYxsX/Nu9D+94=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-389-AjpRtBpYNZaV9EHE_8Rk5w-1; Wed,
 06 Aug 2025 04:05:51 -0400
X-MC-Unique: AjpRtBpYNZaV9EHE_8Rk5w-1
X-Mimecast-MFC-AGG-ID: AjpRtBpYNZaV9EHE_8Rk5w_1754467550
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8250519560B6;
	Wed,  6 Aug 2025 08:05:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DCD9F1956086;
	Wed,  6 Aug 2025 08:05:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 2DD7821E6A27; Wed, 06 Aug 2025 10:05:46 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: shiju.jose--- via <qemu-devel@nongnu.org>
Cc: <linux-cxl@vger.kernel.org>,  <jonathan.cameron@huawei.com>,
  <fan.ni@samsung.com>,  <dave@stgolabs.net>,  <shiju.jose@huawei.com>,
  <linuxarm@huawei.com>
Subject: Re: [PATCH qemu v4 3/7] hw/cxl/events: Updates for rev3.2 DRAM
 event record
In-Reply-To: <20250721172228.2118-4-shiju.jose@huawei.com> (shiju jose's
	message of "Mon, 21 Jul 2025 18:22:24 +0100")
References: <20250721172228.2118-1-shiju.jose@huawei.com>
	<20250721172228.2118-4-shiju.jose@huawei.com>
Date: Wed, 06 Aug 2025 10:05:46 +0200
Message-ID: <878qjwq3hh.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

shiju.jose--- via <qemu-devel@nongnu.org> writes:

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
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>

[...]

> diff --git a/qapi/cxl.json b/qapi/cxl.json
> index e8060d16f7..f84088c0b9 100644
> --- a/qapi/cxl.json
> +++ b/qapi/cxl.json
> @@ -171,6 +171,26 @@
>  # @correction-mask: Bits within each nibble.  Used in order of bits
>  #     set in the nibble-mask.  Up to 4 nibbles may be covered.
>  #
> +# @component-id: Device specific component identifier for the event.
> +#     May describe a field replaceable sub-component of the device.

Identical to cxl-inject-general-media-event's argument, except ...

> +#     See CXL r3.2 Table 8-58 DRAM Event Record.

... we don't have such a reference there.  Should we?

> +#
> +# @is-comp-id-pldm: Flag represents device specific component identifier
> +#     format is PLDM or not.
> +#
> +# @sub-channel: The sub-channel of the memory event location.
> +#     See CXL r3.2 Table 8-58 DRAM Event Record.
> +#
> +# @cme-ev-flags: Advanced programmable corrected memory error
> +#     threshold event flags.
> +#     See CXL r3.2 Table 8-58 DRAM Event Record.
> +#
> +# @cvme-count: Corrected volatile memory error count at event.
> +#     See CXL r3.2 Table 8-58 DRAM Event Record.
> +#
> +# @sub-type: Memory event sub-type.
> +#     See CXL r3.2 Table 8-58 DRAM Event Record.
> +#

Same additions to cxl-inject-dram-event as in the previous patch to
cxl-inject-general-media-event, except this one also adds @component-id
(which already cxl-inject-general-media-event already had), and
@sub-channel.

See also my comment on duplication in review of PATCH 1.

>  # Since: 8.1
>  ##
>  { 'command': 'cxl-inject-dram-event',
> @@ -181,7 +201,11 @@
>              'type': 'uint8', 'transaction-type': 'uint8',
>              '*channel': 'uint8', '*rank': 'uint8', '*nibble-mask': 'uint32',
>              '*bank-group': 'uint8', '*bank': 'uint8', '*row': 'uint32',
> -            '*column': 'uint16', '*correction-mask': [ 'uint64' ]
> +            '*column': 'uint16', '*correction-mask': [ 'uint64' ],
> +            '*component-id': 'str', '*is-comp-id-pldm':'uint8',
> +            '*sub-channel':'uint8',
> +            '*cme-ev-flags':'uint8', '*cvme-count':'uint32',
> +            'sub-type':'uint8'
>             }}
>  
>  ##

