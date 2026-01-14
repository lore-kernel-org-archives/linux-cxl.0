Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDE835FF72
	for <linux-cxl@vger.kernel.org>; Wed, 14 Jan 2026 07:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768375772; cv=none; b=Fztd9kRBjpqkKPqcDw7l+jIRRG8znvpSn0G4F2Mu8sFYGK0gH8y7bDr+p5XKdFSsxXqr74GVMT2QfNvbfjg/0XbHOHI+vC4Xu8sah7EMjUmP0CbAE8ruW8X0dP4q+HBlMih8Nz2zBAV31/dyn614uX2TxcDnW4ph8ECRiBh4ud4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768375772; c=relaxed/simple;
	bh=K04FcQvENuao5NXioTKL5CkiolOZ4lRXHjJ5wgfnAS4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KGX/OL9Os+3Z0AjCPtTtWfji2fmTxK7HxIsX6dGTJAnQafZe0oYp04X35swDbZJea4G+Egh+lPTQ7Sk/l56KPINu6DBVaV0mv5ITM9+IrfO1ykuHBegVU5m2AjB2ULdrQYxMmfCp5I1iKsHkqqoc+3Jz4TwHVVdlc+ZpwGgCto4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=amYtrCen; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="amYtrCen"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768375767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+Q3Vaj0Jb+j0Th1Rh4PTPN205xGvCIudAKPwgrtn+yU=;
	b=amYtrCenDCBbhKZfiF3J/8wbQ5rlnfWddvZVm5o34gRZslDdqXQqHHMzPzj1D7IeTqBX2+
	h5OS+wbArBdCAzjM/AmXOTJ4xg2r1r7tWMQmKFS/lRWdlBkNBpDF2B3ZeNJ0Ew8bFKphQZ
	8DCiOdprp82M5AeqjIZw5/nyHiqUkV4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-215-GqKWK7wSMZWxSzLnj27WFQ-1; Wed,
 14 Jan 2026 02:29:22 -0500
X-MC-Unique: GqKWK7wSMZWxSzLnj27WFQ-1
X-Mimecast-MFC-AGG-ID: GqKWK7wSMZWxSzLnj27WFQ_1768375760
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6D9E71956050;
	Wed, 14 Jan 2026 07:29:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.32])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B11EA1800285;
	Wed, 14 Jan 2026 07:29:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 3645621E66C9; Wed, 14 Jan 2026 08:29:17 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Michael Tsirkin <mst@redhat.com>,  <qemu-devel@nongnu.org>,
  <shiju.jose@huawei.com>,  <linuxarm@huawei.com>,
  <linux-cxl@vger.kernel.org>,  "Ravi Shankar" <venkataravis@micron.com>
Subject: Re: [PATCH qemu v2 5/5] hw/cxl/events: Updates for rev3.2 memory
 module event record
In-Reply-To: <20260113175925.00007966@huawei.com> (Jonathan Cameron's message
	of "Tue, 13 Jan 2026 17:59:25 +0000")
References: <20260102151512.460766-1-Jonathan.Cameron@huawei.com>
	<20260102151512.460766-6-Jonathan.Cameron@huawei.com>
	<87344bf29s.fsf@pond.sub.org> <20260113175925.00007966@huawei.com>
Date: Wed, 14 Jan 2026 08:29:17 +0100
Message-ID: <87zf6g4ppu.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Jonathan Cameron <jonathan.cameron@huawei.com> writes:

> On Mon, 12 Jan 2026 13:23:27 +0100
> Markus Armbruster <armbru@redhat.com> wrote:
>
>> Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:
>> 
>> > From: Shiju Jose <shiju.jose@huawei.com>
>> >
>> > CXL spec rev3.2 section 8.2.10.2.1.3 Table 8-50, memory module
>> > event record has updated with following new fields.
>> > 1. Validity Flags
>> > 2. Component Identifier
>> > 3. Device Event Sub-Type
>> >
>> > Add updates for the above spec changes in the CXL memory module
>> > event reporting and QMP command to inject memory module event.
>> >
>> > Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
>> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> > ---
>> >  qapi/cxl.json               | 12 +++++++++++-
>> >  include/hw/cxl/cxl_events.h |  7 +++++--
>> >  hw/mem/cxl_type3.c          | 20 ++++++++++++++++++++
>> >  hw/mem/cxl_type3_stubs.c    |  4 ++++
>> >  4 files changed, 40 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/qapi/cxl.json b/qapi/cxl.json
>> > index 3e4bad4ad0..752d46cda2 100644
>> > --- a/qapi/cxl.json
>> > +++ b/qapi/cxl.json
>> > @@ -242,6 +242,14 @@
>> >  # @corrected-persistent-error-count: Total number of correctable
>> >  #     errors in persistent memory
>> >  #
>> > +# @component-id: Device specific component identifier for the event.
>> > +#     May describe a field replaceable sub-component of the device.
>> > +#
>> > +# @is-comp-id-pldm: This flag specifies whether the device-specific
>> > +#     component identifier format follows PLDM.
>> > +#
>> > +# @sub-type: Device event sub-type.
>> > +#  
>> 
>> These three seem to be the same in CXLGeneralMediaEvent, CXLDRAMEvent,
>> and CXLMemModuleEvent.  Should they live in their common base type
>> CXLCommonEventBase?
>
> We have documented that base as corresponding to the spec defined
> Common event record header and these aren't part of that.  We could
> invent a CXLMemCommonEventBase that contains the stuff that is shared
> for memory types of errors but it would probably just confuse anyone
> trying to correlate this stuff with the spec.
>
> There are a lot more event records we don't yet support, or are not
> directly injected because they are responses to some other action.
> (e.g. dynamic capacity add produces an event but also changes a bunch
>  of device state)
>
> I'm not sure if we will add direct injection of any of those other
> events in future. Some are errors such as MLD Port Event Records,
> but reporting those inband makes no sense as normal PCIe error
> reporting is used for that. They are to expose what happened to
> an out of band monitoring interface (see examples in patch 2
> discussion).

I gladly defer to your expert opinion here.  We can always factor out
later.

> Thanks for all your other feedback. We'll resolve that for v3.
>
> Jonathan

[...]

