Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33EA16D9C0
	for <linux-cxl@vger.kernel.org>; Wed, 24 Apr 2024 17:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713979590; cv=none; b=LSyDesNcfOeI0bguLbBLz6q3jI603l8Vi3Q37bzP1u7tANHFN6ESgP3KSdduvbtbGLVKo861Dpz/xZDMZb3CeqYTssIIpXzxvFnNbtzubfIVhZgDX3VaeevvZ/2qeRi1Fm3WbRmyvVtwgA03pYYVYRwR38A0FO/XBqUQeoH5tlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713979590; c=relaxed/simple;
	bh=XfPPzXEBiv9xcRjBrytVDrEiIVO7nBjT3pS2RQkJb1w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KMPOKn62S3Tg+RweInfRYJzyZvWLdiyY+PKymf9LgwavIXanIglQ/u4iKwfwHd+ex+bX0TNx0BcM9Le3zxK4+EIhBPZ6PVhxeAEyk3NJh9XwaidiW1BQcBNs7z2jhin0DiPu+FJzxj+fVK3aAjG/Ngqwu/pxXzwVGHG6mLG3MFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PdrjZccw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PdrjZccw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713979587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lNZ2GSMyKTkCQIOnN2LNE4NSLe1XqgAYfruR0VO0M+g=;
	b=PdrjZccwjQhGLuJsFMtVrmIRnUt7792Koto7B11A7JnWNjSS/NGbCvagB5lI3onMNPR00E
	NWTVfIj+z4ajy5hThBt8saCxf37JhLLpLD87m9zhxwH3t3eevlsvBCTinjfGypFiUXEXIz
	n6c/cZcWYD//B44hoMA1eAUYBxmmEDI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-Ta705BcSOjWjRm34S_r5FQ-1; Wed, 24 Apr 2024 13:26:26 -0400
X-MC-Unique: Ta705BcSOjWjRm34S_r5FQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3DEF31815A81;
	Wed, 24 Apr 2024 17:26:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id BC10040C6CC0;
	Wed, 24 Apr 2024 17:26:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id B030F21E66C8; Wed, 24 Apr 2024 19:26:23 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: fan <nifan.cxl@gmail.com>
Cc: qemu-devel@nongnu.org,  jonathan.cameron@huawei.com,
  linux-cxl@vger.kernel.org,  gregory.price@memverge.com,
  ira.weiny@intel.com,  dan.j.williams@intel.com,
  a.manzanares@samsung.com,  dave@stgolabs.net,  nmtadam.samsung@gmail.com,
  jim.harris@samsung.com,  Jorgen.Hansen@wdc.com,  wj28.lee@gmail.com,  Fan
 Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v5 09/13] hw/cxl/events: Add qmp interfaces to
 add/release dynamic capacity extents
In-Reply-To: <Zik88BUMsMEFb0Nr@debian> (fan's message of "Wed, 24 Apr 2024
	10:10:08 -0700")
References: <20240304194331.1586191-1-nifan.cxl@gmail.com>
	<20240304194331.1586191-10-nifan.cxl@gmail.com>
	<87a5livrdr.fsf@pond.sub.org> <Zik88BUMsMEFb0Nr@debian>
Date: Wed, 24 Apr 2024 19:26:23 +0200
Message-ID: <87pluebrk0.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

fan <nifan.cxl@gmail.com> writes:

> On Wed, Apr 24, 2024 at 03:09:52PM +0200, Markus Armbruster wrote:
>> nifan.cxl@gmail.com writes:
>> 
>> > From: Fan Ni <fan.ni@samsung.com>
>> >
>> > Since fabric manager emulation is not supported yet, the change implements
>> > the functions to add/release dynamic capacity extents as QMP interfaces.
>> 
>> Will fabric manager emulation obsolete these commands?
>> 
>
> Hi Markus,
> Thanks for reviewing the patchset. This is v5 and we have sent out v7
> recently, there are a lot of changes from v5 to v7.
>
> FYI. v7: https://lore.kernel.org/linux-cxl/ZiaFYUB6FC9NR7W4@memverge.com/T/#t

Missed it because you neglected to cc: me for qapi/cxl.json :)

Thanks!

