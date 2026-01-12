Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DA526E719
	for <linux-cxl@vger.kernel.org>; Mon, 12 Jan 2026 12:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768220625; cv=none; b=a7wh6CyN2r9wNBqbx7grCguXaQ+Xz/dUukl0TM2Zw90c8WYFx1GHhkMXjIR/6szZd/lys3aORYHCYSinOBU9AlEfACUVAt3GlnyDmHJOuv/Gl7kEjLTBo620Jj0DmsN20F6R2z+ChGtWPEtAvyELYrkfuHrOHo97nFkXPj/XtNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768220625; c=relaxed/simple;
	bh=FnPU60LMYJDVbHJK9QVPdsCe2N5jkZ/m81hSUkCWeq4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HjH6uPn4KwoTrbNbtpPcy6ilvK3sOgriHOkbJSo/bpqHqQ5NC5epae99yzcXa1n/Z5T49IKmlHG7QtRr973T/bF3or50xt06r5ONc8VE7FNEeR2fXviAkXqdkMAVHSD37zJyOHw4djNG/l/UHS77kJFUHPGDA40gFBam6T5tTyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XvM5mCQf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XvM5mCQf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768220614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bBcbqJ+HaHOXY1qhhR27ENO31OIiH/4ni506XBX8/OI=;
	b=XvM5mCQfox3qDSb4G0/JC8lqRqD/F8NXl4Xm1cYdBsDMGi1/sRNQSFzlX1rKHReNmILOd3
	pWtVRejvEUfU4a4z2cSGeE4EiLKqRKvmfQta47g4HCfIIFMdnErxNGo5S6WgqlJwVcmIVN
	QI05VOJk1wIIZVDgYMiEO6jSJX7g7BU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-410-h7EH7fDmMaetLCthkVBawQ-1; Mon,
 12 Jan 2026 07:23:31 -0500
X-MC-Unique: h7EH7fDmMaetLCthkVBawQ-1
X-Mimecast-MFC-AGG-ID: h7EH7fDmMaetLCthkVBawQ_1768220610
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3630B19560B2;
	Mon, 12 Jan 2026 12:23:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.32])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B2E9A18004D8;
	Mon, 12 Jan 2026 12:23:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 3F89821E6742; Mon, 12 Jan 2026 13:23:27 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Michael Tsirkin <mst@redhat.com>,  <qemu-devel@nongnu.org>,
  <shiju.jose@huawei.com>,  <linuxarm@huawei.com>,
  <linux-cxl@vger.kernel.org>,  Ravi Shankar <venkataravis@micron.com>
Subject: Re: [PATCH qemu v2 5/5] hw/cxl/events: Updates for rev3.2 memory
 module event record
In-Reply-To: <20260102151512.460766-6-Jonathan.Cameron@huawei.com> (Jonathan
	Cameron's message of "Fri, 2 Jan 2026 15:15:12 +0000")
References: <20260102151512.460766-1-Jonathan.Cameron@huawei.com>
	<20260102151512.460766-6-Jonathan.Cameron@huawei.com>
Date: Mon, 12 Jan 2026 13:23:27 +0100
Message-ID: <87344bf29s.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:

> From: Shiju Jose <shiju.jose@huawei.com>
>
> CXL spec rev3.2 section 8.2.10.2.1.3 Table 8-50, memory module
> event record has updated with following new fields.
> 1. Validity Flags
> 2. Component Identifier
> 3. Device Event Sub-Type
>
> Add updates for the above spec changes in the CXL memory module
> event reporting and QMP command to inject memory module event.
>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  qapi/cxl.json               | 12 +++++++++++-
>  include/hw/cxl/cxl_events.h |  7 +++++--
>  hw/mem/cxl_type3.c          | 20 ++++++++++++++++++++
>  hw/mem/cxl_type3_stubs.c    |  4 ++++
>  4 files changed, 40 insertions(+), 3 deletions(-)
>
> diff --git a/qapi/cxl.json b/qapi/cxl.json
> index 3e4bad4ad0..752d46cda2 100644
> --- a/qapi/cxl.json
> +++ b/qapi/cxl.json
> @@ -242,6 +242,14 @@
>  # @corrected-persistent-error-count: Total number of correctable
>  #     errors in persistent memory
>  #
> +# @component-id: Device specific component identifier for the event.
> +#     May describe a field replaceable sub-component of the device.
> +#
> +# @is-comp-id-pldm: This flag specifies whether the device-specific
> +#     component identifier format follows PLDM.
> +#
> +# @sub-type: Device event sub-type.
> +#

These three seem to be the same in CXLGeneralMediaEvent, CXLDRAMEvent,
and CXLMemModuleEvent.  Should they live in their common base type
CXLCommonEventBase?

>  # Since: 8.1
>  ##
>  { 'struct': 'CXLMemModuleEvent',
> @@ -251,7 +259,9 @@
>              'life-used': 'uint8', 'temperature' : 'int16',
>              'dirty-shutdown-count': 'uint32',
>              'corrected-volatile-error-count': 'uint32',
> -            'corrected-persistent-error-count': 'uint32'
> +            'corrected-persistent-error-count': 'uint32',
> +            '*component-id': 'str', '*is-comp-id-pldm':'bool',
> +            'sub-type':'uint8'
>              }}
>  
>  ##

[...]

