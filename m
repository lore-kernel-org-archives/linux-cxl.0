Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758A22848A7
	for <linux-cxl@vger.kernel.org>; Thu, 26 Mar 2026 13:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774530085; cv=none; b=Z9TjYUQv0FH/WeKBaHmvEclQ51vo32h60+a8YIWC7fFDTn1uoRKLOSVpTnXkyhnb7Ok4WiOUhYfCigLTk8WXgpuSzUPPgKlDDpYCyY2B+HZO5HyCDIWo6HoPCEk5zRNPywWhrfl75+Jflc3mCm6WxZSUl2d9Xr2oFEpubZvHjPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774530085; c=relaxed/simple;
	bh=JtfRI+SGda94ltJQL8u/sOjJTSX26NJ6vN3Uql6fp98=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YsCFGYSf0zmxc8mIMmUWVnTnZfUlIkCq/1SImSaB+KddX6qSRd3Afz+Zzw2YCNp+HcfcQ8EhjfhsE0trE50iiV1STLO3w0FltTZMOhmzbbiXzhsZLAVsgDNFYO6h8xU4AmmY4Qse69/2QDkYf5VhxyezL6cPZbPE+tHPJQSzYF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GY+2M+Rp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GY+2M+Rp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774530082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dgqnh8YCVC64TnA3VJFCquY3LHbWRG2/wHmvHeqgzDw=;
	b=GY+2M+RptLCcfW6nYQGPNPs6J5WUa0uNqKDh+50rdiJW4HX2kw6Y6wr940JLC9bLVo/+jK
	U6p3TjjguC1NAIzoIya+p09fEwYdjTPECe34bshRqIDb/RS+7+/IEdJ6ILuELznwpCqw1O
	eintz1vESrTBSIx5xrRSZx6rLf3JOT4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-235-dkj09fOLMO2CHio9kGdSLw-1; Thu,
 26 Mar 2026 09:01:19 -0400
X-MC-Unique: dkj09fOLMO2CHio9kGdSLw-1
X-Mimecast-MFC-AGG-ID: dkj09fOLMO2CHio9kGdSLw_1774530071
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5F0EF1955F18;
	Thu, 26 Mar 2026 13:01:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 627103000223;
	Thu, 26 Mar 2026 13:01:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 0600221E6937; Thu, 26 Mar 2026 14:01:07 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Alireza Sanaee <alireza.sanaee@huawei.com>
Cc: <qemu-devel@nongnu.org>,  <anisa.su@samsung.com>,
  <berrange@redhat.com>,  <eblake@redhat.com>,
  <jonathan.cameron@huawei.com>,  <linux-cxl@vger.kernel.org>,
  <linuxarm@huawei.com>,  <lizhijian@fujitsu.com>,  <mst@redhat.com>,
  <pbonzini@redhat.com>,  <gourry@gourry.net>,  <nifan.cxl@gmail.com>,
  <me@linux.beauty>
Subject: Re: [PATCH 1/9] hw/mem: Add tag support to generic host memory
 backends
In-Reply-To: <20260326112921.000028e6.alireza.sanaee@huawei.com> (Alireza
	Sanaee's message of "Thu, 26 Mar 2026 11:29:21 +0000")
References: <20260325184259.366-1-alireza.sanaee@huawei.com>
	<20260325184259.366-2-alireza.sanaee@huawei.com>
	<87a4vuhnxy.fsf@pond.sub.org>
	<20260326112921.000028e6.alireza.sanaee@huawei.com>
Date: Thu, 26 Mar 2026 14:01:06 +0100
Message-ID: <87bjgag2y5.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: HEdkgNvOuX1cHxpYiHPfMYvl5-JMNJJM5M3AlwP7Fxo_1774530071
X-Mimecast-Originator: redhat.com
Content-Type: text/plain

Alireza Sanaee <alireza.sanaee@huawei.com> writes:

> On Thu, 26 Mar 2026 11:42:17 +0100
> Markus Armbruster <armbru@redhat.com> wrote:
>
> Hi Markus,
>
>> Alireza Sanaee <alireza.sanaee@huawei.com> writes:
>> 
>> > Add a string tag property to HostMemoryBackend so that backends can be
>> > identified by a user-assigned name at runtime. Expose the property through
>> > QOM and add a host_memory_backend_find_by_tag() helper that walks the
>> > object tree to locate a backend by its tag.  
>> 
>> Why can't you use the QOM ID?
>> 
>> $ qemu-system-x86_64 -S -display none -monitor stdio -object memory-backend-ram,id=fred,size=1M
>> QEMU 10.2.90 monitor - type 'help' for more information
>> (qemu) info qom-tree /objects/fred
>> /fred (memory-backend-ram)
>>   /fred[0] (memory-region)
>> 
>>  
>
> Fair question. The ID would have been a solution if it had accepted GUIDs. CXL spec 
> requires GUIDs for extents as identification, hence new tag property.

Your commit message should state that this needs to be a GUID and why.

> alireza@blue-ocean:~/Downloads$ qemu-system-x86_64 -s -display none -monitor std
> io -object memory-backend-ram,id=02bb2436-e87d-4aa1-b2be-aaffdd76bb79,size=1M
> qemu-system-x86_64: -object memory-backend-ram,id=02bb2436-e87d-4aa1-b2be-aaffdd
> 76bb79,size=1M: Parameter 'id' expects an identifier
> Identifiers consist of letters, digits, '-', '.', '_', starting with a letter.
>
> Thanks,
> Ali

