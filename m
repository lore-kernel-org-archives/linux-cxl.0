Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAEF50097B
	for <linux-cxl@vger.kernel.org>; Mon, 12 Jan 2026 12:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768220364; cv=none; b=cFU9Gc9i976RNHDnvqLTrQKQyMAvK/iWTCNMxDELMLj6ziWCB/FdFGiLkJuibcf43yj82dpIpLfjSCBd8a5gtbguY2VEdVcwDsDE+bAqYiM4LAAk5R/TPR+I770Tv/iuWfQLYKwkY5lPKBE7UFLuIceWDJBS1l2bN96OWxrZbRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768220364; c=relaxed/simple;
	bh=D4kgri5ykgf0rxlfIIfMWPHda59glzlQAmCysOPhtvM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aF+pkgVso2w45CnIlquC+uLiq2QwG0/enMdbe88b3ok8/QapjwX+ZA/PeI3Eof+cjyd0UoanFwFBb96x6U+VAY8dj/XCDJrNKZt4sLImydjnln54sq+Ty94x7UooOM5QbWi2nv0aEOzBKR+4izlALONa29pr64o3feXN1Frg+J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a3NxX98p; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a3NxX98p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768220361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WSzXhdlhQU08FAnxB9Em4ZWdMNWLxCuKZ7hGG6SV6Vw=;
	b=a3NxX98pFedYYwzNQn4yGRr++rHR8TVV/IyRmxv9sVKAZ/QzbMiR4OV8b1RHywGCOCqG38
	LCKCVxeQXmq8t7R2GbrwsHFOhPYB6fTNJ9ARgFUuLfrN1gSAeu7R/9y+JNdlXMjbpF3Z4h
	9WS52JkZV6EzvwLiyjLYA27ktNsg4So=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-lzoXL7nSO7eIS4SkwHSHjw-1; Mon,
 12 Jan 2026 07:19:16 -0500
X-MC-Unique: lzoXL7nSO7eIS4SkwHSHjw-1
X-Mimecast-MFC-AGG-ID: lzoXL7nSO7eIS4SkwHSHjw_1768220355
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C98941956054;
	Mon, 12 Jan 2026 12:19:14 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.32])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5482319560BA;
	Mon, 12 Jan 2026 12:19:14 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id B34BB21E6683; Mon, 12 Jan 2026 13:19:11 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Michael Tsirkin <mst@redhat.com>,  <qemu-devel@nongnu.org>,
  <shiju.jose@huawei.com>,  <armbru@redhat.com>,  <linuxarm@huawei.com>,
  <linux-cxl@vger.kernel.org>,  Ravi Shankar <venkataravis@micron.com>
Subject: Re: [PATCH qemu v2 4/5] hw/cxl/events: Updates for rev3.2 DRAM
 event record
In-Reply-To: <20260102151512.460766-5-Jonathan.Cameron@huawei.com> (Jonathan
	Cameron's message of "Fri, 2 Jan 2026 15:15:11 +0000")
References: <20260102151512.460766-1-Jonathan.Cameron@huawei.com>
	<20260102151512.460766-5-Jonathan.Cameron@huawei.com>
Date: Mon, 12 Jan 2026 13:19:11 +0100
Message-ID: <87cy3ff2gw.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

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
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  qapi/cxl.json               | 21 ++++++++++++++++++-
>  include/hw/cxl/cxl_events.h |  9 ++++++--
>  hw/mem/cxl_type3.c          | 42 +++++++++++++++++++++++++++++++++++++
>  hw/mem/cxl_type3_stubs.c    |  7 +++++++
>  4 files changed, 76 insertions(+), 3 deletions(-)
>
> diff --git a/qapi/cxl.json b/qapi/cxl.json
> index c5ecbe9646..3e4bad4ad0 100644
> --- a/qapi/cxl.json
> +++ b/qapi/cxl.json
> @@ -168,6 +168,21 @@
   ##
   # @CXLDRAMEvent:
   #
   # Event record for a DRAM Event (CXL r3.0 8.2.9.2.1.2).
   #
   # @dpa: Device Physical Address (relative to @path device).  Note
   #     lower bits include some flags.  See CXL r3.0 Table 8-44 DRAM
   #     Event Record, Physical Address.
   #
   [...]
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

You're not updating the reference to the CXL spec from 3.0 to 3.2.
Intentional?

>  # Since: 8.1
>  ##
>  { 'struct': 'CXLDRAMEvent',
> @@ -176,7 +191,11 @@
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

[...]

